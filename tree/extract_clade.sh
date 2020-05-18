#!/bin/bash
ml newickutils

for line in `cat Clade_list.txt`; do
	echo $line
	clade=$(echo $line|cut -f1 -d',' |sed 's/\.tre//g')
	tip1=$(echo $line|cut -f2 -d ',')
	tip2=$(echo $line|cut -f3 -d',')
	nw_clade OPT_Mint_speciesname_BR_5212_Oct162018.tre $tip1 $tip2 >./Clade/${clade}.tre
	nw_labels -I ./Clade/${clade}.tre >./Clade/${clade}_list.txt
	wc -l ./Clade/${clade}_list.txt
done