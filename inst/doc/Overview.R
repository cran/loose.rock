## ----setup, echo=FALSE, include=FALSE-----------------------------------------
if (!exists('dont_run_setup')) {
  dont_run_setup <- FALSE
} 
if (!dont_run_setup) {
  knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
  )
}
#

## ---- include=FALSE-----------------------------------------------------------
library(loose.rock)
loose.rock::base.dir(file.path(tempdir(), 'run-cache'))

## ----install, eval=FALSE------------------------------------------------------
#  if (!require("BiocManager"))
#    install.packages("BiocManager")
#  BiocManager::install("loose.rock")
#  
#  # use the package
#  library(loose.rock)

## ---- message=FALSE, warning=FALSE--------------------------------------------
library(dplyr)

## ----coding.genes, collapse=TRUE, message=FALSE, warning=FALSE----------------
coding.genes() %>%
  dplyr::arrange(external_gene_name) %>% {
   dplyr::slice(., sample(seq(nrow(.)), 15)) 
  } %>%
  knitr::kable()

## ----balanced.sets, results='hold'--------------------------------------------
set1 <- c(rep(TRUE, 8), FALSE, rep(TRUE, 9), FALSE, TRUE)
set2 <- !set1
cat(
  'Set1', '\n', set1, '\n\n',
  'Set2', '\n', set2, '\n\n',
  'Training / Test set using logical indices', '\n\n'
)
set.seed(1985)
balanced.train.and.test(set1, set2, train.perc = .9)
#
set1 <- which(set1)
set2 <- which(set2)
cat(
  '##### Same sets but using numeric indices', '\n\n', 
  'Set1', '\n', set1, '\n\n', 
  'Set2', '\n', set2, '\n\n', 
  'Training / Test set using numeric indices', '\n')
set.seed(1985)
balanced.train.and.test(set1, set2, train.perc = .9)
#

## ----gen.synth----------------------------------------------------------------
xdata1 <- gen.synth.xdata(10, 5, .2)
xdata2 <- gen.synth.xdata(10, 5, .75)

## ----show.gen.synth, echo=FALSE-----------------------------------------------
#
cat('Using .2^|i-j| to generate co-variance matrix\n\n')
cat('X generated\n\n')
data.frame(xdata1)
cat('cov(X)\n\n')
data.frame(cov(xdata1))
draw.cov.matrix(xdata1) + ggplot2::ggtitle('X1 Covariance Matrix')
#
cat('Using .75^|i-j| to generate co-variance matrix (plotting correlation)\n\n')
cat('X generated\n\n')
data.frame(xdata2)
cat('cov(X)\n\n')
data.frame(cor(xdata2, method = 'pearson'))
draw.cov.matrix(xdata2, fun = cor, method = 'pearson') + 
  ggplot2::ggtitle('X2 Pearson Correlation Matrix')

## -----------------------------------------------------------------------------
base.dir(file.path(tempdir(), 'run-cache'))

## ----runcache1----------------------------------------------------------------
a <- run.cache(sum, 1, 2)
b <- run.cache(sum, 1, 2)
all(a == b)

## ----runcache2----------------------------------------------------------------
a <- run.cache(rnorm, 5, seed = 1985)
b <- run.cache(rnorm, 5, seed = 2000)
all(a == b)

## ----proper-------------------------------------------------------------------
x <- "OnE oF sUcH iS a proPer function that capitalizes a string."
proper(x)

## ----mycolors-----------------------------------------------------------------
xdata <- -10:10
plot(
  xdata, 1/10 * xdata * xdata + 1, type="l", 
  pch = my.symbols(1), col = my.colors(1), cex = .9,
  xlab = '', ylab = '', ylim = c(0, 20)
)
grid(NULL, NULL, lwd = 2) # grid only in y-direction
for (ix in 2:22) {
  points(
    xdata, 1/10 * xdata * xdata + ix, pch = my.symbols(ix), 
    col = my.colors(ix), cex = .9
  )
}

