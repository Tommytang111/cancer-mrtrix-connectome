%Make NBS Ready (my version)

%Zenan Tang
%August 25th 2021
%Purpose: To generate 2D matrices for each subject, then concatenate along
%the 3rd dimension to make one 3D matrix per region and metric of analysis.
%Also makes a spreadsheet of subjectxROIs per DTI metric per hemisphere


%Generates Older PBTS vs Older HC Data matrix only
participant_folders= '/media/mabbottlab/temp_backup/Tommy/DTIs-analysis/';
cd (participant_folders);
folders=(dir(fullfile(participant_folders)));
folders(1:2)= [];
table1 = [];
table2 = [];
table3 = [];
table4 = [];
table5 = [];
table6 = [];
table7 = [];
table8 = [];
table9 = [];
table10 = [];
table11 = [];
table12 = [];
table13 = [];
table14 = [];
table15 = [];
matrix1 = [];
matrix2 = [];
matrix3 = [];
matrix4 = [];
matrix5 = [];
matrix6 = [];
matrix7 = [];
matrix8 = [];
matrix9 = [];
matrix10 = [];
matrix11 = [];
matrix12 = [];
matrix13 = [];
matrix14 = [];
matrix15 = [];
catmatrix1 = [];
catmatrix2 = [];
catmatrix3 = [];
catmatrix4 = [];
catmatrix5 = [];
catmatrix6 = [];
catmatrix7 = [];
catmatrix8 = [];
catmatrix9 = [];
catmatrix10 = [];
catmatrix11 = [];
catmatrix12 = [];
catmatrix13 = [];
catmatrix14 = [];
catmatrix15 = [];
for i = [1,2,3,4,5,6,9,10,11,13,20,23,27,28,29,31,36,38,43,44,45,46,48,49,52,53,56,58,59,62,63,64,65,70,75,76]
    try
        left_fa = ['/media/mabbottlab/temp_backup/Tommy/DTIs-analysis/' + string(folders(i+6).name) + '/' + string(folders(i+6).name) + '_stats/LEFT/FA'];
        cd (left_fa)
        files1= struct2table(dir('*.txt'));
        %go through all files in folder and write to table
        for a = 1:height(files1)
            R1= readtable(files1{a,1}{1});
            table1{i,a}= R1{1,1};
        end
        
        %Fill entries in matrix with NaN or 1s as appropriate
        for b = 1:7
            matrix1(b,b)=1;
            matrix2(b,b)=NaN;
            matrix3(b,b)=NaN;
            matrix4(b,b)=NaN;
            matrix5(b,b)=1;
            matrix6(b,b)=NaN;
            matrix7(b,b)=NaN;
            matrix8(b,b)=NaN;
            matrix9(b,b)=NaN;
            matrix10(b,b)=NaN;
            
        for a = 1:7
            for b = 1:7
               matrix11(a,b)=NaN;
               matrix12(a,b)=NaN;
               matrix13(a,b)=NaN;
               matrix14(a,b)=NaN;
               matrix15(a,b)=NaN;
            end
        end
        
        for a = 8:14
            for b = 8:14
               matrix11(a,b)=NaN;
               matrix12(a,b)=NaN;
               matrix13(a,b)=NaN;
               matrix14(a,b)=NaN;
               matrix15(a,b)=NaN;
            end
        end
           
        end
        try
            matrix1(2,1)=table1{i,1};
            matrix1(1,2)=table1{i,1};
            matrix1(3,1)=table1{i,6};
            matrix1(1,3)=table1{i,6};
            matrix1(4,1)=table1{i,4};
            matrix1(1,4)=table1{i,4};
            matrix1(5,1)=table1{i,15};
            matrix1(1,5)=table1{i,15};
            matrix1(6,1)=table1{i,11};
            matrix1(1,6)=table1{i,11};
            matrix1(7,1)=table1{i,21};
            matrix1(1,7)=table1{i,21};
            matrix1(3,2)=table1{i,5};
            matrix1(2,3)=table1{i,5};
            matrix1(4,2)=table1{i,2};
            matrix1(2,4)=table1{i,2};
            matrix1(5,2)=table1{i,12};
            matrix1(2,5)=table1{i,12};
            matrix1(6,2)=table1{i,7};
            matrix1(2,6)=table1{i,7};
            matrix1(7,2)=table1{i,16};
            matrix1(7,2)=table1{i,16};
            matrix1(4,3)=table1{i,3};
            matrix1(3,4)=table1{i,3};
            matrix1(5,3)=table1{i,14};
            matrix1(3,5)=table1{i,14};
            matrix1(6,3)=table1{i,9};
            matrix1(3,6)=table1{i,9};
            matrix1(7,3)=table1{i,18};
            matrix1(3,7)=table1{i,18};
            matrix1(5,4)=table1{i,13};
            matrix1(4,5)=table1{i,13};
            matrix1(6,4)=table1{i,8};
            matrix1(4,6)=table1{i,8};
            matrix1(7,4)=table1{i,17};
            matrix1(4,7)=table1{i,17};
            matrix1(6,5)=table1{i,10};
            matrix1(5,6)=table1{i,10};
            matrix1(7,5)=table1{i,20};
            matrix1(5,7)=table1{i,20};
            matrix1(7,6)=table1{i,19};
            matrix1(6,7)=table1{i,19};
        catch exception
            warning('error')
        end
        
        left_md = ['/media/mabbottlab/temp_backup/Tommy/DTIs-analysis/' + string(folders(i+6).name) + '/' + string(folders(i+6).name) + '_stats/LEFT/MD'];
        cd (left_md)
        files2= struct2table(dir('*.txt'));
        for a = 1:height(files2)
            R2= readtable(files2{a,1}{1});
            table2{i,a}= R2{1,1};
        end
        try
            matrix2(2,1)=table2{i,1};
            matrix2(1,2)=table2{i,1};
            matrix2(3,1)=table2{i,6};
            matrix2(1,3)=table2{i,6};
            matrix2(4,1)=table2{i,4};
            matrix2(1,4)=table2{i,4};
            matrix2(5,1)=table2{i,15};
            matrix2(1,5)=table2{i,15};
            matrix2(6,1)=table2{i,11};
            matrix2(1,6)=table2{i,11};
            matrix2(7,1)=table2{i,21};
            matrix2(1,7)=table2{i,21};
            matrix2(3,2)=table2{i,5};
            matrix2(2,3)=table2{i,5};
            matrix2(4,2)=table2{i,2};
            matrix2(2,4)=table2{i,2};
            matrix2(5,2)=table2{i,12};
            matrix2(2,5)=table2{i,12};
            matrix2(6,2)=table2{i,7};
            matrix2(2,6)=table2{i,7};
            matrix2(7,2)=table2{i,16};
            matrix2(7,2)=table2{i,16};
            matrix2(4,3)=table2{i,3};
            matrix2(3,4)=table2{i,3};
            matrix2(5,3)=table2{i,14};
            matrix2(3,5)=table2{i,14};
            matrix2(6,3)=table2{i,9};
            matrix2(3,6)=table2{i,9};
            matrix2(7,3)=table2{i,18};
            matrix2(3,7)=table2{i,18};
            matrix2(5,4)=table2{i,13};
            matrix2(4,5)=table2{i,13};
            matrix2(6,4)=table2{i,8};
            matrix2(4,6)=table2{i,8};
            matrix2(7,4)=table2{i,17};
            matrix2(4,7)=table2{i,17};
            matrix2(6,5)=table2{i,10};
            matrix2(5,6)=table2{i,10};
            matrix2(7,5)=table2{i,20};
            matrix2(5,7)=table2{i,20};
            matrix2(7,6)=table2{i,19};
            matrix2(6,7)=table2{i,19};
        catch exception
            warning('error')
        end
        
        left_ad = ['/media/mabbottlab/temp_backup/Tommy/DTIs-analysis/' + string(folders(i+6).name) + '/' + string(folders(i+6).name) + '_stats/LEFT/AD'];
        cd (left_ad)
        files3= struct2table(dir('*.txt'));
        for a = 1:height(files3)
            R3= readtable(files3{a,1}{1});
            table3{i,a}= R3{1,1};
        end
        try
            matrix3(2,1)=table3{i,1};
            matrix3(1,2)=table3{i,1};
            matrix3(3,1)=table3{i,6};
            matrix3(1,3)=table3{i,6};
            matrix3(4,1)=table3{i,4};
            matrix3(1,4)=table3{i,4};
            matrix3(5,1)=table3{i,15};
            matrix3(1,5)=table3{i,15};
            matrix3(6,1)=table3{i,11};
            matrix3(1,6)=table3{i,11};
            matrix3(7,1)=table3{i,21};
            matrix3(1,7)=table3{i,21};
            matrix3(3,2)=table3{i,5};
            matrix3(2,3)=table3{i,5};
            matrix3(4,2)=table3{i,2};
            matrix3(2,4)=table3{i,2};
            matrix3(5,2)=table3{i,12};
            matrix3(2,5)=table3{i,12};
            matrix3(6,2)=table3{i,7};
            matrix3(2,6)=table3{i,7};
            matrix3(7,2)=table3{i,16};
            matrix3(7,2)=table3{i,16};
            matrix3(4,3)=table3{i,3};
            matrix3(3,4)=table3{i,3};
            matrix3(5,3)=table3{i,14};
            matrix3(3,5)=table3{i,14};
            matrix3(6,3)=table3{i,9};
            matrix3(3,6)=table3{i,9};
            matrix3(7,3)=table3{i,18};
            matrix3(3,7)=table3{i,18};
            matrix3(5,4)=table3{i,13};
            matrix3(4,5)=table3{i,13};
            matrix3(6,4)=table3{i,8};
            matrix3(4,6)=table3{i,8};
            matrix3(7,4)=table3{i,17};
            matrix3(4,7)=table3{i,17};
            matrix3(6,5)=table3{i,10};
            matrix3(5,6)=table3{i,10};
            matrix3(7,5)=table3{i,20};
            matrix3(5,7)=table3{i,20};
            matrix3(7,6)=table3{i,19};
            matrix3(6,7)=table3{i,19};
        catch exception
            warning('error')
        end
        
        left_rd = ['/media/mabbottlab/temp_backup/Tommy/DTIs-analysis/' + string(folders(i+6).name) + '/' + string(folders(i+6).name) + '_stats/LEFT/RD'];
        cd (left_rd)
        files4= struct2table(dir('*.txt'));
        for a = 1:height(files4)
            R4= readtable(files4{a,1}{1});
            table4{i,a}= R4{1,1};
        end
        try
            matrix4(2,1)=table4{i,1};
            matrix4(1,2)=table4{i,1};
            matrix4(3,1)=table4{i,6};
            matrix4(1,3)=table4{i,6};
            matrix4(4,1)=table4{i,4};
            matrix4(1,4)=table4{i,4};
            matrix4(5,1)=table4{i,15};
            matrix4(1,5)=table4{i,15};
            matrix4(6,1)=table4{i,11};
            matrix4(1,6)=table4{i,11};
            matrix4(7,1)=table4{i,21};
            matrix4(1,7)=table4{i,21};
            matrix4(3,2)=table4{i,5};
            matrix4(2,3)=table4{i,5};
            matrix4(4,2)=table4{i,2};
            matrix4(2,4)=table4{i,2};
            matrix4(5,2)=table4{i,12};
            matrix4(2,5)=table4{i,12};
            matrix4(6,2)=table4{i,7};
            matrix4(2,6)=table4{i,7};
            matrix4(7,2)=table4{i,16};
            matrix4(7,2)=table4{i,16};
            matrix4(4,3)=table4{i,3};
            matrix4(3,4)=table4{i,3};
            matrix4(5,3)=table4{i,14};
            matrix4(3,5)=table4{i,14};
            matrix4(6,3)=table4{i,9};
            matrix4(3,6)=table4{i,9};
            matrix4(7,3)=table4{i,18};
            matrix4(3,7)=table4{i,18};
            matrix4(5,4)=table4{i,13};
            matrix4(4,5)=table4{i,13};
            matrix4(6,4)=table4{i,8};
            matrix4(4,6)=table4{i,8};
            matrix4(7,4)=table4{i,17};
            matrix4(4,7)=table4{i,17};
            matrix4(6,5)=table4{i,10};
            matrix4(5,6)=table4{i,10};
            matrix4(7,5)=table4{i,20};
            matrix4(5,7)=table4{i,20};
            matrix4(7,6)=table4{i,19};
            matrix4(6,7)=table4{i,19};
        catch exception
            warning('error')
        end
        
        left_streamline = ['/media/mabbottlab/temp_backup/Tommy/DTIs-analysis/' + string(folders(i+6).name) + '/' + string(folders(i+6).name) + '_stats/LEFT/STREAMLINES'];
        cd (left_streamline)
        files9= struct2table(dir('*.txt'));
        for a = 1:height(files9)
            R9= readtable(files9{a,1}{1});
            table9{i,a}= R9{1,1};
        end
        try
            matrix9(2,1)=table9{i,1};
            matrix9(1,2)=table9{i,1};
            matrix9(3,1)=table9{i,6};
            matrix9(1,3)=table9{i,6};
            matrix9(4,1)=table9{i,4};
            matrix9(1,4)=table9{i,4};
            matrix9(5,1)=table9{i,15};
            matrix9(1,5)=table9{i,15};
            matrix9(6,1)=table9{i,11};
            matrix9(1,6)=table9{i,11};
            matrix9(7,1)=table9{i,21};
            matrix9(1,7)=table9{i,21};
            matrix9(3,2)=table9{i,5};
            matrix9(2,3)=table9{i,5};
            matrix9(4,2)=table9{i,2};
            matrix9(2,4)=table9{i,2};
            matrix9(5,2)=table9{i,12};
            matrix9(2,5)=table9{i,12};
            matrix9(6,2)=table9{i,7};
            matrix9(2,6)=table9{i,7};
            matrix9(7,2)=table9{i,16};
            matrix9(7,2)=table9{i,16};
            matrix9(4,3)=table9{i,3};
            matrix9(3,4)=table9{i,3};
            matrix9(5,3)=table9{i,14};
            matrix9(3,5)=table9{i,14};
            matrix9(6,3)=table9{i,9};
            matrix9(3,6)=table9{i,9};
            matrix9(7,3)=table9{i,18};
            matrix9(3,7)=table9{i,18};
            matrix9(5,4)=table9{i,13};
            matrix9(4,5)=table9{i,13};
            matrix9(6,4)=table9{i,8};
            matrix9(4,6)=table9{i,8};
            matrix9(7,4)=table9{i,17};
            matrix9(4,7)=table9{i,17};
            matrix9(6,5)=table9{i,10};
            matrix9(5,6)=table9{i,10};
            matrix9(7,5)=table9{i,20};
            matrix9(5,7)=table9{i,20};
            matrix9(7,6)=table9{i,19};
            matrix9(6,7)=table9{i,19};
        catch exception
            warning('error')
        end
        
        right_fa = ['/media/mabbottlab/temp_backup/Tommy/DTIs-analysis/' + string(folders(i+6).name) + '/' + string(folders(i+6).name) + '_stats/RIGHT/FA'];
        cd (right_fa)
        files5= struct2table(dir('*.txt'));
        for a = 1:height(files5)
            R5= readtable(files5{a,1}{1});
            table5{i,a}= R5{1,1};
        end
        try
            matrix5(2,1)=table5{i,1};
            matrix5(1,2)=table5{i,1};
            matrix5(3,1)=table5{i,6};
            matrix5(1,3)=table5{i,6};
            matrix5(4,1)=table5{i,4};
            matrix5(1,4)=table5{i,4};
            matrix5(5,1)=table5{i,15};
            matrix5(1,5)=table5{i,15};
            matrix5(6,1)=table5{i,11};
            matrix5(1,6)=table5{i,11};
            matrix5(7,1)=table5{i,21};
            matrix5(1,7)=table5{i,21};
            matrix5(3,2)=table5{i,5};
            matrix5(2,3)=table5{i,5};
            matrix5(4,2)=table5{i,2};
            matrix5(2,4)=table5{i,2};
            matrix5(5,2)=table5{i,12};
            matrix5(2,5)=table5{i,12};
            matrix5(6,2)=table5{i,7};
            matrix5(2,6)=table5{i,7};
            matrix5(7,2)=table5{i,16};
            matrix5(7,2)=table5{i,16};
            matrix5(4,3)=table5{i,3};
            matrix5(3,4)=table5{i,3};
            matrix5(5,3)=table5{i,14};
            matrix5(3,5)=table5{i,14};
            matrix5(6,3)=table5{i,9};
            matrix5(3,6)=table5{i,9};
            matrix5(7,3)=table5{i,18};
            matrix5(3,7)=table5{i,18};
            matrix5(5,4)=table5{i,13};
            matrix5(4,5)=table5{i,13};
            matrix5(6,4)=table5{i,8};
            matrix5(4,6)=table5{i,8};
            matrix5(7,4)=table5{i,17};
            matrix5(4,7)=table5{i,17};
            matrix5(6,5)=table5{i,10};
            matrix5(5,6)=table5{i,10};
            matrix5(7,5)=table5{i,20};
            matrix5(5,7)=table5{i,20};
            matrix5(7,6)=table5{i,19};
            matrix5(6,7)=table5{i,19};
        catch exception
            warning('error')
        end
            
        right_md = ['/media/mabbottlab/temp_backup/Tommy/DTIs-analysis/' + string(folders(i+6).name) + '/' + string(folders(i+6).name) + '_stats/RIGHT/MD'];
        cd (right_md)
        files6= struct2table(dir('*.txt'));
        for a = 1:height(files6)
            R6= readtable(files6{a,1}{1});
            table6{i,a}= R6{1,1};
        end
        try
            matrix6(2,1)=table6{i,1};
            matrix6(1,2)=table6{i,1};
            matrix6(3,1)=table6{i,6};
            matrix6(1,3)=table6{i,6};
            matrix6(4,1)=table6{i,4};
            matrix6(1,4)=table6{i,4};
            matrix6(5,1)=table6{i,15};
            matrix6(1,5)=table6{i,15};
            matrix6(6,1)=table6{i,11};
            matrix6(1,6)=table6{i,11};
            matrix6(7,1)=table6{i,21};
            matrix6(1,7)=table6{i,21};
            matrix6(3,2)=table6{i,5};
            matrix6(2,3)=table6{i,5};
            matrix6(4,2)=table6{i,2};
            matrix6(2,4)=table6{i,2};
            matrix6(5,2)=table6{i,12};
            matrix6(2,5)=table6{i,12};
            matrix6(6,2)=table6{i,7};
            matrix6(2,6)=table6{i,7};
            matrix6(7,2)=table6{i,16};
            matrix6(7,2)=table6{i,16};
            matrix6(4,3)=table6{i,3};
            matrix6(3,4)=table6{i,3};
            matrix6(5,3)=table6{i,14};
            matrix6(3,5)=table6{i,14};
            matrix6(6,3)=table6{i,9};
            matrix6(3,6)=table6{i,9};
            matrix6(7,3)=table6{i,18};
            matrix6(3,7)=table6{i,18};
            matrix6(5,4)=table6{i,13};
            matrix6(4,5)=table6{i,13};
            matrix6(6,4)=table6{i,8};
            matrix6(4,6)=table6{i,8};
            matrix6(7,4)=table6{i,17};
            matrix6(4,7)=table6{i,17};
            matrix6(6,5)=table6{i,10};
            matrix6(5,6)=table6{i,10};
            matrix6(7,5)=table6{i,20};
            matrix6(5,7)=table6{i,20};
            matrix6(7,6)=table6{i,19};
            matrix6(6,7)=table6{i,19};
        catch exception
            warning('error')
        end
        
        right_ad = ['/media/mabbottlab/temp_backup/Tommy/DTIs-analysis/' + string(folders(i+6).name) + '/' + string(folders(i+6).name) + '_stats/RIGHT/AD'];
        cd (right_ad)
        files7= struct2table(dir('*.txt'));
        for a = 1:height(files7)
            R7= readtable(files7{a,1}{1});
            table7{i,a}= R7{1,1};
        end
        try
            matrix7(2,1)=table7{i,1};
            matrix7(1,2)=table7{i,1};
            matrix7(3,1)=table7{i,6};
            matrix7(1,3)=table7{i,6};
            matrix7(4,1)=table7{i,4};
            matrix7(1,4)=table7{i,4};
            matrix7(5,1)=table7{i,15};
            matrix7(1,5)=table7{i,15};
            matrix7(6,1)=table7{i,11};
            matrix7(1,6)=table7{i,11};
            matrix7(7,1)=table7{i,21};
            matrix7(1,7)=table7{i,21};
            matrix7(3,2)=table7{i,5};
            matrix7(2,3)=table7{i,5};
            matrix7(4,2)=table7{i,2};
            matrix7(2,4)=table7{i,2};
            matrix7(5,2)=table7{i,12};
            matrix7(2,5)=table7{i,12};
            matrix7(6,2)=table7{i,7};
            matrix7(2,6)=table7{i,7};
            matrix7(7,2)=table7{i,16};
            matrix7(7,2)=table7{i,16};
            matrix7(4,3)=table7{i,3};
            matrix7(3,4)=table7{i,3};
            matrix7(5,3)=table7{i,14};
            matrix7(3,5)=table7{i,14};
            matrix7(6,3)=table7{i,9};
            matrix7(3,6)=table7{i,9};
            matrix7(7,3)=table7{i,18};
            matrix7(3,7)=table7{i,18};
            matrix7(5,4)=table7{i,13};
            matrix7(4,5)=table7{i,13};
            matrix7(6,4)=table7{i,8};
            matrix7(4,6)=table7{i,8};
            matrix7(7,4)=table7{i,17};
            matrix7(4,7)=table7{i,17};
            matrix7(6,5)=table7{i,10};
            matrix7(5,6)=table7{i,10};
            matrix7(7,5)=table7{i,20};
            matrix7(5,7)=table7{i,20};
            matrix7(7,6)=table7{i,19};
            matrix7(6,7)=table7{i,19};
        catch exception
            warning('error')
        end
        
        right_rd = ['/media/mabbottlab/temp_backup/Tommy/DTIs-analysis/' + string(folders(i+6).name) + '/' + string(folders(i+6).name) + '_stats/RIGHT/RD'];
        cd (right_rd)
        files8= struct2table(dir('*.txt'));
        for a = 1:height(files8)
            R8= readtable(files8{a,1}{1});
            table8{i,a}= R8{1,1};
        end
        
        try
            matrix8(2,1)=table8{i,1};
            matrix8(1,2)=table8{i,1};
            matrix8(3,1)=table8{i,6};
            matrix8(1,3)=table8{i,6};
            matrix8(4,1)=table8{i,4};
            matrix8(1,4)=table8{i,4};
            matrix8(5,1)=table8{i,15};
            matrix8(1,5)=table8{i,15};
            matrix8(6,1)=table8{i,11};
            matrix8(1,6)=table8{i,11};
            matrix8(7,1)=table8{i,21};
            matrix8(1,7)=table8{i,21};
            matrix8(3,2)=table8{i,5};
            matrix8(2,3)=table8{i,5};
            matrix8(4,2)=table8{i,2};
            matrix8(2,4)=table8{i,2};
            matrix8(5,2)=table8{i,12};
            matrix8(2,5)=table8{i,12};
            matrix8(6,2)=table8{i,7};
            matrix8(2,6)=table8{i,7};
            matrix8(7,2)=table8{i,16};
            matrix8(7,2)=table8{i,16};
            matrix8(4,3)=table8{i,3};
            matrix8(3,4)=table8{i,3};
            matrix8(5,3)=table8{i,14};
            matrix8(3,5)=table8{i,14};
            matrix8(6,3)=table8{i,9};
            matrix8(3,6)=table8{i,9};
            matrix8(7,3)=table8{i,18};
            matrix8(3,7)=table8{i,18};
            matrix8(5,4)=table8{i,13};
            matrix8(4,5)=table8{i,13};
            matrix8(6,4)=table8{i,8};
            matrix8(4,6)=table8{i,8};
            matrix8(7,4)=table8{i,17};
            matrix8(4,7)=table8{i,17};
            matrix8(6,5)=table8{i,10};
            matrix8(5,6)=table8{i,10};
            matrix8(7,5)=table8{i,20};
            matrix8(5,7)=table8{i,20};
            matrix8(7,6)=table8{i,19};
            matrix8(6,7)=table8{i,19};
        catch exception
            warning('error')
        end
        
        right_streamline = ['/media/mabbottlab/temp_backup/Tommy/DTIs-analysis/' + string(folders(i+6).name) + '/' + string(folders(i+6).name) + '_stats/RIGHT/STREAMLINES'];
        cd (right_streamline)
        files10= struct2table(dir('*.txt'));
        for a = 1:height(files10)
            R10= readtable(files10{a,1}{1});
            table10{i,a}= R10{1,1};
        end
        
        try
            matrix10(2,1)=table10{i,1};
            matrix10(1,2)=table10{i,1};
            matrix10(3,1)=table10{i,6};
            matrix10(1,3)=table10{i,6};
            matrix10(4,1)=table10{i,4};
            matrix10(1,4)=table10{i,4};
            matrix10(5,1)=table10{i,15};
            matrix10(1,5)=table10{i,15};
            matrix10(6,1)=table10{i,11};
            matrix10(1,6)=table10{i,11};
            matrix10(7,1)=table10{i,21};
            matrix10(1,7)=table10{i,21};
            matrix10(3,2)=table10{i,5};
            matrix10(2,3)=table10{i,5};
            matrix10(4,2)=table10{i,2};
            matrix10(2,4)=table10{i,2};
            matrix10(5,2)=table10{i,12};
            matrix10(2,5)=table10{i,12};
            matrix10(6,2)=table10{i,7};
            matrix10(2,6)=table10{i,7};
            matrix10(7,2)=table10{i,16};
            matrix10(7,2)=table10{i,16};
            matrix10(4,3)=table10{i,3};
            matrix10(3,4)=table10{i,3};
            matrix10(5,3)=table10{i,14};
            matrix10(3,5)=table10{i,14};
            matrix10(6,3)=table10{i,9};
            matrix10(3,6)=table10{i,9};
            matrix10(7,3)=table10{i,18};
            matrix10(3,7)=table10{i,18};
            matrix10(5,4)=table10{i,13};
            matrix10(4,5)=table10{i,13};
            matrix10(6,4)=table10{i,8};
            matrix10(4,6)=table10{i,8};
            matrix10(7,4)=table10{i,17};
            matrix10(4,7)=table10{i,17};
            matrix10(6,5)=table10{i,10};
            matrix10(5,6)=table10{i,10};
            matrix10(7,5)=table10{i,20};
            matrix10(5,7)=table10{i,20};
            matrix10(7,6)=table10{i,19};
            matrix10(6,7)=table10{i,19};
        catch exception
            warning('error')
        end
              
        %LEFT-RIGHT
        left_right_fa = ['/media/mabbottlab/temp_backup/Tommy/DTIs-analysis/' + string(folders(i+6).name) + '/' + string(folders(i+6).name) + '_stats/LEFT-RIGHT/FA'];
        cd (left_right_fa)
        files11= struct2table(dir('*.txt'));
        for a = 1:height(files11)
            R11= readtable(files11{a,1}{1});
            table11{i,a}= R11{1,1};
        end
        
        try
            matrix11(8,1)=table11{i,49};
            matrix11(1,8)=table11{i,49};
            matrix11(8,2)=table11{i,7};
            matrix11(2,8)=table11{i,7};
            matrix11(8,3)=table11{i,21};
            matrix11(3,8)=table11{i,21};
            matrix11(8,4)=table11{i,14};
            matrix11(4,8)=table11{i,14};
            matrix11(8,5)=table11{i,35};
            matrix11(5,8)=table11{i,35};
            matrix11(8,6)=table11{i,28};
            matrix11(6,8)=table11{i,28};
            matrix11(8,7)=table11{i,42};
            matrix11(7,8)=table11{i,42};
            matrix11(9,1)=table11{i,43};
            matrix11(1,9)=table11{i,43};
            matrix11(9,2)=table11{i,1};
            matrix11(2,9)=table11{i,1};
            matrix11(9,3)=table11{i,15};
            matrix11(3,9)=table11{i,15};
            matrix11(9,4)=table11{i,8};
            matrix11(4,9)=table11{i,8};
            matrix11(9,5)=table11{i,29};
            matrix11(5,9)=table11{i,29};
            matrix11(9,6)=table11{i,22};
            matrix11(6,9)=table11{i,22};
            matrix11(9,7)=table11{i,36};
            matrix11(7,9)=table11{i,36};
            matrix11(10,1)=table11{i,45};
            matrix11(1,10)=table11{i,45};
            matrix11(10,2)=table11{i,3};
            matrix11(2,10)=table11{i,3};
            matrix11(10,3)=table11{i,17};
            matrix11(3,10)=table11{i,17};
            matrix11(10,4)=table11{i,10};
            matrix11(4,10)=table11{i,10};
            matrix11(10,5)=table11{i,31};
            matrix11(5,10)=table11{i,31};
            matrix11(10,6)=table11{i,24};
            matrix11(6,10)=table11{i,24};
            matrix11(10,7)=table11{i,38};
            matrix11(7,10)=table11{i,38};
            matrix11(11,1)=table11{i,44};
            matrix11(1,11)=table11{i,44};
            matrix11(11,2)=table11{i,2};
            matrix11(2,11)=table11{i,2};
            matrix11(11,3)=table11{i,16};
            matrix11(3,11)=table11{i,16};
            matrix11(11,4)=table11{i,9};
            matrix11(4,11)=table11{i,9};
            matrix11(11,5)=table11{i,30};
            matrix11(5,11)=table11{i,30};
            matrix11(11,6)=table11{i,23};
            matrix11(6,11)=table11{i,23};
            matrix11(11,7)=table11{i,37};
            matrix11(7,11)=table11{i,37};
            matrix11(12,1)=table11{i,47};
            matrix11(1,12)=table11{i,47};
            matrix11(12,2)=table11{i,5};
            matrix11(2,12)=table11{i,5};
            matrix11(12,3)=table11{i,19};
            matrix11(3,12)=table11{i,19};
            matrix11(12,4)=table11{i,12};
            matrix11(4,12)=table11{i,12};
            matrix11(12,5)=table11{i,33};
            matrix11(5,12)=table11{i,33};
            matrix11(12,6)=table11{i,26};
            matrix11(6,12)=table11{i,26};
            matrix11(12,7)=table11{i,40};
            matrix11(7,12)=table11{i,40};
            matrix11(13,1)=table11{i,46};
            matrix11(1,13)=table11{i,46};
            matrix11(13,2)=table11{i,4};
            matrix11(2,13)=table11{i,4};
            matrix11(13,3)=table11{i,18};
            matrix11(3,13)=table11{i,18};
            matrix11(13,4)=table11{i,11};
            matrix11(4,13)=table11{i,11};
            matrix11(13,5)=table11{i,32};
            matrix11(5,13)=table11{i,32};
            matrix11(13,6)=table11{i,25};
            matrix11(6,13)=table11{i,25};
            matrix11(13,7)=table11{i,39};
            matrix11(7,13)=table11{i,39};
            matrix11(14,1)=table11{i,48};
            matrix11(1,14)=table11{i,48};
            matrix11(14,2)=table11{i,6};
            matrix11(2,14)=table11{i,6};
            matrix11(14,3)=table11{i,20};
            matrix11(3,14)=table11{i,20};
            matrix11(14,4)=table11{i,13};
            matrix11(4,14)=table11{i,13};
            matrix11(14,5)=table11{i,34};
            matrix11(5,14)=table11{i,34};
            matrix11(14,6)=table11{i,27};
            matrix11(6,14)=table11{i,27};
            matrix11(14,7)=table11{i,41};
            matrix11(7,14)=table11{i,41};
        catch exception
            warning('error')
        end
        
        left_right_md = ['/media/mabbottlab/temp_backup/Tommy/DTIs-analysis/' + string(folders(i+6).name) + '/' + string(folders(i+6).name) + '_stats/LEFT-RIGHT/MD'];
        cd (left_right_md)
        files12= struct2table(dir('*.txt'));
        for a = 1:height(files12)
            R12= readtable(files12{a,1}{1});
            table12{i,a}= R12{1,1};
        end
        
        try
            matrix12(8,1)=table12{i,49};
            matrix12(1,8)=table12{i,49};
            matrix12(8,2)=table12{i,7};
            matrix12(2,8)=table12{i,7};
            matrix12(8,3)=table12{i,21};
            matrix12(3,8)=table12{i,21};
            matrix12(8,4)=table12{i,14};
            matrix12(4,8)=table12{i,14};
            matrix12(8,5)=table12{i,35};
            matrix12(5,8)=table12{i,35};
            matrix12(8,6)=table12{i,28};
            matrix12(6,8)=table12{i,28};
            matrix12(8,7)=table12{i,42};
            matrix12(7,8)=table12{i,42};
            matrix12(9,1)=table12{i,43};
            matrix12(1,9)=table12{i,43};
            matrix12(9,2)=table12{i,1};
            matrix12(2,9)=table12{i,1};
            matrix12(9,3)=table12{i,15};
            matrix12(3,9)=table12{i,15};
            matrix12(9,4)=table12{i,8};
            matrix12(4,9)=table12{i,8};
            matrix12(9,5)=table12{i,29};
            matrix12(5,9)=table12{i,29};
            matrix12(9,6)=table12{i,22};
            matrix12(6,9)=table12{i,22};
            matrix12(9,7)=table12{i,36};
            matrix12(7,9)=table12{i,36};
            matrix12(10,1)=table12{i,45};
            matrix12(1,10)=table12{i,45};
            matrix12(10,2)=table12{i,3};
            matrix12(2,10)=table12{i,3};
            matrix12(10,3)=table12{i,17};
            matrix12(3,10)=table12{i,17};
            matrix12(10,4)=table12{i,10};
            matrix12(4,10)=table12{i,10};
            matrix12(10,5)=table12{i,31};
            matrix12(5,10)=table12{i,31};
            matrix12(10,6)=table12{i,24};
            matrix12(6,10)=table12{i,24};
            matrix12(10,7)=table12{i,38};
            matrix12(7,10)=table12{i,38};
            matrix12(11,1)=table12{i,44};
            matrix12(1,11)=table12{i,44};
            matrix12(11,2)=table12{i,2};
            matrix12(2,11)=table12{i,2};
            matrix12(11,3)=table12{i,16};
            matrix12(3,11)=table12{i,16};
            matrix12(11,4)=table12{i,9};
            matrix12(4,11)=table12{i,9};
            matrix12(11,5)=table12{i,30};
            matrix12(5,11)=table12{i,30};
            matrix12(11,6)=table12{i,23};
            matrix12(6,11)=table12{i,23};
            matrix12(11,7)=table12{i,37};
            matrix12(7,11)=table12{i,37};
            matrix12(12,1)=table12{i,47};
            matrix12(1,12)=table12{i,47};
            matrix12(12,2)=table12{i,5};
            matrix12(2,12)=table12{i,5};
            matrix12(12,3)=table12{i,19};
            matrix12(3,12)=table12{i,19};
            matrix12(12,4)=table12{i,12};
            matrix12(4,12)=table12{i,12};
            matrix12(12,5)=table12{i,33};
            matrix12(5,12)=table12{i,33};
            matrix12(12,6)=table12{i,26};
            matrix12(6,12)=table12{i,26};
            matrix12(12,7)=table12{i,40};
            matrix12(7,12)=table12{i,40};
            matrix12(13,1)=table12{i,46};
            matrix12(1,13)=table12{i,46};
            matrix12(13,2)=table12{i,4};
            matrix12(2,13)=table12{i,4};
            matrix12(13,3)=table12{i,18};
            matrix12(3,13)=table12{i,18};
            matrix12(13,4)=table12{i,11};
            matrix12(4,13)=table12{i,11};
            matrix12(13,5)=table12{i,32};
            matrix12(5,13)=table12{i,32};
            matrix12(13,6)=table12{i,25};
            matrix12(6,13)=table12{i,25};
            matrix12(13,7)=table12{i,39};
            matrix12(7,13)=table12{i,39};
            matrix12(14,1)=table12{i,48};
            matrix12(1,14)=table12{i,48};
            matrix12(14,2)=table12{i,6};
            matrix12(2,14)=table12{i,6};
            matrix12(14,3)=table12{i,20};
            matrix12(3,14)=table12{i,20};
            matrix12(14,4)=table12{i,13};
            matrix12(4,14)=table12{i,13};
            matrix12(14,5)=table12{i,34};
            matrix12(5,14)=table12{i,34};
            matrix12(14,6)=table12{i,27};
            matrix12(6,14)=table12{i,27};
            matrix12(14,7)=table12{i,41};
            matrix12(7,14)=table12{i,41};
        catch exception
            warning('error')
        end
        
        left_right_ad = ['/media/mabbottlab/temp_backup/Tommy/DTIs-analysis/' + string(folders(i+6).name) + '/' + string(folders(i+6).name) + '_stats/LEFT-RIGHT/AD'];
        cd (left_right_ad)
        files13= struct2table(dir('*.txt'));
        for a = 1:height(files13)
            R13= readtable(files13{a,1}{1});
            table13{i,a}= R13{1,1};
        end
       
        try
            matrix13(8,1)=table13{i,49};
            matrix13(1,8)=table13{i,49};
            matrix13(8,2)=table13{i,7};
            matrix13(2,8)=table13{i,7};
            matrix13(8,3)=table13{i,21};
            matrix13(3,8)=table13{i,21};
            matrix13(8,4)=table13{i,14};
            matrix13(4,8)=table13{i,14};
            matrix13(8,5)=table13{i,35};
            matrix13(5,8)=table13{i,35};
            matrix13(8,6)=table13{i,28};
            matrix13(6,8)=table13{i,28};
            matrix13(8,7)=table13{i,42};
            matrix13(7,8)=table13{i,42};
            matrix13(9,1)=table13{i,43};
            matrix13(1,9)=table13{i,43};
            matrix13(9,2)=table13{i,1};
            matrix13(2,9)=table13{i,1};
            matrix13(9,3)=table13{i,15};
            matrix13(3,9)=table13{i,15};
            matrix13(9,4)=table13{i,8};
            matrix13(4,9)=table13{i,8};
            matrix13(9,5)=table13{i,29};
            matrix13(5,9)=table13{i,29};
            matrix13(9,6)=table13{i,22};
            matrix13(6,9)=table13{i,22};
            matrix13(9,7)=table13{i,36};
            matrix13(7,9)=table13{i,36};
            matrix13(10,1)=table13{i,45};
            matrix13(1,10)=table13{i,45};
            matrix13(10,2)=table13{i,3};
            matrix13(2,10)=table13{i,3};
            matrix13(10,3)=table13{i,17};
            matrix13(3,10)=table13{i,17};
            matrix13(10,4)=table13{i,10};
            matrix13(4,10)=table13{i,10};
            matrix13(10,5)=table13{i,31};
            matrix13(5,10)=table13{i,31};
            matrix13(10,6)=table13{i,24};
            matrix13(6,10)=table13{i,24};
            matrix13(10,7)=table13{i,38};
            matrix13(7,10)=table13{i,38};
            matrix13(11,1)=table13{i,44};
            matrix13(1,11)=table13{i,44};
            matrix13(11,2)=table13{i,2};
            matrix13(2,11)=table13{i,2};
            matrix13(11,3)=table13{i,16};
            matrix13(3,11)=table13{i,16};
            matrix13(11,4)=table13{i,9};
            matrix13(4,11)=table13{i,9};
            matrix13(11,5)=table13{i,30};
            matrix13(5,11)=table13{i,30};
            matrix13(11,6)=table13{i,23};
            matrix13(6,11)=table13{i,23};
            matrix13(11,7)=table13{i,37};
            matrix13(7,11)=table13{i,37};
            matrix13(12,1)=table13{i,47};
            matrix13(1,12)=table13{i,47};
            matrix13(12,2)=table13{i,5};
            matrix13(2,12)=table13{i,5};
            matrix13(12,3)=table13{i,19};
            matrix13(3,12)=table13{i,19};
            matrix13(12,4)=table13{i,12};
            matrix13(4,12)=table13{i,12};
            matrix13(12,5)=table13{i,33};
            matrix13(5,12)=table13{i,33};
            matrix13(12,6)=table13{i,26};
            matrix13(6,12)=table13{i,26};
            matrix13(12,7)=table13{i,40};
            matrix13(7,12)=table13{i,40};
            matrix13(13,1)=table13{i,46};
            matrix13(1,13)=table13{i,46};
            matrix13(13,2)=table13{i,4};
            matrix13(2,13)=table13{i,4};
            matrix13(13,3)=table13{i,18};
            matrix13(3,13)=table13{i,18};
            matrix13(13,4)=table13{i,11};
            matrix13(4,13)=table13{i,11};
            matrix13(13,5)=table13{i,32};
            matrix13(5,13)=table13{i,32};
            matrix13(13,6)=table13{i,25};
            matrix13(6,13)=table13{i,25};
            matrix13(13,7)=table13{i,39};
            matrix13(7,13)=table13{i,39};
            matrix13(14,1)=table13{i,48};
            matrix13(1,14)=table13{i,48};
            matrix13(14,2)=table13{i,6};
            matrix13(2,14)=table13{i,6};
            matrix13(14,3)=table13{i,20};
            matrix13(3,14)=table13{i,20};
            matrix13(14,4)=table13{i,13};
            matrix13(4,14)=table13{i,13};
            matrix13(14,5)=table13{i,34};
            matrix13(5,14)=table13{i,34};
            matrix13(14,6)=table13{i,27};
            matrix13(6,14)=table13{i,27};
            matrix13(14,7)=table13{i,41};
            matrix13(7,14)=table13{i,41};
        catch exception
            warning('error')
        end
        
        left_right_rd = ['/media/mabbottlab/temp_backup/Tommy/DTIs-analysis/' + string(folders(i+6).name) + '/' + string(folders(i+6).name) + '_stats/LEFT-RIGHT/RD'];
        cd (left_right_rd)
        files14= struct2table(dir('*.txt'));
        for a = 1:height(files14)
            R14= readtable(files14{a,1}{1});
            table14{i,a}= R14{1,1};
        end
        
        try
            matrix14(8,1)=table14{i,49};
            matrix14(1,8)=table14{i,49};
            matrix14(8,2)=table14{i,7};
            matrix14(2,8)=table14{i,7};
            matrix14(8,3)=table14{i,21};
            matrix14(3,8)=table14{i,21};
            matrix14(8,4)=table14{i,14};
            matrix14(4,8)=table14{i,14};
            matrix14(8,5)=table14{i,35};
            matrix14(5,8)=table14{i,35};
            matrix14(8,6)=table14{i,28};
            matrix14(6,8)=table14{i,28};
            matrix14(8,7)=table14{i,42};
            matrix14(7,8)=table14{i,42};
            matrix14(9,1)=table14{i,43};
            matrix14(1,9)=table14{i,43};
            matrix14(9,2)=table14{i,1};
            matrix14(2,9)=table14{i,1};
            matrix14(9,3)=table14{i,15};
            matrix14(3,9)=table14{i,15};
            matrix14(9,4)=table14{i,8};
            matrix14(4,9)=table14{i,8};
            matrix14(9,5)=table14{i,29};
            matrix14(5,9)=table14{i,29};
            matrix14(9,6)=table14{i,22};
            matrix14(6,9)=table14{i,22};
            matrix14(9,7)=table14{i,36};
            matrix14(7,9)=table14{i,36};
            matrix14(10,1)=table14{i,45};
            matrix14(1,10)=table14{i,45};
            matrix14(10,2)=table14{i,3};
            matrix14(2,10)=table14{i,3};
            matrix14(10,3)=table14{i,17};
            matrix14(3,10)=table14{i,17};
            matrix14(10,4)=table14{i,10};
            matrix14(4,10)=table14{i,10};
            matrix14(10,5)=table14{i,31};
            matrix14(5,10)=table14{i,31};
            matrix14(10,6)=table14{i,24};
            matrix14(6,10)=table14{i,24};
            matrix14(10,7)=table14{i,38};
            matrix14(7,10)=table14{i,38};
            matrix14(11,1)=table14{i,44};
            matrix14(1,11)=table14{i,44};
            matrix14(11,2)=table14{i,2};
            matrix14(2,11)=table14{i,2};
            matrix14(11,3)=table14{i,16};
            matrix14(3,11)=table14{i,16};
            matrix14(11,4)=table14{i,9};
            matrix14(4,11)=table14{i,9};
            matrix14(11,5)=table14{i,30};
            matrix14(5,11)=table14{i,30};
            matrix14(11,6)=table14{i,23};
            matrix14(6,11)=table14{i,23};
            matrix14(11,7)=table14{i,37};
            matrix14(7,11)=table14{i,37};
            matrix14(12,1)=table14{i,47};
            matrix14(1,12)=table14{i,47};
            matrix14(12,2)=table14{i,5};
            matrix14(2,12)=table14{i,5};
            matrix14(12,3)=table14{i,19};
            matrix14(3,12)=table14{i,19};
            matrix14(12,4)=table14{i,12};
            matrix14(4,12)=table14{i,12};
            matrix14(12,5)=table14{i,33};
            matrix14(5,12)=table14{i,33};
            matrix14(12,6)=table14{i,26};
            matrix14(6,12)=table14{i,26};
            matrix14(12,7)=table14{i,40};
            matrix14(7,12)=table14{i,40};
            matrix14(13,1)=table14{i,46};
            matrix14(1,13)=table14{i,46};
            matrix14(13,2)=table14{i,4};
            matrix14(2,13)=table14{i,4};
            matrix14(13,3)=table14{i,18};
            matrix14(3,13)=table14{i,18};
            matrix14(13,4)=table14{i,11};
            matrix14(4,13)=table14{i,11};
            matrix14(13,5)=table14{i,32};
            matrix14(5,13)=table14{i,32};
            matrix14(13,6)=table14{i,25};
            matrix14(6,13)=table14{i,25};
            matrix14(13,7)=table14{i,39};
            matrix14(7,13)=table14{i,39};
            matrix14(14,1)=table14{i,48};
            matrix14(1,14)=table14{i,48};
            matrix14(14,2)=table14{i,6};
            matrix14(2,14)=table14{i,6};
            matrix14(14,3)=table14{i,20};
            matrix14(3,14)=table14{i,20};
            matrix14(14,4)=table14{i,13};
            matrix14(4,14)=table14{i,13};
            matrix14(14,5)=table14{i,34};
            matrix14(5,14)=table14{i,34};
            matrix14(14,6)=table14{i,27};
            matrix14(6,14)=table14{i,27};
            matrix14(14,7)=table14{i,41};
            matrix14(7,14)=table14{i,41};
        catch exception
            warning('error')
        end
        
        left_right_streamline = ['/media/mabbottlab/temp_backup/Tommy/DTIs-analysis/' + string(folders(i+6).name) + '/' + string(folders(i+6).name) + '_stats/LEFT-RIGHT/STREAMLINES'];
        cd (left_right_streamline)
        files15= struct2table(dir('*.txt'));
        for a = 1:height(files15)
            R15= readtable(files15{a,1}{1});
            table15{i,a}= R15{1,1};
        end
        
        try
            matrix15(8,1)=table15{i,49};
            matrix15(1,8)=table15{i,49};
            matrix15(8,2)=table15{i,7};
            matrix15(2,8)=table15{i,7};
            matrix15(8,3)=table15{i,21};
            matrix15(3,8)=table15{i,21};
            matrix15(8,4)=table15{i,14};
            matrix15(4,8)=table15{i,14};
            matrix15(8,5)=table15{i,35};
            matrix15(5,8)=table15{i,35};
            matrix15(8,6)=table15{i,28};
            matrix15(6,8)=table15{i,28};
            matrix15(8,7)=table15{i,42};
            matrix15(7,8)=table15{i,42};
            matrix15(9,1)=table15{i,43};
            matrix15(1,9)=table15{i,43};
            matrix15(9,2)=table15{i,1};
            matrix15(2,9)=table15{i,1};
            matrix15(9,3)=table15{i,15};
            matrix15(3,9)=table15{i,15};
            matrix15(9,4)=table15{i,8};
            matrix15(4,9)=table15{i,8};
            matrix15(9,5)=table15{i,29};
            matrix15(5,9)=table15{i,29};
            matrix15(9,6)=table15{i,22};
            matrix15(6,9)=table15{i,22};
            matrix15(9,7)=table15{i,36};
            matrix15(7,9)=table15{i,36};
            matrix15(10,1)=table15{i,45};
            matrix15(1,10)=table15{i,45};
            matrix15(10,2)=table15{i,3};
            matrix15(2,10)=table15{i,3};
            matrix15(10,3)=table15{i,17};
            matrix15(3,10)=table15{i,17};
            matrix15(10,4)=table15{i,10};
            matrix15(4,10)=table15{i,10};
            matrix15(10,5)=table15{i,31};
            matrix15(5,10)=table15{i,31};
            matrix15(10,6)=table15{i,24};
            matrix15(6,10)=table15{i,24};
            matrix15(10,7)=table15{i,38};
            matrix15(7,10)=table15{i,38};
            matrix15(11,1)=table15{i,44};
            matrix15(1,11)=table15{i,44};
            matrix15(11,2)=table15{i,2};
            matrix15(2,11)=table15{i,2};
            matrix15(11,3)=table15{i,16};
            matrix15(3,11)=table15{i,16};
            matrix15(11,4)=table15{i,9};
            matrix15(4,11)=table15{i,9};
            matrix15(11,5)=table15{i,30};
            matrix15(5,11)=table15{i,30};
            matrix15(11,6)=table15{i,23};
            matrix15(6,11)=table15{i,23};
            matrix15(11,7)=table15{i,37};
            matrix15(7,11)=table15{i,37};
            matrix15(12,1)=table15{i,47};
            matrix15(1,12)=table15{i,47};
            matrix15(12,2)=table15{i,5};
            matrix15(2,12)=table15{i,5};
            matrix15(12,3)=table15{i,19};
            matrix15(3,12)=table15{i,19};
            matrix15(12,4)=table15{i,12};
            matrix15(4,12)=table15{i,12};
            matrix15(12,5)=table15{i,33};
            matrix15(5,12)=table15{i,33};
            matrix15(12,6)=table15{i,26};
            matrix15(6,12)=table15{i,26};
            matrix15(12,7)=table15{i,40};
            matrix15(7,12)=table15{i,40};
            matrix15(13,1)=table15{i,46};
            matrix15(1,13)=table15{i,46};
            matrix15(13,2)=table15{i,4};
            matrix15(2,13)=table15{i,4};
            matrix15(13,3)=table15{i,18};
            matrix15(3,13)=table15{i,18};
            matrix15(13,4)=table15{i,11};
            matrix15(4,13)=table15{i,11};
            matrix15(13,5)=table15{i,32};
            matrix15(5,13)=table15{i,32};
            matrix15(13,6)=table15{i,25};
            matrix15(6,13)=table15{i,25};
            matrix15(13,7)=table15{i,39};
            matrix15(7,13)=table15{i,39};
            matrix15(14,1)=table15{i,48};
            matrix15(1,14)=table15{i,48};
            matrix15(14,2)=table15{i,6};
            matrix15(2,14)=table15{i,6};
            matrix15(14,3)=table15{i,20};
            matrix15(3,14)=table15{i,20};
            matrix15(14,4)=table15{i,13};
            matrix15(4,14)=table15{i,13};
            matrix15(14,5)=table15{i,34};
            matrix15(5,14)=table15{i,34};
            matrix15(14,6)=table15{i,27};
            matrix15(6,14)=table15{i,27};
            matrix15(14,7)=table15{i,41};
            matrix15(7,14)=table15{i,41};
        catch exception
            warning('error')
        end
        
        catmatrix1 = cat(3,catmatrix1,matrix1);
        catmatrix2 = cat(3,catmatrix2,matrix2);
        catmatrix3 = cat(3,catmatrix3,matrix3);
        catmatrix4 = cat(3,catmatrix4,matrix4);
        catmatrix5 = cat(3,catmatrix5,matrix5);
        catmatrix6 = cat(3,catmatrix6,matrix6);
        catmatrix7 = cat(3,catmatrix7,matrix7);
        catmatrix8 = cat(3,catmatrix8,matrix8);
        catmatrix9 = cat(3,catmatrix9,matrix9);
        catmatrix10 = cat(3, catmatrix10,matrix10);
        catmatrix11 = cat(3, catmatrix11,matrix11);
        catmatrix12 = cat(3, catmatrix12,matrix12);
        catmatrix13 = cat(3, catmatrix13,matrix13);
        catmatrix14 = cat(3, catmatrix14,matrix14);
        catmatrix15 = cat(3, catmatrix15,matrix15);
    catch exception
        %
    end
end

    %spreadsheets
    location = '/media/mabbottlab/temp_backup/Tommy/stats/matlab_test';
    cd (location)
    writecell(table1, 'left_fa.xlsx')
    writecell(table2, 'left_md.xlsx')
    writecell(table3, 'left_ad.xlsx')
    writecell(table4, 'left_rd.xlsx')
    writecell(table9, 'left_streamline.xlsx')
    writecell(table5, 'right_fa.xlsx')
    writecell(table6, 'right_md.xlsx')
    writecell(table7, 'right_ad.xlsx')
    writecell(table8, 'right_rd.xlsx')
    writecell(table10, 'right_streamline.xlsx')
    writecell(table11, 'left-right_fa.xlsx')
    writecell(table12, 'left-right_md.xlsx')
    writecell(table13, 'left-right_ad.xlsx')
    writecell(table14, 'left-right_rd.xlsx')
    writecell(table15, 'left-right_streamline.xlsx')
    
    %matrices
    %Save these as .mat files from the workspace instead of as xlsx below
    writematrix(catmatrix1, 'left_fa_matrix.xlsx')
    writematrix(catmatrix2, 'left_md_matrix.xlsx')
    writematrix(catmatrix3, 'left_ad_matrix.xlsx')
    writematrix(catmatrix4, 'left_rd_matrix.xlsx')
    writematrix(catmatrix9, 'left_streamline_matrix.xlsx')
    writematrix(catmatrix5, 'right_fa_matrix.xlsx')
    writematrix(catmatrix6, 'right_md_matrix.xlsx')
    writematrix(catmatrix7, 'right_ad_matrix.xlsx')
    writematrix(catmatrix8, 'right_rd_matrix.xlsx')
    writematrix(catmatrix10, 'right_streamline_matrix.xlsx')
    writematrix(catmatrix11, 'left-right_fa_matrix.xlsx')
    writematrix(catmatrix12, 'left-right_md_matrix.xlsx')
    writematrix(catmatrix13, 'left-right_ad_matrix.xlsx')
    writematrix(catmatrix14, 'left-right_rd_matrix.xlsx')
    writematrix(catmatrix15, 'left-right_streamline_matrix.xlsx')
    
    