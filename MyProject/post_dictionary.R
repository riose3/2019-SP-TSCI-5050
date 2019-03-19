dat0 <- read.xlsx(inputdata00, startRow = 2, detectDates = T, check.names = T);
names(dat0);
sapply(dat0, class)
cbind(sapply(dat0, function(xx) class(xx) [1]))
dct0 <- data.frame(origname=names(dat0), class=sapply(dat0, class));
dct0$c_outcome <-


c()