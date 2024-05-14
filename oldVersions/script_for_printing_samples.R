
library(tidyverse)


# Species list
species_list <- c("Lodge", "Asp", "Nor","Scots","Birch","Cher")

# Loop for file name
file_list_2 <- c()
for (i in species_list){
  
  expr_name <- paste0("Data/DATA/transcriptomicsData/",i,"Wood_transcriptomics.txt")
  file_list_2 <- append(file_list_2, expr_name, after = length(file_list_2))
  
}


for (i in 1:length(file_list_2)){
  
  # i <- 6
  
  x <- read_delim(file_list_2[i], show_col_types = FALSE)
  
  
  
  species <- sapply(strsplit(file_list_2[i], "transcriptomicsData/"), "[",2)
  species <- sapply(strsplit(species, "Wood"), "[", 1)
  
  
  expression_data <- x %>%
    
    column_to_rownames("Genes") %>% 
    select(contains("1."))
  
  cat("Species: ", species)
  cat("\n")
  cat("Number of samples: ", length(colnames(expression_data)))
  cat("\n")
  cat("Range: ", colnames(expression_data))
  cat("\n")
  cat("\n")
  
}
