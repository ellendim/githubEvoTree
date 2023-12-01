
# Imputation of columns (samples) for the expression data.

# Asp - specimen 1: continuous from 1->25
# Nor - specimen 1: quite a few are missing.....
# Birch - specimen 2: continuous from 1 -> 28
# Cher - specimen 1: continuous from 1->27
# Scots - specimen 1: continuous from 1->28


library(dplyr)
library(tidyr)
library(cowplot)
library(ComplexHeatmap)
setwd("~/NMBU/M60-BIAS/EvoTree/githubEvoTree/Comparative-heatmap_files")


# -------------------------- NORWOOD -------------------------- 

expression_data_nor <- read.delim("Data/DATA/NorWood_transcriptomics_original.txt")
expression_data_nor_imp <- expression_data_nor %>%
  select(c(1:19)) %>%
  mutate(S1.10 = (S1.09 +S1.11)/2, .after = S1.09) %>% 
  mutate(S1.15 = (S1.13 +S1.17)/2, .after = S1.13) %>% 
  mutate(S1.14 = (S1.13 +S1.15)/2, .after = S1.13) %>% 
  mutate(S1.16 = (S1.15 +S1.17)/2, .after = S1.15) %>% 
  mutate(S1.21 = (S1.20+S1.22)/2, .after = S1.20)


# Save with the same file name structure as the others, careful not to mix with original!
write.table(expression_data_nor_imp, file = "~/NMBU/M60-BIAS/EvoTree/githubEvoTree/Comparative-heatmap_files/Data/DATA/NorWood_transcriptomics.txt",
            sep = "\t",row.names = T )

q <-read.delim("Data/DATA/NorWood_transcriptomics.txt")

# -------------------------- BIRCHWOOD -------------------------- 

expression_data_birch <- read.delim("Data/DATA/BirchWood_transcriptomics_original.txt")
expression_data_birch_imp <- expression_data_birch %>%
  select(c(1:27)) %>%
  mutate(B1.10 = (B1.09 +B1.11)/2, .after = B1.09) %>% 
  mutate(B1.24 = (B1.23 +B1.25)/2, .after = B1.23) 

# Save with the same file name structure as the others, careful not to mix with original!
write.table(expression_data_birch_imp, file = "~/NMBU/M60-BIAS/EvoTree/githubEvoTree/Comparative-heatmap_files/Data/DATA/BirchWood_transcriptomics.txt",
            sep = "\t",row.names = T )

q <-read.delim("Data/DATA/BirchWood_transcriptomics.txt")


# -------------------------- CHERWOOD -------------------------- 

# From heatmaps we see that sample nr. 17 stands out in all correlations.
# Wish to remove + imputate.

expression_data_cher <- read.delim("Data/DATA/CherWood_transcriptomics_original.txt")
expression_data_cher_imp <- expression_data_cher %>%
  select(c(1:28)) %>%
  select(-C1.17) %>% 
  mutate(C1.17 = (C1.16 + C1.18)/2, .after = C1.16) 


# Save with the same file name structure as the others, careful not to mix with original!
write.table(expression_data_cher_imp, file = "~/NMBU/M60-BIAS/EvoTree/githubEvoTree/Comparative-heatmap_files/Data/DATA/CherWood_transcriptomics.txt",
            sep = "\t",row.names = T )

q <-read.delim("Data/DATA/CherWood_transcriptomics.txt")




# -------------------------- COMPARING BETWEEN SPECIMENS -------------------------- 

expr_nor_1 <- expression_data_nor %>% 
  select(contains("1."))
  

expr_nor_2 <-expression_data_nor %>% 
  select(contains("2."))

expr_nor_3 <- expression_data_nor %>% 
  select(contains("3."))

# Imputation using samples from nor s3 into s1:
# See above...

# Imputation using mean of adjacent samples:

expr_nor_mean <- expr_nor_1 %>%
  mutate(S1.10 = (S1.09 +S1.11)/2, .after = S1.09) %>%
  mutate(S1.15 = (S1.13+S1.17)/2, .after = S1.13)
  

corr_original <- round(cor(expr_nor_1, expr_nor_1, method = "pearson"), 4)
corr_nor_imp <- round(cor(expression_data_nor_imp[,-1],expression_data_nor_imp[,-1], method = "pearson"), 4)
corr_nor_mean <- round(cor(expr_nor_mean, expr_nor_mean, method = "pearson"),4)

hm_imp <-  Heatmap(corr_nor_imp, column_title = "Nor S1 imputated",     
                    column_title_gp = gpar(fontsize = 15),
                    row_names_gp = gpar(fontsize = 8),
                    column_names_gp = gpar(fontsize = 8),
                    width = ncol(corr_nor_imp)*unit(5, "mm"),
                    height = nrow(corr_nor_imp)*unit(5, "mm"),
                    row_order = 1:ncol(expression_data_nor_imp[,-1]),
                    column_order = 1:ncol(expression_data_nor_imp[,-1]),
                    name = "corr" )


hm_mean <-  Heatmap(corr_nor_mean, column_title = "Nor S1 mean",     
                    column_title_gp = gpar(fontsize = 15),
                    row_names_gp = gpar(fontsize = 8),
                    column_names_gp = gpar(fontsize = 8),
                    width = ncol(corr_nor_mean)*unit(5, "mm"),
                    height = nrow(corr_nor_mean)*unit(5, "mm"),
                    row_order = 1:ncol(expr_nor_mean),
                    column_order = 1:ncol(expr_nor_mean),
                    name = "corr" )

hm_original <-  Heatmap(corr_original, column_title = "Nor S1 orig",     
                    column_title_gp = gpar(fontsize = 15),
                    row_names_gp = gpar(fontsize = 8),
                    column_names_gp = gpar(fontsize = 8),
                    width = ncol(corr_original)*unit(5, "mm"),
                    height = nrow(corr_original)*unit(5, "mm"),
                    row_order = 1:ncol(expr_nor_1),
                    column_order = 1:ncol(expr_nor_1),
                    name = "corr" )


nor_or <- grid.grabExpr(print(hm_original))
nor_imp <- grid.grabExpr(print(hm_imp))
nor_mean <- grid.grabExpr(print(hm_mean))


plot_grid(nor_imp, nor_or)
plot_grid(nor_or, nor_imp, nor_mean)

# ---- pairwise within ----

corr_12 <- round(cor(expr_nor_1,expr_nor_2, method = "pearson"), 4) 
corr_13 <- round(cor(expr_nor_1,expr_nor_3, method = "pearson"), 4)
corr_11 <- round(cor(expr_nor_1,expr_nor_1, method = "pearson"), 4)
corr_22 <- round(cor(expr_nor_2,expr_nor_2, method = "pearson"), 4)
corr_33 <- round(cor(expr_nor_3,expr_nor_3, method = "pearson"), 4)

hm_12 <-  Heatmap(corr_12, column_title = "Nor S1 vs. Nor S2",     
               column_title_gp = gpar(fontsize = 15),
               row_names_gp = gpar(fontsize = 8),
               column_names_gp = gpar(fontsize = 8),
               width = ncol(corr_12)*unit(5, "mm"),
               height = nrow(corr_12)*unit(5, "mm"),
               row_order = 1:ncol(expr_nor_1),
               column_order = 1:ncol(expr_nor_2),
               name = "corr" )

hm_13 <-  Heatmap(corr_13, column_title = "Nor S1 vs. Nor S3",     
                  column_title_gp = gpar(fontsize = 15),
                  row_names_gp = gpar(fontsize = 8),
                  column_names_gp = gpar(fontsize = 8),
                  width = ncol(corr_13)*unit(5, "mm"),
                  height = nrow(corr_13)*unit(5, "mm"),
                  row_order = 1:ncol(expr_nor_1),
                  column_order = 1:ncol(expr_nor_3),
                  name = "corr" )


hm_11 <-  Heatmap(corr_11, column_title = "Nor S1 vs. Nor S1",     
                  column_title_gp = gpar(fontsize = 15),
                  row_names_gp = gpar(fontsize = 8),
                  column_names_gp = gpar(fontsize = 8),
                  width = ncol(corr_11)*unit(5, "mm"),
                  height = nrow(corr_11)*unit(5, "mm"),
                  row_order = 1:ncol(expr_nor_1),
                  column_order = 1:ncol(expr_nor_1),
                  name = "corr" )

hm_22 <-  Heatmap(corr_22, column_title = "Nor S2 vs. Nor S2",     
                  column_title_gp = gpar(fontsize = 15),
                  row_names_gp = gpar(fontsize = 8),
                  column_names_gp = gpar(fontsize = 8),
                  width = ncol(corr_22)*unit(5, "mm"),
                  height = nrow(corr_22)*unit(5, "mm"),
                  row_order = 1:ncol(expr_nor_2),
                  column_order = 1:ncol(expr_nor_2),
                  name = "corr" )

hm_33 <-  Heatmap(corr_33, column_title = "Nor S3 vs. Nor S3",     
                  column_title_gp = gpar(fontsize = 15),
                  row_names_gp = gpar(fontsize = 8),
                  column_names_gp = gpar(fontsize = 8),
                  width = ncol(corr_33)*unit(5, "mm"),
                  height = nrow(corr_33)*unit(5, "mm"),
                  row_order = 1:ncol(expr_nor_3),
                  column_order = 1:ncol(expr_nor_3),
                  name = "corr" )


g1 <- grid.grabExpr(print(hm_12))
g2 <- grid.grabExpr(print(hm_13))
g3 <- grid.grabExpr(print(hm_11))
g4 <- grid.grabExpr(print(hm_22))
g5 <- grid.grabExpr(print(hm_33))
plot_grid(g1, g2)
plot_grid(g3, g4, g5)
  
# Same for Birch

expression_birch <- read.delim("Data/DATA/BirchWood_transcriptomics.txt")

expr_birch_1 <- expression_birch%>% 
  select(contains("1."))


expr_birch_2 <-expression_birch %>% 
  select(contains("2."))

expr_birch_3 <- expression_birch %>% 
  select(contains("3."))

corr_11_b <- round(cor(expr_birch_1,expr_birch_1, method = "pearson"), 4)
corr_22_b <- round(cor(expr_birch_2,expr_birch_2, method = "pearson"), 4)
corr_33_b <- round(cor(expr_birch_3,expr_birch_3, method = "pearson"), 4)

hm_11_b <-  Heatmap(corr_11_b, column_title = "Birch S1 vs. Birch S1",     
                  column_title_gp = gpar(fontsize = 15),
                  row_names_gp = gpar(fontsize = 8),
                  column_names_gp = gpar(fontsize = 8),
                  width = ncol(corr_11_b)*unit(5, "mm"),
                  height = nrow(corr_11_b)*unit(5, "mm"),
                  row_order = 1:ncol(expr_birch_1),
                  column_order = 1:ncol(expr_birch_1),
                  name = "corr" )

hm_22_b <-  Heatmap(corr_22_b, column_title = "Birch S2 vs. Birch S2",     
                  column_title_gp = gpar(fontsize = 15),
                  row_names_gp = gpar(fontsize = 8),
                  column_names_gp = gpar(fontsize = 8),
                  width = ncol(corr_22_b)*unit(5, "mm"),
                  height = nrow(corr_22_b)*unit(5, "mm"),
                  row_order = 1:ncol(expr_birch_2),
                  column_order = 1:ncol(expr_birch_2),
                  name = "corr" )

hm_33_b <-  Heatmap(corr_33_b, column_title = "Birch S3 vs. Birch S3",     
                  column_title_gp = gpar(fontsize = 15),
                  row_names_gp = gpar(fontsize = 8),
                  column_names_gp = gpar(fontsize = 8),
                  width = ncol(corr_33_b)*unit(5, "mm"),
                  height = nrow(corr_33_b)*unit(5, "mm"),
                  row_order = 1:ncol(expr_birch_3),
                  column_order = 1:ncol(expr_birch_3),
                  name = "corr" )


g3_b <- grid.grabExpr(print(hm_11_b))
g4_b <- grid.grabExpr(print(hm_22_b))
g5_b <- grid.grabExpr(print(hm_33_b))

plot_grid(g3_b,g5_b)
plot_grid(g4_b)


# We know what a 'perfect' correlation looks like, and can look at the pattern that scots pine makes - can extract the missing values from the other specimens.

# First, take a look at scots pine...

expr_scots <- read.delim("Data/DATA/ScotsWood_transcriptomics.txt")

expr_scots_1 <- expr_scots%>% 
  select(contains("1."))


expr_scots_2 <-expr_scots %>% 
  select(contains("2."))

expr_scots_3 <- expr_scots %>% 
  select(contains("3."))

corr_11_s <- round(cor(expr_scots_1,expr_scots_1, method = "pearson"), 4)
corr_22_s <- round(cor(expr_scots_2,expr_scots_2, method = "pearson"), 4)
corr_33_s <- round(cor(expr_scots_3,expr_scots_3, method = "pearson"), 4)

hm_11_s <-  Heatmap(corr_11_s, column_title = "Scots S1 vs. Scots S1",     
                    column_title_gp = gpar(fontsize = 15),
                    row_names_gp = gpar(fontsize = 8),
                    column_names_gp = gpar(fontsize = 8),
                    width = ncol(corr_11_s)*unit(5, "mm"),
                    height = nrow(corr_11_s)*unit(5, "mm"),
                    row_order = 1:ncol(expr_scots_1),
                    column_order = 1:ncol(expr_scots_1),
                    name = "corr" )

hm_22_s <-  Heatmap(corr_22_s, column_title = "Scots S2 vs. Scots S2",     
                    column_title_gp = gpar(fontsize = 15),
                    row_names_gp = gpar(fontsize = 8),
                    column_names_gp = gpar(fontsize = 8),
                    width = ncol(corr_22_s)*unit(5, "mm"),
                    height = nrow(corr_22_s)*unit(5, "mm"),
                    row_order = 1:ncol(expr_scots_2),
                    column_order = 1:ncol(expr_scots_2),
                    name = "corr" )

hm_33_s <-  Heatmap(corr_33_s, column_title = "Scots S3 vs. Scots S3",     
                    column_title_gp = gpar(fontsize = 15),
                    row_names_gp = gpar(fontsize = 8),
                    column_names_gp = gpar(fontsize = 8),
                    width = ncol(corr_33_s)*unit(5, "mm"),
                    height = nrow(corr_33_s)*unit(5, "mm"),
                    row_order = 1:ncol(expr_scots_3),
                    column_order = 1:ncol(expr_scots_3),
                    name = "corr" )


g3_s <- grid.grabExpr(print(hm_11_s))
g4_s <- grid.grabExpr(print(hm_22_s))
g5_s <- grid.grabExpr(print(hm_33_s))

plot_grid(g3_s,g4_s)
plot_grid(g5_s)



#Aspen 

expr_asp_1 <- read.delim("Data/DATA/AspWood_transcriptomics.txt") %>% 
  select(contains("1."))

corr_11_a <- round(cor(expr_asp_1,expr_asp_1, method = "pearson"), 4)


hm_11_a <-  Heatmap(corr_11_a, column_title = "Aspen S1 vs. Aspen S1",     
                    column_title_gp = gpar(fontsize = 15),
                    row_names_gp = gpar(fontsize = 8),
                    column_names_gp = gpar(fontsize = 8),
                    width = ncol(corr_11_a)*unit(5, "mm"),
                    height = nrow(corr_11_a)*unit(5, "mm"),
                    row_order = 1:ncol(expr_asp_1),
                    column_order = 1:ncol(expr_asp_1),
                    name = "corr" )

asp_hm <- grid.grabExpr(print(hm_11_a))
plot_grid(asp_hm)

# 
# 
# # Loading mtcars data
# data("mtcars")
# # Writing mtcars data
# write.table(mtcars, file = "~/NMBU/M60-BIAS/EvoTree/githubEvoTree/Comparative-heatmap_files/Data/DATA/mtcars.txt", sep = "\t",
#             row.names = TRUE)
# 
# 
# w <- read.delim("Data/DATA/mtcars.txt")
# w



# ----------------------- OTHER CODE + NOTES ----------------------- 

# Some linear function to create samples 14, 15 and 16...


# Get an overview over missing values:
# 
# original_sample_set <- c()
# 
# for(sample in colnames(expression_data_nor_imp)){
#   sample_nr <- sapply(strsplit(sample, "S1."), "[", 2)
#   print(sample_nr)
#   # can add as.numeric if needed.
# 
#   original_sample_set <- append(original_sample_set, sample_nr, after = length(original_sample_set))
# }
# 
# missing_samples <- c()
# n <- 27
# all_possible_samples <- c(1:n)
# all_possible_samples <- formatC(format = "d",x = all_possible_samples, flag = "0", width=ceiling(log10(max(all_possible_samples))))
# 
# 
# for(i in all_possible_samples){
#   if (!i %in% original_sample_set){
#   print(i)
#   missing_samples <- append(missing_samples, i, after = length(missing_samples))
# }
# }

# Imputation using corresponding samples in the other species.
# Can't assume that sample sample 3 in specimen 1 represents the same area as in specimen 3.
# By setting the specimens up against each other it may be possible to check for samples that correspond.


# Fixing comparison tables - not possible!
# comparison_RData<- paste0("Data/DATA/comparison-Scots_Cher-pearsonMR0.03no-tableN.RData")
# load("Data/DATA/comparison-Cher_Scots-pearsonMR0.03no-table.RData")
# 
# data <- comparison_table %>% 
#   mutate(Species1_copy = Species2, .after = OrthoGroup) %>% 
#   mutate(Species2_copy = Species1, .after = Species1_copy) %>% 
#   select(-c("Species1", "Species2")) %>% 
#   rename(Species1 = Species1_copy) %>% 
#   rename(Species2 = Species2_copy)
# 
# save(data, file = comparison_RData)
# # Save
# write.table(data, file =comparison_RData, sep = "\t",row.names = T )
# write.
# 
# rm(comparison_table)
# q <- read.delim("Data/DATA/comparison-Scots_Cher-pearsonMR0.03no-tableN.RData")


