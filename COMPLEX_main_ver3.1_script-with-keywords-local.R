
# ADD SPECIES 1 AND 2 KEYWORDS BEFORE RUNNING

library(dplyr)
library(tidyr)
library(gdata)
# setwd("~/NMBU/M60-BIAS/EvoTree/githubEvoTree/ComPlEx")


# ------------- Fill in below -------------

# Species to be compared
# Use these combination pairs (S1-S2): 
# Asp-Cher, Asp-Birch, Asp-Scots, Asp-Nor, Nor-Cher, Nor-Birch, Nor-Scots, Scots-Cher, Scots-Birch, Birch-Cher, Lodge-Asp, Lodge-Birch,
# Lodge-Cher, Lodge-Scots, Lodge-Nor

species1_keyword <- "Asp" 
species2_keyword <- "Nor" 
run_version <- "2"

ortholog_group_file <- "Data/DATA/Orthogroups.100323.tsv"

# Parameters
cor_method <- "pearson" # pearson spearman
cor_sign <- "" # abs
norm_method <- "MR" # CLR MR
density_thr <- 0.03
randomize <- "no" # yes no

# For test-runs
test_run <- "yes" # "yes" "no"  
# numb_of_cols <-
numb_of_rows_1 <- 3000
numb_of_rows_2 <- 3000
# ------------- Loop --------------

file <- paste0("Data/DATA/orthologs-",species1_keyword,"-",species2_keyword,"-table.RData")

if (!file.exists(file)){ 
  
  ortho_original <- read.delim2(ortholog_group_file, header = TRUE, sep = "\t")
  
  ortho_general_filtering <- ortho_original %>%
    mutate(Pinsyl.SHORT.cp.pep = Pinsyl.SHORT.pep) %>% 
    rename(
      Asp = Poptre.SHORT.pep,
      Birch = Betpen.SHORT.pep,
      Nor = Picabi.SHORT.pep,
      Scots = Pinsyl.SHORT.pep,
      Cher = Prunavi.SHORT.pep,
      Lodge = Pinsyl.SHORT.cp.pep,
      OrthoGroup = Orthogroup
    ) %>%
    mutate(Asp = gsub("Poptre_", "", Asp)) %>%
    mutate(Birch = gsub("Betpen_", "", Birch)) %>%
    mutate(Cher = gsub("Prunavi_", "", Cher)) %>% 
    select(OrthoGroup, Asp, Nor, Scots, Birch, Cher, Lodge)
  
  # Select the columns in ortho corresponding to the key words from the the ortholog-file name.
  ortho <- ortho_general_filtering %>%
    rename(Species1 = species1_keyword, Species2 = species2_keyword) %>%
    select(OrthoGroup, Species1, Species2) %>%
    filter(Species1 != "", Species2 != "") %>%
    separate_rows(Species1, sep = ", ", convert = FALSE) %>%
    separate_rows(Species2, sep = ", ", convert = FALSE)
  
  # Additional species-specific altercations that are tricky to do before row separation.
  if(species1_keyword == "Asp"){
    
    ortho <- ortho %>% 
      mutate(Species1 = gsub("\\.\\d\\.p\\d$", "", Species1))
  }
  
  if(species2_keyword == "Asp"){
    ortho <- ortho %>% 
      mutate(Species2 = gsub("\\.\\d\\.p\\d$", "", Species2))
    
  }
  
  if(species1_keyword == "Nor"){
    
    ortho <- ortho %>% 
      mutate(Species1 = gsub("\\.p\\d$", "", Species1))
  }
  
  if(species2_keyword == "Nor"){
    ortho <- ortho %>% 
      mutate(Species2 = gsub("\\.p\\d$", "", Species2))
    
  }
  
  if(species1_keyword == "Cher"){
    
    ortho <- ortho %>% 
      mutate(Species1 = gsub("\\.p\\d$", "", Species1))
  }
  
  if(species2_keyword == "Cher"){
    ortho <- ortho %>% 
      mutate(Species2 = gsub("\\.p\\d$", "", Species2))
    
  }
  ortho <- ortho %>% 
    group_by(Species1, Species2, OrthoGroup) %>% 
    slice(1)
  
  # Add annotations from arabidopsis
  symbols <-
    read.delim("~/NMBU/M60-BIAS/EvoTree/githubEvoTree/Data/DATA/gene_aliases_20140331.txt", sep = "\t") %>%
    rename(Arab = locus_name,
           Symbol = symbol,
           Name = full_name)
  
  annot <-
    read.delim2(ortholog_group_file, header = TRUE, sep = "\t") %>%
    rename(Arab = Aratha.SHORT.pep, OrthoGroup = Orthogroup) %>%
    select(Arab, OrthoGroup) %>%
    filter(Arab != "") %>%
    separate_rows(Arab, sep = ", ", convert = FALSE) %>%
    mutate(Arab = gsub("\\.\\d.p\\d$", "", Arab)) %>%
    mutate(Arab = gsub("Aratha_", "", Arab)) %>%
    left_join(symbols, by = "Arab", relationship = "many-to-many") %>%
    group_by(OrthoGroup) %>%
    summarise(
      Arab = paste0(unique(Arab), collapse = "; "),
      Symbol = paste0(unique(Symbol), collapse = "; "),
      Name = paste0(unique(Name), collapse = "; ")
    ) %>%
    mutate(Symbol = gsub("NA", "", Symbol),
           Name = gsub("NA", "", Name))
  
  save(ortho, annot, file = file)
  
  species1_transcription_txt <- paste0("Data/DATA/transcriptomicsData/", species1_keyword,"Wood_transcriptomics.txt")
  species2_transcription_txt <- paste0("Data/DATA/transcriptomicsData/", species2_keyword,"Wood_transcriptomics.txt")
  
  if(test_run == "yes"){
    # Only a subset of genes and samples is run
    species1_expr <- read.delim(species1_transcription_txt, sep = "\t", header = TRUE)[1:numb_of_rows_1, ]
    species2_expr <- read.delim(species2_transcription_txt, sep = "\t", header = TRUE)[1:numb_of_rows_2, ]
    
  } else{
    species1_expr <- read.delim(species1_transcription_txt, sep = "\t", header = TRUE)
    species2_expr <- read.delim(species2_transcription_txt, sep = "\t", header = TRUE)
  }
  
  ortho <- ortho %>%
    filter(Species1 %in% species1_expr$Genes & Species2 %in% species2_expr$Genes)
  
  comparison_RData <- paste0("Data/DATA/comparison-", species1_keyword, "_", species2_keyword, "-", 
                             cor_sign, cor_method, norm_method, density_thr, randomize, "-table-version_",run_version,".RData")
  
  
  
  if (!file.exists(comparison_RData)) {
    if (randomize == "yes") {
      species1_expr$Genes <-
        sample(species1_expr$Genes, nrow(species1_expr), FALSE)
      species2_expr$Genes <-
        sample(species2_expr$Genes, nrow(species2_expr), FALSE)
    }
    # Correlate genes
    species1_net <- cor(t(species1_expr[, -1]), method = cor_method) 
    dimnames(species1_net) <- list(species1_expr$Genes, species1_expr$Genes)               
    
    species2_net <- cor(t(species2_expr[, -1]), method = cor_method)  
    dimnames(species2_net) <- list(species2_expr$Genes, species2_expr$Genes)                 
    
    if (cor_sign == "abs") {
      species1_net <- abs(species1_net)
      species2_net <- abs(species2_net)
    }
    
    if (norm_method == "CLR") {

      
      z <- scale(species1_net)
      z[z < 0] <- 0
      species1_net <- sqrt(t(z) ** 2 + z ** 2)
      
      z <- scale(species2_net)
      z[z < 0] <- 0
      species2_net <- sqrt(t(z) ** 2 + z ** 2)
      
    } else if (norm_method == "MR") {
      R <- t(apply(species1_net, 1, rank)) # Apply rank to correlated genes
      species1_net <- sqrt(R * t(R)) # Geometric average 
      
      R <- t(apply(species2_net, 1, rank))
      species2_net <- sqrt(R * t(R))
    }
    
    diag(species1_net) <- 0
    diag(species2_net) <- 0
    

    R <- sort(species1_net[upper.tri(species1_net, diag = FALSE)], decreasing = TRUE) 
    species1_thr <- R[round(density_thr * length(R))] 
    
    R <-sort(species2_net[upper.tri(species2_net, diag = FALSE)], decreasing = TRUE)
    species2_thr <- R[round(density_thr * length(R))]
    
    comparison <- ortho
    
    comparison$Species1.neigh <- c(NA)
    comparison$Species1.ortho.neigh <- c(NA)
    comparison$Species1.neigh.overlap <- c(NA)
    comparison$Species1.p.val <- c(NA)
    
    comparison$Species2.neigh <- c(NA)
    comparison$Species2.ortho.neigh <- c(NA)
    comparison$Species2.neigh.overlap <- c(NA)
    comparison$Species2.p.val <- c(NA)
    
    for (i in 1:nrow(ortho)) {
      
      if (i %% 100 == 0) {
        cat(i, "\n")
      }
      
      i <- 18
      # Species 1 -> Species 2
   
      neigh <- species1_net[ortho$Species1[i],]  # Named numeric of all genes and their ranked correlations for gene i (entire co-expression network)
      neigh <- names(neigh[neigh >= species1_thr]) # Retain only the 3% top ranked genes
      
      ortho_neigh <- species2_net[ortho$Species2[i],] # Co-expression network for gene i in species 2 (the ortholog)
      ortho_neigh <- names(ortho_neigh[ortho_neigh >= species2_thr]) # Retain only the 3% top ranked genes
      ortho_neigh <- ortho$Species1[ortho$Species2 %in% ortho_neigh] # Overlapping the the networks, i.e. seeing how many of the species 1 genes have orthologs within ortho.neigh


      
      N <- nrow(species1_expr) # Number of all possible genes in S1
      m <- length(neigh) # Number of neighbours of gene i - white balls
      n <- N-m # Number of genes that are NOT neighbours - black balls
      k <- length(unique(ortho_neigh)) # Number of ortholog neighbours  - number of balls we draw
      x <- length(unique(intersect(neigh, ortho_neigh))) # Number of genes that are present in both networks. Must be at least 1.
      p_val <- 1
      if (x > 1) {
        p_val <- phyper(x-1, m, n, k, lower.tail = FALSE)
      }
      
      comparison$Species1.neigh[i] <- m
      comparison$Species1.ortho.neigh[i] <- k
      comparison$Species1.neigh.overlap[i] <- x
      comparison$Species1.p.val[i] <- p_val
      
      # Species 2 -> Species 1
      
      neigh <- species2_net[ortho$Species2[i],]
      neigh <- names(neigh[neigh >= species2_thr])
      
      ortho_neigh <- species1_net[ortho$Species1[i],]
      ortho_neigh <- names(ortho_neigh[ortho_neigh >= species1_thr])
      ortho_neigh <- ortho$Species2[ortho$Species1 %in% ortho_neigh] 
      N <- nrow(species2_expr)
      m <- length(neigh)
      n <- N-m
      k <- length(unique(ortho_neigh))
      x <- length(unique(intersect(neigh, ortho_neigh)))
      p_val <- 1
      
      if (x > 1) {
        p_val <- phyper(x-1, m, n, k, lower.tail = FALSE)
      }
      
      comparison$Species2.neigh[i] <- m
      comparison$Species2.ortho.neigh[i] <- k
      comparison$Species2.neigh.overlap[i] <- x
      comparison$Species2.p.val[i] <- p_val
    }
    
    
    # Remove gene pairs with no overlapping neighbours
    comparison <- comparison %>%
      filter(Species1.neigh.overlap > 0 & Species2.neigh.overlap > 0)
    
    # FDR correction
    comparison$Species1.p.val <- p.adjust(comparison$Species1.p.val, method = "fdr")
    comparison$Species2.p.val <- p.adjust(comparison$Species2.p.val, method = "fdr")
    
    
    comparison_table <- comparison %>%
      rowwise() %>%
      mutate(Max.p.val = max(Species1.p.val, Species2.p.val)) %>%
      left_join(annot, by = "OrthoGroup") %>%
      select(-c("Species1.neigh", "Species1.ortho.neigh", "Species2.neigh", "Species2.ortho.neigh")) %>%
      arrange(Max.p.val)
    
    comparison_table$Species1.p.val <- format(comparison_table$Species1.p.val, digits = 3, scientific = TRUE)
    comparison_table$Species2.p.val <- format(comparison_table$Species2.p.val, digits = 3, scientific = TRUE)
    comparison_table$Max.p.val <- format(comparison_table$Max.p.val, digits = 3, scientific = TRUE)
    
    save(comparison_table, file = comparison_RData)
  }
  
} else{
  print("File already exists")
  
}
















