#!/bin/bash
# this script will look for all those unmatched species, and checking if there are any sister species in the tree;
#if Yes, then add to the most updated tree;
#if No, output the no match list

Site=$1
Info=$2 #History date of the open tree query

#loading models
ml phyx newickutils
Date=$(date|awk -F ' ' '{print $2,$3,$NF}'|sed 's/ //g')


echo -e "\n\n   $Site\n\n"
#put all the data for match Opentree under one directory--
if [ -e "AddTaxa_${Date}" ]
then
	rm -fr AddTaxa_${Date}/*
else
	mkdir AddTaxa_${Date}
fi

cd AddTaxa_${Date}

##########################################################################################
echo -e "\n Step1: gathering the species list\n"
cp ../tree/${Site}_speciesname_BR_${Info}.tre ./
nw_labels -I ${Site}_speciesname_BR_${Info}.tre|sort|uniq >tree_tips.txt
wc -l tree_tips.txt

cp ../Opentree_${Info}/${Site}_Syn_NoBr_upt.txt ./add_taxa_whole_list.tmp
# cut -f1 -d ',' ../species_list/${Site}_NO-match.csv|sed '1d'|sed 's/ /_/g'|sort|uniq >>add_taxa_whole_list.tmp
#cat ../species_list/need_to_add_in.txt >>add_taxa_whole_list.tmp
cat ../Opentree_${Info}/${Site}_query_ottid.nomatch.txt|sed 's/ /_/g' >>add_taxa_whole_list.tmp
#cat ../species_list/hypen_name.csv >>add_taxa_whole_list.tmp
cat ../Opentree_${Info}/${Site}*miss_match_back_${Info}.txt|sort|uniq|sed 's/ott//g' >>miss.tmp
grep -f miss.tmp ../Opentree_${Info}/${Site}_species_names_ottids|cut -f1|sort|uniq >>add_taxa_whole_list.tmp

sed 's/ /_/g' add_taxa_whole_list.tmp|sort|uniq >add_taxa_whole_list2.tmp

comm -3 add_taxa_whole_list2.tmp tree_tips.txt|cut -f1|sort|sed '/^$/d' >add_taxa_whole_list

wc -l add_taxa_whole_list

touch add_taxa_mrca.tmp add_taxa_singleton.tmp ${Site}_No_reference_species.tmp

echo -e "\n Step2: sort the species name by the size of its genus sampled in the tree\n"
for species in `cat add_taxa_whole_list`
	do
		genus=$(echo $species|cut -f1 -d'_')
		N=$(grep $genus tree_tips.txt|wc -l)
		if [ $N -gt 1 ]; then
			sp_head=$(grep $genus tree_tips.txt|head -1)
			sp_tail=$(grep $genus tree_tips.txt|tail -1)
			echo -e "$species,${sp_head},${sp_tail}" >>add_taxa_mrca.tmp
		elif [ $N -eq 0 ]; then
			echo $species >>${Site}_No_reference_species.tmp
		elif [ $N -eq 1 ];then
			sp=$(grep $genus tree_tips.txt)
			echo -e "$species,$sp,$sp" >>add_taxa_singleton.tmp
		fi
done


#grep -f ${Site}_No_reference_species.tmp ../species_list/add_in_name.csv|sort|uniq >>add_taxa_singleton.tmp
cat ../species_list/MRCA_183_1016.csv|sort|uniq >>add_taxa_singleton.tmp
sort add_taxa_singleton.tmp|uniq >add_taxa_singleton.txt
sort add_taxa_mrca.tmp|uniq >add_taxa_mrca.txt
#comm -3 ${Site}_No_reference_species.tmp ../species_list/28_addin_name.txt|cut -f1|sort|sed '/^$/d' >${Site}_No_reference_species_${Date}.txt
sort ${Site}_No_reference_species.tmp|uniq|sed '/^$/d' >${Site}_No_reference_species_${Date}.txt

python /ufrc/soltis/cactus/Dimension/Community_Opentree/opentree_pytoys/src/add_missing_taxa_mrca.py ${Site}_speciesname_BR_${Info}.tre add_taxa_mrca.txt >tree.tmp 2>runing.log
python /ufrc/soltis/cactus/Dimension/Community_Opentree/opentree_pytoys/src/add_missing_taxa_mrca_sis.py tree.tmp add_taxa_singleton.txt >tree_add.tre 2>>runing.log

wc -l ../species_list/${Site}_update.csv
wc -l ${Site}_No_reference_species_${Date}.txt

nw_labels -I tree_add.tre|wc -l
nw_labels -I tree_add.tre|sort|uniq -d|wc -l

mv tree_add.tre ${Site}_speciesname_BR_add${Date}.tre
cp ${Site}_speciesname_BR_add${Date}.tre ../tree/${Site}_speciesname_BR_add${Date}.tre
rm *.tmp

cd ../..

exit 0
