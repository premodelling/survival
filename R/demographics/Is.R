# Title     : Is.R
# Objective : Determine whether the study demographics are representative of the demographics of the target population
# Created by: greyhypotheses
# Created on: 06/01/2022



Is <- function () {


  source(file = 'R/demographics/AggregatingStudy.R')
  source(file = 'R/demographics/AggregatingONS.R')


  # ISARIC Study
  study <- AggregatingStudy()
  study <- study %>%
    select(!'unknown') %>%
    data.frame()
  study$Study <- study$female / study$male


  # ONS: England
  ons <- AggregatingONS()
  ons$England <- ons$female / ons$male


  # A table of the Female/Male quotient values w.r.t. the study & ONS
  quotients <- study %>%
    select(age_group, Study)
  quotients <- dplyr::left_join(x = quotients, y = ons[, c('age_group', 'England')], by = 'age_group')
  quotients$age_group <- factor(x = quotients$age_group,
                                levels = c('0-9', '10-19', '20-29', '30-39', '40-49', '50-59',
                                           '60-69', '70-79', '80-89', '90+'),
                                ordered = TRUE)


  # Illustrate
  # Per age group, the female/male ratio of the study is lower than that of the reference population
  quotients %>%
    gather(key = 'Case', value = 'Female/Male Ratio', -age_group) %>%
    ggplot() +
    geom_bar(mapping = aes(x = age_group, y = `Female/Male Ratio`, fill = Case),
             stat = 'identity', position = position_dodge2(), alpha = 0.35) +
    scale_fill_manual(values = c('orange', 'black')) +
    theme_minimal() +
    theme(panel.grid.minor = element_blank(),
          panel.grid.major = element_line(size = 0.15),
          axis.title.x = element_text(size = 13), axis.title.y = element_text(size = 13),
          axis.text.x = element_text(size = 11, angle = 90), axis.text.y = element_text(size = 11)) +
    xlab(label = '\nage group\n') +
    ylab(label = '\nfemale/male\npopulation ratio\n')


}