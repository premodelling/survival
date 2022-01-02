# Title     : main
# Objective : Exploration
# Created by: greyhypotheses
# Created on: 29/12/2021


# programs
source(file = 'R/functions/StudyData.R')
source(file = 'R/functions/IsDependentCC.R')
source(file = 'R/missing/PredictorTest.R')


# the data set
data <- StudyData()
str(data)



#' Assessing missing data
#'

# NA Intersections
items <- Hmisc::naclus(df = data[, !(names(data) %in% 'outcome')], method = 'complete')


# dendogram
plot(items$hclust, hang = 0.1, check = TRUE,
     axes = TRUE, frame.plot = FALSE, ann = TRUE, yaxt = 'n',
     ylab = 'fraction of NA in common', main = 'Dendogram')
axis(side = 2,
     at = seq(from = 0.95, to = 1.00, by = 0.01),
     labels = c('0.05', '0.04', '0.03', '0.02', '0.01', '0.00'))


# fraction of NA per variable
frac_na_per_variable <- data.frame(variable = unlist(dimnames(items$sim)[1]),
                              frac_of_na = as.numeric(diag(items$sim)))

ggplot(data = frac_na_per_variable) +
  geom_col(mapping = aes(x = variable, y = frac_of_na),
           fill = 'black', alpha = 0.65, position = position_dodge2(preserve = 'single')) +
  geom_hline(yintercept = 0.05, colour = 'black', alpha = 0.85, size = 0.15) +
  theme_minimal() +
  theme(panel.grid.minor = element_blank(),
        panel.grid.major = element_line(size = 0.15),
        axis.title.x = element_text(size = 13, face = 'bold'), axis.text.x = element_text(size = 11, angle = 90),
        axis.title.y = element_text(size = 13, face = 'bold'), axis.text.y = element_text(size = 11)) +
  xlab('\n') +
  ylab('fraction of NA\n') +
  ylim(0, 0.1) +
  annotate('text', x = 1, y = 0.055, label = '5.0%')


# tally of NA per instance, i.e.,  per patient
numbers <- FrequenciesTable(data = items$na.per.obs, label = 'group')
names(numbers) <- c('group', 'frequency')
numbers <- numbers[!is.na(numbers$group),]

ggplot(data = numbers, mapping = aes(x = group, y = frequency)) +
  geom_bar(stat = 'identity') +
  geom_text(mapping = aes(label = frequency), vjust = 0, nudge_y = 65) +
  ggplot2::coord_trans(y = scales::sqrt_trans()) +
  theme_minimal() +
  theme(panel.grid.minor = element_blank(),
        panel.grid.major.y = element_line(size = 0.15),
        panel.grid.major.x = element_blank(),
        axis.title.x = element_text(size = 13), axis.text.x = element_text(size = 11),
        axis.title.y = element_text(size = 13), axis.text.y = element_text(size = 11)) +
  xlab('\n NA per patient') +
  ylab('\nfrequency\n')



# investigating plausible reasons for the miising values
# the resulting matrix suggests that, at a bare minimum we have a few MAR cases
predictors <- c('sex', 'asthma', 'liver_mild', 'renal', 'pulmonary',
            'neurological', 'liver_mod_severe', 'malignant_neoplasm')
instances <- data[, !(names(date) %in% 'admission_date')]

details <- mapply(FUN = PredictorTest, predictor = predictors,
       MoreArgs = list(instances = instances))

data.frame(t(details))



# degree of correlation between predictors
# ggcorrplot

design <- mapply(FUN = IsDependentCC, reference = predictors, MoreArgs = list(variables = predictors, frame = data))
measures <- data.frame(design)





