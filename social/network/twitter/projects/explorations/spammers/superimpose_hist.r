superhist2pdf <- function(x, filename = "super_histograms.pdf", dev = "pdf", title = "Superimposed Histograms", nbreaks ="Sturges")
{
    junk = NULL
    grouping = NULL
    for(i in 1:length(x))
    {
        junk = c(junk,x[[i]])
        grouping <- c(grouping, rep(i,length(x[[i]])))
    }
    grouping <- factor(grouping)
    n.gr <- length(table(grouping))
    xr <- range(junk)
    histL <- tapply(junk, grouping, hist, breaks=nbreaks, plot = FALSE)
    maxC <- max(sapply(lapply(histL, "[[", "counts"), max))
    if(dev == "pdf") { pdf(filename, version = "1.4", height=900, width=1600) } else{}
    if((TC <- transparent.cols <- .Device %in% c("pdf", "png")))
    {
        # cols <- hcl(h = seq(30, by=360 / n.gr, length = n.gr), l = 65, alpha = 0.5)
        cols <- hcl(h = c(0, 120, 240), l = 65, alpha = 0.5)
    }
    else
    {
        h.den <- c(10, 15, 20)
        h.ang <- c(45, 15, -30)
    }
    if(TC)
    {
        histL[[1]]$counts <- histL[[1]]$counts / max(histL[[1]]$counts)
        # plot(histL[[1]], xlim = xr, ylim= c(0, 1), col = cols[1], xlab = "x", main = title)
        plot(histL[[1]], xlim = xr, ylim= c(0, 1), col = cols[1], axes=F)
    }
    else
    {
        plot(histL[[1]], xlim = xr, ylim= c(0, maxC), density = h.den[1], angle = h.ang[1], xlab = "x")
    }
    if(!transparent.cols)
    {
        for(j in 2:n.gr) plot(histL[[j]], add = TRUE, density = h.den[j], angle = h.ang[j])
    }
    else
    {
        for(j in 2:n.gr)
        {
            histL[[j]]$counts <- histL[[j]]$counts / max(histL[[j]]$counts)
            plot(histL[[j]], add = TRUE, col = cols[j])
        }
    }
    invisible()
    if( dev == "pdf")
    {
        dev.off()
    }
}
