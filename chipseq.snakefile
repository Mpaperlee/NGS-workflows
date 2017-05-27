configfile:"CONFIG/chipseq.yaml"
# RUNINFO
INPUTINFO       = config["INPUTINFO"]
# OUTPUTPATH
alignment       = config["OUTPUTPATH"]["alignment"]
macs2           = config["OUTPUTPATH"]["macs2"]
# DATAPATH
SAMPLEPATH      = config["DATAPATH"]["SAMPLEPATH"]
GTF             = config["DATAPATH"]["SAMPLEPATH"]
GENOME          = config["DATAPATH"]["GENOME"]
INDEX           = config["DATAPATH"]["INDEX"]
REFSEQ          = config["DATAPATH"]["REFSEQ"]
#SAMPLEINFO
ALLSAMPLE       = config["ALLSAMPLE"]
# EXNAME          = config["EXNAME"]
INPUTINFO       = config["INPUTINFO"]

# PARA
THREAD          = config["THREAD"]

# SOFT
BOWTIE2         = config["SOFT"]["bowtie2"]
MACS2           = config["SOFT"]["macs2"]
SAMTOOLS        = config["SOFT"]["samtools"]
BAMCOVERAGE     = config["SOFT"]["bamcoverage"]
COMPUTEMATRIX   = config["SOFT"]["computeMatrix"]
PLOTHEATMAP     = config["SOFT"]["plotHeatmap"]
PLOTPROFILE     = config["SOFT"]["plotProfile"]

rule all:
    input:expand(macs2 + '/{sample}/{sample}.png',sample = INPUTINFO),
        expand(macs2 + '/{sample}/{sample}_summits.bed',sample = INPUTINFO)

include:"rules/alignment/bowtie2.rule"
include:"rules/peak/peak.rule"
include:"rules/peak/bamcoverage.rule"