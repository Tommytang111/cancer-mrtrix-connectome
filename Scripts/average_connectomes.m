%make averaged connectomes per group
%load all connectome mat files
%files= dir('*.mat'); %directory of where all participant connectomes are stored in mat format 
%for i= 1:numel(files) %calls every element in the directly and loads into working directory
%    load(files(i).name);
%end

%concatenate into a 3D array, will make array (#nodes X #nodes X #ofgroupparticipants)
pats = cat(3, ST10hcpmmp1, ST25hcpmmp1, ST34hcpmmp1, ST63hcpmmp1, ST64hcpmmp1, ST68hcpmmp1, ST70hcpmmp1, ST71hcpmmp1, ST74hcpmmp1, ST78hcpmmp1, ST79hcpmmp1, ST85hcpmmp1, ST88hcpmmp1, ST94hcpmmp1, ST04hcpmmp1, ST09hcpmmp1, ST11hcpmmp1, ST12hcpmmp1, ST13hcpmmp1, ST15hcpmmp1, ST16hcpmmp1, ST19hcpmmp1, ST26hcpmmp1, ST29hcpmmp1, ST31hcpmmp1, ST35hcpmmp1, ST40hcpmmp1, ST41hcpmmp1, ST43hcpmmp1, ST46hcpmmp1, ST61hcpmmp1, ST69hcpmmp1, ST80hcpmmp1, ST82hcpmmp1, ST83hcpmmp1, ST89hcpmmp1, ST91hcpmmp1, ST92hcpmmp1, ST95hcpmmp1, ST97hcpmmp1); 
ctrls = cat(3, ST02hcpmmp1, ST03hcpmmp1, ST05hcpmmp1, ST06hcpmmp1, ST14hcpmmp1, ST20hcpmmp1, ST22hcpmmp1, ST27hcpmmp1, ST28hcpmmp1, ST32hcpmmp1, ST36hcpmmp1, ST37hcpmmp1, ST38hcpmmp1, ST44hcpmmp1, ST45hcpmmp1, ST47hcpmmp1, ST48hcpmmp1, ST49hcpmmp1, ST50hcpmmp1, ST51hcpmmp1, ST53hcpmmp1, ST56hcpmmp1, ST58hcpmmp1, ST59hcpmmp1, ST60hcpmmp1, ST65hcpmmp1, ST67hcpmmp1, ST72hcpmmp1, ST73hcpmmp1, ST75hcpmmp1, ST77hcpmmp1, ST81hcpmmp1, ST84hcpmmp1, ST86hcpmmp1, ST87hcpmmp1, ST93hcpmmp1); 
surg = cat(3, ST10hcpmmp1, ST25hcpmmp1, ST34hcpmmp1, ST63hcpmmp1, ST64hcpmmp1, ST68hcpmmp1, ST70hcpmmp1, ST71hcpmmp1, ST74hcpmmp1, ST78hcpmmp1, ST79hcpmmp1, ST85hcpmmp1, ST88hcpmmp1, ST94hcpmmp1);
rad = cat(3, ST04hcpmmp1, ST09hcpmmp1, ST11hcpmmp1, ST12hcpmmp1, ST13hcpmmp1, ST15hcpmmp1, ST16hcpmmp1, ST19hcpmmp1, ST26hcpmmp1, ST29hcpmmp1, ST31hcpmmp1, ST35hcpmmp1, ST40hcpmmp1, ST41hcpmmp1, ST43hcpmmp1, ST46hcpmmp1, ST61hcpmmp1, ST69hcpmmp1, ST80hcpmmp1, ST82hcpmmp1, ST83hcpmmp1, ST89hcpmmp1, ST91hcpmmp1, ST92hcpmmp1, ST95hcpmmp1, ST97hcpmmp1);

%make mean matrix
Average_pats = mean(pats, 3); %mean of all matrices in array, vertex-wise (1,1) is mean of value in position (1,1) in every matrix
Average_ctrls = mean(ctrls, 3); %same for ctrl group 
Average_surg = mean(surg, 3);
Average_rad = mean(rad, 3);

imagesc(Average_pats, [0,1])
imagesc(Average_ctrls, [0,1])
imagesc(Average_surg, [0,1])
imagesc(Average_rad, [0,1])


