# viral_variant_pipeline

This viral variant pipeline and dependancies have been packaged on a docker image https://www.docker.com/ to allow it to run on your local machine. To be able to use it you will need to create a dockerhub account https://hub.docker.com/

## SETUP 
Only needs to do be done once OR if the image has been changed and you want to run the updated version.

- Log in to docker using your account information on the command line:

`docker login` 


- Then you can download the image onto your machine

`docker pull philipmac/vir_pipe`


## Running the pipeline.

If you are running Darwin (OSX) or Linux the pipeline can be run using this script. 

Set the following environment variables:

- The path to the directory containing your fastq inputs: `INPUT_DIR`.
- The path to the sinlge reference fasta file which the fastq files will be compared to: `REF_SEQ`.
- The path to the directory that will be created for the outputs: `OUTPUTS`.



`export INPUT_DIR=~/data/test_chikungunya_fq/`

`export REF_SEQ=~/data/ref/GCF_000854045.1_ViralProj14998_genomic.fna`

`export OUTPUTS=~/test_outputs_dir`


Run the pipeline (In this example I'm setting AD to 10 and PL to 20):


`run_pipe.sh -a 10 -p 20`

Look at your results:

`ls $OUTPUTS`

