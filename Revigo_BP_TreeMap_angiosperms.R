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
revigo.data <- rbind(c("GO:0001763","morphogenesis of a branching structure",0.023666435079680612,0.9763393442889703,-0,"morphogenesis of a branching structure"),
                     c("GO:0010223","secondary shoot formation",0.001395042934294858,0.962337615008584,0.41654013,"morphogenesis of a branching structure"),
                     c("GO:0006714","sesquiterpenoid metabolic process",0.00518827805069024,0.884966690012846,0.03812236,"sesquiterpenoid metabolic process"),
                     c("GO:0016106","sesquiterpenoid biosynthetic process",0.0036576744072324544,0.83942538481122,0.54240689,"sesquiterpenoid metabolic process"),
                     c("GO:0007018","microtubule-based movement",0.6202173565622278,0.9883631293912591,0,"microtubule-based movement"),
                     c("GO:0009904","chloroplast accumulation movement",0.008823769796423306,0.8633391232280581,0.00730929,"chloroplast accumulation movement"),
                     c("GO:0009834","plant-type secondary cell wall biogenesis",0.02117458277124934,0.8628263883288977,0.18569774,"chloroplast accumulation movement"),
                     c("GO:0010410","hemicellulose metabolic process",0.14622317512363384,0.7718067478789055,0.67356024,"chloroplast accumulation movement"),
                     c("GO:0044036","cell wall macromolecule metabolic process",0.3020046126133374,0.8075863267890426,0.58230467,"chloroplast accumulation movement"),
                     c("GO:0051644","plastid localization",0.009161439199247327,0.927252171002952,0.51847244,"chloroplast accumulation movement"),
                     c("GO:0009959","negative gravitropism",0.006142132495163933,0.9215951929776501,-0,"negative gravitropism"),
                     c("GO:0007165","signal transduction",8.756627809544993,0.6639270724891301,0.56000793,"negative gravitropism"),
                     c("GO:0009639","response to red or far red light",0.03015856067850156,0.9140030330323637,0.50295508,"negative gravitropism"),
                     c("GO:0009719","response to endogenous stimulus",1.0360338111084262,0.8986481587381895,0.20095728,"negative gravitropism"),
                     c("GO:0009733","response to auxin",0.1256056236300358,0.7985744932888642,0.55937699,"negative gravitropism"),
                     c("GO:0009867","jasmonic acid mediated signaling pathway",0.01419443861944185,0.7377698109618895,0.63255839,"negative gravitropism"),
                     c("GO:0070887","cellular response to chemical stimulus",2.703999888790924,0.813642005529773,0.35049996,"negative gravitropism"),
                     c("GO:0023052","signaling",9.097212999986098,0.7929071234081262,-0,"signaling"),
                     c("GO:0006355","regulation of DNA-templated transcription",11.048858347143273,0.6910842989193254,0.47154662,"signaling"),
                     c("GO:0019222","regulation of metabolic process",15.404248935996318,0.7688114126702091,0.45007165,"signaling"),
                     c("GO:0050789","regulation of biological process",26.88618924255281,0.7490135008297153,0.67620211,"signaling"),
                     c("GO:0050794","regulation of cellular process",25.237088286105465,0.7410024777781561,0.59148681,"signaling"),
                     c("GO:0046483","heterocycle metabolic process",21.449154825808435,0.8949133298070641,0.09295856,"heterocycle metabolic process"),
                     c("GO:0065007","biological regulation",28.180269025403287,1,-0,"biological regulation"),
                     c("GO:0120253","hydrocarbon catabolic process",0.052454600225553295,0.9138088271397433,-0,"hydrocarbon catabolic process"),
                     c("GO:1901336","lactone biosynthetic process",0.05878651771354534,0.8382267527803974,0.04822897,"lactone biosynthetic process"),
                     c("GO:0006139","nucleobase-containing compound metabolic process",18.82728500884891,0.7936602389139318,0.58117122,"lactone biosynthetic process"),
                     c("GO:0006351","DNA-templated transcription",2.043972049057794,0.7782037832347358,0.40345308,"lactone biosynthetic process"),
                     c("GO:0009059","macromolecule biosynthetic process",16.15219652221219,0.8024108748473134,0.48531185,"lactone biosynthetic process"),
                     c("GO:0010467","gene expression",12.663260691525247,0.7910286375895811,0.51324753,"lactone biosynthetic process"),
                     c("GO:0016070","RNA metabolic process",8.143898333608892,0.7796321891168192,0.54037072,"lactone biosynthetic process"),
                     c("GO:0018130","heterocycle biosynthetic process",8.277253100322714,0.8101243370997389,0.4137707,"lactone biosynthetic process"),
                     c("GO:0019438","aromatic compound biosynthetic process",8.059039794413065,0.8167945682405917,0.35742438,"lactone biosynthetic process"),
                     c("GO:0032774","RNA biosynthetic process",2.176481409894473,0.7766014680245613,0.6799919,"lactone biosynthetic process"),
                     c("GO:0034654","nucleobase-containing compound biosynthetic process",6.112506318361417,0.777730752416437,0.69928,"lactone biosynthetic process"),
                     c("GO:0044271","cellular nitrogen compound biosynthetic process",12.957025677761646,0.8119259140990591,0.41134746,"lactone biosynthetic process"),
                     c("GO:0090304","nucleic acid metabolic process",13.541109943481535,0.7681016099782473,0.65913251,"lactone biosynthetic process"),
                     c("GO:1901362","organic cyclic compound biosynthetic process",9.084396351119786,0.8198062286176562,0.23194094,"lactone biosynthetic process"));

stuff <- data.frame(revigo.data);
names(stuff) <- revigo.names;

stuff$frequency <- as.numeric( as.character(stuff$frequency) );
stuff$uniqueness <- as.numeric( as.character(stuff$uniqueness) );
stuff$dispensability <- as.numeric( as.character(stuff$dispensability) );

# by default, outputs to a PDF file
# pdf( file="revigo_treemap.pdf", width=16, height=9 ) # width and height are in inches

# check the tmPlot command documentation for all possible parameters - there are a lot more
treemap(
  title = paste0( "Enriched GO terms for ultra conserved genes", "\n", "within angiosperms") ,
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

