fid = fopen('Zulu01EncodedStart.txt');
[In] = textscan(fid,'%s %s');
X = In{1,1};
Y = In{1,2};