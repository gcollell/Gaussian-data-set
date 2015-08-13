## Description

The algorithm produces a data set with two normally distributed (N-dimensional) classes. Additionally, it outputs the maximum attainable Bayes micro and macro accuracy. The generated data set is particularly appropriate to test new algorithms on (binnary) classification for imbalanced learning as it allows to evaluate the algorithm's performance against the maximum attainable Bayes macro accuracy (quite popular performance measure in imbalanced learning). In addition, it allows to produce data sets with different combinations of standard deviations and different number of examples for each class (e.g., a minority class with low vs. high density of examples) which in classification is known as the problem of the small vs. large disjuncts. For a more detailed description on how Bayes macro accuracy is computed see theorem 1 of the master thesis of Guillem Collell (https://sites.google.com/site/guillemct1/publications).


## Installation

The installation of the following libraries in R is required in order to run the algorithm: MASS and R2Cuba.


## Tests

An example to call the main function "gaussians_ndim" is the following:

e <- gaussians_ndim(N=2, n0=2000, SD0=1, n1=20, SD1=1, d=2, empirical=FALSE)


will produce a data set e$df with 2-dimensional gaussian distributions. The class 0(majority class) is composed of n0=2000 examples and a standard deviation of SD0=1. The class 1 (minority class) is composed of n1=20 examples and a stand. dev. of SD1=1. Both distributions are separated by a distance d=2.
The Bayes micro and macro accuracies can be recalled with e$bayes_micro and e$bayes_macro respectively.


## Known problems

The precision of the bayes macro and macro accuracy depend on the multivariate numerical integration package R2Cuba. As the number of dimensions N increase, precision decrease. So, Bayesian estimations of accuracy are more exact for low dimensions.  


## Contributors

The implementation of this algorithm in R has been developed by G. Collell (MIT Sloan Neuroeconomics lab.)
