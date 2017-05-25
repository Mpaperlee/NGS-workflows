configfile:"CONFIG/chipseq.yaml"

# DATAPATH
SAMPLE          = config["sample"]
SAMPLEPATH      = config["DATAPATH"]["SAMPLEPATH"]
GTF             = config["DATAPATH"]["SAMPLEPATH"]
GENOME          = config["DATAPATH"]["GENOME"]
INDEX           = config["DATAPATH"]["INDEX"]

# PARA
THREAD          = config["THREAD"]

# soft
BOWTIE2         = config["SOFT"]["bowtie2"]
MACS            = config["SOFT"]["macs"]
SAMTOOLS        = config["SOFT"]["samtools"]
BAMCOVERAGE     = config["SOFT"]["bamcoverage"]
COMPUTEMATRIX   = config["SOFT"]["computeMatrix"]
PLOTHEATMAP     = config["SOFT"]["plotHeatmap"]
PLOTPROFILE     = config["SOFT"]["plotProfile"]

rule all:
    input:expand('data/alignment/{sample}.bam',sample = SAMPLE)

include:"rules/alignment/bowtie2.rule"