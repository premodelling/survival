# Title     : Quotients.R
# Objective : Playground
# Created by: greyhypotheses
# Created on: 03/01/2022


Quotients <- function () {

  source(file = 'R/functions/StudyData.R')
  data <- StudyData()


  age_groups <- data %>%
    filter(!is.na(admission_date)& !is.na(age_group)) %>%
    select(age_group) %>%
    group_by(age_group) %>%
    summarise(n_by_age_group = n())


  outcomes <- data %>%
    filter(!is.na(admission_date)& !is.na(age_group)) %>%
    select(age_group, outcome) %>%
    group_by(age_group, outcome) %>%
    summarise(N = n(), .groups = 'drop')
  tidyr::pivot_wider(data = outcomes, id_cols = 'age_group', names_from = 'outcome', values_from = 'N')


  demarcations <- dplyr::left_join(x = outcomes, y = age_groups, by = 'age_group')
  demarcations$quotient <- demarcations$N / demarcations$n_by_age_group
  demarcations$age_group <- factor(x = demarcations$age_group,
                                   levels = c('30-39', '40-49', '50-59', '60-69', '70-79', '80-89', '90+'),
                                   ordered = TRUE)


  demarcations %>%
    filter(outcome == 'Discharged alive' | outcome == 'Remains in hospital') %>%
    ggplot(mapping = aes(x = age_group, y = quotient)) +
    geom_bar(alpha = 0.35, stat = 'identity') +
    facet_wrap(~outcome, scales = 'free') +
    theme_minimal() +
    theme(panel.spacing = unit(x = 3, units = 'lines'),
          panel.grid.minor = element_blank(),
          panel.grid.major = element_line(size = 0.1),
          strip.text.x = element_text(size = 11, face = 'bold'),
          plot.caption = element_text(hjust = 0, size = 11, colour = 'darkgrey'),
          axis.text.x = element_text(size = 11, angle = 90), axis.text.y = element_text(size = 11),
          axis.title.x = element_text(size = 13), axis.title.y = element_text(size = 13)) +
    ylab(label = '\noutcome/admissions\nper age group\n') +
    xlab(label = '\ntime to outcome\n')

}
