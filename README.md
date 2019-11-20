# Project 4: Algorithm implementation and evaluation: Collaborative Filtering

### [Project Description](doc/project4_desc.md)

Term: Fall 2019

+ Team #2
+ Projec title: Alternating Least Squares for Collaborative Filtering
+ Team members
	+ Ashley Culver
	+ Alexandra DeKinder
	+ Samir Hadzic
	+ Richard Lee
	+ Yicheng Li
+ Project summary: The purpose of this project was to implement several versions of the Alternating Least Squares algorithm for collaborative filtering. The goal of collaborative filtering is to develop a recommender system to match users with products. In this project, we focus on building a recommender system for movies, similar to the goal of the Netflix competition discussed in the paper on ALS. The three versions of ALS used are a base ALS with KNN and SVD post processing, ALS with penalty of magnitudes and bias and intercept regularizations, and finally ALS with temporal regularizations. All of the regularizations are accompanied by postprocessing with KNN and SVD. We devloped the algorithms and generated reports using Python. Reference papers are listed below:

[Alternating Least Squares](./paper/P4 Large-scale Parallel Collaborative Filtering for the Netflix Prize.pdf)

[Postprocessing SVD with KNN](./paper/P2 Improving regularized singular value decomposition for collaborative filtering .pdf) Section 3.5

[Penalty of Magnitudes](./paper/P1 Recommender-Systems.pdf) Section: a Basic Matrix Factorization Model

[Bias and Intercepts](./paper/P1 Recommender-Systems.pdf) Section: Adding Biases)	

[Temporal Dynamics](./paper/P5 Collaborative Filtering with Temporal Dynamics.pdf)
	
**Contribution statement**: All team members discussed a project timeline. Yicheng worked on the base ALS with KNN/SVD and Samir worked on hyper-parameter tuning for the SVD/KNN post processing. Richard and Samir worked on adding the penalty of magnitudes and bias/intercept regularizations. All team members helped with the temporal dynamic regularizations. Richard wrote the presentation and will be presenting the results. 

Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.

```
proj/
├── lib/
├── data/
├── doc/
├── figs/
└── output/
```

Please see each subfolder for a README file.
