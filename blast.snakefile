import glob
#configuration files
configfile: "CONFIG/blast.yaml"
#get the list of sequence files
BLAST_SAMPLE = glob.glob(r'split_seq/*')

#print(BLAST_SAMPLE)
print("%s will be running \n" %i for i in config["runinfo"])
#set lists for storing run infomation
BLAST_RESULTS = []
PRASER_INFO = []

#decide which rule will be executed
for i in config["runinfo"]:
    if i in config["run_detail"]:
        #print(config["run_detail"][i])
        BLAST_RESULTS.append(config["run_detail"][i])
    if i in config["praser_detail"]:
        PRASER_INFO.append(config["praser_detail"][i])
    else:
        pass

#database path
nr_path        =     config["database"]["nr_path"]
nt_path        =     config["database"]["nt_path"]
swissprot_path =     config["database"]["swissport_path"]
TrEMBL_path    =     config["database"]["TrEMBL_path"]
Cog_path       =     config["database"]["cog_path"]
Kog_path       =     config["database"]["kog_path"]
Kegg_path      =     config["database"]["kegg_path"]
#parameter
e_value        =     config["evalue"]
blasttype      =     config["blast_type"]
thread         =     config["thread"]
#soft
blast_parser   =     config["blast_parser"]
#for rules-kog
kog_parser1    =     config["kog_parser1"]
kog_parser2    =     config["kog_parser2"]
#for rules-cog
cog_parser1    =     config["cog_parser1"]
cog_parser2    =     config["cog_parser2"]
#for rules-kegg
kegg_parser    =     config["kegg_parser"]


rule all:
     input: expand('{blast_sample}/{blast_results}',blast_sample = BLAST_SAMPLE,blast_results = BLAST_RESULTS),
         expand("blast_results/{runinfo}.best.tab",runinfo = config["runinfo"]),
         expand("blast_results/{runinfo}.tab",runinfo = config["runinfo"]),
         PRASER_INFO


         
#NR
rule nr:
    input:"{blast_sample}/split.fasta" 
    output:"{blast_sample}/nr.blast.xml" 
    shell:
        "blastall -b 100 -v 100 -e {e_value} -F F -p {blasttype} \
         -d {nr_path} -i {input} -m 7 -a {thread} -o {output}"

rule getonebest_nr:
    input:"{blast_sample}/nr.blast.xml"
    output:"{blast_sample}/nr.best.tab" 
    shell:
        "perl {blast_parser} -nohead -eval {e_value} -tophit 1 -topmatch 1 -m 7 {input} > {output}"

rule get50tab_nr:
    input:"{blast_sample}/nr.blast.xml"
    output:"{blast_sample}/nr.tab" 
    shell:
        "perl {blast_parser} -nohead -eval {e_value} -tophit 50 -topmatch 1 -m 7 {input} > {output}"    
rule catbest_nr:
    input:expand("{blast_sample}/nr.best.tab",blast_sample = BLAST_SAMPLE)
    output:"blast_results/nr.best.tab" 
    shell:
        "cat {input} > {output}"
rule cat50tab_nr:
    input:expand("{blast_sample}/nr.tab",blast_sample = BLAST_SAMPLE)
    output:"blast_results/nr.tab" 
    shell:
        "cat {input} > {output}"
#NT

rule nt:
    input:"{blast_sample}/split.fasta" 
    output:"{blast_sample}/nt.blast" 
    shell:
        "blastall -b 100 -v 100 -p blastn -e {e_value} -F F -d {nt_path} -i {input} -a {thread} -o {output}"

rule getonebest_nt:
    input:"{blast_sample}/nt.blast"
    output:"{blast_sample}/nt.best.tab"
    shell:
        "perl {blast_parser} -nohead -eval {e_value} -tophit 1 -topmatch 1 -m 0 {input} > {output}"

rule get50tab_nt:
    input:"{blast_sample}/nt.blast"
    output:"{blast_sample}/nt.tab"
    shell:
        "perl {blast_parser} -nohead -eval {e_value} -tophit 50 -topmatch 1 -m 0 {input} > {output}"    
rule catbest_nt:
    input:expand("{blast_sample}/nt.best.tab",blast_sample = BLAST_SAMPLE)
    output:"blast_results/nt.best.tab"
    shell:
        "cat {input} > {output}"
rule cat50tab_nt:
    input:expand("{blast_sample}/nt.tab",blast_sample = BLAST_SAMPLE)
    output:"blast_results/nt.tab"
    shell:
        "cat {input} > {output}"

#swiss prot

rule swiss_port:
    input:"{blast_sample}/split.fasta"
    output:"{blast_sample}/swiss_port.blast.xml"
    shell:
        "blastall -b 100 -v 100 -p {blasttype} -e {e_value} -F F \
        -d {swissprot_path} -i {input} -m 7 -a {thread} -o {output}"

rule getonebest_swiss:
    input:"{blast_sample}/swiss_port.blast.xml"
    output:"{blast_sample}/swiss_port.best.tab"
    shell:
        "perl {blast_parser} -nohead -eval {e_value} -tophit 1 -topmatch 1 -m 7 {input} > {output}"

rule get50tab_swiss:
    input:"{blast_sample}/swiss_port.blast.xml"
    output:"{blast_sample}/swiss_port.tab"
    shell:
        "perl {blast_parser} -nohead -eval {e_value} -tophit 50 -topmatch 1 -m 7 {input} > {output}"    
rule catbest_swiss:
    input:expand("{blast_sample}/swiss_port.best.tab",blast_sample = BLAST_SAMPLE)
    output:"blast_results/swiss_port.best.tab"
    shell:
        "cat {input} > {output}"
rule cat50tab_swiss:
    input:expand("{blast_sample}/swiss_port.tab",blast_sample = BLAST_SAMPLE)
    output:"blast_results/swiss_port.tab"
    shell:
        "cat {input} > {output}"
#TrEMBL
        
rule TrEMBL:
    input:"{blast_sample}/split.fasta"
    output:"{blast_sample}/TrEMBL.blast"
    shell:
        "blastall -b 100 -v 100 -p {blasttype} -e {e_value} -F F \
        -d {TrEMBL_path} -i {input} -a {thread} -o {output}"

rule getonebest_TrEMBL:
    input:"{blast_sample}/TrEMBL.blast"
    output:"{blast_sample}/TrEMBL.best.tab"
    shell:
        "perl {blast_parser} -nohead -eval {e_value} -tophit 1 -topmatch 1 -m 0 {input} > {output}"

rule get50tab_TrEMBL:
    input:"{blast_sample}/TrEMBL.blast"
    output:"{blast_sample}/TrEMBL.tab"
    shell:
        "perl {blast_parser} -nohead -eval {e_value} -tophit 50 -topmatch 1 -m 0 {input} > {output}"    
rule catbest_TrEMBL:
    input:expand("{blast_sample}/TrEMBL.best.tab",blast_sample = BLAST_SAMPLE)
    output:"blast_results/TrEMBL.best.tab"
    shell:
        "cat {input} > {output}"
rule cat50tab_TrEMBL:
    input:expand("{blast_sample}/TrEMBL.tab",blast_sample = BLAST_SAMPLE)
    output:"blast_results/TrEMBL.tab"
    shell:
        "cat {input} > {output}"
#Cog

rule Cog:
    input:"{blast_sample}/split.fasta"
    output:"{blast_sample}/Cog.blast"
    shell:
        "blastall -b 100 -v 100 -p {blasttype} -e {e_value} -F F \
        -d {Cog_path} -i {input} -a {thread} -o {output}"

rule getonebest_Cog:
    input:"{blast_sample}/Cog.blast"
    output:"{blast_sample}/Cog.best.tab"
    shell:
        "perl {blast_parser} -nohead -eval {e_value} -tophit 1 -topmatch 1 -m 0 {input} > {output}"

rule get50tab_Cog:
    input:"{blast_sample}/Cog.blast"
    output:"{blast_sample}/Cog.tab"
    shell:
        "perl {blast_parser} -nohead -eval {e_value} -tophit 50 -topmatch 1 -m 0 {input} > {output}"    
rule catbest_Cog:
    input:expand("{blast_sample}/Cog.best.tab",blast_sample = BLAST_SAMPLE)
    output:"blast_results/Cog.best.tab"
    shell:
        "cat {input} > {output}"
rule cat50tab_Cog:
    input:expand("{blast_sample}/Cog.tab",blast_sample = BLAST_SAMPLE)
    output:"blast_results/Cog.tab"
    shell:
        "cat {input} > {output}"

rule praser_cog1:
    input:"blast_results/Cog.best.tab"
    output:"blast_results/Cog.class"
    shell:
        "perl {cog_parser1} {input}"

rule praser_cog2:
    input:"blast_results/Cog.class"
    output:"blast_results/Cog.cluster.svg"
    shell:
        "perl {cog_parser2} -i {input} -o {output} -png"
#Kog

rule Kog:
    input:"{blast_sample}/split.fasta"
    output:"{blast_sample}/Kog.blast"
    shell:
        "blastall -b 100 -v 100 -p {blasttype} -e {e_value} -F F \
        -d {Kog_path} -i {input} -a {thread} -o {output}"

rule getonebest_Kog:
    input:"{blast_sample}/Kog.blast"
    output:"{blast_sample}/Kog.best.tab"
    shell:
        "perl {blast_parser} -nohead -eval {e_value} -tophit 1 -topmatch 1 -m 0 {input} > {output}"

rule get50tab_Kog:
    input:"{blast_sample}/Kog.blast"
    output:"{blast_sample}/Kog.tab"
    shell:
        "perl {blast_parser} -nohead -eval {e_value} -tophit 50 -topmatch 1 -m 0 {input} > {output}"    
rule catbest_Kog:
    input:expand("{blast_sample}/Kog.best.tab",blast_sample = BLAST_SAMPLE)
    output:"blast_results/Kog.best.tab"
    shell:
        "cat {input} > {output}"
rule cat50tab_Kog:
    input:expand("{blast_sample}/Kog.tab",blast_sample = BLAST_SAMPLE)
    output:"blast_results/Kog.tab"
    shell:
        "cat {input} > {output}"
rule praser_Kog1:
    input:"blast_results/Kog.best.tab"
    output:"blast_results/Kog.class"
    shell:
        "perl {kog_parser1} {input}"

rule praser_Kog2:
    input:"blast_results/Kog.class"
    output:"blast_results/Kog.cluster.svg"
    shell:
        "perl {kog_parser2} -i {input} -o {output} -png"
#Kegg
        
rule Kegg:
    input:"{blast_sample}/split.fasta"
    output:"{blast_sample}/Kegg.blast"
    shell:
        "blastall -b 100 -v 100 -p {blasttype} -e {e_value} -F F \
        -d {Kegg_path} -i {input} -a {thread} -o {output} "

rule getonebest_Kegg:
    input:"{blast_sample}/Kegg.blast"
    output:"{blast_sample}/Kegg.best.tab"
    shell:
        "perl {blast_parser} -nohead -eval {e_value} -tophit 1 -topmatch 1 -m 0 {input} > {output}"

rule get50tab_Kegg:
    input:"{blast_sample}/Kegg.blast"
    output:"{blast_sample}/Kegg.tab"
    shell:
        "perl {blast_parser} -nohead -eval {e_value} -tophit 50 -topmatch 1 -m 0 {input} > {output}"    

rule catbest_Kegg:
    input:expand("{blast_sample}/Kegg.best.tab",blast_sample = BLAST_SAMPLE)
    output:"blast_results/Kegg.best.tab"
    shell:
        "cat {input} > {output}"
rule cat50tab_Kegg:
    input:expand("{blast_sample}/Kegg.tab",blast_sample = BLAST_SAMPLE)
    output:"blast_results/Kegg.tab"
    shell:
        "cat {input} > {output}"

rule praser_kegg:
    input:"blast_results/Kegg.best.tab"
    output:"best_praser.kegg"
    params:"blast_results/"
    shell:
        "perl {kegg_parser} -tab {input} -od {params} -key {output}"
#blast2go
