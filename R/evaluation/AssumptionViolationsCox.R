# Title     : AssumptionViolationsCox.R
# Objective : Assumptions
# Created by: greyhypotheses
# Created on: 10/01/2022



#' @param model: the training data model
ViolationsProportionalityTable <- function (model) {

  proportionality <- cox.zph(model)
  estimates <- data.frame(proportionality$table)

  return(estimates)

}



#' @param model: the training data model
ViolationsTime <- function (model) {

  proportionality <- cox.zph(model)

  excerpt <- data.frame(proportionality$y) %>%
    mutate(time = proportionality$time, x = proportionality$x)

  excerpt %>%
    select(age_group, malignant_neoplasm, time) %>%
    gather(key = 'covariate', value = 'beta', -time) %>%
    ggplot(mapping = aes(x = time, y = beta)) +
    geom_point(alpha = 0.25) +
    geom_smooth(method = 'loess', formula = 'y ~ x', size = 0.15, colour = 'black') +
    xlim(NA, round(max(excerpt$time), digits = -2)) +
    facet_wrap(~covariate, scales = 'free',
               labeller = as_labeller(c('age_group' = 'Age Group', 'malignant_neoplasm' = 'Malignant Neoplasm'))) +
    coord_trans(x = scales::pseudo_log_trans()) +
    theme_minimal() +
    theme(panel.spacing = unit(x = 3, units = 'lines'),
          panel.grid.minor = element_blank(),
          panel.grid.major = element_line(size = 0.1),
          plot.title = element_text(hjust = 0.5),
          strip.text.x = element_text(size = 11, face = 'bold'),
          plot.caption = element_text(hjust = 0, size = 11, colour = 'darkgrey'),
          axis.text.x = element_text(size = 11, angle = 90), axis.text.y = element_text(size = 11),
          axis.title.x = element_text(size = 13), axis.title.y = element_text(size = 13)) +
    xlab(label = '\ntime\n') +
    ylab(label = '\ntime dependent coefficient\n')


}



#' @param data: training data
ViolationsKaplan <- function (data) {

  # the survfit strata builder
  label <- function (text, times){
    return(list(labels= data.frame(label = rep(text, times))))
  }

  # violation cases
  cases <- list(age_group =
                  survfit(formula = Surv(time = data$time_to_outcome, event = data$deceased) ~ age_group, data = data),
                malignant_neoplasm =
                  survfit(formula = Surv(time = data$time_to_outcome, event = data$deceased) ~ malignant_neoplasm, data = data))

  # data
  T <- data.frame()
  for (case in names(cases)) {
    effects <- cases[case][[1]]
    strata <- effects$strata
    labels <- dplyr::bind_rows(mapply(FUN = label, text = names(strata), times = as.numeric(strata)))
    series <- data.frame(time = effects$time, probability = effects$surv, lower = effects$lower,
                    upper = effects$upper, strata = labels$label, group = case)
    series$strata <- stringr::str_replace(series$strata, pattern = paste0(case, '='), replacement = '')
    T <- rbind(T, series)
  }

  # graphs
  left <- T %>%
    filter(group == 'age_group') %>%
    ggplot(mapping = aes(x = time, fill = strata)) +
    geom_ribbon(mapping = aes(ymin = lower, ymax = upper), alpha = 0.25) +
    geom_line(mapping = aes(y = probability, colour = strata), alpha = 0.65, size = 0.5, linetype = 2) +
    theme_minimal() +
    theme(panel.grid.minor = element_blank(),
          panel.grid.major = element_line(size = 0.1),
          plot.title = element_text(hjust = 0.5),
          plot.caption = element_text(hjust = 0, size = 11, colour = 'darkgrey'),
          axis.text.x = element_text(size = 11, angle = 90), axis.text.y = element_text(size = 11),
          axis.title.x = element_text(size = 13), axis.title.y = element_text(size = 13)) +
    xlab(label = '\ntime\n') +
    ylab(label = '\nprobability\n') +
    labs(title = 'Age Group')

  right <- T %>%
    filter(group != 'age_group') %>%
    ggplot(mapping = aes(x = time, fill = strata)) +
    geom_ribbon(mapping = aes(ymin = lower, ymax = upper), alpha = 0.25) +
    geom_line(mapping = aes(y = probability, colour = strata), alpha = 0.65, size = 0.5, linetype = 2) +
    theme_minimal() +
    theme(panel.grid.minor = element_blank(),
          panel.grid.major = element_line(size = 0.1),
          plot.title = element_text(hjust = 0.5),
          plot.caption = element_text(hjust = 0, size = 11, colour = 'darkgrey'),
          axis.text.x = element_text(size = 11, angle = 90), axis.text.y = element_text(size = 11),
          axis.title.x = element_text(size = 13), axis.title.y = element_text(size = 13)) +
    xlab(label = '\ntime\n') +
    ylab(label = '\nprobability\n') +
    labs(title = 'Malignant Neoplasm')

  left + right

}