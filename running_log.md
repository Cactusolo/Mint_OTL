
#######################################Oct162018#######################################  
 bash trtracer_Signel_Site.sh OPT_Mint  
OTL_update_summary_Oct162018.csv exists  


OPT_Mint  



 Step1: staring from species list, then format it as Opentree query  



 5031 species in the query, 0 duplicated names will be removed,  
 5031 species remained in the query list for OPT_Mint site  


 using Opentree_pytoy to get ottids  


 Step2: go-lang script is querying opentree based on ottids using vas_opentree_9.1.tre  


 There are 9 duplicate ottids, 4844 ottids mapped to the OPT_Mint_ottid_clean.tre  


 giving a summary how many names missed ...  

144 OPT_Mint_miss_match_back_Oct162018.txt

33 OPT_Mint_query_ottid.nomatch.txt  
 

 Step3: go-lang script is querying opentree based on ottids using ALLOTB_ottid.tre  


 query opentree based on ottids...  


 There are 4757 ottids mapped to the OPT_Mint_BR_ottid_clean_Oct162018.tre  



 Step4:converting ottids to species names for subtree...  


 Step5: Generateing a summary table ...  
 
 
 #######################adding_more_tips###############################  

 
 [cactus@login2 OPT_Mint]$ bash add_in_extra_taxa_v3.sh OPT_Mint Oct162018  


   OPT_Mint  



 Step1: gathering the species list  

4757 tree_tips.txt  
274 add_taxa_whole_list  

 Step2: sort the species name by the size of its genus sampled in the tree  

5031 ../species_list/OPT_Mint_update.csv  
0 OPT_Mint_No_reference_species_Oct162018.txt  
5214  
0  


#######################################Oct82018#######################################  
[cactus@login3 OPT_Mint]$ bash add_in_extra_taxa_v3.sh OPT_Mint Oct82018  


   OPT_Mint  



 Step1: gathering the species list  

4757 tree_tips.txt  
274 add_taxa_whole_list  

 Step2: sort the species name by the size of its genus sampled in the tree  

5031 ../species_list/OPT_Mint_update.csv  
0 OPT_Mint_No_reference_species_Oct82018.txt  
5213  
0  

