#!/bin/bash

#Written by Zenan (Tommy) Tang
#Last Update: August 23rd, 2021

#Running script for each subject in folder
for subject in ST*
do 
    SUBJ=$subject
	cd $subject
	echo $subject

	########################### STEP 6 ####################################
	#        Generating Network Streamlines (Within and Between)          #
	#######################################################################

	#NETWORKS
	#L_PCC32-34-33
	#L_mPFC63
	#L_MTL23
	#L_AG151-150-149-148-25-28-145-144 
	#L_DPG73-87-84-86-83-85
	#L_ACC180
	#L_PPC143-151-150-149-116-147-146-145-144
	#R_PCC212-214-213
	#R_mPFC243
	#R_MTL203
	#R_AG331-330-329-328-205-208-325-324 
	#R_DPG253-267-264-266-263-265
	#R_ACC359
	#R_PPC323-331-330-329-296-327-326-325-324

	#GENERATE MASKS FOR EACH NODE OF INTEREST IN NUMERICAL ORDER TO AVOID DUPLICATES
	#left
	mkdir ${SUBJ}_nodes
	for node in 23 25 28 32 33 34 63 73 83 84 85 86 87 116 143 144 145 146 147 148 149 150 151 180 
	do 
		mrcalc /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_hcpmmp1_parcels_coreg.mif $node -eq ${SUBJ}_nodes/L_$node.mif
	done
	#right
	for node in 203 205 208 212 213 214 243 253 263 264 265 266 267 296 323 324 325 326 327 328 329 330 331 359 
	do 
		mrcalc /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_hcpmmp1_parcels_coreg.mif $node -eq ${SUBJ}_nodes/R_$node.mif
	done

	#COMBINE MASKS PER NETWORK
	mkdir ${SUBJ}_masks

	#convert from mif to nifti
	for mask in ${SUBJ}_nodes/*; do
	mrconvert $mask ${mask:0:-4}.nii.gz
	done

	#combine rois into one mask per network
	#left
	fslmaths ${SUBJ}_nodes/L_32.nii.gz -add ${SUBJ}_nodes/L_34.nii.gz -add ${SUBJ}_nodes/L_33.nii.gz ${SUBJ}_masks/${SUBJ}_L_PCC32-34-33.nii.gz
	fslmaths ${SUBJ}_nodes/L_151.nii.gz -add ${SUBJ}_nodes/L_150.nii.gz -add ${SUBJ}_nodes/L_149.nii.gz -add ${SUBJ}_nodes/L_148.nii.gz -add ${SUBJ}_nodes/L_25.nii.gz -add ${SUBJ}_nodes/L_28.nii.gz -add ${SUBJ}_nodes/L_145.nii.gz -add ${SUBJ}_nodes/L_144.nii.gz ${SUBJ}_masks/${SUBJ}_L_AG151-150-149-148-25-28-145-144.nii.gz
	fslmaths ${SUBJ}_nodes/L_73.nii.gz -add ${SUBJ}_nodes/L_87.nii.gz -add ${SUBJ}_nodes/L_84.nii.gz -add ${SUBJ}_nodes/L_86.nii.gz -add ${SUBJ}_nodes/L_83.nii.gz -add ${SUBJ}_nodes/L_85.nii.gz ${SUBJ}_masks/${SUBJ}_L_DPG73-87-84-86-83-85.nii.gz
	fslmaths ${SUBJ}_nodes/L_143.nii.gz -add ${SUBJ}_nodes/L_151.nii.gz -add ${SUBJ}_nodes/L_150.nii.gz -add ${SUBJ}_nodes/L_149.nii.gz -add ${SUBJ}_nodes/L_116.nii.gz -add ${SUBJ}_nodes/L_147.nii.gz -add ${SUBJ}_nodes/L_146.nii.gz -add ${SUBJ}_nodes/L_145.nii.gz -add ${SUBJ}_nodes/L_144.nii.gz ${SUBJ}_masks/${SUBJ}_L_PPC143-151-150-149-116-147-146-145-144.nii.gz
	#right
	fslmaths ${SUBJ}_nodes/R_212.nii.gz -add ${SUBJ}_nodes/R_214.nii.gz -add ${SUBJ}_nodes/R_213.nii.gz ${SUBJ}_masks/${SUBJ}_R_PCC212-214-213.nii.gz
	fslmaths ${SUBJ}_nodes/R_331.nii.gz -add ${SUBJ}_nodes/R_330.nii.gz -add ${SUBJ}_nodes/R_329.nii.gz -add ${SUBJ}_nodes/R_328.nii.gz -add ${SUBJ}_nodes/R_205.nii.gz -add ${SUBJ}_nodes/R_208.nii.gz -add ${SUBJ}_nodes/R_325.nii.gz -add ${SUBJ}_nodes/R_324.nii.gz ${SUBJ}_masks/${SUBJ}_R_AG331-330-329-328-205-208-325-324.nii.gz
	fslmaths ${SUBJ}_nodes/R_253.nii.gz -add ${SUBJ}_nodes/R_267.nii.gz -add ${SUBJ}_nodes/R_264.nii.gz -add ${SUBJ}_nodes/R_266.nii.gz -add ${SUBJ}_nodes/R_263.nii.gz -add ${SUBJ}_nodes/R_265.nii.gz ${SUBJ}_masks/${SUBJ}_R_DPG253-267-264-266-263-265.nii.gz
	fslmaths ${SUBJ}_nodes/R_323.nii.gz -add ${SUBJ}_nodes/R_331.nii.gz -add ${SUBJ}_nodes/R_330.nii.gz -add ${SUBJ}_nodes/R_329.nii.gz -add ${SUBJ}_nodes/R_296.nii.gz -add ${SUBJ}_nodes/R_327.nii.gz -add ${SUBJ}_nodes/R_326.nii.gz -add ${SUBJ}_nodes/R_325.nii.gz -add ${SUBJ}_nodes/R_324.nii.gz ${SUBJ}_masks/${SUBJ}_R_PPC323-331-330-329-296-327-326-325-324.nii.gz

	#convert back from nifti to mif 
	#left
	mrconvert ${SUBJ}_masks/${SUBJ}_L_AG151-150-149-148-25-28-145-144.nii.gz ${SUBJ}_masks/${SUBJ}_L_AG151-150-149-148-25-28-145-144.mif
	mrconvert ${SUBJ}_masks/${SUBJ}_L_PCC32-34-33.nii.gz ${SUBJ}_masks/${SUBJ}_L_PCC32-34-33.mif
	mrconvert ${SUBJ}_masks/${SUBJ}_L_DPG73-87-84-86-83-85.nii.gz ${SUBJ}_masks/${SUBJ}_L_DPG73-87-84-86-83-85.mif
	mrconvert ${SUBJ}_masks/${SUBJ}_L_PPC143-151-150-149-116-147-146-145-144.nii.gz ${SUBJ}_masks/${SUBJ}_L_PPC143-151-150-149-116-147-146-145-144.mif
	#right
	mrconvert ${SUBJ}_masks/${SUBJ}_R_AG331-330-329-328-205-208-325-324.nii.gz ${SUBJ}_masks/${SUBJ}_R_AG331-330-329-328-205-208-325-324.mif
	mrconvert ${SUBJ}_masks/${SUBJ}_R_PCC212-214-213.nii.gz ${SUBJ}_masks/${SUBJ}_R_PCC212-214-213.mif
	mrconvert ${SUBJ}_masks/${SUBJ}_R_DPG253-267-264-266-263-265.nii.gz ${SUBJ}_masks/${SUBJ}_R_DPG253-267-264-266-263-265.mif
	mrconvert ${SUBJ}_masks/${SUBJ}_R_PPC323-331-330-329-296-327-326-325-324.nii.gz ${SUBJ}_masks/${SUBJ}_R_PPC323-331-330-329-296-327-326-325-324.mif

	#copy single node masks into masks directory
	#left
	cp ${SUBJ}_nodes/L_63.mif ${SUBJ}_masks/${SUBJ}_L_mPFC63.mif 
	cp ${SUBJ}_nodes/L_23.mif ${SUBJ}_masks/${SUBJ}_L_MTL23.mif
	cp ${SUBJ}_nodes/L_180.mif ${SUBJ}_masks/${SUBJ}_L_ACC180.mif
	#right
	cp ${SUBJ}_nodes/R_243.mif ${SUBJ}_masks/${SUBJ}_R_mPFC243.mif 
	cp ${SUBJ}_nodes/R_203.mif ${SUBJ}_masks/${SUBJ}_R_MTL203.mif
	cp ${SUBJ}_nodes/R_359.mif ${SUBJ}_masks/${SUBJ}_R_ACC359.mif

	#convert into nifti for future use
	#left
	mrconvert ${SUBJ}_masks/${SUBJ}_L_mPFC63.mif ${SUBJ}_masks/${SUBJ}_L_mPFC63.nii.gz
	mrconvert ${SUBJ}_masks/${SUBJ}_L_MTL23.mif ${SUBJ}_masks/${SUBJ}_L_MTL23.nii.gz
	mrconvert ${SUBJ}_masks/${SUBJ}_L_ACC180.mif ${SUBJ}_masks/${SUBJ}_L_ACC180.nii.gz
	#right
	mrconvert ${SUBJ}_masks/${SUBJ}_R_mPFC243.mif ${SUBJ}_masks/${SUBJ}_R_mPFC243.nii.gz
	mrconvert ${SUBJ}_masks/${SUBJ}_R_MTL203.mif ${SUBJ}_masks/${SUBJ}_R_MTL203.nii.gz
	mrconvert ${SUBJ}_masks/${SUBJ}_R_ACC359.mif ${SUBJ}_masks/${SUBJ}_R_ACC359.nii.gz

	#COMBINE MASKS BETWEEN TWO NETWORKS

	#optimize with a nested for loop later for efficiency
	cd ${SUBJ}_nodes
	#left
	mrmath L_32.mif L_34.mif L_33.mif L_63.mif max ../${SUBJ}_masks/${SUBJ}_L_PCC32-34-33_mPFC63_combined.mif
	mrmath L_32.mif L_34.mif L_33.mif L_23.mif max ../${SUBJ}_masks/${SUBJ}_L_PCC32-34-33_MTL23_combined.mif
	mrmath L_32.mif L_34.mif L_33.mif L_151.mif L_150.mif L_149.mif L_25.mif L_28.mif L_145.mif L_144.mif max ../${SUBJ}_masks/${SUBJ}_L_PCC32-34-33_AG151-150-149-148-25-28-145-144_combined.mif
	mrmath L_32.mif L_34.mif L_33.mif L_73.mif L_87.mif L_84.mif L_86.mif L_83.mif L_85.mif max ../${SUBJ}_masks/${SUBJ}_L_PCC32-34-33_DPG73-87-84-86-83-85_combined.mif
	mrmath L_32.mif L_34.mif L_33.mif L_180.mif max ../${SUBJ}_masks/${SUBJ}_L_PCC32-34-33_ACC180_combined.mif
	mrmath L_32.mif L_34.mif L_33.mif L_143.mif L_151.mif L_150.mif L_149.mif L_116.mif L_147.mif L_146.mif L_145.mif L_144.mif max ../${SUBJ}_masks/${SUBJ}_L_PCC32-34-33_PPC143-151-150-149-116-147-146-145-144_combined.mif

	mrmath L_63.mif L_23.mif max ../${SUBJ}_masks/${SUBJ}_L_mPFC63_MTL23_combined.mif
	mrmath L_63.mif L_151.mif L_150.mif L_149.mif L_148.mif L_25.mif L_28.mif L_145.mif L_144.mif max ../${SUBJ}_masks/${SUBJ}_L_mPFC63_AG151-150-149-148-25-28-145-144_combined.mif
	mrmath L_63.mif L_73.mif L_87.mif L_84.mif L_86.mif L_83.mif L_85.mif max ../${SUBJ}_masks/${SUBJ}_L_mPFC63_DPG73-87-84-86-83-85_combined.mif
	mrmath L_63.mif L_180.mif max ../${SUBJ}_masks/${SUBJ}_L_mPFC63_ACC180_combined.mif
	mrmath L_63.mif L_143.mif L_151.mif L_150.mif L_149.mif L_116.mif L_147.mif L_146.mif L_145.mif L_144.mif max ../${SUBJ}_masks/${SUBJ}_L_mPFC63_PPC143-151-150-149-116-147-146-145-144_combined.mif

	mrmath L_23.mif L_151.mif L_150.mif L_149.mif L_148.mif L_25.mif L_28.mif L_145.mif L_144.mif max ../${SUBJ}_masks/${SUBJ}_L_MTL23_AG151-150-149-148-25-28-145-144_combined.mif
	mrmath L_23.mif L_73.mif L_87.mif L_84.mif L_86.mif L_83.mif L_85.mif max ../${SUBJ}_masks/${SUBJ}_L_MTL23_DPG73-87-84-86-83-85_combined.mif
	mrmath L_23.mif L_180.mif max ../${SUBJ}_masks/${SUBJ}_L_MTL23_ACC180_combined.mif
	mrmath L_23.mif L_143.mif L_151.mif L_150.mif L_149.mif L_116.mif L_147.mif L_146.mif L_145.mif L_144.mif max ../${SUBJ}_masks/${SUBJ}_L_MTL23_PPC143-151-150-149-116-147-146-145-144_combined.mif

	mrmath L_151.mif L_150.mif L_149.mif L_148.mif L_25.mif L_28.mif L_145.mif L_144.mif L_73.mif L_87.mif L_84.mif L_86.mif L_83.mif L_85.mif max ../${SUBJ}_masks/${SUBJ}_L_AG151-150-149-148-25-28-145-144_DPG73-87-84-86-83-85_combined.mif
	mrmath L_151.mif L_150.mif L_149.mif L_148.mif L_25.mif L_28.mif L_145.mif L_144.mif L_180.mif max ../${SUBJ}_masks/${SUBJ}_L_AG151-150-149-148-25-28-145-144_ACC180_combined.mif
	mrmath L_148.mif L_25.mif L_28.mif L_143.mif L_151.mif L_150.mif L_149.mif L_116.mif L_147.mif L_146.mif L_145.mif L_144.mif max ../${SUBJ}_masks/${SUBJ}_L_AG151-150-149-148-25-28-145-144_PPC143-151-150-149-116-147-146-145-144_combined.mif

	mrmath L_73.mif L_87.mif L_84.mif L_86.mif L_83.mif L_85.mif L_180.mif max ../${SUBJ}_masks/${SUBJ}_L_DPG73-87-84-86-83-85_ACC180_combined.mif
	mrmath L_73.mif L_87.mif L_84.mif L_86.mif L_83.mif L_85.mif L_143.mif L_151.mif L_150.mif L_149.mif L_116.mif L_147.mif L_146.mif L_145.mif L_144.mif max ../${SUBJ}_masks/${SUBJ}_L_DPG73-87-84-86-83-85_PPC143-151-150-149-116-147-146-145-144_combined.mif

	mrmath L_180.mif L_143.mif L_151.mif L_150.mif L_149.mif L_116.mif L_147.mif L_146.mif L_145.mif L_144.mif max ../${SUBJ}_masks/${SUBJ}_L_ACC180_PPC143-151-150-149-116-147-146-145-144_combined.mif

	#right
	mrmath R_212.mif R_214.mif R_213.mif R_243.mif max ../${SUBJ}_masks/${SUBJ}_R_PCC212-214-213_mPFC243_combined.mif
	mrmath R_212.mif R_214.mif R_213.mif R_203.mif max ../${SUBJ}_masks/${SUBJ}_R_PCC212-214-213_MTL203_combined.mif
	mrmath R_212.mif R_214.mif R_213.mif R_331.mif R_330.mif R_329.mif R_205.mif R_208.mif R_325.mif R_324.mif max ../${SUBJ}_masks/${SUBJ}_R_PCC212-214-213_AG331-330-329-328-205-208-325-324_combined.mif
	mrmath R_212.mif R_214.mif R_213.mif R_253.mif R_267.mif R_264.mif R_266.mif R_263.mif R_265.mif max ../${SUBJ}_masks/${SUBJ}_R_PCC212-214-213_DPG253-267-264-266-263-265_combined.mif
	mrmath R_212.mif R_214.mif R_213.mif R_359.mif max ../${SUBJ}_masks/${SUBJ}_R_PCC212-214-213_ACC359_combined.mif
	mrmath R_212.mif R_214.mif R_213.mif R_323.mif R_331.mif R_330.mif R_329.mif R_296.mif R_327.mif R_326.mif R_325.mif R_324.mif max ../${SUBJ}_masks/${SUBJ}_R_PCC212-214-213_PPC323-331-330-329-296-327-326-325-324_combined.mif

	mrmath R_243.mif R_203.mif max ../${SUBJ}_masks/${SUBJ}_R_mPFC243_MTL203_combined.mif
	mrmath R_243.mif R_331.mif R_330.mif R_329.mif R_328.mif R_205.mif R_208.mif R_325.mif R_324.mif max ../${SUBJ}_masks/${SUBJ}_R_mPFC243_AG331-330-329-328-205-208-325-324_combined.mif
	mrmath R_243.mif R_253.mif R_267.mif R_264.mif R_266.mif R_263.mif R_265.mif max ../${SUBJ}_masks/${SUBJ}_R_mPFC243_DPG253-267-264-266-263-265_combined.mif
	mrmath R_243.mif R_359.mif max ../${SUBJ}_masks/${SUBJ}_R_mPFC243_ACC359_combined.mif
	mrmath R_243.mif R_323.mif R_331.mif R_330.mif R_329.mif R_296.mif R_327.mif R_326.mif R_325.mif R_324.mif max ../${SUBJ}_masks/${SUBJ}_R_mPFC243_PPC323-331-330-329-296-327-326-325-324_combined.mif

	mrmath R_203.mif R_331.mif R_330.mif R_329.mif R_328.mif R_205.mif R_208.mif R_325.mif R_324.mif max ../${SUBJ}_masks/${SUBJ}_R_MTL203_AG331-330-329-328-205-208-325-324_combined.mif
	mrmath R_203.mif R_253.mif R_267.mif R_264.mif R_266.mif R_263.mif R_265.mif max ../${SUBJ}_masks/${SUBJ}_R_MTL203_DPG253-267-264-266-263-265_combined.mif
	mrmath R_203.mif R_359.mif max ../${SUBJ}_masks/${SUBJ}_R_MTL203_ACC359_combined.mif
	mrmath R_203.mif R_323.mif R_331.mif R_330.mif R_329.mif R_296.mif R_327.mif R_326.mif R_325.mif R_324.mif max ../${SUBJ}_masks/${SUBJ}_R_MTL203_PPC323-331-330-329-296-327-326-325-324_combined.mif

	mrmath R_331.mif R_330.mif R_329.mif R_328.mif R_205.mif R_208.mif R_325.mif R_324.mif R_253.mif R_267.mif R_264.mif R_266.mif R_263.mif R_265.mif max ../${SUBJ}_masks/${SUBJ}_R_AG331-330-329-328-205-208-325-324_DPG253-267-264-266-263-265_combined.mif
	mrmath R_331.mif R_330.mif R_329.mif R_328.mif R_205.mif R_208.mif R_325.mif R_324.mif R_359.mif max ../${SUBJ}_masks/${SUBJ}_R_AG331-330-329-328-205-208-325-324_ACC359_combined.mif
	mrmath R_328.mif R_205.mif R_208.mif R_323.mif R_331.mif R_330.mif R_329.mif R_296.mif R_327.mif R_326.mif R_325.mif R_324.mif max ../${SUBJ}_masks/${SUBJ}_R_AG331-330-329-328-205-208-325-324_PPC323-331-330-329-296-327-326-325-324_combined.mif

	mrmath R_253.mif R_267.mif R_264.mif R_266.mif R_263.mif R_265.mif R_359.mif max ../${SUBJ}_masks/${SUBJ}_R_DPG253-267-264-266-263-265_ACC359_combined.mif
	mrmath R_253.mif R_267.mif R_264.mif R_266.mif R_263.mif R_265.mif R_323.mif R_331.mif R_330.mif R_329.mif R_296.mif R_327.mif R_326.mif R_325.mif R_324.mif max ../${SUBJ}_masks/${SUBJ}_R_DPG253-267-264-266-263-265_PPC323-331-330-329-296-327-326-325-324_combined.mif

	mrmath R_359.mif R_323.mif R_331.mif R_330.mif R_329.mif R_296.mif R_327.mif R_326.mif R_325.mif R_324.mif max ../${SUBJ}_masks/${SUBJ}_R_ACC359_PPC323-331-330-329-296-327-326-325-324_combined.mif
	
	cd ../${SUBJ}_masks/
	
	#left-right pairs
	for mask in L_PCC32-34-33 L_mPFC63 L_MTL23 L_AG151-150-149-148-25-28-145-144 L_DPG73-87-84-86-83-85 L_ACC180 L_PPC143-151-150-149-116-147-146-145-144
	do 
		mrmath ${SUBJ}_${mask}.mif ${SUBJ}_R_PCC212-214-213.mif max ${SUBJ}_${mask}_R_PCC212-214-213_combined.mif 
		mrmath ${SUBJ}_${mask}.mif ${SUBJ}_R_mPFC243.mif max ${SUBJ}_${mask}_R_mPFC243_combined.mif
		mrmath ${SUBJ}_${mask}.mif ${SUBJ}_R_MTL203.mif max ${SUBJ}_${mask}_R_MTL203_combined.mif
		mrmath ${SUBJ}_${mask}.mif ${SUBJ}_R_AG331-330-329-328-205-208-325-324.mif max ${SUBJ}_${mask}_R_AG331-330-329-328-205-208-325-324_combined.mif
		mrmath ${SUBJ}_${mask}.mif ${SUBJ}_R_DPG253-267-264-266-263-265.mif max ${SUBJ}_${mask}_R_DPG253-267-264-266-263-265_combined.mif
		mrmath ${SUBJ}_${mask}.mif ${SUBJ}_R_ACC359.mif max ${SUBJ}_${mask}_R_ACC359_combined.mif
		mrmath ${SUBJ}_${mask}.mif ${SUBJ}_R_PPC323-331-330-329-296-327-326-325-324.mif max ${SUBJ}_${mask}_R_PPC323-331-330-329-296-327-326-325-324_combined.mif
	done

	cd ..

	#GENERATE EXCLUSION MASKS
	
	#designate path
	leftpath=/home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_leftnodes/
	rightpath=/home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_rightnodes/

	#make directories
	mkdir ${SUBJ}_exclusion_masks
	mkdir ${SUBJ}_leftnodes
	mkdir ${SUBJ}_rightnodes

	#generate all right hcpmmp1 nodes
	for node in $(seq 181 359)
	do 
		mrcalc /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_hcpmmp1_parcels_coreg.mif $node -eq ${SUBJ}_rightnodes/R_$node.mif -force
	done

	cd ${SUBJ}_rightnodes

	#make mask of all right hemisphere nodes
	include_list=()
	for node in *.mif
	do 
		include_list+=(${node})
	done
	mrmath ${include_list[*]} max ../${SUBJ}_exclusion_masks/${SUBJ}_exclude_right_hemisphere.mif -force
	mrconvert ../${SUBJ}_exclusion_masks/${SUBJ}_exclude_right_hemisphere.mif ../${SUBJ}_exclusion_masks/${SUBJ}_exclude_right_hemisphere.nii.gz

	cd ..
	 
	#generate all left hcpmmp1 nodes
	for node in $(seq 1 180)
	do 
		mrcalc /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_hcpmmp1_parcels_coreg.mif $node -eq ${SUBJ}_leftnodes/L_$node.mif -force
	done

	cd ${SUBJ}_leftnodes

	#make mask of all left hemisphere nodes
	include_list=()
	for node in *.mif
	do 
		include_list+=(${node})
	done
	mrmath ${include_list[*]} max ../${SUBJ}_exclusion_masks/${SUBJ}_exclude_left_hemisphere.mif -force
	mrconvert ../${SUBJ}_exclusion_masks/${SUBJ}_exclude_left_hemisphere.mif ../${SUBJ}_exclusion_masks/${SUBJ}_exclude_left_hemisphere.nii.gz
	
	cd ../${SUBJ}_exclusion_masks
	
	#make network exclusion masks within each hemisphere
	#left
	#L_PCC32-34-33 and L_mPFC63
	#make array
	declare -a exclude_list=( "${leftpath}L_32.mif" "${leftpath}L_34.mif" "${leftpath}L_33.mif" "${leftpath}L_63.mif" )
	#make mask
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_left_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_PCC32-34-33_mPFC63_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_PCC32-34-33_mPFC63_combined.nii.gz ${SUBJ}_exclude_L_PCC32-34-33_mPFC63_combined.mif -force

	#L_PCC32-34-33 and L_MTL23
	#make array
	declare -a exclude_list=( "${leftpath}L_32.mif" "${leftpath}L_34.mif" "${leftpath}L_33.mif" "${leftpath}L_23.mif" )
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_left_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_PCC32-34-33_MTL23_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_PCC32-34-33_MTL23_combined.nii.gz ${SUBJ}_exclude_L_PCC32-34-33_MTL23_combined.mif -force

	#L_PCC32-34-33 and L_AG151-150-149-148-25-28-145-144
	#make array
	declare -a exclude_list=( "${leftpath}L_32.mif" "${leftpath}L_34.mif" "${leftpath}L_33.mif" "${leftpath}L_151.mif" "${leftpath}L_150.mif" "${leftpath}L_149.mif" "${leftpath}L_25.mif" "${leftpath}L_28.mif" "${leftpath}L_145.mif" "${leftpath}L_144.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_left_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_PCC32-34-33_AG151-150-149-148-25-28-145-144_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_PCC32-34-33_AG151-150-149-148-25-28-145-144_combined.nii.gz ${SUBJ}_exclude_L_PCC32-34-33_AG151-150-149-148-25-28-145-144_combined.mif -force

	#L_PCC32-34-33 and L_DPG73-87-84-86-83-85
	#make array
	declare -a exclude_list=( "${leftpath}L_32.mif" "${leftpath}L_34.mif" "${leftpath}L_33.mif" "${leftpath}L_73.mif" "${leftpath}L_87.mif" "${leftpath}L_84.mif" "${leftpath}L_86.mif" "${leftpath}L_83.mif" "${leftpath}L_85.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_left_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_PCC32-34-33_DPG73-87-84-86-83-85_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_PCC32-34-33_DPG73-87-84-86-83-85_combined.nii.gz ${SUBJ}_exclude_L_PCC32-34-33_DPG73-87-84-86-83-85_combined.mif -force

	#L_PCC32-34-33 and L_ACC180
	#make array
	declare -a exclude_list=( "${leftpath}L_32.mif" "${leftpath}L_34.mif" "${leftpath}L_33.mif" "${leftpath}L_180.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_left_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_PCC32-34-33_ACC180_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_PCC32-34-33_ACC180_combined.nii.gz ${SUBJ}_exclude_L_PCC32-34-33_ACC180_combined.mif -force

	#L_PCC32-34-33 and L_PPC143-151-150-149-116-147-146-145-144
	#make array
	declare -a exclude_list=( "${leftpath}L_32.mif" "${leftpath}L_34.mif" "${leftpath}L_33.mif" "${leftpath}L_143.mif" "${leftpath}L_151.mif" "${leftpath}L_150.mif" "${leftpath}L_149.mif" "${leftpath}L_116.mif" "${leftpath}L_147.mif" "${leftpath}L_146.mif" "${leftpath}L_145.mif" "${leftpath}L_144.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_left_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_PCC32-34-33_PPC143-151-150-149-116-147-146-145-144_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_PCC32-34-33_PPC143-151-150-149-116-147-146-145-144_combined.nii.gz ${SUBJ}_exclude_L_PCC32-34-33_PPC143-151-150-149-116-147-146-145-144_combined.mif -force

	#L_mPFC63 and L_MTL23
	#make array
	declare -a exclude_list=( "${leftpath}L_63.mif" "${leftpath}L_23.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_left_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_mPFC63_MTL23_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_mPFC63_MTL23_combined.nii.gz ${SUBJ}_exclude_L_mPFC63_MTL23_combined.mif -force

	#L_mPFC63 and L_AG151-150-149-148-25-28-145-144
	#make array
	declare -a exclude_list=( "${leftpath}L_63.mif" "${leftpath}L_151.mif" "${leftpath}L_150.mif" "${leftpath}L_149.mif" "${leftpath}L_148.mif" "${leftpath}L_25.mif" "${leftpath}L_28.mif" "${leftpath}L_145.mif" "${leftpath}L_144.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_left_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_mPFC63_AG151-150-149-148-25-28-145-144_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_mPFC63_AG151-150-149-148-25-28-145-144_combined.nii.gz ${SUBJ}_exclude_L_mPFC63_AG151-150-149-148-25-28-145-144_combined.mif -force

	#L_mPFC63 and L_DPG73-87-84-86-83-85
	#make array
	declare -a exclude_list=( "${leftpath}L_63.mif" "${leftpath}L_73.mif" "${leftpath}L_87.mif" "${leftpath}L_84.mif" "${leftpath}L_86.mif" "${leftpath}L_83.mif" "${leftpath}L_85.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_left_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_mPFC63_DPG73-87-84-86-83-85_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_mPFC63_DPG73-87-84-86-83-85_combined.nii.gz ${SUBJ}_exclude_L_mPFC63_DPG73-87-84-86-83-85_combined.mif -force

	#L_mPFC63 and L_ACC180
	#make array
	declare -a exclude_list=( "${leftpath}L_63.mif" "${leftpath}L_180.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_left_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_mPFC63_ACC180_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_mPFC63_ACC180_combined.nii.gz ${SUBJ}_exclude_L_mPFC63_ACC180_combined.mif -force

	#L_mPFC63 and L_PPC143-151-150-149-116-147-146-145-144
	#make array
	declare -a exclude_list=( "${leftpath}L_63.mif" "${leftpath}L_143.mif" "${leftpath}L_151.mif" "${leftpath}L_150.mif" "${leftpath}L_149.mif" "${leftpath}L_116.mif" "${leftpath}L_147.mif" "${leftpath}L_116.mif" "${leftpath}L_147.mif" "${leftpath}L_146.mif" "${leftpath}L_145.mif" "${leftpath}L_144.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_left_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_mPFC63_PPC143-151-150-149-116-147-146-145-144_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_mPFC63_PPC143-151-150-149-116-147-146-145-144_combined.nii.gz ${SUBJ}_exclude_L_mPFC63_PPC143-151-150-149-116-147-146-145-144_combined.mif -force

	#L_MTL23 and L_AG151-150-149-148-25-28-145-144 
	#make array
	declare -a exclude_list=( "${leftpath}L_23.mif" "${leftpath}L_151.mif" "${leftpath}L_150.mif" "${leftpath}L_149.mif" "${leftpath}L_148.mif" "${leftpath}L_25.mif" "${leftpath}L_28.mif" "${leftpath}L_145.mif" "${leftpath}L_144.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_left_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_MTL23_AG151-150-149-148-25-28-145-144_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_MTL23_AG151-150-149-148-25-28-145-144_combined.nii.gz ${SUBJ}_exclude_L_MTL23_AG151-150-149-148-25-28-145-144_combined.mif -force

	#L_MTL23 and L_DPG73-87-84-86-83-85
	#make array
	declare -a exclude_list=( "${leftpath}L_23.mif" "${leftpath}L_73.mif" "${leftpath}L_87.mif" "${leftpath}L_84.mif" "${leftpath}L_86.mif" "${leftpath}L_83.mif" "${leftpath}L_85.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_left_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_MTL23_DPG73-87-84-86-83-85_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_MTL23_DPG73-87-84-86-83-85_combined.nii.gz ${SUBJ}_exclude_L_MTL23_DPG73-87-84-86-83-85_combined.mif -force

	#L_MTL23 and L_ACC180
	#make array
	declare -a exclude_list=( "${leftpath}L_23.mif" "${leftpath}L_180.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_left_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_MTL23_ACC180_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_MTL23_ACC180_combined.nii.gz ${SUBJ}_exclude_L_MTL23_ACC180_combined.mif -force

	#L_MTL23 and L_PPC143-151-150-149-116-147-146-145-144
	#make array
	declare -a exclude_list=( "${leftpath}L_23.mif" "${leftpath}L_143.mif" "${leftpath}L_151.mif" "${leftpath}L_150.mif" "${leftpath}L_149.mif" "${leftpath}L_116.mif" "${leftpath}L_147.mif" "${leftpath}L_146.mif" "${leftpath}L_145.mif" "${leftpath}L_144.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_left_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_MTL23_PPC143-151-150-149-116-147-146-145-144_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_MTL23_PPC143-151-150-149-116-147-146-145-144_combined.nii.gz ${SUBJ}_exclude_L_MTL23_PPC143-151-150-149-116-147-146-145-144_combined.mif -force

	#L_AG151-150-149-148-25-28-145-144 and L_DPG73-87-84-86-83-85
	#make array
	declare -a exclude_list=( "${leftpath}L_151.mif" "${leftpath}L_150.mif" "${leftpath}L_149.mif" "${leftpath}L_148.mif" "${leftpath}L_25.mif" "${leftpath}L_28.mif" "${leftpath}L_145.mif" "${leftpath}L_144.mif" "${leftpath}L_73.mif" "${leftpath}L_87.mif" "${leftpath}L_84.mif" "${leftpath}L_86.mif" "${leftpath}L_83.mif" "${leftpath}L_85.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_left_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_AG151-150-149-148-25-28-145-144_DPG73-87-84-86-83-85_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_AG151-150-149-148-25-28-145-144_DPG73-87-84-86-83-85_combined.nii.gz ${SUBJ}_exclude_L_AG151-150-149-148-25-28-145-144_DPG73-87-84-86-83-85_combined.mif -force

	#L_AG151-150-149-148-25-28-145-144 and L_ACC180
	#make array
	declare -a exclude_list=( "${leftpath}L_151.mif" "${leftpath}L_150.mif" "${leftpath}L_149.mif" "${leftpath}L_148.mif" "${leftpath}L_25.mif" "${leftpath}L_28.mif" "${leftpath}L_145.mif" "${leftpath}L_144.mif" "${leftpath}L_180.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_left_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_AG151-150-149-148-25-28-145-144_ACC180_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_AG151-150-149-148-25-28-145-144_ACC180_combined.nii.gz ${SUBJ}_exclude_L_AG151-150-149-148-25-28-145-144_ACC180_combined.mif -force

	#L_AG151-150-149-148-25-28-145-144 and L_PPC143-151-150-149-116-147-146-145-144
	#make array
	declare -a exclude_list=( "${leftpath}L_148.mif" "${leftpath}L_25.mif" "${leftpath}L_28.mif" "${leftpath}L_145.mif" "${leftpath}L_144.mif" "${leftpath}L_143.mif" "${leftpath}L_151.mif" "${leftpath}L_150.mif" "${leftpath}L_149.mif" "${leftpath}L_116.mif" "${leftpath}L_147.mif" "${leftpath}L_146.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_left_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_AG151-150-149-148-25-28-145-144_PPC143-151-150-149-116-147-146-145-144_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_AG151-150-149-148-25-28-145-144_PPC143-151-150-149-116-147-146-145-144_combined.nii.gz ${SUBJ}_exclude_L_AG151-150-149-148-25-28-145-144_PPC143-151-150-149-116-147-146-145-144_combined.mif -force

	#L_DPG73-87-84-86-83-85 and L_ACC180
	#make array
	declare -a exclude_list=( "${leftpath}L_73.mif" "${leftpath}L_87.mif" "${leftpath}L_84.mif" "${leftpath}L_86.mif" "${leftpath}L_83.mif" "${leftpath}L_85.mif" "${leftpath}L_180.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_left_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_DPG73-87-84-86-83-85_ACC180_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_DPG73-87-84-86-83-85_ACC180_combined.nii.gz ${SUBJ}_exclude_L_DPG73-87-84-86-83-85_ACC180_combined.mif -force

	#L_DPG73-87-84-86-83-85 and L_PPC143-151-150-149-116-147-146-145-144
	#make array
	declare -a exclude_list=( "${leftpath}L_73.mif" "${leftpath}L_87.mif" "${leftpath}L_84.mif" "${leftpath}L_86.mif" "${leftpath}L_83.mif" "${leftpath}L_85.mif" "${leftpath}L_143.mif" "${leftpath}L_151.mif" "${leftpath}L_150.mif" "${leftpath}L_149.mif" "${leftpath}L_116.mif" "${leftpath}L_147.mif" "${leftpath}L_146.mif" "${leftpath}L_145.mif" "${leftpath}L_144.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_left_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_DPG73-87-84-86-83-85_PPC143-151-150-149-116-147-146-145-144_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_DPG73-87-84-86-83-85_PPC143-151-150-149-116-147-146-145-144_combined.nii.gz ${SUBJ}_exclude_L_DPG73-87-84-86-83-85_PPC143-151-150-149-116-147-146-145-144_combined.mif -force

	#L_ACC180 and L_PPC143-151-150-149-116-147-146-145-14
	#make array
	declare -a exclude_list=( "${leftpath}L_180.mif" "${leftpath}L_143.mif" "${leftpath}L_151.mif" "${leftpath}L_150.mif" "${leftpath}L_149.mif" "${leftpath}L_116.mif" "${leftpath}L_147.mif" "${leftpath}L_146.mif" "${leftpath}L_145.mif" "${leftpath}L_144.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_left_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_ACC180_PPC143-151-150-149-116-147-146-145-144_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_ACC180_PPC143-151-150-149-116-147-146-145-144_combined.nii.gz ${SUBJ}_exclude_L_ACC180_PPC143-151-150-149-116-147-146-145-144_combined.mif -force

	#right
	#R_PCC212-214-213 and R_mPFC243
	#make array
	declare -a exclude_list=( "${rightpath}R_212.mif" "${rightpath}R_214.mif" "${rightpath}R_213.mif" "${rightpath}R_243.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_right_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_R_PCC212-214-213_mPFC243_combined.nii.gz
	mrconvert ${SUBJ}_exclude_R_PCC212-214-213_mPFC243_combined.nii.gz ${SUBJ}_exclude_R_PCC212-214-213_mPFC243_combined.mif -force

	#R_PCC212-214-213 and R_MTL203
	#make array
	declare -a exclude_list=( "${rightpath}R_212.mif" "${rightpath}R_214.mif" "${rightpath}R_213.mif" "${rightpath}R_203.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_right_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_R_PCC212-214-213_MTL203_combined.nii.gz
	mrconvert ${SUBJ}_exclude_R_PCC212-214-213_MTL203_combined.nii.gz ${SUBJ}_exclude_R_PCC212-214-213_MTL203_combined.mif -force

	#R_PCC212-214-213 and R_AG331-330-329-328-205-208-325-324
	#make array
	declare -a exclude_list=( "${rightpath}R_212.mif" "${rightpath}R_214.mif" "${rightpath}R_213.mif" "${rightpath}R_331.mif" "${rightpath}R_330.mif" "${rightpath}R_329.mif" "${rightpath}R_205.mif" "${rightpath}R_208.mif" "${rightpath}R_325.mif" "${rightpath}R_324.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_right_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_R_PCC212-214-213_AG331-330-329-328-205-208-325-324_combined.nii.gz
	mrconvert ${SUBJ}_exclude_R_PCC212-214-213_AG331-330-329-328-205-208-325-324_combined.nii.gz ${SUBJ}_exclude_R_PCC212-214-213_AG331-330-329-328-205-208-325-324_combined.mif -force

	#R_PCC212-214-213 and R_DPG253-267-264-266-263-265
	#make array
	declare -a exclude_list=( "${rightpath}R_212.mif" "${rightpath}R_214.mif" "${rightpath}R_213.mif" "${rightpath}R_253.mif" "${rightpath}R_267.mif" "${rightpath}R_264.mif" "${rightpath}R_266.mif" "${rightpath}R_263.mif" "${rightpath}R_265.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_right_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_R_PCC212-214-213_DPG253-267-264-266-263-265_combined.nii.gz
	mrconvert ${SUBJ}_exclude_R_PCC212-214-213_DPG253-267-264-266-263-265_combined.nii.gz ${SUBJ}_exclude_R_PCC212-214-213_DPG253-267-264-266-263-265_combined.mif -force

	#R_PCC212-214-213 and R_ACC359
	#make array
	declare -a exclude_list=( "${rightpath}R_212.mif" "${rightpath}R_214.mif" "${rightpath}R_213.mif" "${rightpath}R_359.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_right_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_R_PCC212-214-213_ACC359_combined.nii.gz
	mrconvert ${SUBJ}_exclude_R_PCC212-214-213_ACC359_combined.nii.gz ${SUBJ}_exclude_R_PCC212-214-213_ACC359_combined.mif -force

	#R_PCC212-214-213 and R_PPC323-331-330-329-296-327-326-325-324
	#make array
	declare -a exclude_list=( "${rightpath}R_212.mif" "${rightpath}R_214.mif" "${rightpath}R_213.mif" "${rightpath}R_323.mif" "${rightpath}R_331.mif" "${rightpath}R_330.mif" "${rightpath}R_329.mif" "${rightpath}R_296.mif" "${rightpath}R_327.mif" "${rightpath}R_326.mif" "${rightpath}R_325.mif" "${rightpath}R_324.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_right_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_R_PCC212-214-213_PPC323-331-330-329-296-327-326-325-324_combined.nii.gz
	mrconvert ${SUBJ}_exclude_R_PCC212-214-213_PPC323-331-330-329-296-327-326-325-324_combined.nii.gz ${SUBJ}_exclude_R_PCC212-214-213_PPC323-331-330-329-296-327-326-325-324_combined.mif -force

	#R_mPFC243 and R_MTL203
	#make array
	declare -a exclude_list=( "${rightpath}R_243.mif" "${rightpath}R_203.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_right_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_R_mPFC243_MTL203_combined.nii.gz
	mrconvert ${SUBJ}_exclude_R_mPFC243_MTL203_combined.nii.gz ${SUBJ}_exclude_R_mPFC243_MTL203_combined.mif -force

	#R_mPFC243 and R_AG331-330-329-328-205-208-325-324
	#make array
	declare -a exclude_list=( "${rightpath}R_243.mif" "${rightpath}R_331.mif" "${rightpath}R_330.mif" "${rightpath}R_329.mif" "${rightpath}R_328.mif" "${rightpath}R_205.mif" "${rightpath}R_208.mif" "${rightpath}R_325.mif" "${rightpath}R_324.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_right_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_R_mPFC243_AG331-330-329-328-205-208-325-324_combined.nii.gz
	mrconvert ${SUBJ}_exclude_R_mPFC243_AG331-330-329-328-205-208-325-324_combined.nii.gz ${SUBJ}_exclude_R_mPFC243_AG331-330-329-328-205-208-325-324_combined.mif -force

	#R_mPFC243 and R_DPG253-267-264-266-263-265
	#make array
	declare -a exclude_list=( "${rightpath}R_243.mif" "${rightpath}R_253.mif" "${rightpath}R_267.mif" "${rightpath}R_264.mif" "${rightpath}R_266.mif" "${rightpath}R_263.mif" "${rightpath}R_265.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_right_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_R_mPFC243_DPG253-267-264-266-263-265_combined.nii.gz
	mrconvert ${SUBJ}_exclude_R_mPFC243_DPG253-267-264-266-263-265_combined.nii.gz ${SUBJ}_exclude_R_mPFC243_DPG253-267-264-266-263-265_combined.mif -force

	#R_mPFC243 and R_ACC359
	#make array
	declare -a exclude_list=( "${rightpath}R_243.mif" "${rightpath}R_359.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_right_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_R_mPFC243_ACC359_combined.nii.gz
	mrconvert ${SUBJ}_exclude_R_mPFC243_ACC359_combined.nii.gz ${SUBJ}_exclude_R_mPFC243_ACC359_combined.mif -force

	#R_mPFC243 and R_PPC323-331-330-329-296-327-326-325-324
	#make array
	declare -a exclude_list=( "${rightpath}R_243.mif" "${rightpath}R_323.mif" "${rightpath}R_331.mif" "${rightpath}R_330.mif" "${rightpath}R_329.mif" "${rightpath}R_296.mif" "${rightpath}R_327.mif" "${rightpath}R_296.mif" "${rightpath}R_327.mif" "${rightpath}R_326.mif" "${rightpath}R_325.mif" "${rightpath}R_324.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_right_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_R_mPFC243_PPC323-331-330-329-296-327-326-325-324_combined.nii.gz
	mrconvert ${SUBJ}_exclude_R_mPFC243_PPC323-331-330-329-296-327-326-325-324_combined.nii.gz ${SUBJ}_exclude_R_mPFC243_PPC323-331-330-329-296-327-326-325-324_combined.mif -force

	#R_MTL203 and R_AG331-330-329-328-205-208-325-324 
	#make array
	declare -a exclude_list=( "${rightpath}R_203.mif" "${rightpath}R_331.mif" "${rightpath}R_330.mif" "${rightpath}R_329.mif" "${rightpath}R_328.mif" "${rightpath}R_205.mif" "${rightpath}R_208.mif" "${rightpath}R_325.mif" "${rightpath}R_324.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_right_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_R_MTL203_AG331-330-329-328-205-208-325-324_combined.nii.gz
	mrconvert ${SUBJ}_exclude_R_MTL203_AG331-330-329-328-205-208-325-324_combined.nii.gz ${SUBJ}_exclude_R_MTL203_AG331-330-329-328-205-208-325-324_combined.mif -force

	#R_MTL203 and R_DPG253-267-264-266-263-265
	#make array
	declare -a exclude_list=( "${rightpath}R_203.mif" "${rightpath}R_253.mif" "${rightpath}R_267.mif" "${rightpath}R_264.mif" "${rightpath}R_266.mif" "${rightpath}R_263.mif" "${rightpath}R_265.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_right_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_R_MTL203_DPG253-267-264-266-263-265_combined.nii.gz
	mrconvert ${SUBJ}_exclude_R_MTL203_DPG253-267-264-266-263-265_combined.nii.gz ${SUBJ}_exclude_R_MTL203_DPG253-267-264-266-263-265_combined.mif -force

	#R_MTL203 and R_ACC359
	#make array
	declare -a exclude_list=( "${rightpath}R_203.mif" "${rightpath}R_359.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_right_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_R_MTL203_ACC359_combined.nii.gz
	mrconvert ${SUBJ}_exclude_R_MTL203_ACC359_combined.nii.gz ${SUBJ}_exclude_R_MTL203_ACC359_combined.mif -force

	#R_MTL203 and R_PPC323-331-330-329-296-327-326-325-324
	#make array
	declare -a exclude_list=( "${rightpath}R_203.mif" "${rightpath}R_323.mif" "${rightpath}R_331.mif" "${rightpath}R_330.mif" "${rightpath}R_329.mif" "${rightpath}R_296.mif" "${rightpath}R_327.mif" "${rightpath}R_326.mif" "${rightpath}R_325.mif" "${rightpath}R_324.mif" )
	#make mask
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_right_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_R_MTL203_PPC323-331-330-329-296-327-326-325-324_combined.nii.gz
	mrconvert ${SUBJ}_exclude_R_MTL203_PPC323-331-330-329-296-327-326-325-324_combined.nii.gz ${SUBJ}_exclude_R_MTL203_PPC323-331-330-329-296-327-326-325-324_combined.mif -force

	#R_AG331-330-329-328-205-208-325-324 and R_DPG253-267-264-266-263-265
	#make array
	declare -a exclude_list=( "${rightpath}R_331.mif" "${rightpath}R_330.mif" "${rightpath}R_329.mif" "${rightpath}R_328.mif" "${rightpath}R_205.mif" "${rightpath}R_208.mif" "${rightpath}R_325.mif" "${rightpath}R_324.mif" "${rightpath}R_253.mif" "${rightpath}R_267.mif" "${rightpath}R_264.mif" "${rightpath}R_266.mif" "${rightpath}R_263.mif" "${rightpath}R_265.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_right_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_R_AG331-330-329-328-205-208-325-324_DPG253-267-264-266-263-265_combined.nii.gz
	mrconvert ${SUBJ}_exclude_R_AG331-330-329-328-205-208-325-324_DPG253-267-264-266-263-265_combined.nii.gz ${SUBJ}_exclude_R_AG331-330-329-328-205-208-325-324_DPG253-267-264-266-263-265_combined.mif -force

	#R_AG331-330-329-328-205-208-325-324 and R_ACC359
	#make array
	declare -a exclude_list=( "${rightpath}R_331.mif" "${rightpath}R_330.mif" "${rightpath}R_329.mif" "${rightpath}R_328.mif" "${rightpath}R_205.mif" "${rightpath}R_208.mif" "${rightpath}R_325.mif" "${rightpath}R_324.mif" "${rightpath}R_359.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_right_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_R_AG331-330-329-328-205-208-325-324_ACC359_combined.nii.gz
	mrconvert ${SUBJ}_exclude_R_AG331-330-329-328-205-208-325-324_ACC359_combined.nii.gz ${SUBJ}_exclude_R_AG331-330-329-328-205-208-325-324_ACC359_combined.mif -force

	#R_AG331-330-329-328-205-208-325-324 and R_PPC323-331-330-329-296-327-326-325-324
	#make array
	declare -a exclude_list=( "${rightpath}R_328.mif" "${rightpath}R_205.mif" "${rightpath}R_208.mif" "${rightpath}R_325.mif" "${rightpath}R_324.mif" "${rightpath}R_323.mif" "${rightpath}R_331.mif" "${rightpath}R_330.mif" "${rightpath}R_329.mif" "${rightpath}R_296.mif" "${rightpath}R_327.mif" "${rightpath}R_326.mif" )
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_right_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_R_AG331-330-329-328-205-208-325-324_PPC323-331-330-329-296-327-326-325-324_combined.nii.gz
	mrconvert ${SUBJ}_exclude_R_AG331-330-329-328-205-208-325-324_PPC323-331-330-329-296-327-326-325-324_combined.nii.gz ${SUBJ}_exclude_R_AG331-330-329-328-205-208-325-324_PPC323-331-330-329-296-327-326-325-324_combined.mif -force

	#R_DPG253-267-264-266-263-265 and R_ACC359
	#make array
	declare -a exclude_list=( "${rightpath}R_253.mif" "${rightpath}R_267.mif" "${rightpath}R_264.mif" "${rightpath}R_266.mif" "${rightpath}R_263.mif" "${rightpath}R_265.mif" "${rightpath}R_359.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_right_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_R_DPG253-267-264-266-263-265_ACC359_combined.nii.gz
	mrconvert ${SUBJ}_exclude_R_DPG253-267-264-266-263-265_ACC359_combined.nii.gz ${SUBJ}_exclude_R_DPG253-267-264-266-263-265_ACC359_combined.mif -force

	#R_DPG253-267-264-266-263-265 and R_PPC323-331-330-329-296-327-326-325-324
	#make array
	declare -a exclude_list=( "${rightpath}R_253.mif" "${rightpath}R_267.mif" "${rightpath}R_264.mif" "${rightpath}R_266.mif" "${rightpath}R_263.mif" "${rightpath}R_265.mif" "${rightpath}R_323.mif" "${rightpath}R_331.mif" "${rightpath}R_330.mif" "${rightpath}R_329.mif" "${rightpath}R_296.mif" "${rightpath}R_327.mif" "${rightpath}R_326.mif" "${rightpath}R_325.mif" "${rightpath}R_324.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_right_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_R_DPG253-267-264-266-263-265_PPC323-331-330-329-296-327-326-325-324_combined.nii.gz
	mrconvert ${SUBJ}_exclude_R_DPG253-267-264-266-263-265_PPC323-331-330-329-296-327-326-325-324_combined.nii.gz ${SUBJ}_exclude_R_DPG253-267-264-266-263-265_PPC323-331-330-329-296-327-326-325-324_combined.mif -force

	#R_ACC359 and R_PPC323-331-330-329-296-327-326-325-14
	#make array
	declare -a exclude_list=( "${rightpath}R_359.mif" "${rightpath}R_323.mif" "${rightpath}R_331.mif" "${rightpath}R_330.mif" "${rightpath}R_329.mif" "${rightpath}R_296.mif" "${rightpath}R_327.mif" "${rightpath}R_326.mif" "${rightpath}R_325.mif" "${rightpath}R_324.mif" )
	#make mask 
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_right_hemisphere.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_R_ACC359_PPC323-331-330-329-296-327-326-325-324_combined.nii.gz
	mrconvert ${SUBJ}_exclude_R_ACC359_PPC323-331-330-329-296-327-326-325-324_combined.nii.gz ${SUBJ}_exclude_R_ACC359_PPC323-331-330-329-296-327-326-325-324_combined.mif -force
	
	#left-right pair exclusion masks
	
	#Add left and right hemispheres together
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_right_hemisphere.nii.gz -max /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_left_hemisphere.nii.gz /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz
	
	#L_PCC32-34-33 and R_PCC212-214-213
	#make array
	declare -a exclude_list=( "${leftpath}L_32.mif" "${leftpath}L_34.mif" "${leftpath}L_33.mif" "${rightpath}R_212.mif" "${rightpath}R_214.mif" "${rightpath}R_213.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_PCC32-34-33_R_PCC212-214-213_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_PCC32-34-33_R_PCC212-214-213_combined.nii.gz ${SUBJ}_exclude_L_PCC32-34-33_R_PCC212-214-213_combined.mif -force

	#L_PCC32-34-33 and R_mPFC243
	#make array
	declare -a exclude_list=( "${leftpath}L_32.mif" "${leftpath}L_34.mif" "${leftpath}L_33.mif" "${rightpath}R_243.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_PCC32-34-33_R_mPFC243_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_PCC32-34-33_R_mPFC243_combined.nii.gz ${SUBJ}_exclude_L_PCC32-34-33_R_mPFC243_combined.mif -force
	
	#L_PCC32-34-33 and R_MTL203
	#make array
	declare -a exclude_list=( "${leftpath}L_32.mif" "${leftpath}L_34.mif" "${leftpath}L_33.mif" "${rightpath}R_203.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_PCC32-34-33_R_MTL203_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_PCC32-34-33_R_MTL203_combined.nii.gz ${SUBJ}_exclude_L_PCC32-34-33_R_MTL203_combined.mif -force
	
	#L_PCC32-34-33 and R_AG331-330-329-328-205-208-325-324
	#make array
	declare -a exclude_list=( "${leftpath}L_32.mif" "${leftpath}L_34.mif" "${leftpath}L_33.mif" "${rightpath}R_331.mif" "${rightpath}R_330.mif" "${rightpath}R_329.mif" "${rightpath}R_328.mif" "${rightpath}R_205.mif" "${rightpath}R_208.mif" "${rightpath}R_325.mif" "${rightpath}R_324.mif")
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_PCC32-34-33_R_AG331-330-329-328-205-208-325-324_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_PCC32-34-33_R_AG331-330-329-328-205-208-325-324_combined.nii.gz ${SUBJ}_exclude_L_PCC32-34-33_R_AG331-330-329-328-205-208-325-324_combined.mif -force
	
	#L_PCC32-34-33 and R_DPG253-267-264-266-263-265
	#make array
	declare -a exclude_list=( "${leftpath}L_32.mif" "${leftpath}L_34.mif" "${leftpath}L_33.mif" "${rightpath}R_253.mif" "${rightpath}R_267.mif" "${rightpath}R_264.mif" "${rightpath}R_266.mif" "${rightpath}R_263.mif" "${rightpath}R_265.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_PCC32-34-33_R_DPG253-267-264-266-263-265_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_PCC32-34-33_R_DPG253-267-264-266-263-265_combined.nii.gz ${SUBJ}_exclude_L_PCC32-34-33_R_DPG253-267-264-266-263-265_combined.mif -force
	
	#L_PCC32-34-33 and R_ACC359
	#make array
	declare -a exclude_list=( "${leftpath}L_32.mif" "${leftpath}L_34.mif" "${leftpath}L_33.mif" "${rightpath}R_359.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_PCC32-34-33_R_ACC359_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_PCC32-34-33_R_ACC359_combined.nii.gz ${SUBJ}_exclude_L_PCC32-34-33_R_ACC359_combined.mif -force
	
	#L_PCC32-34-33 and R_PPC323-331-330-329-296-327-326-325-324
	#make array
	declare -a exclude_list=( "${leftpath}L_32.mif" "${leftpath}L_34.mif" "${leftpath}L_33.mif" "${rightpath}R_323.mif" "${rightpath}R_331.mif" "${rightpath}R_330.mif" "${rightpath}R_329.mif" "${rightpath}R_296.mif" "${rightpath}R_327.mif" "${rightpath}R_326.mif" "${rightpath}R_325.mif" "${rightpath}R_324.mif")
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_PCC32-34-33_R_PPC323-331-330-329-296-327-326-325-324_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_PCC32-34-33_R_PPC323-331-330-329-296-327-326-325-324_combined.nii.gz ${SUBJ}_exclude_L_PCC32-34-33_R_PPC323-331-330-329-296-327-326-325-324_combined.mif -force
	
	#L_mPFC63 and R_PCC212-214-213
	#make array
	declare -a exclude_list=( "${leftpath}L_63.mif" "${rightpath}R_212.mif" "${rightpath}R_214.mif" "${rightpath}R_213.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_mPFC63_R_PCC212-214-213_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_mPFC63_R_PCC212-214-213_combined.nii.gz ${SUBJ}_exclude_L_mPFC63_R_PCC212-214-213_combined.mif -force
	
	#L_mPFC63 and R_mPFC243
	#make array
	declare -a exclude_list=( "${leftpath}L_63.mif" "${rightpath}R_243.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_mPFC63_R_mPFC243_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_mPFC63_R_mPFC243_combined.nii.gz ${SUBJ}_exclude_L_mPFC63_R_mPFC243_combined.mif -force
	
	#L_mPFC63 and R_MTL203
	#make array
	declare -a exclude_list=( "${leftpath}L_63.mif" "${rightpath}R_203.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_mPFC63_R_MTL203_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_mPFC63_R_MTL203_combined.nii.gz ${SUBJ}_exclude_L_mPFC63_R_MTL203_combined.mif -force
	
	#L_mPFC63 and R_AG331-330-329-328-205-208-325-324
	#make array
	declare -a exclude_list=( "${leftpath}L_63.mif" "${rightpath}R_331.mif" "${rightpath}R_330.mif" "${rightpath}R_329.mif" "${rightpath}R_328.mif" "${rightpath}R_205.mif" "${rightpath}R_208.mif" "${rightpath}R_325.mif" "${rightpath}R_324.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_mPFC63_R_AG331-330-329-328-205-208-325-324_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_mPFC63_R_AG331-330-329-328-205-208-325-324_combined.nii.gz ${SUBJ}_exclude_L_mPFC63_R_AG331-330-329-328-205-208-325-324_combined.mif -force
	
	#L_mPFC63 and R_DPG253-267-264-266-263-265
	#make array
	declare -a exclude_list=( "${leftpath}L_63.mif" "${rightpath}R_253.mif" "${rightpath}R_267.mif" "${rightpath}R_264.mif" "${rightpath}R_266.mif" "${rightpath}R_263.mif" "${rightpath}R_265.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_mPFC63_R_DPG253-267-264-266-263-265_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_mPFC63_R_DPG253-267-264-266-263-265_combined.nii.gz ${SUBJ}_exclude_L_mPFC63_R_DPG253-267-264-266-263-265_combined.mif -force
	
	#L_mPFC63 and R_ACC359
	#make array
	declare -a exclude_list=( "${leftpath}L_63.mif" "${rightpath}R_359.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_mPFC63_R_ACC359_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_mPFC63_R_ACC359_combined.nii.gz ${SUBJ}_exclude_L_mPFC63_R_ACC359_combined.mif -force
	
	#L_mPFC63 and R_PPC323-331-330-329-296-327-326-325-324
	#make array
	declare -a exclude_list=( "${leftpath}L_63.mif" "${rightpath}R_323.mif" "${rightpath}R_331.mif" "${rightpath}R_330.mif" "${rightpath}R_329.mif" "${rightpath}R_296.mif" "${rightpath}R_327.mif" "${rightpath}R_326.mif" "${rightpath}R_325.mif" "${rightpath}R_324.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_mPFC63_R_PPC323-331-330-329-296-327-326-325-324_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_mPFC63_R_PPC323-331-330-329-296-327-326-325-324_combined.nii.gz ${SUBJ}_exclude_L_mPFC63_R_PPC323-331-330-329-296-327-326-325-324_combined.mif -force
	
	#L_MTL23 and R_PCC212-214-213
	#make array
	declare -a exclude_list=( "${leftpath}L_23.mif" "${rightpath}R_212.mif" "${rightpath}R_214.mif" "${rightpath}R_213.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_MTL23_R_PCC212-214-213_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_MTL23_R_PCC212-214-213_combined.nii.gz ${SUBJ}_exclude_L_MTL23_R_PCC212-214-213_combined.mif -force
	
	#L_MTL23 and R_mPFC243
	#make array
	declare -a exclude_list=( "${leftpath}L_23.mif" "${rightpath}R_243.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_MTL23_R_mPFC243_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_MTL23_R_mPFC243_combined.nii.gz ${SUBJ}_exclude_L_MTL23_R_mPFC243_combined.mif -force
	
	#L_MTL23 and R_MTL203
	#make array
	declare -a exclude_list=( "${leftpath}L_23.mif" "${rightpath}R_203.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_MTL23_R_MTL203_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_MTL23_R_MTL203_combined.nii.gz ${SUBJ}_exclude_L_MTL23_R_MTL203_combined.mif -force
	
	#L_MTL23 and R_AG331-330-329-328-205-208-325-324 
	#make array
	declare -a exclude_list=( "${leftpath}L_23.mif" "${rightpath}R_331.mif" "${rightpath}R_330.mif" "${rightpath}R_329.mif" "${rightpath}R_328.mif" "${rightpath}R_205.mif" "${rightpath}R_208.mif" "${rightpath}R_325.mif" "${rightpath}R_324.mif")
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_MTL23_R_AG331-330-329-328-205-208-325-324_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_MTL23_R_AG331-330-329-328-205-208-325-324_combined.nii.gz ${SUBJ}_exclude_L_MTL23_R_AG331-330-329-328-205-208-325-324_combined.mif -force
	
	#L_MTL23 and R_DPG253-267-264-266-263-265
	#make array
	declare -a exclude_list=( "${leftpath}L_23.mif" "${rightpath}R_253.mif" "${rightpath}R_267.mif" "${rightpath}R_264.mif" "${rightpath}R_266.mif" "${rightpath}R_263.mif" "${rightpath}R_265.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_MTL23_R_DPG253-267-264-266-263-265_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_MTL23_R_DPG253-267-264-266-263-265_combined.nii.gz ${SUBJ}_exclude_L_MTL23_R_DPG253-267-264-266-263-265_combined.mif -force
	 
	#L_MTL23 and R_ACC359
	#make array
	declare -a exclude_list=( "${leftpath}L_23.mif" "${rightpath}R_359.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_MTL23_R_ACC359_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_MTL23_R_ACC359_combined.nii.gz ${SUBJ}_exclude_L_MTL23_R_ACC359_combined.mif -force
	
	#L_MTL23 and R_PPC323-331-330-329-296-327-326-325-324
	#make array
	declare -a exclude_list=( "${leftpath}L_23.mif" "${rightpath}R_323.mif" "${rightpath}R_331.mif" "${rightpath}R_330.mif" "${rightpath}R_329.mif" "${rightpath}R_296.mif" "${rightpath}R_327.mif" "${rightpath}R_326.mif" "${rightpath}R_325.mif" "${rightpath}R_324.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_MTL23_R_PPC323-331-330-329-296-327-326-325-324_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_MTL23_R_PPC323-331-330-329-296-327-326-325-324_combined.nii.gz ${SUBJ}_exclude_L_MTL23_R_PPC323-331-330-329-296-327-326-325-324_combined.mif -force
	
	#L_AG151-150-149-148-25-28-145-144 and R_PCC212-214-213
	#make array
	declare -a exclude_list=( "${leftpath}L_151.mif" "${leftpath}L_150.mif" "${leftpath}L_149.mif" "${leftpath}L_148.mif" "${leftpath}L_25.mif" "${leftpath}L_28.mif" "${leftpath}L_145.mif" "${leftpath}L_144.mif" "${rightpath}R_212.mif" "${rightpath}R_214.mif" "${rightpath}R_213.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_AG151-150-149-148-25-28-145-144_R_PCC212-214-213_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_AG151-150-149-148-25-28-145-144_R_PCC212-214-213_combined.nii.gz ${SUBJ}_exclude_L_AG151-150-149-148-25-28-145-144_R_PCC212-214-213_combined.mif -force
	
	#L_AG151-150-149-148-25-28-145-144 and R_mPFC243
	#make array
	declare -a exclude_list=( "${leftpath}L_151.mif" "${leftpath}L_150.mif" "${leftpath}L_149.mif" "${leftpath}L_148.mif" "${leftpath}L_25.mif" "${leftpath}L_28.mif" "${leftpath}L_145.mif" "${leftpath}L_144.mif" "${rightpath}R_243.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_AG151-150-149-148-25-28-145-144_R_mPFC243_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_AG151-150-149-148-25-28-145-144_R_mPFC243_combined.nii.gz ${SUBJ}_exclude_L_AG151-150-149-148-25-28-145-144_R_mPFC243_combined.mif -force
	
	#L_AG151-150-149-148-25-28-145-144 and R_MTL203
	#make array
	declare -a exclude_list=( "${leftpath}L_151.mif" "${leftpath}L_150.mif" "${leftpath}L_149.mif" "${leftpath}L_148.mif" "${leftpath}L_25.mif" "${leftpath}L_28.mif" "${leftpath}L_145.mif" "${leftpath}L_144.mif" "${rightpath}R_203.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_AG151-150-149-148-25-28-145-144_R_MTL203_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_AG151-150-149-148-25-28-145-144_R_MTL203_combined.nii.gz ${SUBJ}_exclude_L_AG151-150-149-148-25-28-145-144_R_MTL203_combined.mif -force
	
	#L_AG151-150-149-148-25-28-145-144 and R_AG331-330-329-328-205-208-325-324
	#make array
	declare -a exclude_list=( "${leftpath}L_151.mif" "${leftpath}L_150.mif" "${leftpath}L_149.mif" "${leftpath}L_148.mif" "${leftpath}L_25.mif" "${leftpath}L_28.mif" "${leftpath}L_145.mif" "${leftpath}L_144.mif" "${rightpath}R_331.mif" "${rightpath}R_330.mif" "${rightpath}R_329.mif" "${rightpath}R_328.mif" "${rightpath}R_205.mif" "${rightpath}R_208.mif" "${rightpath}R_325.mif" "${rightpath}R_324.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_AG151-150-149-148-25-28-145-144_R_AG331-330-329-328-205-208-325-324_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_AG151-150-149-148-25-28-145-144_R_AG331-330-329-328-205-208-325-324_combined.nii.gz ${SUBJ}_exclude_L_AG151-150-149-148-25-28-145-144_R_AG331-330-329-328-205-208-325-324_combined.mif -force
	
	#L_AG151-150-149-148-25-28-145-144 and R_DPG253-267-264-266-263-265
	#make array
	declare -a exclude_list=( "${leftpath}L_151.mif" "${leftpath}L_150.mif" "${leftpath}L_149.mif" "${leftpath}L_148.mif" "${leftpath}L_25.mif" "${leftpath}L_28.mif" "${leftpath}L_145.mif" "${leftpath}L_144.mif" "${rightpath}R_253.mif" "${rightpath}R_267.mif" "${rightpath}R_264.mif" "${rightpath}R_266.mif" "${rightpath}R_263.mif" "${rightpath}R_265.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_AG151-150-149-148-25-28-145-144_R_DPG253-267-264-266-263-265_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_AG151-150-149-148-25-28-145-144_R_DPG253-267-264-266-263-265_combined.nii.gz ${SUBJ}_exclude_L_AG151-150-149-148-25-28-145-144_R_DPG253-267-264-266-263-265_combined.mif -force
	
	#L_AG151-150-149-148-25-28-145-144 and R_ACC359
	#make array
	declare -a exclude_list=( "${leftpath}L_151.mif" "${leftpath}L_150.mif" "${leftpath}L_149.mif" "${leftpath}L_148.mif" "${leftpath}L_25.mif" "${leftpath}L_28.mif" "${leftpath}L_145.mif" "${leftpath}L_144.mif" "${rightpath}R_359.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_AG151-150-149-148-25-28-145-144_R_ACC359_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_AG151-150-149-148-25-28-145-144_R_ACC359_combined.nii.gz ${SUBJ}_exclude_L_AG151-150-149-148-25-28-145-144_R_ACC359_combined.mif -force
	
	#L_AG151-150-149-148-25-28-145-144 and R_PPC323-331-330-329-296-327-326-325-324
	#make array
	declare -a exclude_list=( "${leftpath}L_151.mif" "${leftpath}L_150.mif" "${leftpath}L_149.mif" "${leftpath}L_148.mif" "${leftpath}L_25.mif" "${leftpath}L_28.mif" "${leftpath}L_145.mif" "${leftpath}L_144.mif" "${rightpath}R_323.mif" "${rightpath}R_331.mif" "${rightpath}R_330.mif" "${rightpath}R_329.mif" "${rightpath}R_296.mif" "${rightpath}R_327.mif" "${rightpath}R_326.mif" "${rightpath}R_325.mif" "${rightpath}R_324.mif")
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_AG151-150-149-148-25-28-145-144_R_PPC323-331-330-329-296-327-326-325-324_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_AG151-150-149-148-25-28-145-144_R_PPC323-331-330-329-296-327-326-325-324_combined.nii.gz ${SUBJ}_exclude_L_AG151-150-149-148-25-28-145-144_R_PPC323-331-330-329-296-327-326-325-324_combined.mif -force
	
	#L_DPG73-87-84-86-83-85 and R_PCC212-214-213
	#make array
	declare -a exclude_list=( "${leftpath}L_73.mif" "${leftpath}L_87.mif" "${leftpath}L_84.mif" "${leftpath}L_86.mif" "${leftpath}L_83.mif" "${leftpath}L_85.mif" "${rightpath}R_212.mif" "${rightpath}R_214.mif" "${rightpath}R_213.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_DPG73-87-84-86-83-85_R_PCC212-214-213_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_DPG73-87-84-86-83-85_R_PCC212-214-213_combined.nii.gz ${SUBJ}_exclude_L_DPG73-87-84-86-83-85_R_PCC212-214-213_combined.mif -force
	
	#L_DPG73-87-84-86-83-85 and R_mPFC243
	#make array
	declare -a exclude_list=( "${leftpath}L_73.mif" "${leftpath}L_87.mif" "${leftpath}L_84.mif" "${leftpath}L_86.mif" "${leftpath}L_83.mif" "${leftpath}L_85.mif" "${rightpath}R_243.mif"  )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_DPG73-87-84-86-83-85_R_mPFC243_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_DPG73-87-84-86-83-85_R_mPFC243_combined.nii.gz ${SUBJ}_exclude_L_DPG73-87-84-86-83-85_R_mPFC243_combined.mif -force
	
	#L_DPG73-87-84-86-83-85 and R_MTL203
	#make array
	declare -a exclude_list=( "${leftpath}L_73.mif" "${leftpath}L_87.mif" "${leftpath}L_84.mif" "${leftpath}L_86.mif" "${leftpath}L_83.mif" "${leftpath}L_85.mif" "${rightpath}R_203.mif"  )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_DPG73-87-84-86-83-85_R_MTL203_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_DPG73-87-84-86-83-85_R_MTL203_combined.nii.gz ${SUBJ}_exclude_L_DPG73-87-84-86-83-85_R_MTL203_combined.mif -force
	
	#L_DPG73-87-84-86-83-85 and R_AG331-330-329-328-205-208-325-324 
	#make array
	declare -a exclude_list=( "${leftpath}L_73.mif" "${leftpath}L_87.mif" "${leftpath}L_84.mif" "${leftpath}L_86.mif" "${leftpath}L_83.mif" "${leftpath}L_85.mif" "${rightpath}R_331.mif" "${rightpath}R_330.mif" "${rightpath}R_329.mif" "${rightpath}R_328.mif" "${rightpath}R_205.mif" "${rightpath}R_208.mif" "${rightpath}R_325.mif" "${rightpath}R_324.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_DPG73-87-84-86-83-85_R_AG331-330-329-328-205-208-325-324_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_DPG73-87-84-86-83-85_R_AG331-330-329-328-205-208-325-324_combined.nii.gz ${SUBJ}_exclude_L_DPG73-87-84-86-83-85_R_AG331-330-329-328-205-208-325-324_combined.mif -force
	
	#L_DPG73-87-84-86-83-85 and R_DPG253-267-264-266-263-265
	#make array
	declare -a exclude_list=( "${leftpath}L_73.mif" "${leftpath}L_87.mif" "${leftpath}L_84.mif" "${leftpath}L_86.mif" "${leftpath}L_83.mif" "${leftpath}L_85.mif" "${rightpath}R_253.mif" "${rightpath}R_267.mif" "${rightpath}R_264.mif" "${rightpath}R_266.mif" "${rightpath}R_263.mif" "${rightpath}R_265.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_DPG73-87-84-86-83-85_R_DPG253-267-264-266-263-265_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_DPG73-87-84-86-83-85_R_DPG253-267-264-266-263-265_combined.nii.gz ${SUBJ}_exclude_L_DPG73-87-84-86-83-85_R_DPG253-267-264-266-263-265_combined.mif -force
	
	#L_DPG73-87-84-86-83-85 and R_ACC359
	#make array
	declare -a exclude_list=( "${leftpath}L_73.mif" "${leftpath}L_87.mif" "${leftpath}L_84.mif" "${leftpath}L_86.mif" "${leftpath}L_83.mif" "${leftpath}L_85.mif" "${rightpath}R_359.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_DPG73-87-84-86-83-85_R_ACC359_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_DPG73-87-84-86-83-85_R_ACC359_combined.nii.gz ${SUBJ}_exclude_L_DPG73-87-84-86-83-85_R_ACC359_combined.mif -force
	
	#L_DPG73-87-84-86-83-85 and R_PPC323-331-330-329-296-327-326-325-324
	#make array
	declare -a exclude_list=( "${leftpath}L_73.mif" "${leftpath}L_87.mif" "${leftpath}L_84.mif" "${leftpath}L_86.mif" "${leftpath}L_83.mif" "${leftpath}L_85.mif" "${rightpath}R_323.mif" "${rightpath}R_331.mif" "${rightpath}R_330.mif" "${rightpath}R_329.mif" "${rightpath}R_296.mif" "${rightpath}R_327.mif" "${rightpath}R_326.mif" "${rightpath}R_325.mif" "${rightpath}R_324.mif")
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_DPG73-87-84-86-83-85_R_PPC323-331-330-329-296-327-326-325-324_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_DPG73-87-84-86-83-85_R_PPC323-331-330-329-296-327-326-325-324_combined.nii.gz ${SUBJ}_exclude_L_DPG73-87-84-86-83-85_R_PPC323-331-330-329-296-327-326-325-324_combined.mif -force
	
	#L_ACC180 and R_PCC212-214-213
	#make array
	declare -a exclude_list=( "${leftpath}L_180.mif" "${rightpath}R_212.mif" "${rightpath}R_214.mif" "${rightpath}R_213.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_ACC180_R_PCC212-214-213_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_ACC180_R_PCC212-214-213_combined.nii.gz ${SUBJ}_exclude_L_ACC180_R_PCC212-214-213_combined.mif -force
	 
	#L_ACC180 and R_mPFC243
	#make array
	declare -a exclude_list=( "${leftpath}L_180.mif" "${rightpath}R_243.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_ACC180_R_mPFC243_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_ACC180_R_mPFC243_combined.nii.gz ${SUBJ}_exclude_L_ACC180_R_mPFC243_combined.mif -force
	
	#L_ACC180 and R_MTL203
	#make array
	declare -a exclude_list=( "${leftpath}L_180.mif" "${rightpath}R_203.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_ACC180_R_MTL203_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_ACC180_R_MTL203_combined.nii.gz ${SUBJ}_exclude_L_ACC180_R_MTL203_combined.mif -force
	
	#L_ACC180 and R_AG331-330-329-328-205-208-325-324 
	#make array
	declare -a exclude_list=( "${leftpath}L_180.mif" "${rightpath}R_331.mif" "${rightpath}R_330.mif" "${rightpath}R_329.mif" "${rightpath}R_328.mif" "${rightpath}R_205.mif" "${rightpath}R_208.mif" "${rightpath}R_325.mif" "${rightpath}R_324.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_ACC180_R_AG331-330-329-328-205-208-325-324_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_ACC180_R_AG331-330-329-328-205-208-325-324_combined.nii.gz ${SUBJ}_exclude_L_ACC180_R_AG331-330-329-328-205-208-325-324_combined.mif -force
	
	#L_ACC180 and R_DPG253-267-264-266-263-265
	#make array
	declare -a exclude_list=( "${leftpath}L_180.mif" "${rightpath}R_253.mif" "${rightpath}R_267.mif" "${rightpath}R_264.mif" "${rightpath}R_266.mif" "${rightpath}R_263.mif" "${rightpath}R_265.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_ACC180_R_DPG253-267-264-266-263-265_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_ACC180_R_DPG253-267-264-266-263-265_combined.nii.gz ${SUBJ}_exclude_L_ACC180_R_DPG253-267-264-266-263-265_combined.mif -force
	
	#L_ACC180 and R_ACC359
	#make array
	declare -a exclude_list=( "${leftpath}L_180.mif" "${rightpath}R_359.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_ACC180_R_ACC359_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_ACC180_R_ACC359_combined.nii.gz ${SUBJ}_exclude_L_ACC180_R_ACC359_combined.mif -force
	
	#L_ACC180 and R_PPC323-331-330-329-296-327-326-325-324
	#make array
	declare -a exclude_list=( "${leftpath}L_180.mif" "${rightpath}R_323.mif" "${rightpath}R_331.mif" "${rightpath}R_330.mif" "${rightpath}R_329.mif" "${rightpath}R_296.mif" "${rightpath}R_327.mif" "${rightpath}R_326.mif" "${rightpath}R_325.mif" "${rightpath}R_324.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_ACC180_R_PPC323-331-330-329-296-327-326-325-324_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_ACC180_R_PPC323-331-330-329-296-327-326-325-324_combined.nii.gz ${SUBJ}_exclude_L_ACC180_R_PPC323-331-330-329-296-327-326-325-324_combined.mif -force
	
	#L_PPC143-151-150-149-116-147-146-145-144 and R_PCC212-214-213
	#make array
	declare -a exclude_list=( "${leftpath}L_143.mif" "${leftpath}L_151.mif" "${leftpath}L_150.mif" "${leftpath}L_149.mif" "${leftpath}L_116.mif" "${leftpath}L_147.mif" "${leftpath}L_146.mif" "${leftpath}L_145.mif" "${leftpath}L_144.mif" "${rightpath}R_212.mif" "${rightpath}R_214.mif" "${rightpath}R_213.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_PPC143-151-150-149-116-147-146-145-144_R_PCC212-214-213_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_PPC143-151-150-149-116-147-146-145-144_R_PCC212-214-213_combined.nii.gz ${SUBJ}_exclude_L_PPC143-151-150-149-116-147-146-145-144_R_PCC212-214-213_combined.mif -force
	
	#L_PPC143-151-150-149-116-147-146-145-144 and R_mPFC243
	#make array
	declare -a exclude_list=( "${leftpath}L_143.mif" "${leftpath}L_151.mif" "${leftpath}L_150.mif" "${leftpath}L_149.mif" "${leftpath}L_116.mif" "${leftpath}L_147.mif" "${leftpath}L_146.mif" "${leftpath}L_145.mif" "${leftpath}L_144.mif" "${rightpath}R_243.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_PPC143-151-150-149-116-147-146-145-144_R_mPFC243_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_PPC143-151-150-149-116-147-146-145-144_R_mPFC243_combined.nii.gz ${SUBJ}_exclude_L_PPC143-151-150-149-116-147-146-145-144_R_mPFC243_combined.mif -force
	
	#L_PPC143-151-150-149-116-147-146-145-144 and R_MTL203
	#make array
	declare -a exclude_list=( "${leftpath}L_143.mif" "${leftpath}L_151.mif" "${leftpath}L_150.mif" "${leftpath}L_149.mif" "${leftpath}L_116.mif" "${leftpath}L_147.mif" "${leftpath}L_146.mif" "${leftpath}L_145.mif" "${leftpath}L_144.mif" "${rightpath}R_203.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_PPC143-151-150-149-116-147-146-145-144_R_MTL203_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_PPC143-151-150-149-116-147-146-145-144_R_MTL203_combined.nii.gz ${SUBJ}_exclude_L_PPC143-151-150-149-116-147-146-145-144_R_MTL203_combined.mif -force
	
	#L_PPC143-151-150-149-116-147-146-145-144 and R_AG331-330-329-328-205-208-325-324 
	#make array
	declare -a exclude_list=( "${leftpath}L_143.mif" "${leftpath}L_151.mif" "${leftpath}L_150.mif" "${leftpath}L_149.mif" "${leftpath}L_116.mif" "${leftpath}L_147.mif" "${leftpath}L_146.mif" "${leftpath}L_145.mif" "${leftpath}L_144.mif" "${rightpath}R_331.mif" "${rightpath}R_330.mif" "${rightpath}R_329.mif" "${rightpath}R_328.mif" "${rightpath}R_205.mif" "${rightpath}R_208.mif" "${rightpath}R_325.mif" "${rightpath}R_324.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_PPC143-151-150-149-116-147-146-145-144_R_AG331-330-329-328-205-208-325-324_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_PPC143-151-150-149-116-147-146-145-144_R_AG331-330-329-328-205-208-325-324_combined.nii.gz ${SUBJ}_exclude_L_PPC143-151-150-149-116-147-146-145-144_R_AG331-330-329-328-205-208-325-324_combined.mif -force
	
	#L_PPC143-151-150-149-116-147-146-145-144 and R_DPG253-267-264-266-263-265
	#make array
	declare -a exclude_list=( "${leftpath}L_143.mif" "${leftpath}L_151.mif" "${leftpath}L_150.mif" "${leftpath}L_149.mif" "${leftpath}L_116.mif" "${leftpath}L_147.mif" "${leftpath}L_146.mif" "${leftpath}L_145.mif" "${leftpath}L_144.mif" "${rightpath}R_253.mif" "${rightpath}R_267.mif" "${rightpath}R_264.mif" "${rightpath}R_266.mif" "${rightpath}R_263.mif" "${rightpath}R_265.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_PPC143-151-150-149-116-147-146-145-144_R_DPG253-267-264-266-263-265_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_PPC143-151-150-149-116-147-146-145-144_R_DPG253-267-264-266-263-265_combined.nii.gz ${SUBJ}_exclude_L_PPC143-151-150-149-116-147-146-145-144_R_DPG253-267-264-266-263-265_combined.mif -force
	
	#L_PPC143-151-150-149-116-147-146-145-144 and R_ACC359
	#make array
	declare -a exclude_list=( "${leftpath}L_143.mif" "${leftpath}L_151.mif" "${leftpath}L_150.mif" "${leftpath}L_149.mif" "${leftpath}L_116.mif" "${leftpath}L_147.mif" "${leftpath}L_146.mif" "${leftpath}L_145.mif" "${leftpath}L_144.mif" "${rightpath}R_359.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_PPC143-151-150-149-116-147-146-145-144_R_ACC359_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_PPC143-151-150-149-116-147-146-145-144_R_ACC359_combined.nii.gz ${SUBJ}_exclude_L_PPC143-151-150-149-116-147-146-145-144_R_ACC359_combined.mif -force
	
	#L_PPC143-151-150-149-116-147-146-145-144 and R_PPC323-331-330-329-296-327-326-325-324
	#make array
	declare -a exclude_list=( "${leftpath}L_143.mif" "${leftpath}L_151.mif" "${leftpath}L_150.mif" "${leftpath}L_149.mif" "${leftpath}L_116.mif" "${leftpath}L_147.mif" "${leftpath}L_146.mif" "${leftpath}L_145.mif" "${leftpath}L_144.mif" "${rightpath}R_323.mif" "${rightpath}R_331.mif" "${rightpath}R_330.mif" "${rightpath}R_329.mif" "${rightpath}R_296.mif" "${rightpath}R_327.mif" "${rightpath}R_326.mif" "${rightpath}R_325.mif" "${rightpath}R_324.mif" )
	mrmath ${exclude_list[*]} max exclude_list.mif -force
	mrconvert exclude_list.mif exclude_list.nii.gz -force
	#make mask 
	fslmaths /home/ttang/DTIs-analysis/${SUBJ}/${SUBJ}_exclusion_masks/${SUBJ}_exclude_whole_brain.nii.gz -sub exclude_list.nii.gz ${SUBJ}_exclude_L_PPC143-151-150-149-116-147-146-145-144_R_PPC323-331-330-329-296-327-326-325-324_combined.nii.gz
	mrconvert ${SUBJ}_exclude_L_PPC143-151-150-149-116-147-146-145-144_R_PPC323-331-330-329-296-327-326-325-324_combined.nii.gz ${SUBJ}_exclude_L_PPC143-151-150-149-116-147-146-145-144_R_PPC323-331-330-329-296-327-326-325-324_combined.mif -force
	
	cd ..

	#MAKE BRAINSTEM AND CEREBELLUM EXCLUSION MASK

	#Obtain, threshold, and combine cerebellum and brainstem masks from two different atlases (Cerebellum and HarvardOxford Subcortical in MNI152)
	#Note that the below atlases are incorrect, I had to use FSLeyes to manually export the cerebellum and brainstem masks. Still looking into why this is. This required manually copying the cerebellum and brainstem mask into each subject directory.
	#fslmaths $FSL_DIR/data/atlases/Cerebellum/Cerebellum-MNIfnirt-prob-1mm.nii.gz -thr 0.9 -bin cerebellum_mask_thresholded.nii.gz
	#fslmaths $FSL_DIR/data/atlases/HarvardOxford/HarvardOxford-sub-maxprob-thr0-1mm.nii.gz -thr 10 -bin brainstem_mask_thresholded.nii.gz
	#fslmaths cerebellum_mask_thresholded.nii.gz -max brainstem_mask_thresholded.nii.gz cerebellum_brainstem_mask.nii.gz

	#Register mask from standard space to diffusion space
	flirt -in /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_mean_b0_processed.nii.gz -ref /usr/local/fsl/data/standard/FMRIB58_FA_1mm.nii.gz -dof 6 -omat ${SUBJ}_diff2standardFMRIB58_fsl.mat
	transformconvert ${SUBJ}_diff2standardFMRIB58_fsl.mat /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_mean_b0_processed.nii.gz /usr/local/fsl/data/standard/FMRIB58_FA_1mm.nii.gz flirt_import ${SUBJ}_diff2standardFMRIB58_mrtrix.txt
	mrconvert cerebellum_brainstem_mask.nii.gz cerebellum_brainstem_mask.mif
	mrtransform cerebellum_brainstem_mask.mif -linear ${SUBJ}_diff2standardFMRIB58_mrtrix.txt -inverse ${SUBJ}_cerebellum_brainstem_mask_coreg.mif 

	#check mask
	#mrview mean_b0_preprocessed.mif -overlay.load cerebellum_brainstem_mask_coreg.mif

	#MAKE CORPUS CALLOSUM EXCLUSION MASK

	#Note that corpus_callosum_mask.nii.gz is already in subject folder (I obtained it from fsleyes manually by combining genu, body, splenium from JHU white matter atlas, thresholded to 1 and binarized). This required manually copying the corpus callosum mask into each subject directory.
	mrconvert corpus_callosum_mask.nii.gz corpus_callosum_mask.mif
	mrtransform corpus_callosum_mask.mif -linear ${SUBJ}_diff2standardFMRIB58_mrtrix.txt -inverse ${SUBJ}_corpus_callosum_mask_coreg.mif

	#OBTAIN TRACKS CONNECTED TO MASKS (~3 minutes per subject)

	mkdir ${SUBJ}_tracts

	#Within networks

	#left
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_L_PCC32-34-33.tck -include ${SUBJ}_masks/${SUBJ}_L_PCC32-34-33.mif
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_L_mPFC63.tck -include ${SUBJ}_masks/${SUBJ}_L_mPFC63.mif
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_L_MTL23.tck -include ${SUBJ}_masks/${SUBJ}_L_MTL23.mif
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_L_AG151-150-149-148-25-28-145-144.tck -include ${SUBJ}_masks/${SUBJ}_L_AG151-150-149-148-25-28-145-144.mif
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_L_DPG73-87-84-86-83-85.tck -include ${SUBJ}_masks/${SUBJ}_L_DPG73-87-84-86-83-85.mif
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_L_ACC180.tck -include ${SUBJ}_masks/${SUBJ}_L_ACC180.mif
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_L_PPC143-151-150-149-116-147-146-145-144.tck -include ${SUBJ}_masks/${SUBJ}_L_PPC143-151-150-149-116-147-146-145-144.mif

	#right
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_R_PCC212-214-213.tck -include ${SUBJ}_masks/${SUBJ}_R_PCC212-214-213.mif
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_R_mPFC243.tck -include ${SUBJ}_masks/${SUBJ}_R_mPFC243.mif
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_R_MTL203.tck -include ${SUBJ}_masks/${SUBJ}_R_MTL203.mif
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_R_AG331-330-329-328-205-208-325-324.tck -include ${SUBJ}_masks/${SUBJ}_R_AG331-330-329-328-205-208-325-324.mif
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_R_DPG253-267-264-266-263-265.tck -include ${SUBJ}_masks/${SUBJ}_R_DPG253-267-264-266-263-265.mif
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_R_ACC359.tck -include ${SUBJ}_masks/${SUBJ}_R_ACC359.mif
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_R_PPC323-331-330-329-296-327-326-325-324.tck -include ${SUBJ}_masks/${SUBJ}_R_PPC323-331-330-329-296-327-326-325-324.mif

	#Between networks - Use a nested for loop when I optimize this script.

	#left
	#L_PCC32-34-33 and L_mPFC63
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_L_PCC32-34-33_mPFC63_combined.tck -include ${SUBJ}_masks/${SUBJ}_L_PCC32-34-33_mPFC63_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_L_PCC32-34-33_mPFC63_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#L_PCC32-34-33 and L_MTL23
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_L_PCC32-34-33_MTL23_combined.tck -include ${SUBJ}_masks/${SUBJ}_L_PCC32-34-33_MTL23_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_L_PCC32-34-33_MTL23_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#L_PCC32-34-33 and L_AG151-150-149-148-25-28-145-144
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_L_PCC32-34-33_AG151-150-149-148-25-28-145-144_combined.tck -include ${SUBJ}_masks/${SUBJ}_L_PCC32-34-33_AG151-150-149-148-25-28-145-144_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_L_PCC32-34-33_AG151-150-149-148-25-28-145-144_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#L_PCC32-34-33 and L_DPG73-87-84-86-83-85
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_L_PCC32-34-33_DPG73-87-84-86-83-85_combined.tck -include ${SUBJ}_masks/${SUBJ}_L_PCC32-34-33_DPG73-87-84-86-83-85_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_L_PCC32-34-33_DPG73-87-84-86-83-85_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#L_PCC32-34-33 and L_ACC180
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_L_PCC32-34-33_ACC180_combined.tck -include ${SUBJ}_masks/${SUBJ}_L_PCC32-34-33_ACC180_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_L_PCC32-34-33_ACC180_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#L_PCC32-34-33 and L_PPC143-151-150-149-116-147-146-145-144
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_L_PCC32-34-33_PPC143-151-150-149-116-147-146-145-144_combined.tck -include ${SUBJ}_masks/${SUBJ}_L_PCC32-34-33_PPC143-151-150-149-116-147-146-145-144_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_L_PCC32-34-33_PPC143-151-150-149-116-147-146-145-144_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#L_mPFC63 and L_MTL23
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_L_mPFC63_MTL23_combined.tck -include ${SUBJ}_masks/${SUBJ}_L_mPFC63_MTL23_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_L_mPFC63_MTL23_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#L_mPFC63 and L_AG151-150-149-148-25-28-145-144 
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_L_mPFC63_AG151-150-149-148-25-28-145-144_combined.tck -include ${SUBJ}_masks/${SUBJ}_L_mPFC63_AG151-150-149-148-25-28-145-144_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_L_mPFC63_AG151-150-149-148-25-28-145-144_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#L_mPFC63 and L_DPG73-87-84-86-83-85
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_L_mPFC63_DPG73-87-84-86-83-85_combined.tck -include ${SUBJ}_masks/${SUBJ}_L_mPFC63_DPG73-87-84-86-83-85_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_L_mPFC63_DPG73-87-84-86-83-85_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#L_mPFC63 and L_ACC180
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_L_mPFC63_ACC180_combined.tck -include ${SUBJ}_masks/${SUBJ}_L_mPFC63_ACC180_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_L_mPFC63_ACC180_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#L_mPFC63 and L_PPC143-151-150-149-116-147-146-145-144
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_L_mPFC63_PPC143-151-150-149-116-147-146-145-144_combined.tck -include ${SUBJ}_masks/${SUBJ}_L_mPFC63_PPC143-151-150-149-116-147-146-145-144_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_L_mPFC63_PPC143-151-150-149-116-147-146-145-144_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#L_MTL23 and L_AG151-150-149-148-25-28-145-144 
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_L_MTL23_AG151-150-149-148-25-28-145-144_combined.tck -include ${SUBJ}_masks/${SUBJ}_L_MTL23_AG151-150-149-148-25-28-145-144_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_L_MTL23_AG151-150-149-148-25-28-145-144_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#L_MTL23 and L_DPG73-87-84-86-83-85
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_L_MTL23_DPG73-87-84-86-83-85_combined.tck -include ${SUBJ}_masks/${SUBJ}_L_MTL23_DPG73-87-84-86-83-85_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_L_MTL23_DPG73-87-84-86-83-85_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#L_MTL23 and L_ACC180
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_L_MTL23_ACC180_combined.tck -include ${SUBJ}_masks/${SUBJ}_L_MTL23_ACC180_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_L_MTL23_ACC180_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#L_MTL23 and L_PPC143-151-150-149-116-147-146-145-144
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_L_MTL23_PPC143-151-150-149-116-147-146-145-144_combined.tck -include ${SUBJ}_masks/${SUBJ}_L_MTL23_PPC143-151-150-149-116-147-146-145-144_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_L_MTL23_PPC143-151-150-149-116-147-146-145-144_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#L_AG151-150-149-148-25-28-145-144 and L_DPG73-87-84-86-83-85
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_L_AG151-150-149-148-25-28-145-144_DPG73-87-84-86-83-85_combined.tck -include ${SUBJ}_masks/${SUBJ}_L_AG151-150-149-148-25-28-145-144_DPG73-87-84-86-83-85_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_L_AG151-150-149-148-25-28-145-144_DPG73-87-84-86-83-85_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#L_AG151-150-149-148-25-28-145-144 and L_ACC180
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_L_AG151-150-149-148-25-28-145-144_ACC180_combined.tck -include ${SUBJ}_masks/${SUBJ}_L_AG151-150-149-148-25-28-145-144_ACC180_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_L_AG151-150-149-148-25-28-145-144_ACC180_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#L_AG151-150-149-148-25-28-145-144 and L_PPC143-151-150-149-116-147-146-145-144
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_L_AG151-150-149-148-25-28-145-144_PPC143-151-150-149-116-147-146-145-144_combined.tck -include ${SUBJ}_masks/${SUBJ}_L_AG151-150-149-148-25-28-145-144_PPC143-151-150-149-116-147-146-145-144_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_L_AG151-150-149-148-25-28-145-144_PPC143-151-150-149-116-147-146-145-144_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#L_DPG73-87-84-86-83-85 and L_ACC180
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_L_DPG73-87-84-86-83-85_ACC180_combined.tck -include ${SUBJ}_masks/${SUBJ}_L_DPG73-87-84-86-83-85_ACC180_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_L_DPG73-87-84-86-83-85_ACC180_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#L_DPG73-87-84-86-83-85 and L_PPC143-151-150-149-116-147-146-145-144
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_L_DPG73-87-84-86-83-85_PPC143-151-150-149-116-147-146-145-144_combined.tck -include ${SUBJ}_masks/${SUBJ}_L_DPG73-87-84-86-83-85_PPC143-151-150-149-116-147-146-145-144_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_L_DPG73-87-84-86-83-85_PPC143-151-150-149-116-147-146-145-144_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#L_ACC180 and L_PPC143-151-150-149-116-147-146-145-144
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_L_ACC180_PPC143-151-150-149-116-147-146-145-144_combined.tck -include ${SUBJ}_masks/${SUBJ}_L_ACC180_PPC143-151-150-149-116-147-146-145-144_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_L_ACC180_PPC143-151-150-149-116-147-146-145-144_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#right
	#R_PCC212-214-213 and R_mPFC243
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_R_PCC212-214-213_mPFC243_combined.tck -include ${SUBJ}_masks/${SUBJ}_R_PCC212-214-213_mPFC243_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_R_PCC212-214-213_mPFC243_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#R_PCC212-214-213 and R_MTL203
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_R_PCC212-214-213_MTL203_combined.tck -include ${SUBJ}_masks/${SUBJ}_R_PCC212-214-213_MTL203_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_R_PCC212-214-213_MTL203_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#R_PCC212-214-213 and R_AG331-330-329-328-205-208-325-324
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_R_PCC212-214-213_AG331-330-329-328-205-208-325-324_combined.tck -include ${SUBJ}_masks/${SUBJ}_R_PCC212-214-213_AG331-330-329-328-205-208-325-324_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_R_PCC212-214-213_AG331-330-329-328-205-208-325-324_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#R_PCC212-214-213 and R_DPG253-267-264-266-263-265
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_R_PCC212-214-213_DPG253-267-264-266-263-265_combined.tck -include ${SUBJ}_masks/${SUBJ}_R_PCC212-214-213_DPG253-267-264-266-263-265_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_R_PCC212-214-213_DPG253-267-264-266-263-265_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#R_PCC212-214-213 and R_ACC359
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_R_PCC212-214-213_ACC359_combined.tck -include ${SUBJ}_masks/${SUBJ}_R_PCC212-214-213_ACC359_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_R_PCC212-214-213_ACC359_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#R_PCC212-214-213 and R_PPC323-331-330-329-296-327-326-325-324
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_R_PCC212-214-213_PPC323-331-330-329-296-327-326-325-324_combined.tck -include ${SUBJ}_masks/${SUBJ}_R_PCC212-214-213_PPC323-331-330-329-296-327-326-325-324_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_R_PCC212-214-213_PPC323-331-330-329-296-327-326-325-324_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#R_mPFC243 and R_MTL203
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_R_mPFC243_MTL203_combined.tck -include ${SUBJ}_masks/${SUBJ}_R_mPFC243_MTL203_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_R_mPFC243_MTL203_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#R_mPFC243 and R_AG331-330-329-328-205-208-325-324 
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_R_mPFC243_AG331-330-329-328-205-208-325-324_combined.tck -include ${SUBJ}_masks/${SUBJ}_R_mPFC243_AG331-330-329-328-205-208-325-324_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_R_mPFC243_AG331-330-329-328-205-208-325-324_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#R_mPFC243 and R_DPG253-267-264-266-263-265
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_R_mPFC243_DPG253-267-264-266-263-265_combined.tck -include ${SUBJ}_masks/${SUBJ}_R_mPFC243_DPG253-267-264-266-263-265_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_R_mPFC243_DPG253-267-264-266-263-265_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#R_mPFC243 and R_ACC359
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_R_mPFC243_ACC359_combined.tck -include ${SUBJ}_masks/${SUBJ}_R_mPFC243_ACC359_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_R_mPFC243_ACC359_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#R_mPFC243 and R_PPC323-331-330-329-296-327-326-325-324
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_R_mPFC243_PPC323-331-330-329-296-327-326-325-324_combined.tck -include ${SUBJ}_masks/${SUBJ}_R_mPFC243_PPC323-331-330-329-296-327-326-325-324_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_R_mPFC243_PPC323-331-330-329-296-327-326-325-324_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#R_MTL203 and R_AG331-330-329-328-205-208-325-324 
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_R_MTL203_AG331-330-329-328-205-208-325-324_combined.tck -include ${SUBJ}_masks/${SUBJ}_R_MTL203_AG331-330-329-328-205-208-325-324_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_R_MTL203_AG331-330-329-328-205-208-325-324_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#R_MTL203 and R_DPG253-267-264-266-263-265
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_R_MTL203_DPG253-267-264-266-263-265_combined.tck -include ${SUBJ}_masks/${SUBJ}_R_MTL203_DPG253-267-264-266-263-265_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_R_MTL203_DPG253-267-264-266-263-265_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#R_MTL203 and R_ACC359
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_R_MTL203_ACC359_combined.tck -include ${SUBJ}_masks/${SUBJ}_R_MTL203_ACC359_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_R_MTL203_ACC359_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#R_MTL203 and R_PPC323-331-330-329-296-327-326-325-324
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_R_MTL203_PPC323-331-330-329-296-327-326-325-324_combined.tck -include ${SUBJ}_masks/${SUBJ}_R_MTL203_PPC323-331-330-329-296-327-326-325-324_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_R_MTL203_PPC323-331-330-329-296-327-326-325-324_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#R_AG331-330-329-328-205-208-325-324 and R_DPG253-267-264-266-263-265
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_R_AG331-330-329-328-205-208-325-324_DPG253-267-264-266-263-265_combined.tck -include ${SUBJ}_masks/${SUBJ}_R_AG331-330-329-328-205-208-325-324_DPG253-267-264-266-263-265_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_R_AG331-330-329-328-205-208-325-324_DPG253-267-264-266-263-265_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#R_AG331-330-329-328-205-208-325-324 and R_ACC359
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_R_AG331-330-329-328-205-208-325-324_ACC359_combined.tck -include ${SUBJ}_masks/${SUBJ}_R_AG331-330-329-328-205-208-325-324_ACC359_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_R_AG331-330-329-328-205-208-325-324_ACC359_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#R_AG331-330-329-328-205-208-325-324 and R_PPC323-331-330-329-296-327-326-325-324
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_R_AG331-330-329-328-205-208-325-324_PPC323-331-330-329-296-327-326-325-324_combined.tck -include ${SUBJ}_masks/${SUBJ}_R_AG331-330-329-328-205-208-325-324_PPC323-331-330-329-296-327-326-325-324_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_R_AG331-330-329-328-205-208-325-324_PPC323-331-330-329-296-327-326-325-324_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#R_DPG253-267-264-266-263-265 and R_ACC359
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_R_DPG253-267-264-266-263-265_ACC359_combined.tck -include ${SUBJ}_masks/${SUBJ}_R_DPG253-267-264-266-263-265_ACC359_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_R_DPG253-267-264-266-263-265_ACC359_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#R_DPG253-267-264-266-263-265 and R_PPC323-331-330-329-296-327-326-325-324
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_R_DPG253-267-264-266-263-265_PPC323-331-330-329-296-327-326-325-324_combined.tck -include ${SUBJ}_masks/${SUBJ}_R_DPG253-267-264-266-263-265_PPC323-331-330-329-296-327-326-325-324_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_R_DPG253-267-264-266-263-265_PPC323-331-330-329-296-327-326-325-324_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#R_ACC359 and R_PPC323-331-330-329-296-327-326-325-324
	tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_R_ACC359_PPC323-331-330-329-296-327-326-325-324_combined.tck -include ${SUBJ}_masks/${SUBJ}_R_ACC359_PPC323-331-330-329-296-327-326-325-324_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_R_ACC359_PPC323-331-330-329-296-327-326-325-324_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif -exclude ${SUBJ}_corpus_callosum_mask_coreg.mif

	#Networks between both hemispheres
	#Use a for loop iterating through left ROIs and right ROIs to reduce code length
	
	for roi1 in L_PCC32-34-33 L_mPFC63 L_MTL23 L_AG151-150-149-148-25-28-145-144 L_DPG73-87-84-86-83-85 L_ACC180 L_PPC143-151-150-149-116-147-146-145-144
	do
		for roi2 in R_PCC212-214-213 R_mPFC243 R_MTL203 R_AG331-330-329-328-205-208-325-324 R_DPG253-267-264-266-263-265 R_ACC359 R_PPC323-331-330-329-296-327-326-325-324
		do
			tckedit /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_sift_1M.tck ${SUBJ}_tracts/${SUBJ}_${roi1}_${roi2}_combined.tck -include ${SUBJ}_masks/${SUBJ}_${roi1}_${roi2}_combined.mif -exclude ${SUBJ}_exclusion_masks/${SUBJ}_exclude_${roi1}_${roi2}_combined.mif -exclude ${SUBJ}_cerebellum_brainstem_mask_coreg.mif
	
		done
	done

	########################### STEP 7 ####################################
	#                  Tract Metrics: FA, MD, RD, AD                      #
	#######################################################################

	#OBTAIN DTI METRIC MAPS
	dwi2tensor /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_dwi_den_preproc_unbiased.mif -mask /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_mask.mif - | tensor2metric - -fa ${SUBJ}_fa.mif 
	dwi2tensor /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_dwi_den_preproc_unbiased.mif -mask /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_mask.mif - | tensor2metric - -adc ${SUBJ}_md.mif 
	dwi2tensor /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_dwi_den_preproc_unbiased.mif -mask /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_mask.mif - | tensor2metric - -rd ${SUBJ}_rd.mif 
	dwi2tensor /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_dwi_den_preproc_unbiased.mif -mask /home/ttang/myDTIs-processed_new/${SUBJ}/${SUBJ}_mask.mif - | tensor2metric - -ad ${SUBJ}_ad.mif

	#GENERATING DTI METRICS

	mkdir ${SUBJ}_stats

	#get average dti metric per streamline within networks
	for tck in L_PCC32-34-33 L_mPFC63 L_MTL23 L_AG151-150-149-148-25-28-145-144 L_DPG73-87-84-86-83-85 L_ACC180 L_PPC143-151-150-149-116-147-146-145-144 R_PCC212-214-213 R_mPFC243 R_MTL203 R_AG331-330-329-328-205-208-325-324 R_DPG253-267-264-266-263-265 R_ACC359 R_PPC323-331-330-329-296-327-326-325-324
	do
		tcksample ${SUBJ}_tracts/${SUBJ}_${tck}.tck ${SUBJ}_fa.mif ${SUBJ}_stats/${SUBJ}_${tck}_tck_fa.csv -stat_tck mean
		tcksample ${SUBJ}_tracts/${SUBJ}_${tck}.tck ${SUBJ}_md.mif ${SUBJ}_stats/${SUBJ}_${tck}_tck_md.csv -stat_tck mean
		tcksample ${SUBJ}_tracts/${SUBJ}_${tck}.tck ${SUBJ}_rd.mif ${SUBJ}_stats/${SUBJ}_${tck}_tck_rd.csv -stat_tck mean
		tcksample ${SUBJ}_tracts/${SUBJ}_${tck}.tck ${SUBJ}_ad.mif ${SUBJ}_stats/${SUBJ}_${tck}_tck_ad.csv -stat_tck mean
	done

#R_AG331-330-329-328-205-208-325-324 and R_ACC359

	#get average dti metric per streamline between networks
	for tck in L_PCC32-34-33_mPFC63_combined L_PCC32-34-33_MTL23_combined L_PCC32-34-33_AG151-150-149-148-25-28-145-144_combined L_PCC32-34-33_DPG73-87-84-86-83-85_combined L_PCC32-34-33_ACC180_combined L_PCC32-34-33_PPC143-151-150-149-116-147-146-145-144_combined L_mPFC63_MTL23_combined L_mPFC63_AG151-150-149-148-25-28-145-144_combined L_mPFC63_DPG73-87-84-86-83-85_combined L_mPFC63_ACC180_combined L_mPFC63_PPC143-151-150-149-116-147-146-145-144_combined L_MTL23_AG151-150-149-148-25-28-145-144_combined L_MTL23_DPG73-87-84-86-83-85_combined L_MTL23_ACC180_combined L_MTL23_PPC143-151-150-149-116-147-146-145-144_combined L_AG151-150-149-148-25-28-145-144_DPG73-87-84-86-83-85_combined L_AG151-150-149-148-25-28-145-144_ACC180_combined L_AG151-150-149-148-25-28-145-144_PPC143-151-150-149-116-147-146-145-144_combined L_DPG73-87-84-86-83-85_ACC180_combined L_DPG73-87-84-86-83-85_PPC143-151-150-149-116-147-146-145-144_combined L_ACC180_PPC143-151-150-149-116-147-146-145-144_combined R_PCC212-214-213_mPFC243_combined R_PCC212-214-213_MTL203_combined R_PCC212-214-213_AG331-330-329-328-205-208-325-324_combined R_PCC212-214-213_DPG253-267-264-266-263-265_combined R_PCC212-214-213_ACC359_combined R_PCC212-214-213_PPC323-331-330-329-296-327-326-325-324_combined R_mPFC243_MTL203_combined R_mPFC243_AG331-330-329-328-205-208-325-324_combined R_mPFC243_DPG253-267-264-266-263-265_combined R_mPFC243_ACC359_combined R_mPFC243_PPC323-331-330-329-296-327-326-325-324_combined R_MTL203_AG331-330-329-328-205-208-325-324_combined R_MTL203_DPG253-267-264-266-263-265_combined R_MTL203_ACC359_combined R_MTL203_PPC323-331-330-329-296-327-326-325-324_combined R_AG331-330-329-328-205-208-325-324_DPG253-267-264-266-263-265_combined R_AG331-330-329-328-205-208-325-324_ACC359_combined R_AG331-330-329-328-205-208-325-324_PPC323-331-330-329-296-327-326-325-324_combined R_DPG253-267-264-266-263-265_ACC359_combined R_DPG253-267-264-266-263-265_PPC323-331-330-329-296-327-326-325-324_combined R_ACC359_PPC323-331-330-329-296-327-326-325-324_combined L_PCC32-34-33_R_PCC212-214-213_combined L_PCC32-34-33_R_mPFC243_combined L_PCC32-34-33_R_MTL203_combined L_PCC32-34-33_R_AG331-330-329-328-205-208-325-324_combined L_PCC32-34-33_R_DPG253-267-264-266-263-265_combined L_PCC32-34-33_R_ACC359_combined L_PCC32-34-33_R_PPC323-331-330-329-296-327-326-325-324_combined L_mPFC63_R_PCC212-214-213_combined L_mPFC63_R_mPFC243_combined L_mPFC63_R_MTL203_combined L_mPFC63_R_AG331-330-329-328-205-208-325-324_combined L_mPFC63_R_DPG253-267-264-266-263-265_combined L_mPFC63_R_ACC359_combined L_mPFC63_R_PPC323-331-330-329-296-327-326-325-324_combined L_MTL23_R_PCC212-214-213_combined L_MTL23_R_mPFC243_combined L_MTL23_R_MTL203_combined L_MTL23_R_AG331-330-329-328-205-208-325-324_combined L_MTL23_R_DPG253-267-264-266-263-265_combined L_MTL23_R_ACC359_combined L_MTL23_R_PPC323-331-330-329-296-327-326-325-324_combined L_AG151-150-149-148-25-28-145-144_R_PCC212-214-213_combined L_AG151-150-149-148-25-28-145-144_R_mPFC243_combined L_AG151-150-149-148-25-28-145-144_R_MTL203_combined L_AG151-150-149-148-25-28-145-144_R_AG331-330-329-328-205-208-325-324_combined L_AG151-150-149-148-25-28-145-144_R_DPG253-267-264-266-263-265_combined L_AG151-150-149-148-25-28-145-144_R_ACC359_combined L_AG151-150-149-148-25-28-145-144_R_PPC323-331-330-329-296-327-326-325-324_combined L_DPG73-87-84-86-83-85_R_PCC212-214-213_combined L_DPG73-87-84-86-83-85_R_mPFC243_combined L_DPG73-87-84-86-83-85_R_MTL203_combined L_DPG73-87-84-86-83-85_R_AG331-330-329-328-205-208-325-324_combined L_DPG73-87-84-86-83-85_R_DPG253-267-264-266-263-265_combined L_DPG73-87-84-86-83-85_R_ACC359_combined L_DPG73-87-84-86-83-85_R_PPC323-331-330-329-296-327-326-325-324_combined L_ACC180_R_PCC212-214-213_combined L_ACC180_R_mPFC243_combined L_ACC180_R_MTL203_combined L_ACC180_R_AG331-330-329-328-205-208-325-324_combined L_ACC180_R_DPG253-267-264-266-263-265_combined L_ACC180_R_ACC359_combined L_ACC180_R_PPC323-331-330-329-296-327-326-325-324_combined L_PPC143-151-150-149-116-147-146-145-144_R_PCC212-214-213_combined L_PPC143-151-150-149-116-147-146-145-144_R_mPFC243_combined L_PPC143-151-150-149-116-147-146-145-144_R_MTL203_combined L_PPC143-151-150-149-116-147-146-145-144_R_AG331-330-329-328-205-208-325-324_combined L_PPC143-151-150-149-116-147-146-145-144_R_DPG253-267-264-266-263-265_combined L_PPC143-151-150-149-116-147-146-145-144_R_ACC359_combined L_PPC143-151-150-149-116-147-146-145-144_R_PPC323-331-330-329-296-327-326-325-324_combined
	do
		tcksample ${SUBJ}_tracts/${SUBJ}_${tck}.tck ${SUBJ}_fa.mif ${SUBJ}_stats/${SUBJ}_${tck}_tck_fa.csv -stat_tck mean
		tcksample ${SUBJ}_tracts/${SUBJ}_${tck}.tck ${SUBJ}_md.mif ${SUBJ}_stats/${SUBJ}_${tck}_tck_md.csv -stat_tck mean 
		tcksample ${SUBJ}_tracts/${SUBJ}_${tck}.tck ${SUBJ}_rd.mif ${SUBJ}_stats/${SUBJ}_${tck}_tck_rd.csv -stat_tck mean
		tcksample ${SUBJ}_tracts/${SUBJ}_${tck}.tck ${SUBJ}_ad.mif ${SUBJ}_stats/${SUBJ}_${tck}_tck_ad.csv -stat_tck mean
		
		#Generate number of streamlines per tract as an individual file
		
		#define variable as output of tckstats
		streamline_count=$(tckstats -output count ${SUBJ}_tracts/${SUBJ}_${tck}.tck)
		#Create file
		>${SUBJ}_stats/${SUBJ}_${tck}_streamlines.txt
		#Write to file
		echo $streamline_count > ${SUBJ}_stats/${SUBJ}_${tck}_streamlines.txt
	done

	#Run this python file to get mean of all mean DTI metric streamlines (one value!) 
	#Note: Python file also needs to be updated for every tract specific .csv file we generate.
	python3 /home/ttang/MRTrix_Connectome/mean_DTI_metric.py
	
	#Remove 3 folders that take up alot of space (~27gb per subject). No need to do this if there is more than 5tb of storage on disk, but is recommended because there is no need for these node files after stats are generated.
	rm ${SUBJ}_nodes -r
	rm ${SUBJ}_leftnodes -r
	rm ${SUBJ}_rightnodes -r

	cd ..

done