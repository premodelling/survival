<br>

**CHIC601 Project: Survival Modelling & Analysis**

<br>

### Notes

**NHS England COVID-19 Hospital Activity & ISARIC Study Excerpt**:

It is probably impossible to compare the study's patient population to the NHS England patient population of the same
time period.  There are a few reasons why

* The COVID-19 Hospital Activity Data:
  * Does not include a daily record of new COVID-19 patients admissions.  Instead, it continuously updates a number 
    that denotes *the number of admitted COVID-19 patients that were still in hospital during the last 24 hours*
  * Does not include in-hospital COVID-19 deaths.
  * Has a different age groups demarcation: `[0  5]`, `[6  17]`, `[18  64]`, `[65  84]`, `85+`

Therefore, for example, the discharges numbers of the Hospital Activity Data cannot be compared with those of the study
because the baseline numbers that the discharges are relative to are unknown.

<br>

**Important Modelling & Analysis Points**:

* Internal validation
* External validation
* C Indices
* Calibration plots


<br>
<br>


### Snippets

Excluding fields:

```r
# Either
data %>% dplyr::select(!outcome)
data[, !(names(data) %in% 'outcome')]
```

<br>

``Hmisc::naclus()``:

```r
# the diagonal is.na(i)/(number of instances)
# the off-diagonal is.na(i, j)/(number of instances)
# colSums(is.na(data)) / nrow(data)
# sum(is.na(data$asthma) & is.na(data$pulmonary)) / nrow(data)
```

<br>

**``ggplot2`` & subplots**

Use ``library(patchwork)``; cf. ``facet_wrap()``.


<br>
<br>

### Variables

variable | elements | frequencies
:--- | :--- | ---:
``sex`` | male | 28116
 &nbsp; | female | 21789
 &nbsp; | not specified | 91
 &nbsp; | NA | 4
``asthma`` | no | 40458
 &nbsp; | yes | 6393
 &nbsp; | unknown | 2739
 &nbsp; | NA | 410
``liver_mild`` | no | 45550
 &nbsp; | unknown | 3327
 &nbsp; | yes | 712
 &nbsp; | NA | 411
``renal`` | no | 38210
 &nbsp; | yes | 8623
 &nbsp; | unknown | 2767
 &nbsp; | NA | 400

<br>

variable | elements | frequencies
:--- | :--- | ---:
``pulmonary`` | no | 38255
 &nbsp; | yes | 8710
 &nbsp; | unknown | 2628
 &nbsp; | NA | 407
``neurological`` | no | 40381
 &nbsp; | yes | 6227
 &nbsp; | unknown | 2994
 &nbsp; | NA | 398
``liver_mod_severe`` | no | 45430
 &nbsp; | unknown | 3195
 &nbsp; | yes | 961
 &nbsp; | NA | 414
``malignant_neoplasm`` | no | 45430
 &nbsp; | unknown | 3195
 &nbsp; | yes | 961
 &nbsp; | NA | 414

<br>

variable | elements | frequencies
:--- | :--- | ---:
``outcome`` | Discharged alive | 29097
&nbsp; | Death | 15233
&nbsp; | Transferred | 2941
&nbsp; | Remains in hospital | 1434
&nbsp; | Palliative discharge | 941
&nbsp; | NA | 297
&nbsp; | Unknown | 57
``outcome_date`` | ... | 49039
&nbsp; | NA | 961


<br>
<br>

### Independent Development Environment

* Edit the help file skeletons in 'man', possibly combining help files
  for multiple functions.
* Edit the exports in 'NAMESPACE', and add necessary imports.
* Put any C/C++/Fortran code in 'src'.
* If you have compiled code, add a useDynLib() directive to
  'NAMESPACE'.
* Run R CMD build to build the package tarball.
* Run R CMD check to check the package tarball.

Read "Writing R Extensions" for more information.

<br>
<br>

**CoxBoost**

```r

# https://cran.r-project.org/web/packages/devtools/index.html
# https://cran.r-project.org/bin/windows/Rtools/rtools40.html
# https://github.com/binderh/CoxBoost

library(devtools)
install_github(repo = 'binderh/CoxBoost')
```

<br>
<br>

<br>
<br>

<br>
<br>