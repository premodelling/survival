# Title     : Install Packages
# Objective : Installs packages
# Created by: greyhypotheses
# Created on: 29/12/2021

InstallPackages <- function (){

  # rstatix: For basic statistics tests (https://cran.r-project.org/web/packages/rstatix/index.html)
  # moments: For moments, skewness, kurtosis, etc.
  # healthcareai: Machine learning toolbox for health care. Interests: stratified splitting via split_train_test(), etc.
  # EpiEstim: Reproduction numbers of epidemics. (https://cran.r-project.org/web/packages/EpiEstim/index.html)
  packages <- c('tidyverse', 'data.table', 'ggplot2', 'rmarkdown', 'rstatix', 'latex2exp', 'moments', 'healthcareai',
                'equatiomatic', 'survival', 'survminer', 'EpiEstim', 'rticles', 'ggcorrplot', 'rcompanion', 'patchwork')

  # Install
  .install <- function(x){
    if (!require(x, character.only = TRUE)) {
      install.packages(x, dependencies = TRUE)
      if (x == 'rmarkdown') {tinytex::install_tinytex()}
    }
  }
  lapply(packages, .install)

  # Activate
  .activate <- function (x){
    library(x, character.only = TRUE)
    if (x == 'rmarkdown') {library(tinytex)}
  }

  # Activating
  lapply(packages[!(packages %in% c('tidyverse', 'healthcareai', 'equatiomatic'))], .activate)

  # Special Case
  if ('tidyverse' %in% packages) {
    lapply(X = c('magrittr', 'dplyr', 'tibble', 'ggplot2', 'stringr'), .activate)
  }

  # Active libraries
  sessionInfo()

}