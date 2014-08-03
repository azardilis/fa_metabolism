fa
GetMLEstimates <- function(data) {
    # Return point estimates for the parameters based on the ML
    # estimation of success probabilities of the independent
    # Bernoulli trials
    MakeAbsNums <- function(d) {
        nd <- apply(d, 1, function(x) { floor(x / min(x[x > 0])) })

        return(t(nd))
    }

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




Likelihood <- function(p) {
    D <- c(5, 231, 3061, 468, 4, 1)
    D <- c(1, 0, 0, 0, 0, 0)
    succ.probs <- list(1-p, p)
    lprobs <- rep(0, length(D))
    for (i in 1:length(D)) {
        events <- c(rep(1, i-1), 2)
        sp <- sum(sapply(1:length(events), function(x) { log(succ.probs[[events[x]]][x]) }))
        lprobs[i] <- D[i] * sp
    }

    return(sum(lprobs))
}

ProposalFunc <- function(p) {
    return(sapply(p, function(x) { rtruncnorm(1, 0, 1, mean=x, sd=0.1) }))

}

mcmc <- function(ip, n.steps) {
    # MCMC sampling from the posterior of model parameters
    mcmc.trace <- matrix(rep(0, n.steps*6), nrow=n.steps)
    mcmc.trace[1, ] <- ip
    p <- ip
    oldll <- Likelihood(p)
    for (i in 2:n.steps) {
        pp <- ProposalFunc(p)
        loglik <- Likelihood(pp)
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


