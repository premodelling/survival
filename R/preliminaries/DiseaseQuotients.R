# Title     : DiseaseQuotients.R
# Objective : yes/no quotients of a disease by age group & sex
# Created by: greyhypotheses
# Created on: 04/01/2022

DiseaseQuotients <- function (field) {

  source(file = '../functions/StudyData.R')
  original <- StudyData()

  excerpt <- original[, c('age_group', 'sex', field)]

  excerpt <- excerpt %>%
    filter(!is.na(sex) & !is.na((!!sym(field)))) %>%
    group_by(age_group, sex, (!!sym(field))) %>%
    summarise(N = n(), .groups = 'drop')
  excerpt$age_group <- factor(x = excerpt$age_group,
                              levels = c('30-39', '40-49', '50-59', '60-69', '70-79', '80-89', '90+'),
                              ordered = TRUE)

  wide <- pivot_wider(data = excerpt, id_cols = c('age_group', 'sex'),
                      names_from = (!!sym(field)), values_from = 'N')
  wide$quotient <- wide$yes / wide$no

  ggplot(data = wide, mapping = aes(x = age_group, y = quotient, fill = sex)) +
    geom_bar(stat = 'identity', alpha = 0.35, position = position_dodge2()) +
    theme_minimal() +
    theme(panel.spacing = unit(x = 3, units = 'lines'),
          panel.grid.minor = element_blank(),
          panel.grid.major = element_line(size = 0.1),
          plot.title = element_text(hjust = 0.5),
          strip.text.x = element_text(size = 11, face = 'bold'),
          plot.caption = element_text(hjust = 0, size = 11, colour = 'darkgrey'),
          axis.text.x = element_text(size = 11, angle = 90), axis.text.y = element_text(size = 11),
          axis.title.x = element_text(size = 13), axis.title.y = element_text(size = 13)) +
    ylab(label = '\nyes/no ratio\n') +
    xlab(label = '\n') +
    labs(title = str_glue('yes/no ratio\n{field}\n'))



}