# Title     : Graph Frequencies
# Objective : Graphs of error frequencies
# Created by:
# Created on: 06/01/2022

classified <- function (frequencies) {
  frequencies %>%
    select(threshold, TN, TP) %>%
    gather(key = 'Frequency', value = 'value', -threshold) %>%
    ggplot(aes(x = threshold, y = value)) +
    geom_line(aes(colour = Frequency)) +
    geom_point(aes(colour = Frequency)) +
    scale_colour_manual(values = c('darkred', 'steelblue', 'green', 'orange')) +
    theme_minimal()  +
    theme(axis.text.x = element_text(size = 10),
          axis.text.y = element_text(size = 10),
          axis.title.x = element_text(face = 'bold', size = 11),
          axis.title.y = element_text(face = 'bold', size = 11),
          legend.title = element_text() ) +
    xlab('\nThreshold') +
    ylab('Matrix Frequency\n')
}

misclassified <- function (frequencies) {
  frequencies %>%
    select(threshold, FN, FP) %>%
    gather(key = 'Frequency', value = 'value', -threshold) %>%
    ggplot(aes(x = threshold, y = value)) +
    geom_line(aes(colour = Frequency)) +
    geom_point(aes(colour = Frequency)) +
    scale_colour_manual(values = c('darkred', 'steelblue', 'green', 'orange')) +
    theme_minimal()  +
    theme(axis.text.x = element_text(size = 10),
          axis.text.y = element_text(size = 10),
          axis.title.x = element_text(face = 'bold', size = 11),
          axis.title.y = element_text(face = 'bold', size = 11),
          legend.title = element_text() ) +
    xlab('\nThreshold') +
    ylab('Matrix Frequency\n')
}



