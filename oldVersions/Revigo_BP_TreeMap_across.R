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
revigo.data <- rbind(c("GO:0006105","succinate metabolic process",0.015500750907739157,0.882048130227811,0.06696501,"succinate metabolic process"),
                     c("GO:0006544","glycine metabolic process",0.2121204682178164,0.8258454837610885,0.54413097,"succinate metabolic process"),
                     c("GO:0006570","tyrosine metabolic process",0.11567518549880967,0.809178139841642,0.46338106,"succinate metabolic process"),
                     c("GO:0008652","amino acid biosynthetic process",2.679426429329935,0.7786960999128705,0.59951093,"succinate metabolic process"),
                     c("GO:0009423","chorismate biosynthetic process",0.1731948267667233,0.8353917039258992,0.5669208,"succinate metabolic process"),
                     c("GO:0019632","shikimate metabolic process",0.0351644479568635,0.8784275888608644,0.26738178,"succinate metabolic process"),
                     c("GO:0035999","tetrahydrofolate interconversion",0.15991234200892296,0.8387099910889793,0.20304178,"succinate metabolic process"),
                     c("GO:0046417","chorismate metabolic process",0.22896943199668504,0.856372380532462,0.68965489,"succinate metabolic process"),
                     c("GO:1902221","erythrose 4-phosphate/phosphoenolpyruvate family amino acid metabolic process",0.12549471032253884,0.8376010538517562,0.30559503,"succinate metabolic process"),
                     c("GO:1902223","erythrose 4-phosphate/phosphoenolpyruvate family amino acid biosynthetic process",0.045703676909239495,0.8261408214998636,0.48601365,"succinate metabolic process"),
                     c("GO:0006790","sulfur compound metabolic process",2.4931808033810716,0.9180678000493386,0.06382146,"sulfur compound metabolic process"),
                     c("GO:0006091","generation of precursor metabolites and energy",2.5115061465197326,0.9180029995395255,0.11315615,"sulfur compound metabolic process"),
                     c("GO:0015980","energy derivation by oxidation of organic compounds",1.5185732467046178,0.8970172268846158,0.1059306,"sulfur compound metabolic process"),
                     c("GO:0042776","proton motive force-driven mitochondrial ATP synthesis",0.026939610020923672,0.7675328676329023,0.57900146,"sulfur compound metabolic process"),
                     c("GO:0007017","microtubule-based process",1.4522840599239462,0.9842237237486535,0.01167087,"microtubule-based process"),
                     c("GO:0007018","microtubule-based movement",0.6202173565622278,0.9641139417033243,0.01066591,"microtubule-based movement"),
                     c("GO:0007049","cell cycle",2.8073119376140743,0.9830620520053583,0.01353242,"cell cycle"),
                     c("GO:0009311","oligosaccharide metabolic process",0.3704479822996164,0.8815024207459663,0.05535151,"oligosaccharide metabolic process"),
                     c("GO:0005976","polysaccharide metabolic process",1.5360556487063022,0.8467833132445188,0.6736108,"oligosaccharide metabolic process"),
                     c("GO:0005982","starch metabolic process",0.040983699490203,0.8565053598821961,0.63030219,"oligosaccharide metabolic process"),
                     c("GO:0005984","disaccharide metabolic process",0.2026632601985772,0.884736153250874,0.47009629,"oligosaccharide metabolic process"),
                     c("GO:0010410","hemicellulose metabolic process",0.14622317512363384,0.8153722265702745,0.69838792,"oligosaccharide metabolic process"),
                     c("GO:0016051","carbohydrate biosynthetic process",1.2946614615297933,0.8397403020940079,0.65990968,"oligosaccharide metabolic process"),
                     c("GO:0016052","carbohydrate catabolic process",1.727161742263698,0.8573225477429638,0.574402,"oligosaccharide metabolic process"),
                     c("GO:0044042","glucan metabolic process",0.5261456186236556,0.8381137693734215,0.59605864,"oligosaccharide metabolic process"),
                     c("GO:0009987","cellular process",78.37474688350859,1,-0,"cellular process"),
                     c("GO:0015976","carbon utilization",0.03248281065560413,0.9745937596355697,-0,"carbon utilization"),
                     c("GO:0001666","response to hypoxia",0.08314800952020678,0.9536579453911037,0.53306591,"carbon utilization"),
                     c("GO:0007264","small GTPase-mediated signal transduction",0.38558395166269893,0.9171608126239545,0.29341673,"carbon utilization"),
                     c("GO:0010038","response to metal ion",0.32910689548525657,0.9573076236946836,0.29558021,"carbon utilization"),
                     c("GO:0010332","response to gamma radiation",0.006090372951665361,0.9706235930246344,0.16163565,"carbon utilization"),
                     c("GO:0030970","retrograde protein transport, ER to cytosol",0.041313974672527225,0.7534712631654666,0.55254322,"carbon utilization"),
                     c("GO:0032011","ARF protein signal transduction",2.4647401665986892E-05,0.9511652025420189,0.46139142,"carbon utilization"),
                     c("GO:0032482","Rab protein signal transduction",0.016166230752720803,0.9320802499322715,0.67083666,"carbon utilization"),
                     c("GO:0034620","cellular response to unfolded protein",0.15332162680343805,0.9281186521221937,0.47193106,"carbon utilization"),
                     c("GO:0034976","response to endoplasmic reticulum stress",0.252707344541197,0.9429638718108017,0.20460869,"carbon utilization"),
                     c("GO:0035966","response to topologically incorrect protein",0.1942264546083099,0.9485153082890854,0.61975638,"carbon utilization"),
                     c("GO:0070482","response to oxygen levels",0.10178390991985946,0.9653594523871695,0.64042889,"carbon utilization"),
                     c("GO:1904481","response to tetrahydrofolate",0.00010598382716374363,0.96878497476502,0.37681051,"carbon utilization"),
                     c("GO:1904482","cellular response to tetrahydrofolate",0.00010598382716374363,0.9592434513082392,0.13158395,"carbon utilization"),
                     c("GO:0016049","cell growth",0.07489112996210118,0.9680284998269654,0.00779724,"cell growth"),
                     c("GO:0018126","protein hydroxylation",0.00015774337066231612,0.9221533279524757,0.02559308,"protein hydroxylation"),
                     c("GO:0018208","peptidyl-proline modification",0.0005644254981510998,0.9158072601683677,0.24766645,"protein hydroxylation"),
                     c("GO:0019511","peptidyl-proline hydroxylation",4.9294803331973784E-05,0.9219648960827986,0.32986743,"protein hydroxylation"),
                     c("GO:0019748","secondary metabolic process",0.7294472465253818,0.9591623675193671,-0,"secondary metabolic process"),
                     c("GO:0022406","membrane docking",0.18014785877669817,0.9870218528044464,-0,"membrane docking"),
                     c("GO:0022411","cellular component disassembly",0.5876679979221254,0.8575449670247283,0.01060803,"cellular component disassembly"),
                     c("GO:0000027","ribosomal large subunit assembly",0.012821578346646382,0.8371266606869723,0.55914193,"cellular component disassembly"),
                     c("GO:0000393","spliceosomal conformational changes to generate catalytic conformation",0.02552977864562922,0.7252753896756272,0.5909171,"cellular component disassembly"),
                     c("GO:0006901","vesicle coating",0.029155411430695895,0.7909850805246891,0.69428756,"cellular component disassembly"),
                     c("GO:0006996","organelle organization",6.781836087483291,0.8173881787962632,0.61704991,"cellular component disassembly"),
                     c("GO:0007010","cytoskeleton organization",1.98151060375585,0.8199131506672765,0.54313461,"cellular component disassembly"),
                     c("GO:0007032","endosome organization",0.07057290519022028,0.8543109516215593,0.2961287,"cellular component disassembly"),
                     c("GO:0007033","vacuole organization",0.29445264874287896,0.8485222281867331,0.38343195,"cellular component disassembly"),
                     c("GO:0010256","endomembrane system organization",0.639629650114359,0.8564532773302777,0.36019313,"cellular component disassembly"),
                     c("GO:0016043","cellular component organization",12.33090773324058,0.8175193658099792,0.69458731,"cellular component disassembly"),
                     c("GO:0016050","vesicle organization",0.49145933025911226,0.8417734988787574,0.45227,"cellular component disassembly"),
                     c("GO:0022613","ribonucleoprotein complex biogenesis",2.5375929564430133,0.8209687532640862,0.65931649,"cellular component disassembly"),
                     c("GO:0030030","cell projection organization",1.3282977705833654,0.8462836262134054,0.42315086,"cellular component disassembly"),
                     c("GO:0030036","actin cytoskeleton organization",0.799830366722774,0.8216960751945058,0.57336577,"cellular component disassembly"),
                     c("GO:0031529","ruffle organization",0.004288647889881719,0.8939646915887084,0.58553528,"cellular component disassembly"),
                     c("GO:0032984","protein-containing complex disassembly",0.34131475353041985,0.8477378278275864,0.45952375,"cellular component disassembly"),
                     c("GO:0036388","pre-replicative complex assembly",0.002021086936610925,0.7610100443546229,0.39330075,"cellular component disassembly"),
                     c("GO:0042254","ribosome biogenesis",2.136224808753416,0.8095461171847516,0.42039354,"cellular component disassembly"),
                     c("GO:0043933","protein-containing complex organization",3.8518047369742674,0.8285636632355396,0.48429452,"cellular component disassembly"),
                     c("GO:0044085","cellular component biogenesis",6.962804704735466,0.8296084931211674,0.55809526,"cellular component disassembly"),
                     c("GO:0045229","external encapsulating structure organization",1.2084152736201719,0.8476813696785566,0.39708395,"cellular component disassembly"),
                     c("GO:0048268","clathrin coat assembly",0.035341909248858605,0.856126761184605,0.28047706,"cellular component disassembly"),
                     c("GO:0048284","organelle fusion",0.3097784030987896,0.8478797979759727,0.43230595,"cellular component disassembly"),
                     c("GO:0061024","membrane organization",1.2886105244207935,0.8467346855346263,0.41858566,"cellular component disassembly"),
                     c("GO:0070676","intralumenal vesicle formation",0.0019101736291139838,0.8219350308390317,0.5837567,"cellular component disassembly"),
                     c("GO:0070925","organelle assembly",1.3561320812847646,0.80033498229942,0.6101863,"cellular component disassembly"),
                     c("GO:0071826","protein-RNA complex organization",0.6518695497816881,0.8424790136303827,0.58454785,"cellular component disassembly"),
                     c("GO:0090174","organelle membrane fusion",0.23749743297311648,0.8418835226747592,0.4226296,"cellular component disassembly"),
                     c("GO:0097178","ruffle assembly",0.0032928928625758484,0.8772192615772586,0.57510238,"cellular component disassembly"),
                     c("GO:0097435","supramolecular fiber organization",0.801568008540226,0.8534609638410812,0.37151144,"cellular component disassembly"),
                     c("GO:0120036","plasma membrane bounded cell projection organization",1.1030821378604103,0.8399310965392119,0.41129301,"cellular component disassembly"),
                     c("GO:0140694","non-membrane-bounded organelle assembly",0.7232459602662196,0.8070421441964317,0.65542123,"cellular component disassembly"),
                     c("GO:0030029","actin filament-based process",0.8246601591610891,0.9850980967318917,0.00947979,"actin filament-based process"),
                     c("GO:0032259","methylation",2.6278542060840238,0.9534355224385348,0.05465772,"methylation"),
                     c("GO:0035383","thioester metabolic process",0.5539971825062208,0.9100055643247774,0.09391166,"thioester metabolic process"),
                     c("GO:0000096","sulfur amino acid metabolic process",0.6045711859846593,0.8238327093529698,0.6986631,"thioester metabolic process"),
                     c("GO:0009086","methionine biosynthetic process",0.33635076683489007,0.7929701484053584,0.6610459,"thioester metabolic process"),
                     c("GO:0040007","growth",0.14923755234738403,1,0,"growth"),
                     c("GO:0042537","benzene-containing compound metabolic process",0.3046221666702652,0.8685290627305807,0.08799024,"benzene-containing compound metabolic process"),
                     c("GO:0000724","double-strand break repair via homologous recombination",0.4336168080293742,0.772038292346424,0.66888864,"benzene-containing compound metabolic process"),
                     c("GO:0006260","DNA replication",1.488685807444442,0.7860677734611091,0.5047373,"benzene-containing compound metabolic process"),
                     c("GO:0006261","DNA-templated DNA replication",0.9202033469791208,0.7796048382702299,0.61057325,"benzene-containing compound metabolic process"),
                     c("GO:0006302","double-strand break repair",0.7881154567109305,0.762335148451237,0.60011993,"benzene-containing compound metabolic process"),
                     c("GO:0016072","rRNA metabolic process",1.653535024007062,0.7863497260387157,0.63321287,"benzene-containing compound metabolic process"),
                     c("GO:0016074","sno(s)RNA metabolic process",0.09080349247766231,0.8327491057116881,0.45267118,"benzene-containing compound metabolic process"),
                     c("GO:0022616","DNA strand elongation",0.14249648799173661,0.8247100622874082,0.19474916,"benzene-containing compound metabolic process"),
                     c("GO:0034660","ncRNA metabolic process",4.184236566944265,0.7736665484655408,0.37072972,"benzene-containing compound metabolic process"),
                     c("GO:0055086","nucleobase-containing small molecule metabolic process",5.3738729852351215,0.7719637738486328,0.44460203,"benzene-containing compound metabolic process"),
                     c("GO:0072521","purine-containing compound metabolic process",3.5086882583820636,0.8145763525318389,0.26298286,"benzene-containing compound metabolic process"),
                     c("GO:1901566","organonitrogen compound biosynthetic process",14.093783560518295,0.8370680266686795,0.35525015,"benzene-containing compound metabolic process"),
                     c("GO:1902292","cell cycle DNA replication initiation",0.03303244771275563,0.7963316079661982,0.65250625,"benzene-containing compound metabolic process"),
                     c("GO:0043087","regulation of GTPase activity",0.0013728602727954699,0.979058021908652,-0,"regulation of GTPase activity"),
                     c("GO:0043603","amide metabolic process",6.707376287050344,0.9049886726918924,0.08920219,"amide metabolic process"),
                     c("GO:0044843","cell cycle G1/S phase transition",0.05461124787132716,0.946016785087377,0.00761922,"cell cycle G1/S phase transition"),
                     c("GO:0032508","DNA duplex unwinding",0.6410641288913195,0.8319421398179452,0.60354312,"cell cycle G1/S phase transition"),
                     c("GO:0051177","meiotic sister chromatid cohesion",0.018603858777486906,0.8415983983525185,0.47509762,"cell cycle G1/S phase transition"),
                     c("GO:1903047","mitotic cell cycle process",0.9528882663283861,0.9322421591551563,0.62880697,"cell cycle G1/S phase transition"),
                     c("GO:0045903","positive regulation of translational fidelity",0.00040668212748878364,0.9713206994016816,0.07705908,"positive regulation of translational fidelity"),
                     c("GO:0002181","cytoplasmic translation",0.3974763229665376,0.8091192133331601,0.6792736,"positive regulation of translational fidelity"),
                     c("GO:0006412","translation",4.38869169324396,0.7597899660114507,0.47678922,"positive regulation of translational fidelity"),
                     c("GO:0006457","protein folding",1.174377211919444,0.8321551493816084,0.20440425,"positive regulation of translational fidelity"),
                     c("GO:0031126","sno(s)RNA 3'-end processing",0.07140845210669723,0.818580039024027,0.52610704,"positive regulation of translational fidelity"),
                     c("GO:0031344","regulation of cell projection organization",0.33189698135384627,0.9299831964273497,0.67402708,"positive regulation of translational fidelity"),
                     c("GO:0032881","regulation of polysaccharide metabolic process",0.057874563851903815,0.952539013717468,0.17028956,"positive regulation of translational fidelity"),
                     c("GO:0033044","regulation of chromosome organization",0.18193972487781543,0.9304887574334695,0.60946142,"positive regulation of translational fidelity"),
                     c("GO:0043628","regulatory ncRNA 3'-end processing",0.00018239077232830298,0.8480343512218267,0.13244121,"positive regulation of translational fidelity"),
                     c("GO:0046578","regulation of Ras protein signal transduction",0.033439129840244414,0.9626376846772756,0.62358381,"positive regulation of translational fidelity"),
                     c("GO:0051128","regulation of cellular component organization",1.6291932501217334,0.9627677918699244,0.12454856,"positive regulation of translational fidelity"),
                     c("GO:0051453","regulation of intracellular pH",0.16922413035833278,0.9561198029608021,0.34829016,"positive regulation of translational fidelity"),
                     c("GO:0120032","regulation of plasma membrane bounded cell projection assembly",0.09291823954060398,0.931180243282909,0.18550195,"positive regulation of translational fidelity"),
                     c("GO:1902531","regulation of intracellular signal transduction",1.0161384284836417,0.9555157572396278,0.23646869,"positive regulation of translational fidelity"),
                     c("GO:2001251","negative regulation of chromosome organization",0.07336545579897658,0.9310509907985303,0.68158865,"positive regulation of translational fidelity"),
                     c("GO:0048229","gametophyte development",0.017253181166190824,0.9831048419367777,-0,"gametophyte development"),
                     c("GO:0000902","cell morphogenesis",0.6354075502089755,0.9780031296201092,0.69769973,"gametophyte development"),
                     c("GO:0009555","pollen development",0.012900450031977538,0.9833719060994066,0.4072143,"gametophyte development"),
                     c("GO:0009653","anatomical structure morphogenesis",1.6026307453462993,0.9783718683468254,0.50110615,"gametophyte development"),
                     c("GO:0090377","seed trichome initiation",3.6971102498980334E-05,0.9799374749929454,0.30565335,"gametophyte development"),
                     c("GO:0051156","glucose 6-phosphate metabolic process",0.29545579799068467,0.860150306325032,0.08770773,"glucose 6-phosphate metabolic process"),
                     c("GO:0009226","nucleotide-sugar biosynthetic process",0.35550672740969513,0.7625435661334553,0.42144167,"glucose 6-phosphate metabolic process"),
                     c("GO:0018279","protein N-linked glycosylation via asparagine",0.04641598681738651,0.8387169917674898,0.34710385,"glucose 6-phosphate metabolic process"),
                     c("GO:0019637","organophosphate metabolic process",6.719722170544837,0.840641147634015,0.61029109,"glucose 6-phosphate metabolic process"),
                     c("GO:0019693","ribose phosphate metabolic process",2.986873188231122,0.8245823882582382,0.53960114,"glucose 6-phosphate metabolic process"),
                     c("GO:0033865","nucleoside bisphosphate metabolic process",0.7966828935300275,0.7626817905206144,0.62223113,"glucose 6-phosphate metabolic process"),
                     c("GO:0033875","ribonucleoside bisphosphate metabolic process",0.7966828935300275,0.757473731376242,0.60375363,"glucose 6-phosphate metabolic process"),
                     c("GO:0046496","nicotinamide nucleotide metabolic process",1.124163060505329,0.7462917910439677,0.64521865,"glucose 6-phosphate metabolic process"),
                     c("GO:0051179","localization",19.75810399172557,1,-0,"localization"),
                     c("GO:0071554","cell wall organization or biogenesis",1.477434268583919,0.9841955431390779,0.01247652,"cell wall organization or biogenesis"),
                     c("GO:0071669","plant-type cell wall organization or biogenesis",0.07584991388690805,0.9412601945947536,0.00780459,"plant-type cell wall organization or biogenesis"),
                     c("GO:0009832","plant-type cell wall biogenesis",0.055902771718624865,0.8301020562266651,0.56599951,"plant-type cell wall organization or biogenesis"),
                     c("GO:0044036","cell wall macromolecule metabolic process",0.3020046126133374,0.8679821234199053,0.63951684,"plant-type cell wall organization or biogenesis"),
                     c("GO:0071840","cellular component organization or biogenesis",14.483683272212708,0.9792235399187704,0.01914371,"cellular component organization or biogenesis"),
                     c("GO:0072334","UDP-galactose transmembrane transport",0.027208266699082932,0.9276338987406084,0.00725384,"UDP-galactose transmembrane transport"),
                     c("GO:0006810","transport",18.530066921639108,0.8882859542089431,0.57608784,"UDP-galactose transmembrane transport"),
                     c("GO:0006890","retrograde vesicle-mediated transport, Golgi to endoplasmic reticulum",0.1396694310206479,0.8913467260777941,0.22745343,"UDP-galactose transmembrane transport"),
                     c("GO:0006897","endocytosis",0.6399968963991822,0.8785553562364549,0.61094635,"UDP-galactose transmembrane transport"),
                     c("GO:0016192","vesicle-mediated transport",2.6087919056355493,0.8988333837567909,0.34761272,"UDP-galactose transmembrane transport"),
                     c("GO:0016482","cytosolic transport",0.24169981495716725,0.8887676440110327,0.50181104,"UDP-galactose transmembrane transport"),
                     c("GO:0032527","protein exit from endoplasmic reticulum",0.051232089102920354,0.8972412764342079,0.44413075,"UDP-galactose transmembrane transport"),
                     c("GO:0032940","secretion by cell",0.7673426265868367,0.9011184607879513,0.26724673,"UDP-galactose transmembrane transport"),
                     c("GO:0033036","macromolecule localization",5.437478069974368,0.9076670563325833,0.39682233,"UDP-galactose transmembrane transport"),
                     c("GO:0033365","protein localization to organelle",1.527857922912195,0.8718286604423341,0.63578029,"UDP-galactose transmembrane transport"),
                     c("GO:0042147","retrograde transport, endosome to Golgi",0.19146348088155277,0.8659436546313078,0.62798518,"UDP-galactose transmembrane transport"),
                     c("GO:0046903","secretion",0.8219612686786636,0.9226662128427836,0.28401786,"UDP-galactose transmembrane transport"),
                     c("GO:0046907","intracellular transport",2.9683457363987995,0.8591349933861784,0.69228996,"UDP-galactose transmembrane transport"),
                     c("GO:0051640","organelle localization",0.768961960876292,0.9260393662745333,0.19900268,"UDP-galactose transmembrane transport"),
                     c("GO:0051641","cellular localization",5.891744471119505,0.891891595547127,0.45310835,"UDP-galactose transmembrane transport"),
                     c("GO:0071692","protein localization to extracellular region",0.43191860205458765,0.8868243992997921,0.47000226,"UDP-galactose transmembrane transport"),
                     c("GO:0071702","organic substance transport",8.155300221619576,0.8989936208265755,0.63961773,"UDP-galactose transmembrane transport"),
                     c("GO:0071705","nitrogen compound transport",6.023736236521199,0.9029238440743446,0.59651016,"UDP-galactose transmembrane transport"),
                     c("GO:0098657","import into cell",1.4184357832160461,0.9181174020570637,0.30328438,"UDP-galactose transmembrane transport"),
                     c("GO:0140056","organelle localization by membrane tethering",0.1792137222535573,0.9042314135852922,0.23251983,"UDP-galactose transmembrane transport"),
                     c("GO:0140352","export from cell",0.9302841342605095,0.9094948805562384,0.30748738,"UDP-galactose transmembrane transport"),
                     c("GO:1902600","proton transmembrane transport",1.312853708699458,0.9058201045393139,0.31981999,"UDP-galactose transmembrane transport"),
                     c("GO:1903513","endoplasmic reticulum to cytosol transport",0.041313974672527225,0.903536842787097,0.2055684,"UDP-galactose transmembrane transport"),
                     c("GO:0120254","olefinic compound metabolic process",0.16629601904041355,0.9505857632934591,0.0413303,"olefinic compound metabolic process"),
                     c("GO:0120255","olefinic compound biosynthetic process",0.011254003600689615,0.9266212497892286,0.04286728,"olefinic compound biosynthetic process"),
                     c("GO:0009805","coumarin biosynthetic process",0.00857483103959684,0.8524073779952009,0.66874442,"olefinic compound biosynthetic process"),
                     c("GO:0009810","stilbene metabolic process",0.00011091330749694102,0.9149461282110929,0.56029443,"olefinic compound biosynthetic process"),
                     c("GO:0042401","biogenic amine biosynthetic process",0.4031131837275488,0.8284148219460469,0.16335743,"olefinic compound biosynthetic process"),
                     c("GO:0042435","indole-containing compound biosynthetic process",0.24212867974615543,0.8145792223940472,0.30835152,"olefinic compound biosynthetic process"),
                     c("GO:0044550","secondary metabolite biosynthetic process",0.5275874916211158,0.8995242537070913,0.12258313,"olefinic compound biosynthetic process"),
                     c("GO:1901135","carbohydrate derivative metabolic process",7.864044340872776,0.9271407974509883,0.08157054,"carbohydrate derivative metabolic process"),
                     c("GO:0005975","carbohydrate metabolic process",5.3400641443698875,0.9162078797446278,0.12134048,"carbohydrate derivative metabolic process"));


stuff <- data.frame(revigo.data);
names(stuff) <- revigo.names;

stuff$frequency <- as.numeric( as.character(stuff$frequency) );
stuff$uniqueness <- as.numeric( as.character(stuff$uniqueness) );
stuff$dispensability <- as.numeric( as.character(stuff$dispensability) );

# by default, outputs to a PDF file
# pdf( file="revigo_treemap.pdf", width=20, height=12 ) # width and height are in inches

# check the tmPlot command documentation for all possible parameters - there are a lot more
treemap(
  title = "GO terms for ultra-ultra-conserved genes (across clades)",
  fontsize.title = 20,
  stuff,
  index = c("representative","description"),
  vSize = "uniqueness",
  type = "categorical",
  vColor = "representative",
  algorithm = "squarified",
  inflate.labels = T,      # set this to TRUE for space-filling group labels - good for posters
  lowerbound.cex.labels = 0.5,   # try to draw as many labels as possible (still, some small squares may not get a label) - increase to get fewer
  bg.labels = "#CCCCCC00",   # define background color of group labels
  # "#CCCCCC00" is fully transparent, "#CCCCCCAA" is semi-transparent grey, NA is opaque
  position.legend = "none",
  palette = c("#F7FBFF", "#DEEBF7", "#C6DBEF", "#9ECAE1", "#6BAED6", "#4292C6", "#2171B5"),
  fontsize.labels = c(10,0), # Set last number to 0 to hid children
  border.col = c("black", "#CCCCCC00")
)

#blues palette without darkest col: c("#F7FBFF", "#DEEBF7", "#C6DBEF", "#9ECAE1", "#6BAED6", "#4292C6", "#2171B5")
# #F7FBFF", "#DEEBF7", "#C6DBEF", "#9ECAE1", "#6BAED6", "#4292C6", "#2171B5"

dev.off()

