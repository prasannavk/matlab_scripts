function [covPerEpoch lclPerEpoch lcl_held, F_measure_train, F_measure_held] = GibbsSampl_alpha_beta(alpha,beta,iter, wvec,mvec,wvec_held,mvec_held,reduced_vocab)
%SparseTrain=dlmread('train.data',' ');
%SparseTest =dlmread('test.data',' ');

% ??? HOW TO GET THE TRUE LABELS ***********
% true_label_held = truelabels(held_idx);
% true_label_train = truelabels(train_idx);

%[m,n]=size(Train);
%fid = fopen('vocabulary.txt');
%vocab=textscan(fid,'%s'); %%% NOT READING CORRECT
%fclose(fid);
m =2795;
%n=length(vocab{1});
n=length(reduced_vocab);

%wvec=[];%contains the indexes of the words in the vocabulary
zvec=[];%contains the topic corresponding to wvec
zvec_mod=[];
%mvec=[];%contains the document number of each word
% for i=1:floor(size(SparseTrain,1)) %%HUNDRED TIMES DOWN SAMPLED
%     i
%     wvec= [wvec , repmat(SparseTrain(i,2),1,SparseTrain(i,3))];
%     mvec=[mvec,repmat(SparseTrain(i,1),1,SparseTrain(i,3))];
% end

%% wvec and mvec for Held Out
%[m_held,n_held]=size(SparseTest);
m_held=1873;
n_held=n;
%wvec_held=[];%contains the indexes of the words in the vocabulary
zvec_held=[];%contains the topic corresponding to wvec
%mvec_held=[];%contains the document number of each word
% for i=1:floor(size(SparseTest,1)) %%HUNDRED TIMES DOWN SAMPLED
%     i
%     wvec_held = [wvec_held,repmat(SparseTest(i,2),1,SparseTest(i,3))];
%     mvec_held = [mvec_held,repmat(SparseTest(i,1),1,SparseTest(i,3))];
% end
%save('vecsNews20.mat','wvec','mvec','wvec_held','mvec_held');
K=5;%No of categories
zvec=randsample(K,length(wvec),true);
zvec_mod = zvec;
zvec_prev = zvec;

epochs = 50; 
prob = zeros(1,K);

%******covPerEpoch***********
%q = getqs(zvec_mod,wvec,n,K);
%nm = getnms(zvec_mod,n,K,m,mvec);
%save('vec20News_qs_nmsInitial','q','nm');
load('vec20News_qs_nmsInitial');
tic
for e = 1: epochs
smpl=randsample(1:length(zvec),length(zvec));
for i=smpl
    
    q(wvec(i),zvec_mod(i)) = q(wvec(i),zvec_mod(i)) -1 ;
    nm(mvec(i),zvec_mod(i)) = nm(mvec(i),zvec_mod(i)) -1;
    for j=1:K        
        prob(j) = (q(wvec(i),j)+ beta(wvec(i)))*(nm(mvec(i),j) + alpha(j))/sum(q(:,j)+beta(:));

    end
    prev_topic = zvec_mod(i);
    zvec_mod(i) = getbesttopic(prob./sum(prob)); %sum(prob) = Z
    q(wvec(i),zvec_mod(i)) = q(wvec(i),zvec_mod(i)) + 1;
    nm(mvec(i),zvec_mod(i)) = nm(mvec(i),zvec_mod(i)) + 1;
end

%% Convergence Metric
idx   = find(zvec_mod ~= zvec_prev);
zvec_prev=zvec_mod;
covPerEpoch(e) = size(idx,1); % Plot this for Convergence. 

[phis,thetas, derived_labels_train] = get_phisthetas(zvec_mod,mvec,wvec,nm,K,n);
%% LCL Calculations
lclPerEpoch(e) = lcl_func(phis,thetas,mvec,wvec,nm,K,n);
end

%[phis,thetas, derived_labels] = get_phisthetas(zvec_mod,mvec,wvec,nm,K,n);
toc

%% Calculate zvec_held
for i=1:length(wvec_held)
    zvec_held(i)=getbesttopic(phis(wvec_held(i),:)');
end

nm_held = getnms(zvec_held,n_held,K,m_held,mvec_held);

[phis_held,thetas_held, derived_labels_held] = get_phisthetas(zvec_held,mvec_held,wvec_held,nm_held,K,n_held);

lcl_held = lcl_func(phis_held,thetas_held,mvec_held,wvec_held,nm_held,K,n_held);


% Visualization stuff and calculating whatever report asks for
% Highest probability words for each topic are obtained from phis
save('derived_labels','derived_labels_held','true_label_held');

[phis_sorted, sorted_idx] = sort(phis,1,'descend');
topic1 = cell(size(sorted_idx,1),1);
topic2 = cell(size(sorted_idx,1),1);
topic3 = cell(size(sorted_idx,1),1);
for i = 1:size(sorted_idx,1)
topic1{i,1} = classicwordlist{sorted_idx(i,1)};
topic2{i,1} = classicwordlist{sorted_idx(i,2)};
topic3{i,1} = classicwordlist{sorted_idx(i,3)};
end 
save('clusters_final','topic1','topic2','topic3');

% F-measure for reporting--NOTE needs converstion of true labels according
% to how clustering happens. Done inside compare_results. 
%[F_measure_train] = compare_results(derived_labels_train,true_label_train);
%[F_measure_held] = compare_results(derived_labels_held,true_label_held);

end
%Visualization of the topic model based on documents
