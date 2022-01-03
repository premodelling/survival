# Title     : TimeVariance.R
# Objective : TODO
# Created by: greyhypotheses
# Created on: 03/01/2022


TimeVariance <- function (data) {


  # extract the records whereby neither time_to_outcome nor outcome is NA
  excerpt <- data %>%
    filter(!is.na(time_to_outcome) & !is.na(outcome))


  # test equality of variance via Leven'e Test
  #     null hypothesis: the outcomes groups have equivalent variances
  #     alternative hypothesis: their variances differ
  #
  # ... Pr(>F) < 2.2e-16
  # ... reject the null hypothesis in favour of the alternative
  #
  H <- car::leveneTest(time_to_outcome ~ outcome, data = excerpt)
  H$`Pr(>F)`


  # caption
  notes <- 'This box plot is based on the {nrow(excerpt)} observations whereby neither time to outcome nor
  outcome is NA; the total number of observations is {nrow(data)}.'
  caption <- stringr::str_glue(notes)


  # illustrate spread
  ggplot(data = excerpt) +
    geom_boxplot(mapping = aes(x = outcome, y = time_to_outcome, colour = outcome),
                 show.legend = FALSE, notch = TRUE, notchwidth = 0.5, na.rm = TRUE) +
    ggplot2::coord_trans(y = scales::pseudo_log_trans()) +
    theme_minimal() +
    theme(plot.caption = element_text(hjust = 0, size = 11, colour = 'darkgrey'),
          axis.text.x = element_text(size = 11, angle = 90),
          axis.text.y = element_text(size = 11),
          axis.title.x = element_text(size = 13),
          axis.title.y = element_text(size = 13)) +
    ylab(label = 'time to outcome\n') +
    xlab(label = '') +
    labs(caption = str_wrap(caption, width = 60) )


}