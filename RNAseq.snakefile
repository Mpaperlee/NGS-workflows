configfile: "CONFIG/hisat.yaml"
sample            = config['sample']
samplepath        = config['datapath']['sample_path']
genome            = config['datapath']['genome_path']
gtf               = config['datapath']['gtf_path']
trimmomatic       = config['trimmomatic']

thread_his		  = config['thread']['hisat2']
thread_top		  = config['thread']['tophat2']
thread_cuf		  = config['thread']['cuff']

##tophat2
bowtie2_index	  = config['datapath']['bowtie2_index']
##hisat2
Hisat2_splicesite = config['Hisat2_splicesite']
index             = config['datapath']['index_path']
Max_intron        = config['Max_intron']
Min_intron        = config['Min_intron']
Strand_specific   = config['Strand_specific']
##cufflink
cuff_lib_type     = config['cuff_lib_type']
# SAMPLE_LIST       = ['A1', 'F4', 'P3', 'Pa', 'Pc', 'Pd', 'Pt13', 'Pt']
# LABLES_string     = []
# for i in sample:
#     a = "data/cuffquant/%s/abundances.cxb" % i
#     LABLES_string.append(a)
#print (LABLES_string)
#print(Sample)
###############outpath################
tri_path          = config['outputpath']['trimmomatic']
hisat2_path       = config['outputpath']['hisat2']
tophat2_path	  = config['outputpath']['tophat2']
stringtie_path    = config['outputpath']['stringtie']
cuffquant_path    = config['outputpath']['cuffquant']
cuffdiff_path     = config['outputpath']['cuffdiff']
gffcompare_path   = config['outputpath']['gffcompare']
ballgown_path     = config['outputpath']['ballgown']

rule all:
	input:


include:
