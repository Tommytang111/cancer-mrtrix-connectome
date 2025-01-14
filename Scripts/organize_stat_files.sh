#!/bin/bash

#Written by Zenan (Tommy) Tang
#Last Update: August 23rd, 2021
#Purpose: To organize stats files into their respective folders

#Running script for each subject in folder
for subject in ST*
do 
    SUBJ=$subject
	cd $subject
	echo $subject
	cd ${SUBJ}_stats
	
	mkdir LEFT RIGHT LEFT-RIGHT

	for folder in LEFT RIGHT LEFT-RIGHT
	do 
		mkdir ${folder}/FA ${folder}/RD ${folder}/MD ${folder}/AD ${folder}/STREAMLINES
	done
	
	#left
	for file in ${SUBJ}_L*combined*.txt
	do
		if [[ $file != *"R"* ]]
		then 
			if [[ ${file: -6:-4} == "fa" ]]
			then
				mv ${file} LEFT/FA/
			elif [[ ${file: -6:-4} == "md" ]]
			then
				mv ${file} LEFT/MD/
			elif  [[ ${file: -6:-4} == "rd" ]]
			then
				mv ${file} LEFT/RD/
			elif [[ ${file: -6:-4} == "ad" ]]
			then
				mv ${file} LEFT/AD/
			elif [[ ${file: -6:-4} == "es" ]]
			then
				mv ${file} LEFT/STREAMLINES/
			fi 
		fi
	done
	
	#right
	for file in ${SUBJ}_R*combined*.txt
	do
		if [[ ${file: -6:-4} == "fa" ]]
		then
			mv ${file} RIGHT/FA/
		elif [[ ${file: -6:-4} == "md" ]]
		then
			mv ${file} RIGHT/MD/
		elif  [[ ${file: -6:-4} == "rd" ]]
		then
			mv ${file} RIGHT/RD/
		elif [[ ${file: -6:-4} == "ad" ]]
		then
			mv ${file} RIGHT/AD/
		elif [[ ${file: -6:-4} == "es" ]]
		then
			mv ${file} RIGHT/STREAMLINES/
		else
			echo ERROR File Not Found
		fi 
	done
	
	#left-right
	for file in *${SUBJ}_L*R*combined*.txt
	do
		if [[ ${file: -6:-4} == "fa" ]]
		then
			mv ${file} LEFT-RIGHT/FA/
		elif [[ ${file: -6:-4} == "md" ]]
		then
			mv ${file} LEFT-RIGHT/MD/
		elif  [[ ${file: -6:-4} == "rd" ]]
		then
			mv ${file} LEFT-RIGHT/RD/
		elif [[ ${file: -6:-4} == "ad" ]]
		then
			mv ${file} LEFT-RIGHT/AD/
		elif [[ ${file: -6:-4} == "es" ]]
		then
			mv ${file} LEFT-RIGHT/STREAMLINES/
		else
			echo ERROR File Not Found
		fi 
	done
	
	cd ../..
done