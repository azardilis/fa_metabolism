Notes
========

These will form the basis for the presentation and will also serve as a skeleton for the main report.

## Introduction
Perhaps the huge complexity of biological systems has led Biology as a discipline to focus on understanding the inner workings of their components 
instead of understanding the systems a whole. Perhaps it was also the idea that if we knew how all the constituent parts work than we would know
how the entire systems work. While System Biology ideas are not new (for example Weiner etc.) they relatively recently regained momentum and a rewenable 
interest thanks to new experimental technologies that has led to the accumulation of a wealth of data. This quickly led to the realisation that in taking a
'wholistic' view at the systems the most important aspect of them is not the inner working of the individual components but rather the interactions between
them and the constraints these interactions impose on their concurrent behaviour and to the overall behaviour of the system.

Computer Science, altough a fundamentally different discipline than Biology, has gone through a similar trend. The focus at the start of computing was on 
the computation of individual information processing entities. This is reflected in the models of computation that inspired early computers and programming 
languages like Turing Machines and lambda calculus. These formalisms describe computation in a different way, lambda calculus as rewrite/reduction rules in
a calculus and Turing Machines as state manipulation of an Abstract Machine. Despite these differences they both capture computation of single information
processing entities formally and are equivalent in expressive power (see Church-Turing thesis). This notion of computation is more formally called operational
semantics of a formal system as they describe how they operate or behave over 'time'. As computing and technology grew over time the focus moved from single 
information processing entities to systems of tens, hundreds, and even more (see Internet, clusters) of information processing entities. Then the realisation
settled in that the most important aspect of those systems is computation but in a much more broader sense than mere calculation(which was the focus in earlier
computer systems). This broader notion of computation encompasses the interaction between the computing/information processing components and in fact this interaction
part of computation is much more important than the calculation/computation of the individual components. This is reflected in later formalisms about concurrent and
distributed systems like process algebras of various forms with the most important representative being pi-calculus. Being a calculus it follows from the tradtion of 
lamba-calculus and its operational semantics is defined in terms of syntax manipulation (rewrite/reduction rules). While in lambda-calculus(model of individual process) 
the reduction rules are about function application- calculation-, the rewrite rules for pi-calculus are about message passing in shared channels between processes- interaction.

The similarities in the shift of focus from individual components to systems of interacting components in both disciplines are apparent. The difference is that Computer Science
used formal methods even in the early stages when the focus was on individual components and this tradition continued in the study of distributed computation with formalisms
being developed for systems of components. In Biology when the focus was on individual components there was no apparent need for using anything formal for describing the workings
of the individual components but as the focus shifted to systems of interacting components which grew in size it became apparent that some form of change in direction in the methods
used is needed to handle the increased complexity. The difference is that Biology had no tradition of using more formal methods(ie Maths) to model or 'program' systems so
this gap in knowledge appeared which Systems Biology attempts to fill by bringing practises from other fields which are traditionally more formal in their approach. 

Early attempts to tackle the complexity of biological systems relied on informal diagrams to capture the interactions and dependencies between components. Those static diagrams
altough very important failed in capturing the dynamic aspects of the systems or how they behaved over time. Mathematical biologists first started using mathematical models
in terms of differential equations to capture the dynamic nature of these systems since these methods have been used successfully in other field like Engineering. This methodology
has become very popular and is almost the de facto approach to time simulation of biological systems. So this is an attempt to fill in the gap with mathematical methods and mathematical 
models.

But since Computer Science has developed appproaches to specifically tackle the complexity of systems of interacting components, 
can we use those practises to talk about biological systems
more formally? In principle yes. The computer science formalisms like process algebras, despite their name, are not restricted to processes but any kind of entities that interacts with other
similar entities. We use the physical term interaction here not only for physical interactions but also as a metaphor for virtual interactions. Since the process algebras are able 
to capture abstractly the notions of interacting components and systems then there's no reason that they shouldn't work for Biology or for that matter any system that has similar characteristics. Moreover computer systems are highly concurrent as are biological systems. The term concurrency here should not be confused with parallelism. 
The term concurrency only refers to the non-determinism of systems of interacting entities leading to a probabilistic view of computation(again used in a broader sense here 
to include both calculation and interaction). (maybe say something about scale? numbers of interacting components are on the same scale)

So it seems from a first view that the types of systems that the computer science formalisms were designed to capture are similar, on a higher level, to the biological systems that 
Systems Biology is interested in and the power of them can in principle capture biological systems as well.
The fact that we can use them does not mean that we should use them though. The notation and language we use to describe something is important as it is essentially a tool for
thought and using the correct language for the job can help us gain new insights into problems or solve problems easier. That's the reason we have not one but multiple high-level
programming languages. Even though these programming languages are all Turing complete and hence can in principle all do all computations there are some languages that are
more expressive for problems in particular domains. We'll come back to this question in the discussion section.

Since these computational models have formally defined operational semantics we can not only describe the static structure of the biological systems but we can also execute
them like computer programs and see their behaviour over time





Early approaches -> static diagrams to highlight dependencies
dynamic views -> from mathematical biologists relied heavily on the used of mathematical methods and models and this approach primarily with the use of differential equation has
proven useful and popular over the years and it is still the case today. 

Difference between mathematical and computational models -> different perspective and views of the same systems which can provide new insights. They can be executed 
since they have operational semantics. This could be important.
Also as systems grow, and with the ultimate goal to describe an entire cell perhaps, are equations the way to go?

Describe Pi-calculus and Petri Nets informally and their differences.

Outline the goals and the work done in the study

End of introduction.


## Petri Net basics
#### Syntax
Explain the graphical notation and its advantages -> intuitive, closely resembles chemical notation but more formal, general

#### Semantics
Operational semantics formally both in terms of graph changes.

#### Stochastic Petri Net extension
Differences in the operation semantics with the addition of delay.

## FA metabolism basics
Explain the system that we try to model from Acetyl-CoA to FAs.


## Basic Petri Net model

#### Original model and reduced order model
Assumptions made for reduced order model etc.

#### Reduced order model as a series of Bernoulli trials
##### The Data

##### Point estimation of parameters
From Data to point estimates of the success probabilities.
##### An exact likelihood function and parameter distributions
Explain the likelihood function for the system and give results of MCMC for
success probabilities.

##### Flow parameters calculation(lambdas)
Stoichiometry considerations etc.


##### A stochastic pi-calculus version of the basic model
Difference with standard pi-calculus, quantitative semantics.


## Extended Petri Net model (control AMPK)

Explain control mechanisms. Give references to literature
Give the model and explain



## Discussion

Is Petri Nets a succesfull/useful formalism for talking about metabolism? 
Advantages/Disadvantages (maybe compared to stoch pi-calculus)

The Future: a formal modeling language for multi-level modeling of biological systems which will 
support multi-level abstractions and the interfaces between them? Can this give rise to a 'real'
programming language like lambda-calculus gave rise to Lisp or pi-calculus inspired Actors in 
Scala and message-passing in Erlang?

Also, more extensive use of dynamic models instead of static pictures of KEGG pathways?
More tools to make it easier for Biologists, so I think computational models instead of 
mathematical models would be a better choice(more intuitive,  better tools)

Something that will combine the advantages of reaction-centric graphical languages like Petri Nets and 
the advantages of process-algebras maybe?

