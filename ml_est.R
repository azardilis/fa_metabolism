MakeAbsNums <- function(d) {
    nd <- apply(d, 1, function(x) { ceiling(x / min(x[x > 0])) })

    return(t(nd))
}

GetMLEstimates <- function(data) {
    # Return point estimates for the parameters based on the ML
    # estimation of success probabilities of the independent
    # Bernoulli trials


    n.data <- MakeAbsNums(data)
    n.succ <- colSums(n.data)
    n.trials <- rowSums(apply(n.data, 1, function(x) { cumsum(x) }))
    n.trials[n.trials == 0] <- 1 #avoid NaNs
    ml.params <- n.succ / n.trials

    return(ml.params)
}

FilterControls <- function() {
    FilterData <- function(data) {
        fas <- c("C.12.0", "C.14.0", "C.16.0", "C.18.0", "C.20.0", "C22.0")
        data <- data[data$Treatment=="C", rev(fas)]

        return(data)
    }

    fname <- "data/GCFIDrawdata.csv"
    data <- read.csv(fname)
    data <- FilterData(data)

    return(data)
}

GetMLEstimatesSample <- function() {
    #Return point estimates for the parameters based on the ML
    #estimation of success probabilities per sample
    fname <- "data/GCFIDrawdata.csv"

    data <- read.csv(fname)
    fas <- c("C.12.0", "C.14.0", "C.16.0", "C.18.0", "C.20.0", "C22.0")
    data <- data[, rev(fas)]

    res <- apply(data, 1, function(x) {GetMLEstimates(matrix(x, nrow=1))})
    res <- t(res)
    colnames(res) <- rev(fas)

    return(res)
}


LikelihoodData <- function(D) {

    Likelihood <- function(p) {

        succ.probs <- list(1-p, p)
        lprobs <- rep(0, length(D))
        for (i in 1:length(D)) {
            events <- c(rep(1, i-1), 2)
            sp <- prod(sapply(1:length(events), function(x) { succ.probs[[events[x]]][x] }))
            lprobs[i] <- D[i]*sp
        }

        return(prod(lprobs))
    }

    return(Likelihood)
}

ProcessLik <- function(D) {

    Lik <- function(p) {
        probs <- rep(0, length(D))
        probs[1] <- D[1]*p[1]
        for (i in 2:length(D)) {
            probs[i] <- D[i]*p[i]*prod(1-p[1:(i-1)])
        }
        return(probs)
    }

    return(Lik)
}


ProposalFunc <- function(p) {
    return(sapply(p, function(x) { rtruncnorm(1, 0, 1, mean=x, sd=0.1) }))

}

mcmc <- function(ip, n.steps) {
    # MCMC sampling from the posterior of model parameters
    data <- FilterControls()
    n.data <- rev(colSums(MakeAbsNums(data[1, ])))

    mcmc.trace <- matrix(rep(0, n.steps*length(ip)), nrow=n.steps)
    mcmc.trace[1, ] <- ip
    p <- ip
    oldll <- dmultinom(n.data, sum(n.data), GetSinkProb(p), log=TRUE)
    for (i in 2:n.steps) {
        pp <- ProposalFunc(p)
        loglik <- dmultinom(n.data, sum(n.data), GetSinkProb(pp), log=TRUE)#Likelihood(pp)
        a <- loglik - oldll
        if (log(runif(1)) < a) {
            p <- pp
            oldll <- loglik
        }
        mcmc.trace[i, ] <- p
    }

    return(mcmc.trace)
}



GetEventProb <- function(p, i) {
    if (i == 1) { return(p[1]) }
    pi <- p[i]*prod((1-p)[1:(i-1)])
    return(pi)
}

GetSinkProb <- function(p) {
    return(sapply(1:length(p), function(x) { GetEventProb(p, x) }))
}


GetInputRateEstimates <- function() {
    bern.tca <- 0.5
    data <- FilterControls()
    p <- rev(GetMLEstimates(data))
    ep <- GetSinkProb(p)
    event.exp <- sum((1:length(p)) * ep)

    rates <- c(1, event.exp, event.exp)
    rates <- rates/sum(rates)

    rates[3] <- rates[3] / bern.tca
    rates <- rates / sum(rates)

    return(rates)
}


BinLik <- function(x, p, n) {
    return(dbinom(x,size=n,prob=p,log=TRUE))
}










cl.inds <- lapply(1:5, function(x) { read.table(paste0("cl", x, ".txt")) })
fas <- c("C.12.0", "C.14.0", "C.16.0", "C.18.0", "C.20.0", "C22.0")
fname <- "data/GCFIDrawdata.csv"
data <- read.csv(fname)
data <- data[, rev(fas)]

data.cl <- lapply(cl.inds, function(ind.l) { data[unlist(ind.l), ] })
cl.centres <- lapply(data.cl, function(cl) { colMeans(cl) })
cl.centres[[4]] <- NULL
ml.est <- lapply(cl.centres, function(cl) {GetMLEstimates(t(as.matrix(cl)))})
ml.est.mat <- matrix(unlist(ml.est), nrow=4, byrow = T)
colnames(ml.est.mat) <- rev(fas)
ml.est.mat <- ml.est.mat[, fas]

xtable(ml.est.mat)



