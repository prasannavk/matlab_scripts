%function coeff = LearningSimilarity
train=dlmread('C:\Users\Prasanna\Courses\winter11\cse250B\hw1\zip.train\zip.train',' ');
test= dlmread('C:\Users\Prasanna\Courses\winter11\cse250B\hw1\zip.test\zip.test',' ');
% clear train_new;
% 
 i=1;
 [m_tr n_tr]=size(train);

temp_mat=repmat(train(i,1:257),[m_tr-i, 1]);
temp_train_new=temp_mat.*train(i+1:m_tr,1:257);
%matrix containing dot products for each i
temp_train_new(:,1)=(temp_mat(:,1)==train(i+1:m_tr,1))*2-1;
train_new= temp_train_new;

%Database generation
%Extremely slow because of the number of combinations
%maybe we should just sample the inter class combinations and not take all of them
% for us m_tr is around 7000
%I doubt if we can reach 200 after an hour of running time...in any case, save whatever trained onto a mat file as in bottom

%Below is what the code is supposed to be..but because of time constraints I am randomly sampling on the inter class combinations which are anyway huge in number

%for i=2:m_tr
%    temp_mat=repmat(train(i,1:257),[m_tr-i, 1]);
%    temp_train_new=temp_mat.*train(i+1:m_tr,1:257);
%    %matrix containing dot products for each i
%    temp_train_new(:,1)=(temp_mat(:,1)==train(i+1:m_tr,1))*2-1;
%    train_new=vertcat(train_new, temp_train_new);
%    i
%end
for i=2:1000%m_tr
    clear temp_train_new
    comp_vector=repmat(train(i,1),[m_tr-i, 1]);
    temp_train_new(:,1)=(comp_vector==train(i+1:m_tr,1))*2-1;
    
    idx=find(temp_train_new(:,1)==1);
    idx_inter_class=find(temp_train_new(:,1)==-1);
    sampled_idx_inter_class=randsample(idx_inter_class,500);
    buff=train([idx; sampled_idx_inter_class],1:257);
    temp_mat=repmat(train(i,1:257),[size(buff,1), 1]);
    

    similarity_mat=temp_mat.*buff;%%Just 500 of the interclass combinations are selected
    similarity_mat(:,1)=temp_train_new([idx; sampled_idx_inter_class],1);
    %matrix containing dot products for each i
    
    train_new=vertcat(train_new, similarity_mat);
    i
end

coeff=regress(train_new(:,1),train_new(:,2:257));
save('new_data.mat','coeff')

