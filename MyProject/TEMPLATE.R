#' ---
#' title: "%1$s"
#' author: "%2$s"
#' date: "%3$s"
#' ---
#' 
#+ message=F,echo=F
# init -----
# %1$s %2$s %3$s %4$s %5$s %6$s
.packages <- %4$s;
.deps <- %6$s;
.loadedobjects <- c();
debug <- 0;
if(debug>0) source('global.R') else {
  .junk<-capture.output(source('global.R',echo=F))};
if(length(.packages) > 1 || .packages != '') instrequire(.packages);
.currentscript <- "%5$s";
tself(scriptname=.currentscript);
if(length(.deps)>1 || .deps != ''){
  for(ii in .deps){
    .depdata <- paste0(ii,'.rdata');
    if(!file.exists(.depdata)) {
      system(sprintf('R -e "source(\'%%s\')"',ii))};
    .loadedobjects <- union(.loadedobjects,tload(.depdata));
  }
}
#' ### Put your code here!
#+ echo=F
pander(summary(dat0));

#+ echo=F
# Saving original file-list so we don't keep exporting functions and 
# environment variables to other scripts
.origfiles <- ls();

#+ echo=F
# save out with audit trail ----
tsave(file=paste0(.currentscript,'.rdata'),list=setdiff(ls(),.origfiles),verbose=F);
#+ echo=F,eval=F
c()