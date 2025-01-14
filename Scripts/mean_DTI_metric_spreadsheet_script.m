%Zenan Tang
%August 25th 2021
%Purpose: To get an overview of all file values per subject per each DTI metric.

%Enter analysis folder
participant_folders= '/media/mabbottlab/temp_backup/Tommy/DTIs-analysis/';
cd (participant_folders);
folders=(dir(fullfile(participant_folders)));
folders(1:2)= [];
%Create 5 empty tables
table1 = [];
table2 = [];
table3 = [];
table4 = [];
table5 = [];
%Reorganize mean DTI metric files and put it into one table per
%metric where rows are subjects and columns are the ROI files 
for k= 1:length(folders(2:77))
    subject_stats_folder = ['/media/mabbottlab/temp_backup/Tommy/DTIs-analysis/' + string(folders(k+5).name) + '/' + string(folders(k+5).name) + '_stats/'];
    cd (subject_stats_folder)
    files1= struct2table(dir('*fa.txt'));
    files2= struct2table(dir('*ad.txt'));
    files3= struct2table(dir('*md.txt'));
    files4= struct2table(dir('*rd.txt'));
    files5= struct2table(dir('*es.txt'));
    %Go through all files per each DTI metric and write it to the respective table
    for i= 1:height(files1)
       R1= readtable(files1{i,1}{1});
       table1{k,i}= R1{1,1};
    end
    for i= 1:height(files2)
       R2= readtable(files2{i,1}{1});
       table2{k,i}= R2{1,1};
    end
    for i= 1:height(files3)
       R3= readtable(files3{i,1}{1});
       table3{k,i}= R3{1,1};
    end
    for i= 1:height(files4)
       R4= readtable(files4{i,1}{1});
       table4{k,i}= R4{1,1};
    end
    for i= 1:height(files5)
       R5= readtable(files5{i,1}{1});
       table5{k,i}= R5{1,1};
    end
end
%switch back to DTI-analysis dir
cd ../..
%Make spreadsheets
writecell(table1, 'Mean_FA_Overview.xlsx')
writecell(table2, 'Mean_AD_Overview.xlsx')
writecell(table3, 'Mean_MD_Overview.xlsx')
writecell(table4, 'Mean_RD_Overview.xlsx')
writematrix(table5, 'Mean_Streamlines_Overview.xlsx')