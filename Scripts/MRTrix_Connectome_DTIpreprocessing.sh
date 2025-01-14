#!/bin/bash

#Last Optimization on July 9th, 2021 by Zenan (Tommy) Tang

RAW_DWI='/home/naldahhan/Noor_Analysis/Analyses/DTIs-processed/ST24/ST24_dwi.nii'
AP_BVEC='/home/naldahhan/Noor_Analysis/Analyses/DTIs-processed/ST24/ST24_dwi.bvec'
AP_BVAL='/home/naldahhan/Noor_Analysis/Analyses/DTIs-processed/ST24/ST24_dwi.bval'
ANAT='/home/naldahhan/Noor_Analysis/Analyses/DTIs-processed/ST24/ST24xC_T1.nii.gz'

SUBJ='ST24';

#note: in the terminal, type in: bash MRTrix_Connectome_DTIpreprocessing.sh to run the script
#note: make sure all image labels are in proper orientation before doing anything!!!

########################### STEP 1 ###################################
#	        Convert data to .mif format and denoise	   	     #
######################################################################

# Also consider doing Gibbs denoising (using mrdegibbs). Check your diffusion data for ringing artifacts before deciding whether to use it

mrconvert $RAW_DWI ${SUBJ}_dwi.mif -fslgrad $AP_BVEC $AP_BVAL

dwidenoise ${SUBJ}_DTI.mif ${SUBJ}_dwi_den.mif -noise ${SUBJ}_noise.mif

# Extract the b0 images from the diffusion data acquired in the AP direction
dwiextract ${SUBJ}_dwi_den.mif - -bzero | mrmath - mean ${SUBJ}_mean_b0_AP.mif -axis 3

# Runs the dwipreproc command, which is a wrapper for eddy and topup. 
dwifslpreproc ${SUBJ}_dwi_den.mif ${SUBJ}_dwi_den_preproc.mif -nocleanup -pe_dir AP -rpe_none -eddy_options " --slm=linear" -export_grad_mrtrix ${SUBJ}_output_grad.txt

# Performs bias field correction. Needs ANTs to be installed in order to use the "ants" option (use "fsl" otherwise)
dwibiascorrect ants ${SUBJ}_dwi_den_preproc.mif ${SUBJ}_dwi_den_preproc_unbiased.mif -bias ${SUBJ}_bias.mif

# Create a mask for future processing steps
dwi2mask ${SUBJ}_dwi_den_preproc_unbiased.mif ${SUBJ}_mask.mif


########################### STEP 2 ###################################
#             Basis function for each tissue type                    #
######################################################################

# Create a basis function from the subject's DWI data. The "dhollander" function is best used for multi-shell acquisitions; it will estimate different basis functions for each tissue type. For single-shell acquisition, use the "tournier" function instead
dwi2response dhollander ${SUBJ}_dwi_den_preproc_unbiased.mif ${SUBJ}_wm.txt ${SUBJ}_gm.txt ${SUBJ}_csf.txt -voxels ${SUBJ}_voxels.mif

# Performs multishell-multitissue constrained spherical deconvolution, using the basis functions estimated above
dwi2fod msmt_csd ${SUBJ}_dwi_den_preproc_unbiased.mif -mask ${SUBJ}_mask.mif ${SUBJ}_wm.txt ${SUBJ}_wmfod.mif ${SUBJ}_gm.txt ${SUBJ}_gmfod.mif ${SUBJ}_csf.txt ${SUBJ}_csffod.mif

# Creates an image of the fiber orientation densities overlaid onto the estimated tissues (Blue=WM; Green=GM; Red=CSF)
# You should see FOD's mostly within the white matter. These can be viewed later with the command "mrview vf.mif -odf.load_sh wmfod.mif"

mrconvert -coord 3 0 ${SUBJ}_wmfod.mif - | mrcat ${SUBJ}_csffod.mif ${SUBJ}_gmfod.mif - ${SUBJ}_vf.mif

# Now normalize the FODs to enable comparison between subjects
mtnormalise ${SUBJ}_wmfod.mif ${SUBJ}_wmfod_norm.mif ${SUBJ}_csffod.mif ${SUBJ}_csffod_norm.mif -mask ${SUBJ}_mask.mif


########################### STEP 3 ###################################
#            Create a GM/WM boundary for seed analysis               #
######################################################################

# Convert the anatomical image to .mif format, and then extract all five tissue catagories (1=GM; 2=Subcortical GM; 3=WM; 4=CSF; 5=Pathological tissue)

#Note if header/orientation labels are wrong, just open mrview, transform, then save.

mrconvert ${SUBJ}_T1.mif ${SUBJ}_T1.nii.gz

#Note, if 5ttgen results in error, reorient it to regular orientaiton before running. There are many ways to do this: The easiest is to use the transform tool in mrview. Otherwise you can use Flirt settings (tip: open up GUI and change search angles to max)
#This is can be done with the line below (replace input/output image with desired images):

#flirt -in /media/mabbottlab/temp_backup/noor/DTIS-processed/${SUBJ}/${SUBJ}_T1.nii.gz -ref /usr/local/fsl/data/standard/MNI152_T1_1mm_brain.nii.gz -out /media/mabbottlab/temp_backup/noor/DTIS-processed/${SUBJ}/${SUBJ}_T1_reoriented.nii.gz -omat /media/mabbottlab/temp_backup/noor/DTIS-processed/${SUBJ}/${SUBJ}_T1_reoriented.mat -bins 256 -cost corratio -searchrx -180 180 -searchry -180 180 -searchrz -180 180 -dof 12  -interp trilinear
#The line above this causes errors when running recon-all with the reoriented T1.

#Note: Also if 5ttgen is cutting off 1/3 of the brain, run bet2 beforehand and use it as an input into 5ttgen using the -premasked option.

5ttgen fsl ${SUBJ}_T1.mif ${SUBJ}_5tt_nocoreg.mif

# The following series of commands will take the average of the b0 images (which have the best contrast), convert them and the 5tt image to NIFTI format, and use it for coregistration.
dwiextract ${SUBJ}_dwi_den_preproc_unbiased.mif - -bzero | mrmath - mean ${SUBJ}_mean_b0_processed.mif -axis 3

mrconvert ${SUBJ}_mean_b0_processed.mif ${SUBJ}_mean_b0_processed.nii.gz

mrconvert ${SUBJ}_5tt_nocoreg.mif ${SUBJ}_5tt_nocoreg.nii.gz

#apply a transformation to mean_b0 space and generate matrix at same time starting from 5tt_nocoreg
#this will generate a 3D volume from 5tt_nocoreg using the same method as fslroi 0 1 but it will output a transformed image that is also 3D which is a problem
flirt -in /media/mabbottlab/temp_backup/noor/DTIs-processed/${SUBJ}/${SUBJ}_5tt_nocoreg.nii.gz -ref /media/mabbottlab/temp_backup/noor/DTIs-processed/${SUBJ}/${SUBJ}_mean_b0_processed.nii.gz -omat /media/mabbottlab/temp_backup/noor/DTIs-processed/${SUBJ}/${SUBJ}_struct2diff.mat -bins 256 -cost corratio -searchrx -180 180 -searchry -180 180 -searchrz -180 180 -dof 12  -interp trilinear

#Convert FSL transformation matrix into a mrtrix txt file
transformconvert ${SUBJ}_struct2diff.mat ${SUBJ}_5tt_nocoreg.nii.gz ${SUBJ}_mean_b0_processed.nii.gz flirt_import ${SUBJ}_struct2diff_mrtrix.txt

#Do a direct linear transform using mrtrix txt file.
mrtransform ${SUBJ}_5tt_nocoreg.mif -linear ${SUBJ}_struct2diff_mrtrix.txt ${SUBJ}_5tt_coreg.mif

#Create a seed region along the GM/WM boundary
5tt2gmwmi ${SUBJ}_5tt_coreg.mif ${SUBJ}_gmwmSeed_coreg.mif

########################### STEP 4 ###################################
#   Prepare an atlas for structural connectivity analysis            #
######################################################################

#Process the anatomical image with freesurfer recon-all

recon-all -i ${SUBJ}_T1.nii.gz -all -sd /home/naldahhan/Noor_Analysis/DTIs-processed/${SUBJ} -s ${SUBJ}

#To incorporate the HCP atlas into the pipeline: 

#Map the annotation files of the HCP MMP 1.0 atlas from fsaverage to your subject for each hemisphere  


#Note: $SUBJECTS_DIR needs to contain both fs_average as well as the subject recon-all output (ex. ST02). The following lines will not run if they are not located in the same folder. Do this by:

# export SUBJECTS_DIR=target_directory
# source $FREESURFER_HOME/SetUpFreeSurfer.sh

#Should have the output of recon-all for any subject that we run go to a folder with fsaverage inside (somewhere in carbon). This would remove the need to copy and paste fsaverage to every subject folder. #Any parcellation file that needs to be generated can use this folder.  

mri_surf2surf --srcsubject fsaverage --trgsubject ${SUBJ} --hemi lh --sval-annot $SUBJECTS_DIR/fsaverage/label/lh.HCP-MMP1.annot --tval $SUBJECTS_DIR/${SUBJ}/label/lh.HCP-MMP1.annot 

mri_surf2surf --srcsubject fsaverage --trgsubject ${SUBJ} --hemi rh --sval-annot $SUBJECTS_DIR/fsaverage/label/rh.HCP-MMP1.annot --tval $SUBJECTS_DIR/${SUBJ}/label/rh.HCP-MMP1.annot 

mri_aparc2aseg --old-ribbon --s ${SUBJ} --annot HCP-MMP1 --o ${SUBJ}_hcpmmp1.mgz --sd $SUBJECTS_DIR

mrconvert -datatype uint32 ${SUBJ}_hcpmmp1.mgz ${SUBJ}_hcpmmp1.mif

labelconvert ${SUBJ}_hcpmmp1.mif /home/ttang/Downloads/hcpmmp1_original.txt /home/ttang/Downloads/hcpmmp1_ordered.txt ${SUBJ}_hcpmmp1_parcels_nocoreg.mif 

mrconvert ${SUBJ}_hcpmmp1_parcels_nocoreg.mif ${SUBJ}_hcpmmp1_parcels_nocoreg.nii.gz 

#apply a transformation to mean_b0 space and generate only output from hcpmmp1_parcels_nocoreg.
#Confirmed that nodes can still be extracted successfully.
flirt -in /media/mabbottlab/temp_backup/noor/DTIs-processed/${SUBJ}/${SUBJ}_hcpmmp1_parcels_nocoreg.nii.gz -ref /media/mabbottlab/temp_backup/noor/DTIs-processed/${SUBJ}/${SUBJ}_mean_b0_processed.nii.gz -out /media/mabbottlab/temp_backup/noor/DTIs-processed/${SUBJ}/${SUBJ}_hcpmmp1_parcels_coreg.nii.gz -bins 256 -cost corratio -searchrx -180 180 -searchry -180 180 -searchrz -180 180 -dof 12  -interp nearestneighbour

mrconvert ${SUBJ}_hcpmmp1_parcels_coreg.nii.gz ${SUBJ}_hcpmmp1_parcels_coreg.mif

########################### STEP 5 ###################################
#                 Run the streamline analysis                        #
######################################################################

# Create streamlines
# Note that the "right" number of streamlines is still up for debate. Last I read from the MRtrix documentation,
# They recommend about 100 million tracks. Here I use 10 million, if only to save time. Read their papers and then make a decision

tckgen -act ${SUBJ}_5tt_coreg.mif -backtrack -seed_gmwmi ${SUBJ}_gmwmSeed_coreg.mif -nthreads 8 -maxlength 250 -cutoff 0.06 -select 10000000 ${SUBJ}_wmfod_norm.mif ${SUBJ}_tracks_10M.tck

# Extract a subset of tracks (here, 200 thousand) for ease of visualization
tckedit ${SUBJ}_tracks_10M.tck -number 200k ${SUBJ}_smallerTracks_200k.tck

# Reduce the number of streamlines with tcksift:

#tcksift2 -act ${SUBJ}_5tt_coreg.mif -out_mu ${SUBJ}_sift_mu.txt -out_coeffs ${SUBJ}_sift_coeffs.txt -nthreads 8 ${SUBJ}_tracks_10M.tck ${SUBJ}_wmfod_norm.mif ${SUBJ}_sift_1M.txt

tcksift -act ${SUBJ}_5tt_coreg.mif -term_number 1000000 ${SUBJ}_tracks_10M.tck ${SUBJ}_wmfod_norm.mif ${SUBJ}_sift_1mio.tck


########################### STEP 6 ###################################
#                 Create the connectome                              #
######################################################################

#Create a whole-brain connectome, representing the streamlines between each parcellation pair in the atlas (in this case, 180x180). The "symmetric" option will make the lower diagonal the same as the upper diagonal, and the "scale_invnodevol" option will scale the connectome by the inverse of the size of the node 

#Note: you need the output from -out-assigments to extract steamlines between atlas regions 


#tck2connectome -symmetric -zero_diagonal -scale_invnodevol -tck_weights_in ${SUBJ}_sift_1M.txt ${SUBJ}_tracks_10M.tck ${SUBJ}_parcels_coreg.mif ${SUBJ}_parcels_coreg.csv -out_assignment ${SUBJ}_assignments_parcels_coreg.csv

tck2connectome -symmetric -zero_diagonal -scale_invnodevol ${SUBJ}_sift_1mio.tck ${SUBJ}_hcpmmp1_parcels_coreg.mif ${SUBJ}_hcpmmp1.csv -out_assignment ${SUBJ}_assignments_hcpmmp1.csv


#To view the structural connectome matrix in matlab, open matlab and type in:

#connectome = importdata('${SUBJ}_hcpmmp1.csv'); imagesc(connectome, [0 1])


