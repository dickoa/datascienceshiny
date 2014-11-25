library(forecast)
library(ggplot2)
library(tidyr)
library(dplyr)
library(mgcv)

decomp_ts <- function(x, transform = TRUE) {
    ## Transform series
    if(transform & min(x, na.rm = TRUE) >= 0) {
        lambda <- BoxCox.lambda(na.contiguous(x))
        x <- BoxCox(x,lambda)
    } else {
        lambda <- NULL
        transform <- FALSE
    }
    ## Seasonal data
    if(frequency(x) > 1) {
      x.stl <- stl(x,s.window="periodic",na.action=na.contiguous)
      trend <- x.stl$time.series[,2]
      season <- x.stl$time.series[,1]
      remainder <- x - trend - season
      df <- data.frame(date = as.Date(time(x)),
                       orig = as.vector(x),
                       season = as.vector(season),
                       trend = as.vector(trend),
                       remainder = as.vector(remainder))           
  } else { #Nonseasonal data 
      tt <- 1:length(x)
      trend <- rep(NA,length(x))
      trend[!is.na(x)] <- fitted(gam(x ~ s(tt)))
      season <- NULL
      remainder <- x - trend
      df <- data.frame(date = as.Date(time(x)),
                       orig = as.vector(x),
                       trend = as.vector(trend),
                       remainder = as.vector(remainder))   
  }
  df <- df %>%
    gather(type, value, -date)
  return(df)
}
