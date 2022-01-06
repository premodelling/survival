# Title     : Graph Metrics
# Objective : Graphs of error metrics
# Created by: 
# Created on: 06/01/2022

roc <- function (metrics) {

  ggplot(data = metrics, mapping = aes(x = fpr, y = sensitivity)) +
    geom_line(alpha = 0.35) +
    geom_jitter(alpha = 0.25, height = 0.001, width = 0.001) +
    theme_minimal() +
    theme(plot.caption = element_text(hjust = 0, size = 13, colour = 'steelblue'),
          axis.text.x = element_text(size = 11, face = 'bold'),
          axis.text.y = element_text(size = 11, face = 'bold'),
          axis.title.x = element_text(size = 13, face = 'bold'),
          axis.title.y = element_text(size = 13, face = 'bold'),
          aspect.ratio = 0.85) +
    xlab('\nfalse positive rate\n') +
    ylab('true postive rate\n(sensitivity)\n')

}


special <- function (metrics) {
  metrics %>%
    select(threshold, precision, sensitivity, specifity, matthews, balanced_accuracy, standard_accuracy) %>%
    gather(key = 'Metric', value = 'value', -threshold) %>%
    ggplot(aes(x = threshold, y = value)) +
    geom_line(aes(colour = Metric)) +
    geom_point(aes(colour = Metric), size = 0.5) +
    theme_minimal() +
    theme(plot.caption = element_text(hjust = 0, size = 13, colour = 'steelblue'),
          axis.text.x = element_text(size = 11, face = 'bold'),
          axis.text.y = element_text(size = 11, face = 'bold'),
          axis.title.x = element_text(size = 13, face = 'bold'),
          axis.title.y = element_text(size = 13, face = 'bold'),
          aspect.ratio = 0.85) +
    xlab('\nthreshold\n') +
    ylab('metric\n') +
    ylim(0.65, 1)
}


accuracy <- function (metrics) {
  metrics %>%
    select(threshold, balanced_accuracy, standard_accuracy) %>%
    gather(key = 'Metric', value = 'value', -threshold) %>%
    ggplot(aes(x = threshold, y = value)) +
    geom_line(aes(colour = Metric)) +
    geom_point(aes(colour = Metric)) +
    theme_minimal() +
    theme(plot.caption = element_text(hjust = 0, size = 13, colour = 'steelblue'),
          axis.text.x = element_text(size = 11, face = 'bold'),
          axis.text.y = element_text(size = 11, face = 'bold'),
          axis.title.x = element_text(size = 13, face = 'bold'),
          axis.title.y = element_text(size = 13, face = 'bold'),
          aspect.ratio = 0.85) +
    xlab('\nthreshold\n') +
    ylab('metric\n') +
    ylim(0, 1)
}

