% clear;
% K = 5;
% n = 6205;
% 
% 
% %Train = full(classic400);
% %[m,n]= size(Train);
% 
% SparseTrain=dlmread('train.data',' ');
% SparseTest =dlmread('test.data',' ');
% %%HARD CODING THE LIMITS FOR THE 5 topics constraint
% SparseTrain=SparseTrain(1:297059,:);%find(SparseTest(:,1)==1873,1,'last') %1873 is the number of the last topic 5 word
% SparseTest=SparseTest(1:213216,:);%find(SparseTrain(:,1)==2795,1,'last')  %2795 is the number of the last topic 5 word
% reduced_vocab=unique(SparseTrain(:,2));

fid = fopen('vocabulary.txt');
vocab=textscan(fid,'%s'); 
fclose(fid);
m =11269;
%n=length(vocab{1});%vocab{1} is the cell that contains all the words in the vocabulary
n=length(reduced_vocab);
alpha(1,:) = 0.2*ones(1,K);
beta(1,:)  = 0.33*ones(1,n);

alpha(2,:) = 0.3*ones(1,K); 
beta(2,:)  = 0.4*ones(1,n);

alpha(3,:) = 0.4*ones(1,K); 
beta(3,:)  = 0.8*ones(1,n);

% NO NEED AS SEPRATE TEST AND TRAIN ARE IN THE DATA SET
% held_idx=randsample(400,100);
% train_idx=setdiff([1:400],held_idx);
load 'vecsNews20.mat';
%SparseTrain=SparseTrain(1:100,:);%find(SparseTest(:,1)==1873,1,'last') %1873 is the number of the last topic 5 word
%SparseTest=SparseTest(1:100,:);%find(SparseTrain(:,1)==2795,1,'last')  %2795 is the number of the last topic 5 word
for i=1:size(alpha,1)
    a=alpha(i,:);
    b=beta(i,:);
    [covPerEpoch lclPerEpoch lcl_held, F_measure_train,F_measure_test] = GibbsSampl_alpha_beta(a,b,i,wvec,mvec,wvec_held,mvec_held,reduced_vocab);
    str=strcat('run',num2str(i));
    save(str, 'a','b','covPerEpoch','lclPerEpoch','lcl_held','F_measure_train','F_measure_test');
end
