folder_path = 'E:\CSE250 B\Project4\scene_categories\';
path1 = [folder_path,'bedroom'];
path2 = [folder_path,'CALsuburb'];
path3 = [folder_path,'industrial'];
path4 = [folder_path,'MITforest'];
path5 = [folder_path,'MITmountain'];
% path6 = [folderpath,bedroom];
% path7 = [folderpath,bedroom];
% path8 = [folderpath,bedroom];
% path9 = [folderpath,bedroom];
% path10 = [folderpath,bedroom];
% path11 = [folderpath,bedroom];
% path12 = [folderpath,bedroom];
% path13 = [folderpath,bedroom];
% path14 = [folderpath,bedroom];
% path15 = [folderpath,bedroom];

for i = 1 : 216
    upper = [];
    lower = num2str(i);
    upperlen = 4 - length(lower);
    for j = 1:upperlen
    upper = strcat(upper,'0');
    end
    filename = [path1,'\image_',upper,lower,'.jpg'];
   A = imread(filename);
   [m,n,p] = size(A);
   if p==3
       bedroom(1:m,1:n,i) = rgb2gray(A);
   else
   bedroom(1:m,1:n,i) = A;
   end
   clear A;
end

for i = 1 : 241
    upper = [];
    lower = num2str(i);
    upperlen = 4 - length(lower);
    for j = 1:upperlen
    upper = strcat(upper,'0');
    end
    filename = [path2,'\image_',upper,lower,'.jpg'];
   A = imread(filename);
   [m,n,p] = size(A);
   if p==3
       CALsuburb(1:m,1:n,i) = rgb2gray(A);
   else
        CALsuburb(1:m,1:n,i) = A;
   end
   clear A;
end

for i = 1 : 311
    upper = [];
    lower = num2str(i);
    upperlen = 4 - length(lower);
    for j = 1:upperlen
    upper = strcat(upper,'0');
    end
    filename = [path3,'\image_',upper,lower,'.jpg'];
   A = imread(filename);
   [m,n,p] = size(A);
   if p==3
       industrial(1:m,1:n,i) = rgb2gray(A);
   else
       industrial(1:m,1:n,i) = A;
   end
   clear A;
end

for i = 1 : 328
    upper = [];
    lower = num2str(i);
    upperlen = 4 - length(lower);
    for j = 1:upperlen
    upper = strcat(upper,'0');
    end
    filename = [path4,'\image_',upper,lower,'.jpg'];
   A = imread(filename);
   [m,n,p] = size(A);
   if p==3
       MITforest(1:m,1:n,i) = rgb2gray(A);
   else
       MITforest(1:m,1:n,i) = A;
   end
   clear A;
end

for i = 1 : 374
    upper = [];
    lower = num2str(i);
    upperlen = 4 - length(lower);
    for j = 1:upperlen
    upper = strcat(upper,'0');
    end
    filename = [path5,'\image_',upper,lower,'.jpg'];
   A = imread(filename);
   [m,n,p] = size(A);
   if p==3
        MITmountain(1:m,1:n,i) = rgb2gray(A);
   else
       MITmountain(1:m,1:n,i) = A;
   end
   clear A;
end

