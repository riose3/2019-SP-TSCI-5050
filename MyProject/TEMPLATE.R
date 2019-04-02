#' ---
#' title: "%1$s"
#' author: "%2$s"
#' date: "%3$s"
#' ---
#' 
#+ message=F,echo=F
# init -----
debug <- 0;
if(debug>0) source('global.R') else {
  .junk<-capture.output(source('global.R',echo=F))};
.currentscript <- parent.frame(2)$ofile;
if(is.null(.currentscript)) .currentscript <- 'RUN_FROM_INTERACTIVE_SESSION';
tself(scriptname=.currentscript);
#' Saving original file-list so we don't keep exporting functions and 
#' environment variables to other scripts
.origfiles <- ls();
# read student pre-run script if it exists ----
if('pre_dictionary.R' %%in%% list.files()) source('pre_dictionary.R');

# This is a new section ----
