%% THIS CODE IS THE WRAPPER MAIN CODE FOR THE FUNCTIONS
% fid = fopen('Zulu01EncodedStart.txt');
% [In] = textscan(fid,'%s %s');
% X = In{1,1};
% Y = In{1,2};
% train = randsample(10040,5020);
% test = setdiff(1:10040,train);
% test_indx = randsample(5020,5020);
% test = test (test_indx);
clc;
clear all;

load('Data_random_Zulu.mat');

%% Initialise number of feature functions
NumF1=26*26;
NumF2=26*26*26;
NumF3=26*26;
NumF4=26*26;
NumF5=26*26;
NumF6=26*26;
NumF7=26*2;
NumF8=26*26*26*26;

Num_FFs = NumF1+NumF2+NumF3+NumF4+NumF5+NumF6+NumF7+NumF8;
J=Num_FFs;



tags = 0:1;
frac = 1000;
best_seq=cell(frac,1);

for run = 1:2
    if run==1
        TrainX = X_train(1:frac);
        TrainY = Y_train(1:frac);
        TestX = X_test(1:frac);
        TestY = Y_test(1:frac);
    else
        TrainX = X_test(1:frac);
        TrainY = Y_test(1:frac);
        TestX = X_train(1:frac);
        TestY = Y_train(1:frac);
        
    end
%% Training
% [wt_final_SGA] = SGA_fb(TrainX,TrainY,tags,J,frac);
[wt_final_col] = Collins_Pton(TrainX,TrainY,tags,J,frac);
save('wt_final_col');
%%  Inference
%%% For each example, generate gi_mats using our wj
%for i = 1:size(X_test,1)
for i = 1:frac
     xbar = TestX{i,:};
     y = TestY{i,:};
     gi_mat=gi(xbar,tags,wt_final_col,J);
%    gi_mat=gi(xbar,tags,wt_final_SGA,J);
     [bst_seq{i,1}]=Viterbi_mine(xbar,gi_mat, tags);
end 
 
 %% Accuracy Measurements
% [letter_col(run), word_col(run)] = accuracy(bst_seq,TestY);
[letter_sga(run), word_sga(run)] = accuracy(bst_seq,TestY);

end


