# A treemap R script produced by the Revigo server at http://revigo.irb.hr/
# If you found Revigo useful in your work, please cite the following reference:
# Supek F et al. "REVIGO summarizes and visualizes long lists of Gene Ontology
# terms" PLoS ONE 2011. doi:10.1371/journal.pone.0021800

# author: Anton Kratz <anton.kratz@gmail.com>, RIKEN Omics Science Center, Functional Genomics Technology Team, Japan
# created: Fri, Nov 02, 2012  7:25:52 PM
# last change: Fri, Nov 09, 2012  3:20:01 PM

# -----------------------------------------------------------------------------
# If you don't have the treemap package installed, uncomment the following line:
# install.packages( "treemap" );
library(treemap) 								# treemap package by Martijn Tennekes

# Set the working directory if necessary
# setwd("C:/Users/username/workingdir");

# --------------------------------------------------------------------------
# Here is your data from Revigo. Scroll down for plot configuration options.

revigo.names <- c("term_ID","description","frequency","uniqueness","dispensability","representative");
revigo.data <- rbind(c("GO:0006265","DNA topological change",0.18213197461081013,0.7928616175033592,0.08393509,"DNA topological change"),
                     c("GO:0006139","nucleobase-containing compound metabolic process",18.82728500884891,0.6940716047248087,0.58117122,"DNA topological change"),
                     c("GO:0015074","DNA integration",0.7252350055806647,0.7631737782366738,0.48345366,"DNA topological change"),
                     c("GO:0018130","heterocycle biosynthetic process",8.277253100322714,0.7574881996303566,0.35937708,"DNA topological change"),
                     c("GO:0019438","aromatic compound biosynthetic process",8.059039794413065,0.7483116752215592,0.37455412,"DNA topological change"),
                     c("GO:0090304","nucleic acid metabolic process",13.541109943481535,0.6818359859587625,0.65913251,"DNA topological change"),
                     c("GO:1901362","organic cyclic compound biosynthetic process",9.084396351119786,0.7579887793009652,0.26206488,"DNA topological change"),
                     c("GO:0009719","response to endogenous stimulus",1.0360338111084262,0.9232634971327591,0,"response to endogenous stimulus"),
                     c("GO:0000160","phosphorelay signal transduction system",2.0739975137672992,0.6816477025992805,0.62944347,"response to endogenous stimulus"),
                     c("GO:0009725","response to hormone",0.7083441412189638,0.912022472910251,0.6420364,"response to endogenous stimulus"),
                     c("GO:0010033","response to organic substance",1.803573616908591,0.9048853877701512,0.40724732,"response to endogenous stimulus"),
                     c("GO:0035556","intracellular signal transduction",4.1384737362710275,0.6490647852827878,0.46171648,"response to endogenous stimulus"),
                     c("GO:0042221","response to chemical",4.8560360057130705,0.910224493364055,0.37752063,"response to endogenous stimulus"),
                     c("GO:0031047","regulatory ncRNA-mediated gene silencing",0.26322685557224024,0.7412538886861764,-0,"regulatory ncRNA-mediated gene silencing"),
                     c("GO:0006355","regulation of DNA-templated transcription",11.048858347143273,0.5483012530651343,0.47154662,"regulatory ncRNA-mediated gene silencing"),
                     c("GO:0019222","regulation of metabolic process",15.404248935996318,0.6678332292939784,0.2459253,"regulatory ncRNA-mediated gene silencing"),
                     c("GO:0050789","regulation of biological process",26.88618924255281,0.6401059802331676,0.67620211,"regulatory ncRNA-mediated gene silencing"),
                     c("GO:0050794","regulation of cellular process",25.237088286105465,0.6292434440599745,0.59148681,"regulatory ncRNA-mediated gene silencing"),
                     c("GO:0065007","biological regulation",28.180269025403287,1,-0,"biological regulation"),
                     c("GO:1901360","organic cyclic compound metabolic process",22.80942274109275,0.8845403154957283,0.08528849,"organic cyclic compound metabolic process"),
                     c("GO:0006725","cellular aromatic compound metabolic process",21.583212043469736,0.8607027258247567,0.18617691,"organic cyclic compound metabolic process"),
                     c("GO:0016310","phosphorylation",5.235381700014107,0.872994073945591,0.1056638,"organic cyclic compound metabolic process"),
                     c("GO:1902221","erythrose 4-phosphate/phosphoenolpyruvate family amino acid metabolic process",0.12549471032253884,0.8370611035156118,-0,"erythrose 4-phosphate/phosphoenolpyruvate family amino acid metabolic process"),
                     c("GO:0006351","DNA-templated transcription",2.043972049057794,0.7032886317308373,0.42269862,"erythrose 4-phosphate/phosphoenolpyruvate family amino acid metabolic process"),
                     c("GO:0006468","protein phosphorylation",1.0150465485898383,0.8100105132369589,0.67515312,"erythrose 4-phosphate/phosphoenolpyruvate family amino acid metabolic process"),
                     c("GO:0009095","aromatic amino acid family biosynthetic process, prephenate pathway",0.08543775313497697,0.7421501910199092,0.40266065,"erythrose 4-phosphate/phosphoenolpyruvate family amino acid metabolic process"),
                     c("GO:0016070","RNA metabolic process",8.143898333608892,0.6895804649580981,0.54037072,"erythrose 4-phosphate/phosphoenolpyruvate family amino acid metabolic process"),
                     c("GO:0032774","RNA biosynthetic process",2.176481409894473,0.7011514055360807,0.6799919,"erythrose 4-phosphate/phosphoenolpyruvate family amino acid metabolic process"),
                     c("GO:0034654","nucleobase-containing compound biosynthetic process",6.112506318361417,0.6904005284862009,0.69928,"erythrose 4-phosphate/phosphoenolpyruvate family amino acid metabolic process"),
                     c("GO:0036211","protein modification process",3.782609621537176,0.8119172419400069,0.1894599,"erythrose 4-phosphate/phosphoenolpyruvate family amino acid metabolic process"),
                     c("GO:0043412","macromolecule modification",5.943809642398736,0.8527384425368837,0.28276727,"erythrose 4-phosphate/phosphoenolpyruvate family amino acid metabolic process"),
                     c("GO:1902223","erythrose 4-phosphate/phosphoenolpyruvate family amino acid biosynthetic process",0.045703676909239495,0.7901331720208629,0.48601365,"erythrose 4-phosphate/phosphoenolpyruvate family amino acid metabolic process"));

stuff <- data.frame(revigo.data);
names(stuff) <- revigo.names;

stuff$frequency <- as.numeric( as.character(stuff$frequency) );
stuff$uniqueness <- as.numeric( as.character(stuff$uniqueness) );
stuff$dispensability <- as.numeric( as.character(stuff$dispensability) );

# by default, outputs to a PDF file
# pdf( file="revigo_treemap.pdf", width=16, height=9 ) # width and height are in inches

# check the tmPlot command documentation for all possible parameters - there are a lot more
treemap(
  title = paste0( "Enriched GO terms for ultra conserved genes", "\n", "within gymnosperms") ,
  fontsize.title = 20,
  stuff,
  index = c("representative","description"),
  vSize = "uniqueness",
  type = "categorical",
  vColor = "representative",
  algorithm = "pivotSize",
  inflate.labels = T,      # set this to TRUE for space-filling group labels - good for posters
  lowerbound.cex.labels = 0.4,   # try to draw as many labels as possible (still, some small squares may not get a label) - increase to get fewer
  bg.labels = "#CCCCCC00",   # define background color of group labels
  # "#CCCCCC00" is fully transparent, "#CCCCCCAA" is semi-transparent grey, NA is opaque
  position.legend = "none",
  palette = c("#F7FBFF", "#DEEBF7", "#C6DBEF", "#9ECAE1", "#6BAED6", "#4292C6", "#2171B5"),
  fontsize.labels = c(10,0), # Set last number to 0 to hide children
  border.col = c("black", "#CCCCCC00")
)

dev.off()

