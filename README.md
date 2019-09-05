# viral_variant_pipeline

## Overview
This pipeline was prepared for Yinda Kwe Claude (kweclaudey2@nih.gov).  It was tested with minION reads expected to map to reference genomes for Nipah virus and Hendra virus.  The goal is to identify variants in new samples in relation to the reference provided. 

## Summary of Mapping and Variant Calling Steps:

- FASTQ files are filtered and trimmed with Nanofilt (-q 8 -l 500 --headcrop 50).  
- Reads are then aligned to the reference genome using minimap2(x) and parameter -ax map-ont.  
- Variants are called using both samtools and bcftools.  
- Coverage plots are created using R from a bedgraph file generated using bedtools and plotted with R ggplot2 package. 
- A consensus sequence was generated for each sample incorporating variants called.  
- All consensus sequences are finally aligned together with the reference sequence using mafft with default parameters.


The pipeline and dependancies have been packaged on a [docker](https://www.docker.com/) image  to allow it to run on your local machine. To be able to use it you will need a [dockerhub](https://hub.docker.com/) account.

## Environment Setup:
This only needs to do be done once OR if the image has been changed and you want to run the updated version.

- Log in to docker and download the image:

```sh
docker login
# enter details
docker pull philipmac/vir_pipe
```


## Running the pipeline:

If you are running Darwin (OSX) or Linux the pipeline can be run using [this](https://github.com/niaid/viral_variant_pipeline/blob/master/vir_call.sh) script. 
Set the following environment variables:

- The path to the directory containing your fastq inputs: `INPUTS`.
- The path to the sinlge reference fasta file which the fastq files will be compared to: `REF_SEQ`.
- The path to the directory that will be created for the outputs: `OUTPUTS`.

This might look something like this:

```sh
export INPUTS=/home/macmenaminpe/data/test_chikungunya_fq/
export REF_SEQ=/home/macmenaminpe/data/ref/GCF_000854045.1_ViralProj14998_genomic.fna
export OUTPUTS=/home/macmenaminpe/test_outputs_dir
```

Run the pipeline (In this example I'm setting AD to 10 and PL to 20):

```sh
run_pipe.sh -a 10 -p 20
```

Look at your results:
```sh
ls $OUTPUTS
```

## Outputs
1. VCF file with variants
2. plots of coverage (pdf)
3. consensus sequence for each sample (fasta)
4. aligned sequences
5. log file

## References

 

**Poretools**

_Loman N, Quinlan A. Poretools: a toolkit for analyzing nanopore sequence data. Bioinformatics. 2014;30.23:3399–3401._

 

**Porechops**

https://github.com/rrwick/Porechop/


**Minimap2**

_Heng Li. Minimap2: pairwise alignment for nucleotide sequences Bioinformatics, Volume 34, Issue 18, 15 September 2018, Pages 3094–3100_


**Samtools**

_Li H, Handsaker B, Wysoker A, Fennell T, Ruan J, Homer N, Marth G, Abecasis G, Durbin R; 1000 Genome Project Data Processing Subgroup. The Sequence Alignment/Map format and SAMtools. Bioinformatics. 2009 Aug 15;25(16):2078-9_


**BCFtools**

_Danecek P, McCarthy SA. BCFtools/csq: haplotype-aware variant consequences. Bioinformatics. 2017 Jul 1;33(13):2037-2039_

 
**BEDTools**

_Quinlan AR1. BEDTools: The Swiss-Army Tool for Genome Feature Analysis. Curr Protoc Bioinformatics. 2014 Sep 8;47:11.12.1-34_
 
**R**

_R Core Team (2018). R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria. URL https://www.R-project.org/._


**R package ggplot2**

_H. Wickham. ggplot2: Elegant Graphics for Data Analysis. Springer-Verlag New York, 2016._


**Mafft**

_Kazutaka Katoh and Daron M. Standley. MAFFT Multiple Sequence Alignment Software Version 7: Improvements in Performance and Usability. Mol Biol Evol. 2013 Apr; 30(4): 772–780._
