
GetMLEstimates <- function() {
    # Return point estimates for the parameters based on the ML
    # estimation of success probabilities of the independent
    # Bernoulli trials
    MakeAbsNums <- function(data) {
        nd <- apply(data, 1, function(x) { floor(x / min(x[x > 0])) })

        return(t(nd))
    }

    FilterData <- function(data) {
        fas <- c("C.12.0", "C.14.0", "C.16.0", "C.18.0", "C.20.0", "C22.0")
        data <- data[data$Treatment=="C", rev(fas)]

        return(data)
    }

    fname <- "data/GCFIDrawdata.csv"
    data <- read.csv(fname)
    data <- FilterData(data)
    n.data <- MakeAbsNums(data)

    n.succ <- colSums(n.data)
    n.trials <- rowSums(apply(n.data, 1, function(x) { cumsum(x) }))

    ml.params <- n.succ / n.trials

    return(ml.params)
}

Likelihood <- function(p) {
    D <- c(5, 231, 3061, 468, 4, 1)
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




