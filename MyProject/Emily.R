#' ---
#' title: "NewScript"
#' author: "Emily"
#' date: "16/04/2019"
#' ---
#' 
#+ message=F,echo=F
# init -----

# set to > 0 for verbose initialization
debug <- 0;

# vector of additional packages to install, if needed. If none needed, should be
# an empty string
.packages <- c( 'GGally','ggplot2','tableone' );

# name of this script
.currentscript <- "Emily.R"; 

# vector of other scripts which need to run before this one. If none needed, 
# should be an empty string
.deps <- c( 'dictionary.R' ); 

# load stuff ----
# load project-wide settings, including your personalized config.R
if(debug>0) source('global.R') else {
  .junk<-capture.output(source('global.R',echo=F))};
# load any additional packages needed by just this script
message('Problem?')
if(length(.packages) > 1 || .packages != '') instrequire(.packages);
# start logging
tself(scriptname=.currentscript);
# track what objects here come from other scripts
.origfiles <- ls(); .loadedobjects <- c();
# run scripts on which this one depends, if any that have not been
# cached yet
if(length(.deps)>1 || .deps != ''){
  for(ii in .deps){
    .depdata <- paste0(ii,'.rdata');
    if(!file.exists(.depdata)) {
      system(sprintf('R -e "source(\'%s\')"',ii))};
    .loadedobjects <- union(.loadedobjects,tload(.depdata));
  }
}
#+ echo=F
#############################################################
# Your code goes below, content provided only as an example #
#############################################################

#' ### Data Dictionary
#' 
#' Quality control, descriptive statistics, etc.

#+ echo=F
# characterization ----
set.caption('Data Dictionary');
set.alignment(row.names='right')
.oldopt00 <- panderOptions('table.continues');
panderOptions('table.continues','Data Dictionary (continued)');
#  render the Data Dictionary table
pander(dct0[,-1],row.names=dct0$column); 
#  reset this option to its previous value
panderOptions('table.continues',.oldopt00);

#' ### Select predictor and outcome variables (step 8)
#' 
#' Predictors
# Uncomment the below line after putting in the actual predictor column names
# from your dat0
predictorvars <- c('race','ethnicity','gender');
#' Outcomes
# Uncomment the below line after putting in the actual outcome column names
# from your dat0
outcomevars <- c('surgical.approach','type.of.diversion');
#' All analysis-ready variables
# Uncomment the below line after predictorvars and outcomevars already exist
mainvars <- c(outcomevars, predictorvars);
#' ### Scatterplot matrix (step 10)
#' 
#' To explore pairwise relationships between all variables of interest.
#+ ggpairs_plot
# Uncomment the below after mainvars already exists and you have chosen a 
# discrete variable to take the place of VAR1 (note that you don't quote that
# one)
dat1 <- dat0
dat1$gender <- factor(dat0$gender,levels = 0:1,labels = c('Male','Female'));
dat1$ethnicity <- factor(dat0$ethnicity,levels = 0:1,labels = c('Non-Hispanic','Hispanic'));
dat1$race <- factor(dat0$race,levels = 0:3,labels = c('Caucasian','African-American','Asian','Other'));
dat1$surgical.approach <- factor(dat0$surgical.approach,levels = 0:3,labels = c('Open','Robotic with Open','Total Robotic','Robotic Converted to Open'));
dat1$type.of.diversion <- factor(dat0$type.of.diversion,levels = 0:2,labels = c('Ileal Conduit','Continent Cutaneous','Orthopic Neobladder'));
ggpairs(dat1[,mainvars],mapping=aes(color=gender));
ggpairs(dat1[,mainvars],mapping=aes(color=ethnicity));
ggpairs(dat1[,mainvars],mapping=aes(color=type.of.diversion));
#' ### Cohort Characterization (step 10)
#' 
#' To explore possible covariates
# Uncomment the below code after mainvars exists and you have chosen a discrete
# variable to take the place of VAR1 (this time you do quote it)
#
#pander(print(CreateTableOne(
#  vars = setdiff(mainvars,'VAR1'),strata='VAR1',data = dat0
#  , includeNA = T), printToggle=F), caption='Group Characterization');

#' ### Data Analysis
#' 
#' Fitting the actual statistical models.
#+ echo=F
# analysis ----

#+ echo=F
#############################################################
# End of your code, start of boilerplate code               #
#############################################################

# save out with audit trail ----
# Saving original file-list so we don't keep exporting functions and 
# environment variables to other scripts. Could also replace .origfiles
# with the expression c(.origfiles,.loadedobjects) and then, nothing
# get inherited from previous files, only the stuff created in this 
# script gets saved. If this doesn't make sense, don't worry about it.
tsave(file=paste0(.currentscript,'.rdata'),list=setdiff(ls(),.origfiles)
      ,verbose=F);

#' ### Audit Trail
#+ echo=F
.wt <- walktrail();
pander(.wt[order(.wt$sequence),-5],split.tables=Inf,justify='left',missing=''
       ,row.names=F);
#+ echo=F,eval=F
c()
