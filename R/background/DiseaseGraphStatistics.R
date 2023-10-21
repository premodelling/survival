# Title     : DiseaseGraphStatistics.R
# Objective : Disease Graph Statistics
# Created by: greyhypotheses
# Created on: 18/01/2022


DiseaseGraphStatistics <- function () {

  disease <- data %>%
    select(asthma, liver_mild, renal, pulmonary, neurological, liver_mod_severe, malignant_neoplasm) %>%
    gather(key = 'disease', value = 'Class') %>%
    group_by(disease, Class) %>%
    summarise(N = n(), .groups = 'drop') %>%
    pivot_wider(id_cols = 'disease', names_from = 'Class', values_from = 'N') %>%
    data.frame()

  names(disease)[names(disease) == 'NA.'] <- 'unknown'


  disease$total <- disease %>% select(!disease) %>% rowSums(.)

  numbers <- disease %>%
    select(disease, no, yes, unknown) %>%
    gather(key = 'Class', value = 'N', -disease)

  fractions <- cbind(disease = disease$disease, disease[, c('no', 'yes', 'unknown')] / disease$total) %>%
    select(disease, no, yes, unknown) %>%
    gather(key = 'Class', value = 'fraction', -disease)

  arithmetic <- dplyr::left_join(x = numbers, y = fractions, by = c('disease', 'Class'))


  ggplot(data = arithmetic) +
    geom_bar(mapping = aes(x = disease, y = N, fill = Class), alpha = 0.25, stat = 'identity') +
    scale_fill_manual(values = c('grey', 'black', 'steelblue')) +
    scale_x_discrete(breaks = c('asthma', 'liver_mild', 'liver_mod_severe', 'malignant_neoplasm',
                                 'neurological', 'pulmonary', 'renal'),
                     labels = c('asthma', 'mild liver\ndisease', 'moderate, severe\nliver disease', 'malignant\nneoplasm',
                                'neurological\ndisorder', 'pulmonary\ndisease', 'renal\ndisease')) +
    theme_minimal() +
    theme(panel.grid.minor = element_blank(),
          panel.grid.major = element_line(size = 0.1),
          plot.caption = element_text(hjust = 0, size = 11, colour = 'darkgrey'),
          axis.text.x = element_text(size = 9, angle = 90, vjust = 0.5), axis.text.y = element_text(size = 11),
          axis.title.x = element_text(size = 13), axis.title.y = element_text(size = 13)) +
    ylab(label = '\nN\n') +
    xlab(label = '\n')



}