# Title     : AgeGroupSexEvent.R
# Objective : Age Group, Sex, Event
# Created by: greyhypotheses
# Created on: 05/01/2022


AgeGroupSexEvent <- function () {

  source(file = 'R/functions/StudyData.R')
  original <- StudyData()

  original$age_group <- factor(x = original$age_group,
                              levels = c('30-39', '40-49', '50-59', '60-69', '70-79', '80-89', '90+'),
                              ordered = TRUE)

  original %>%
    filter(!is.na(outcome) & !is.na(time_to_outcome) & !is.na(sex)) %>%
    ggplot(mapping = aes(x = age_group, y = time_to_outcome, colour = sex)) +
    geom_boxplot(notch = TRUE, notchwidth = 0.5) +
    ggplot2::coord_trans(y = scales::pseudo_log_trans()) +
    facet_wrap(~outcome) +
    theme_minimal() +
    theme(panel.spacing = unit(x = 3, units = 'lines'),
          panel.grid.minor = element_blank(),
          panel.grid.major = element_line(size = 0.1),
          plot.title = element_text(hjust = 0.5),
          strip.text.x = element_text(size = 11, face = 'bold'),
          plot.caption = element_text(hjust = 0, size = 11, colour = 'darkgrey'),
          axis.text.x = element_text(size = 11, angle = 90), axis.text.y = element_text(size = 11),
          axis.title.x = element_text(size = 13), axis.title.y = element_text(size = 13)) +
    xlab(label = '\n\n') +
    ylab(label = '\ntime to outcome\n')

}