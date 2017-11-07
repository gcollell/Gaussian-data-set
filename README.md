## Description

The algorithm produces a data set with two normally distributed (N-dimensional) classes. Additionally, it outputs the maximum attainable Bayes micro and macro accuracy. The generated data set is especially useful for testing new algorithms on (binnary) classification with imbalanced classes as it allows to evaluate the algorithm's performance against the maximum attainable Bayes macro accuracy (a popular performance measure in imbalanced learning). In addition, it allows to produce data sets with different combinations of standard deviations and different number of examples for each class (e.g., a minority class with low vs. high density of examples) which is known as the problem of the small vs. large disjuncts. For a more detailed description on how Bayes macro accuracy is computed see Theorem 1 in my master thesis (https://sites.google.com/site/guillemct1/publications).


## Dependencies

The following R libraries are required: 
-MASS
-R2Cuba


## Tests

An example to call the main function "gaussians_ndim" is the following:

e <- gaussians_ndim(N=2, n0=2000, SD0=1, n1=20, SD1=1, d=2, empirical=FALSE)


will produce a data set e$df with 2-dimensional gaussian distributions. The class 0 (majority class) is composed of n0=2000 examples and has a standard deviation of SD0=1. The class 1 (minority class) is composed of n1=20 examples and a stand. dev. of SD1=1. The means of these distributions are separated by a distance d=2.
The Bayes micro and macro accuracies can be recalled with e$bayes_micro and e$bayes_macro respectively.


## Known problems

The precision of the bayes macro and macro accuracy depend on the multivariate numerical integration package R2Cuba. As the number of dimensions N increase, precision decrease. So, Bayes accuracy is more accurately computed for low dimensions.  


## Contributors

G. Collell (MIT Sloan Neuroeconomics lab.) is the sole author of this code.
