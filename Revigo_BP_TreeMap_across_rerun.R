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
library(RColorBrewer)

# Set the working directory if necessary
# setwd("C:/Users/username/workingdir");

# --------------------------------------------------------------------------
# Here is your data from Revigo. Scroll down for plot configuration options.

revigo.names <- c("term_ID","description","frequency","uniqueness","dispensability","representative");
revigo.data <- rbind(c("GO:0006105","succinate metabolic process",0.015500750907739157,0.8930899728360616,0.06696501,"succinate metabolic process"),
                     c("GO:0002181","cytoplasmic translation",0.3974763229665376,0.8160381960844386,0.6792736,"succinate metabolic process"),
                     c("GO:0006412","translation",4.38869169324396,0.7676820705893941,0.49906638,"succinate metabolic process"),
                     c("GO:0006565","L-serine catabolic process",0.10188496426669003,0.8468247386334343,0.51472609,"succinate metabolic process"),
                     c("GO:0006570","tyrosine metabolic process",0.11567518549880967,0.8138885011779228,0.46338106,"succinate metabolic process"),
                     c("GO:0008652","amino acid biosynthetic process",2.679426429329935,0.7927696379231958,0.43415934,"succinate metabolic process"),
                     c("GO:0046417","chorismate metabolic process",0.22896943199668504,0.8697765928813631,0.57757759,"succinate metabolic process"),
                     c("GO:0055086","nucleobase-containing small molecule metabolic process",5.3738729852351215,0.7804922794060234,0.47199217,"succinate metabolic process"),
                     c("GO:1902221","erythrose 4-phosphate/phosphoenolpyruvate family amino acid metabolic process",0.12549471032253884,0.8496675765052971,0.28939545,"succinate metabolic process"),
                     c("GO:1902223","erythrose 4-phosphate/phosphoenolpyruvate family amino acid biosynthetic process",0.045703676909239495,0.8358132633373065,0.52889473,"succinate metabolic process"),
                     c("GO:0006790","sulfur compound metabolic process",2.4931808033810716,0.9189842143013736,0.06382146,"sulfur compound metabolic process"),
                     c("GO:0006091","generation of precursor metabolites and energy",2.5115061465197326,0.9189195120329714,0.11315615,"sulfur compound metabolic process"),
                     c("GO:0015980","energy derivation by oxidation of organic compounds",1.5185732467046178,0.8934159808685249,0.1059306,"sulfur compound metabolic process"),
                     c("GO:0042776","proton motive force-driven mitochondrial ATP synthesis",0.026939610020923672,0.78194025654844,0.57900146,"sulfur compound metabolic process"),
                     c("GO:0007017","microtubule-based process",1.4522840599239462,0.9835550444508132,0.00998825,"microtubule-based process"),
                     c("GO:0007018","microtubule-based movement",0.6202173565622278,0.9618186016720119,0.01131391,"microtubule-based movement"),
                     c("GO:0007035","vacuolar acidification",0.07733615220736707,0.9708560262413233,-0,"vacuolar acidification"),
                     c("GO:0007264","small GTPase-mediated signal transduction",0.38558395166269893,0.9175182442014367,0.20288639,"vacuolar acidification"),
                     c("GO:0031110","regulation of microtubule polymerization or depolymerization",0.07288729620665643,0.9410641013620356,0.17427619,"vacuolar acidification"),
                     c("GO:0031344","regulation of cell projection organization",0.33189698135384627,0.9368449229099749,0.66268601,"vacuolar acidification"),
                     c("GO:0032011","ARF protein signal transduction",2.4647401665986892E-05,0.9507788154727975,0.46139142,"vacuolar acidification"),
                     c("GO:0032482","Rab protein signal transduction",0.016166230752720803,0.9317959734257968,0.67083666,"vacuolar acidification"),
                     c("GO:0046578","regulation of Ras protein signal transduction",0.033439129840244414,0.9629838496172489,0.62358381,"vacuolar acidification"),
                     c("GO:0120032","regulation of plasma membrane bounded cell projection assembly",0.09291823954060398,0.9356231483364124,0.60017406,"vacuolar acidification"),
                     c("GO:1902531","regulation of intracellular signal transduction",1.0161384284836417,0.9572159154015413,0.15477919,"vacuolar acidification"),
                     c("GO:1902904","negative regulation of supramolecular fiber organization",0.14811856031174822,0.9373457561053286,0.58956729,"vacuolar acidification"),
                     c("GO:2001006","regulation of cellulose biosynthetic process",0.002356291599268347,0.96720391387742,0.10208763,"vacuolar acidification"),
                     c("GO:0009311","oligosaccharide metabolic process",0.3704479822996164,0.8918517514464185,0.04520447,"oligosaccharide metabolic process"),
                     c("GO:0005976","polysaccharide metabolic process",1.5360556487063022,0.8567743535933114,0.56751084,"oligosaccharide metabolic process"),
                     c("GO:0010410","hemicellulose metabolic process",0.14622317512363384,0.81886737028082,0.69838792,"oligosaccharide metabolic process"),
                     c("GO:0016051","carbohydrate biosynthetic process",1.2946614615297933,0.8532484108067746,0.65083034,"oligosaccharide metabolic process"),
                     c("GO:0030243","cellulose metabolic process",0.14144650868076555,0.8522120949748045,0.69642362,"oligosaccharide metabolic process"),
                     c("GO:0044042","glucan metabolic process",0.5261456186236556,0.8492275060209664,0.58864141,"oligosaccharide metabolic process"),
                     c("GO:0009987","cellular process",78.37474688350859,1,-0,"cellular process"),
                     c("GO:0010332","response to gamma radiation",0.006090372951665361,0.9759729773205061,-0,"response to gamma radiation"),
                     c("GO:0010038","response to metal ion",0.32910689548525657,0.9516266164450778,0.29558021,"response to gamma radiation"),
                     c("GO:0030970","retrograde protein transport, ER to cytosol",0.041313974672527225,0.749795245296634,0.55254322,"response to gamma radiation"),
                     c("GO:0034620","cellular response to unfolded protein",0.15332162680343805,0.9187989962878395,0.47193106,"response to gamma radiation"),
                     c("GO:0035966","response to topologically incorrect protein",0.1942264546083099,0.9420650796030079,0.61975638,"response to gamma radiation"),
                     c("GO:1904481","response to tetrahydrofolate",0.00010598382716374363,0.9635785915434624,0.37681051,"response to gamma radiation"),
                     c("GO:1904482","cellular response to tetrahydrofolate",0.00010598382716374363,0.9533378373571866,0.12219615,"response to gamma radiation"),
                     c("GO:0019748","secondary metabolic process",0.7294472465253818,0.9601281959122221,-0,"secondary metabolic process"),
                     c("GO:0022406","membrane docking",0.18014785877669817,0.9864836901124875,-0,"membrane docking"),
                     c("GO:0022411","cellular component disassembly",0.5876679979221254,0.8438873271093777,0.01124881,"cellular component disassembly"),
                     c("GO:0000027","ribosomal large subunit assembly",0.012821578346646382,0.8214250872326109,0.55914193,"cellular component disassembly"),
                     c("GO:0000393","spliceosomal conformational changes to generate catalytic conformation",0.02552977864562922,0.7164593036997496,0.5909171,"cellular component disassembly"),
                     c("GO:0006996","organelle organization",6.781836087483291,0.8002484829724124,0.61704991,"cellular component disassembly"),
                     c("GO:0007010","cytoskeleton organization",1.98151060375585,0.8047639166974784,0.54313461,"cellular component disassembly"),
                     c("GO:0007032","endosome organization",0.07057290519022028,0.841863924531838,0.2961287,"cellular component disassembly"),
                     c("GO:0008154","actin polymerization or depolymerization",0.11682868389677786,0.8402607739360466,0.35812958,"cellular component disassembly"),
                     c("GO:0010256","endomembrane system organization",0.639629650114359,0.8426984984643219,0.36019313,"cellular component disassembly"),
                     c("GO:0016043","cellular component organization",12.33090773324058,0.79999728965691,0.69458731,"cellular component disassembly"),
                     c("GO:0016050","vesicle organization",0.49145933025911226,0.8283041462905543,0.45227,"cellular component disassembly"),
                     c("GO:0022613","ribonucleoprotein complex biogenesis",2.5375929564430133,0.8023614511233518,0.65931649,"cellular component disassembly"),
                     c("GO:0031529","ruffle organization",0.004288647889881719,0.8842937069537647,0.58553528,"cellular component disassembly"),
                     c("GO:0032984","protein-containing complex disassembly",0.34131475353041985,0.8308051873565978,0.45952375,"cellular component disassembly"),
                     c("GO:0036388","pre-replicative complex assembly",0.002021086936610925,0.7445183635828162,0.39330075,"cellular component disassembly"),
                     c("GO:0042254","ribosome biogenesis",2.136224808753416,0.7897102951173727,0.42039354,"cellular component disassembly"),
                     c("GO:0043933","protein-containing complex organization",3.8518047369742674,0.8123691942147501,0.48236366,"cellular component disassembly"),
                     c("GO:0044085","cellular component biogenesis",6.962804704735466,0.8131217056780173,0.55809526,"cellular component disassembly"),
                     c("GO:0048268","clathrin coat assembly",0.035341909248858605,0.8404495836855771,0.28047706,"cellular component disassembly"),
                     c("GO:0048284","organelle fusion",0.3097784030987896,0.8348887157280334,0.42444382,"cellular component disassembly"),
                     c("GO:0061024","membrane organization",1.2886105244207935,0.8321199403844408,0.39986392,"cellular component disassembly"),
                     c("GO:0070676","intralumenal vesicle formation",0.0019101736291139838,0.8035963110139243,0.5837567,"cellular component disassembly"),
                     c("GO:0070925","organelle assembly",1.3561320812847646,0.7814668517736556,0.6101863,"cellular component disassembly"),
                     c("GO:0071826","protein-RNA complex organization",0.6518695497816881,0.8258204555029335,0.58454785,"cellular component disassembly"),
                     c("GO:0090174","organelle membrane fusion",0.23749743297311648,0.8278924618251932,0.39209554,"cellular component disassembly"),
                     c("GO:0097178","ruffle assembly",0.0032928928625758484,0.8644247510511041,0.57510238,"cellular component disassembly"),
                     c("GO:0097435","supramolecular fiber organization",0.801568008540226,0.8394404676208487,0.37151144,"cellular component disassembly"),
                     c("GO:0120036","plasma membrane bounded cell projection organization",1.1030821378604103,0.8261840576974053,0.41427625,"cellular component disassembly"),
                     c("GO:0140694","non-membrane-bounded organelle assembly",0.7232459602662196,0.7907189454357055,0.65542123,"cellular component disassembly"),
                     c("GO:0022616","DNA strand elongation",0.14249648799173661,0.8219930444172656,0.08146515,"DNA strand elongation"),
                     c("GO:0000724","double-strand break repair via homologous recombination",0.4336168080293742,0.7678615507315611,0.66888864,"DNA strand elongation"),
                     c("GO:0006260","DNA replication",1.488685807444442,0.782754155250784,0.5047373,"DNA strand elongation"),
                     c("GO:0006261","DNA-templated DNA replication",0.9202033469791208,0.7710963739532,0.61057325,"DNA strand elongation"),
                     c("GO:0006302","double-strand break repair",0.7881154567109305,0.7586531570051921,0.60011993,"DNA strand elongation"),
                     c("GO:0016072","rRNA metabolic process",1.653535024007062,0.7918417944159231,0.63321287,"DNA strand elongation"),
                     c("GO:0034660","ncRNA metabolic process",4.184236566944265,0.7774885550310835,0.37072972,"DNA strand elongation"),
                     c("GO:0043603","amide metabolic process",6.707376287050344,0.9079845303551416,0.11779077,"DNA strand elongation"),
                     c("GO:0072521","purine-containing compound metabolic process",3.5086882583820636,0.8187202340867764,0.24421145,"DNA strand elongation"),
                     c("GO:1901566","organonitrogen compound biosynthetic process",14.093783560518295,0.843585186867985,0.35525015,"DNA strand elongation"),
                     c("GO:1902292","cell cycle DNA replication initiation",0.03303244771275563,0.7855822306886716,0.65250625,"DNA strand elongation"),
                     c("GO:0032259","methylation",2.6278542060840238,0.9544503628171657,0.05465772,"methylation"),
                     c("GO:0035383","thioester metabolic process",0.5539971825062208,0.9146849720499728,0.09391166,"thioester metabolic process"),
                     c("GO:0006555","methionine metabolic process",0.34006759500612094,0.8278371639280271,0.66171365,"thioester metabolic process"),
                     c("GO:0006637","acyl-CoA metabolic process",0.5539971825062208,0.7550421332250118,0.69278956,"thioester metabolic process"),
                     c("GO:0040007","growth",0.14923755234738403,1,0,"growth"),
                     c("GO:0048229","gametophyte development",0.017253181166190824,0.9837170832519478,-0,"gametophyte development"),
                     c("GO:0000902","cell morphogenesis",0.6354075502089755,0.9785519092502185,0.46732555,"gametophyte development"),
                     c("GO:0009555","pollen development",0.012900450031977538,0.9839581356352182,0.4072143,"gametophyte development"),
                     c("GO:0048589","developmental growth",0.12506091605321748,0.9681073440785979,0.51920046,"gametophyte development"),
                     c("GO:0051156","glucose 6-phosphate metabolic process",0.29545579799068467,0.8775510978189754,0.08770773,"glucose 6-phosphate metabolic process"),
                     c("GO:0006739","NADP metabolic process",0.3459780419256246,0.7894213376554685,0.54888247,"glucose 6-phosphate metabolic process"),
                     c("GO:0018279","protein N-linked glycosylation via asparagine",0.04641598681738651,0.845698620635513,0.34710385,"glucose 6-phosphate metabolic process"),
                     c("GO:0019693","ribose phosphate metabolic process",2.986873188231122,0.8464035277762494,0.53960114,"glucose 6-phosphate metabolic process"),
                     c("GO:0051179","localization",19.75810399172557,1,-0,"localization"),
                     c("GO:0051640","organelle localization",0.768961960876292,0.91564833557576,-0,"organelle localization"),
                     c("GO:0006810","transport",18.530066921639108,0.8717292156474807,0.57608784,"organelle localization"),
                     c("GO:0006890","retrograde vesicle-mediated transport, Golgi to endoplasmic reticulum",0.1396694310206479,0.8782339687774171,0.22745343,"organelle localization"),
                     c("GO:0006897","endocytosis",0.6399968963991822,0.8642507671859286,0.61094635,"organelle localization"),
                     c("GO:0016192","vesicle-mediated transport",2.6087919056355493,0.8859862193445388,0.34761272,"organelle localization"),
                     c("GO:0016482","cytosolic transport",0.24169981495716725,0.8772329959042061,0.67033554,"organelle localization"),
                     c("GO:0032527","protein exit from endoplasmic reticulum",0.051232089102920354,0.8873409800256516,0.44413075,"organelle localization"),
                     c("GO:0032940","secretion by cell",0.7673426265868367,0.8866574212655925,0.26724673,"organelle localization"),
                     c("GO:0033036","macromolecule localization",5.437478069974368,0.8942985194523829,0.39682233,"organelle localization"),
                     c("GO:0046903","secretion",0.8219612686786636,0.9117670273664672,0.28401786,"organelle localization"),
                     c("GO:0046907","intracellular transport",2.9683457363987995,0.844101012082367,0.59469535,"organelle localization"),
                     c("GO:0048199","vesicle targeting, to, from or within Golgi",0.0330842072562542,0.8594573131622948,0.67378701,"organelle localization"),
                     c("GO:0051641","cellular localization",5.891744471119505,0.8780457735391498,0.45310835,"organelle localization"),
                     c("GO:0071692","protein localization to extracellular region",0.43191860205458765,0.8740139868655918,0.47000226,"organelle localization"),
                     c("GO:0071702","organic substance transport",8.155300221619576,0.8842413659039171,0.63961773,"organelle localization"),
                     c("GO:0071705","nitrogen compound transport",6.023736236521199,0.8888227248539327,0.59651016,"organelle localization"),
                     c("GO:0098657","import into cell",1.4184357832160461,0.9064929133014392,0.30328438,"organelle localization"),
                     c("GO:0140056","organelle localization by membrane tethering",0.1792137222535573,0.9005959809810169,0.23251983,"organelle localization"),
                     c("GO:0140352","export from cell",0.9302841342605095,0.898172630724567,0.30748738,"organelle localization"),
                     c("GO:1903513","endoplasmic reticulum to cytosol transport",0.041313974672527225,0.8936821041275211,0.2055684,"organelle localization"),
                     c("GO:0071554","cell wall organization or biogenesis",1.477434268583919,0.9835255164416041,0.01247652,"cell wall organization or biogenesis"),
                     c("GO:0071669","plant-type cell wall organization or biogenesis",0.07584991388690805,0.9303015488865969,0.00780459,"plant-type cell wall organization or biogenesis"),
                     c("GO:0009832","plant-type cell wall biogenesis",0.055902771718624865,0.8058486951452161,0.56599951,"plant-type cell wall organization or biogenesis"),
                     c("GO:0044036","cell wall macromolecule metabolic process",0.3020046126133374,0.8592038054720599,0.63951684,"plant-type cell wall organization or biogenesis"),
                     c("GO:0071840","cellular component organization or biogenesis",14.483683272212708,0.9783071510166717,0.01714456,"cellular component organization or biogenesis"),
                     c("GO:0120255","olefinic compound biosynthetic process",0.011254003600689615,0.9275020632566887,0.03338727,"olefinic compound biosynthetic process"),
                     c("GO:0009805","coumarin biosynthetic process",0.00857483103959684,0.8500315728636834,0.66874442,"olefinic compound biosynthetic process"),
                     c("GO:0009810","stilbene metabolic process",0.00011091330749694102,0.9142926943875247,0.56029443,"olefinic compound biosynthetic process"),
                     c("GO:0044550","secondary metabolite biosynthetic process",0.5275874916211158,0.8957731535422134,0.12258313,"olefinic compound biosynthetic process"),
                     c("GO:1901135","carbohydrate derivative metabolic process",7.864044340872776,0.9292644623695052,0.08157054,"carbohydrate derivative metabolic process"),
                     c("GO:0005975","carbohydrate metabolic process",5.3400641443698875,0.9190670311305462,0.12134048,"carbohydrate derivative metabolic process"),
                     c("GO:1903047","mitotic cell cycle process",0.9528882663283861,0.9238317998425056,0.0118607,"mitotic cell cycle process"),
                     c("GO:0032508","DNA duplex unwinding",0.6410641288913195,0.8161603970315584,0.60354312,"mitotic cell cycle process"),
                     c("GO:0051177","meiotic sister chromatid cohesion",0.018603858777486906,0.8239384596244332,0.57767469,"mitotic cell cycle process"));


stuff <- data.frame(revigo.data);
names(stuff) <- revigo.names;

stuff$frequency <- as.numeric( as.character(stuff$frequency) );
stuff$uniqueness <- as.numeric( as.character(stuff$uniqueness) );
stuff$dispensability <- as.numeric( as.character(stuff$dispensability) );

treemap(
  
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


  
#blues palette without darkest col: c("#F7FBFF", "#DEEBF7", "#C6DBEF", "#9ECAE1", "#6BAED6", "#4292C6", "#2171B5")
# #F7FBFF", "#DEEBF7", "#C6DBEF", "#9ECAE1", "#6BAED6", "#4292C6", "#2171B5"

dev.off()

