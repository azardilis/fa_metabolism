
GetMLEstimates <- function() {
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















