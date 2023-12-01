

# Part of ComPlEx_copy. An effort in splitting strings for entire data set.
# Issue arises due to empty strings creating different vector lengths. 
# One alternative would be to add text to empty strings, but this seems like uneccessary work. 

library(dplyr)
library(tidyr)

setwd("~/NMBU/M60-BIAS/EvoTree/githubEvoTree")
ortho <- read.delim2(ortholog_group_file, header = TRUE, sep = "\t")
  
OG_RData <- ortholog_group_RData [1]  # REMOVE THIS LINE BEFORE RUNNING LOOP.
ortho <- read.delim2(ortholog_group_file, header = TRUE, sep = "\t") 
  # Issue: separate_rows doesn't like empty rows... but rows can't be removed yet - this needs to be done pairwise. 
  
  
  ortho <- ortho[c(1:100), -c(1)]  
  column_list <- c()
  
  for (i in 1:ncol(ortho)) { # i = 1,2,3,...11
    # for (r in 1:length(ortho[,i])){ # r = 1,2,3,...100
    
    column_name <- colnames(ortho)[i] #get the name of column
    column_list <- append(column_list, col_name, after = length(column_list)) # add all column names to list
    
    for (column in col_name){
      for(x in 1:nrow(ortho[,i]))
        cell <- ortho[x,i]
      if(ortho[cell] != "")  
        ortho <- separate_rows_(ortho, all_of(columns)) 
    }
    
  }
  
  
    

