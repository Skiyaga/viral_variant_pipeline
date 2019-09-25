#!/usr/bin/env bash

set -e
set -o pipefail

details="\n-a \t(Required) Sets minimium allele depth (AL) in at least one sample\n-p\t(Required) Sets Phred-scaled genotype likelihoods (PL)\n-m\t(Optional) Use -m flag if you'd like to run mafft phylip\n\n"
usage(){
  printf "\nUsage: $0 -a  <integer> -p <integer> -m <flag>\n$details">&2; exit 1;
}
if [[ -z "${INPUTS}" ]]; then
    echo -e "INPUTS is not set. Set using:\n\n\texport INPUTS='/path/to/inputs'\n"
    usage
elif [[ ! -d "${INPUTS}" ]]; then
    echo -e "$INPUTS is not not a directory. Set using:\n\n\texport INPUTS='/path/to/inputs'\n"
    usage
elif [[ -z "${OUTPUTS}" ]]; then
    echo -e "OUTPUTS is not set. Set using:\n\nexport OUTPUTS='/path/to/outputs'\n"
    usage
elif [[ -z "${REF_SEQ}" ]]; then
    echo -e "REF_SEQ is not set. Set using:\n\nexport REF_SEQ='/path/to/ref_seq.fa'\n"
    usage
elif [[ ! -f "${REF_SEQ}" ]]; then
    echo -e "REF_SEQ is not a regular file. Set using:\n\nexport REF_SEQ='/path/to/ref_seq.fa'\n"
    usage
elif [[ -z $(which docker) ]]; then
    echo -e "Please install path docker."
    usage
fi

run_mafft_phylip=false

while getopts ":a:p:m" o; do
  case "${o}" in
    a)
      a=${OPTARG}
      if [[ ! $a =~ ^-?[0-9]+$ ]]; then
	usage
      fi
      ;;
    p)
      p=${OPTARG}
      if [[ ! $p =~ ^-?[0-9]+$ ]]; then
	usage
      fi
      ;;
    m)
      run_mafft_phylip=true
      ;;
    *)
      usage
      ;;
  esac
done
shift $((OPTIND-1))

if [[ ! $a ]]; then
  usage
  exit 1
fi

docker run --rm -v $INPUTS:/data -v $REF_SEQ:/ref.fa -v $OUTPUTS:/outputs niaid/vir_pipe:latest bash -c "/vir_call.sh ${a} ${p} ${run_mafft_phylip}> outputs/log.txt 2>&1"
