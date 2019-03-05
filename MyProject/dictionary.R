#' ---
#' title: "Kidney Cancer Data Dictionary Init"
#' author: 
#' - "Alex F. Bokov^[UT Health, Department of Epidemiology and Biostatistics]"
#' date: "09/14/2018"
#' ---
#' 
#+ message=F,echo=F
# init -------------------------------------------------------------------------
debug <- 0;
if(debug>0) source('global.R') else {
  .junk<-capture.output(source('global.R',echo=F))};
.currentscript <- parent.frame(2)$ofile;
if(is.null(.currentscript)) .currentscript <- 'RUN_FROM_INTERACTIVE_SESSION';
tself(scriptname=.currentscript);
#' Saving original file-list so we don't keep exporting functions and 
#' environment variables to other scripts
.origfiles <- ls();
#+ echo=F
# read dat0 --------------------------------------------------------------------
#' If we don't know the field delimiter for sure, we will avoid making 
#' assumptions and try to determine it empirically
if(!exists('file_delim')) {
  .temp <- try(read_tsv(inputdata,spec_tsv,n_max=1000));
  #' If there was an error or there is only one column in the result, assume we 
  #' guessed wrong and fail over to using CSV otherwise use TSV
  file_delim <- if(is(.temp,'try-error')||length(.temp$cols)==1) ',' else '\t'
}

#' ## Initialize the column specification for parsing the input data
dat0spec <- spec_delim(inputdata,na=c('(null)','','.')
                       ,guess_max=5000
                       ,skip=n_skip
                       ,delim = file_delim);

#' ## Optional: patient number
#' 
#' If you patient number variable (see `global.R`) is a number, force it to be
#' treated as numeric rather than an integer to avoid missing values due to it 
#' being too large
if(pn %in% names(dat0spec$cols)) dat0spec$cols[[pn]] <- col_number();

#' ## Read the data 
dat0 <- read_delim(inputdata,delim=file_delim
                   ,na=c('(null)','','.')
                   ,skip=n_skip
                   ,col_type=dat0spec);
#' The `colnames` command is unusual in that is 
#' can both output a result and be on the receiving
#' end of a value assignment.
colnames(dat0) <- tolower(colnames(dat0));
#' Hint: if your data has no column names, here is
#' how you can auto-generate them:
# colnames(datX) <- make.names(seq_len(ncol(datX)))

#+ echo=F
# make data dictionary ---------------------------------------------------------
#' ## Create the data dictionary (TBD)
#dct0 <- rebuild_dct(dat0,dctfile_raw,dctfile_tpl,tread_fun = read_csv,na=''
#                    ,searchrep=globalsearchrep);

#+ echo=F
# a few dat0 hacks -------------------------------------------------------------
#' ## Raw Data Ops
#' 
#' Since you're messing around with the raw data anyway, if there is anything 
#' you will need later which does not depend on the processing steps in the
#' `data.R` script, you might as well get it out of the way in this section

#+ echo=F
# save out ---------------------------------------------------------------------
#' ## Save all the processed data to an rdata file 
#' 
#' ...which includes the audit trail
tsave(file=paste0(.currentscript,'.rdata'),list=setdiff(ls(),.origfiles));
#+ echo=F,eval=F
c()