# Title     : Time.R
# Objective : Time to event patterns
# Created by: greyhypotheses
# Created on: 03/01/2022


TimeData <- function (data) {
  excerpt <- data %>%
    filter(!is.na(time_to_outcome))
  excerpt$censored <- factor(x = excerpt$censored,
                             levels = c(0, 1, NA),
                             labels = c('uncensored', 'censored', 'unknown'), exclude = NULL)
}


TimeDensityOutcome <- function(data) {

  excerpt <- TimeData(data = data)

  ggplot(data = excerpt, mapping = aes(x = time_to_outcome, colour = outcome, fill = outcome)) +
    geom_density(alpha = 0.35) +
    facet_wrap(~censored) +
    theme_minimal() +
    theme(panel.spacing = unit(x = 2, units = 'lines'),
          panel.grid.minor = element_blank(),
          panel.grid.major = element_line(size = 0.15),
          strip.text.x = element_text(size = 11, face = 'bold'),
          plot.caption = element_text(hjust = 0, size = 11, colour = 'darkgrey'),
          axis.text.x = element_text(size = 11), axis.text.y = element_text(size = 11),
          axis.title.x = element_text(size = 13), axis.title.y = element_text(size = 13)) +
    ylab(label = '\ndensity\n') +
    xlab(label = '\ntime to outcome\n')

}


TimeDensityCensor <- function (data) {

  excerpt <- TimeData(data = data)

  ggplot(data = excerpt, mapping = aes(x = time_to_outcome, colour = censored, fill = censored)) +
    geom_density(alpha = 0.35) +
    facet_wrap(~censored) +
    theme_minimal() +
    theme(panel.spacing = unit(x = 2, units = 'lines'),
          panel.grid.minor = element_blank(),
          panel.grid.major = element_line(size = 0.15),
          strip.text.x = element_text(size = 11, face = 'bold'),
          plot.caption = element_text(hjust = 0, size = 11, colour = 'darkgrey'),
          axis.text.x = element_text(size = 11), axis.text.y = element_text(size = 11),
          axis.title.x = element_text(size = 13), axis.title.y = element_text(size = 13)) +
    ylab(label = '\ndensity\n') +
    xlab(label = '\ntime to outcome\n')

}


TimeHistogramOutcome <- function (data) {

  excerpt <- TimeData(data = data)

  ggplot(data = excerpt, mapping = aes(x = time_to_outcome, colour = outcome, fill = outcome)) +
    geom_histogram(bins = 25, alpha = 0.35) +
    facet_wrap(~censored) +
    theme_minimal() +
    theme(panel.spacing = unit(x = 2, units = 'lines'),
          panel.grid.minor = element_blank(),
          panel.grid.major = element_line(size = 0.15),
          strip.text.x = element_text(size = 11, face = 'bold'),
          plot.caption = element_text(hjust = 0, size = 11, colour = 'darkgrey'),
          axis.text.x = element_text(size = 11), axis.text.y = element_text(size = 11),
          axis.title.x = element_text(size = 13), axis.title.y = element_text(size = 13)) +
    xlab(label = '\ntime to outcome\n')

}


TimeHistogramCensor <- function (data) {

  excerpt <- TimeData(data = data)

  ggplot(data = excerpt, mapping = aes(x = time_to_outcome, colour = censored, fill = censored)) +
    geom_histogram(bins = 25, alpha = 0.35) +
    facet_wrap(~censored) +
    theme_minimal() +
    theme(panel.spacing = unit(x = 2, units = 'lines'),
          panel.grid.minor = element_blank(),
          panel.grid.major = element_line(size = 0.15),
          strip.text.x = element_text(size = 11, face = 'bold'),
          plot.caption = element_text(hjust = 0, size = 11, colour = 'darkgrey'),
          axis.text.x = element_text(size = 11), axis.text.y = element_text(size = 11),
          axis.title.x = element_text(size = 13), axis.title.y = element_text(size = 13)) +
    xlab(label = '\ntime to outcome\n')

}
