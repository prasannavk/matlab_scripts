load('classic400.mat');
Train = full(classic400);
[m,n]=size(Train);
wvec=[];%contains the indexes of the words in the vocabulary
zvec=[];%contains the topic corresponding to wvec
zvec_mod=[];
mvec=[];%contains the document number of each word
for i=1 : m % assuming rows are documents
    for j=1:n % assuming columns are different words
        if Train(i,j)==0
            continue;
        end
        wvec= [wvec , repmat(j,1,Train(i,j))];
        mvec=[mvec,repmat(i,1,Train(i,j))];%mvec contains all the document
        %numbers corresponding to the words specified in wvec
    end %construct n_mj
    
end
zvec=randsample(3,length(wvec),true);
zvec_mod = zvec;
K=4;%No of categories
epochs = 50; 
prob = zeros(1,K);
%*******************
%beta = rand(length(zvec));%NEED TO FIND OUT HOW TO EFFECTIVELY 
    %DO THIS%generate alphas
%beta=[1:n]./n;%faaltoo method!!
beta = 0.33*ones(1,n);
%alpha=rand(3);
alpha = 0.2*ones(1,K);
%*****************
q = getqs(zvec_mod,wvec,n,K);
nm = getnms(zvec_mod,n,K,m,mvec);
% [qnevx,qnevy] = find(q==0);
% qdashed = q -1;
% qdashed(qnevx,qnevy) = qdashed(qnevx,qnevy)+1;
% [nnevx,nnevy] = find(nm==0);
% nmdashed=nm-1;
% nmdashed(nnevx,nnevy) = nmdashed(nnevx,nnevy) + 1;
% clear qnevx qnevy nnevx nnevy;

%smpl=randsampl(1:length(zvec),length(zvec));
tic
for e = 1: epochs
smpl=randsample(1:length(zvec),length(zvec));
for i=smpl
    %Take one word..what is its prob of class 1, 2 or 3 
    %we need beta_t for the computation
    %beta_vector is a vector of length K for each word in the vocabulary
    %it is a 
    %i in z_i determines current word without topic w     
    %what document number does this word_i belong to--> given by mvec    
    %calculate qdashed here
%   lower_limit = 0; 
    q(wvec(i),zvec_mod(i)) = q(wvec(i),zvec_mod(i)) -1 ;
    nm(mvec(i),zvec_mod(i)) = nm(mvec(i),zvec_mod(i)) -1;
    for j=1:K        
        prob(j) = (q(wvec(i),j)+ beta(wvec(i)))*(nm(mvec(i),j) + alpha(j))/sum(q(:,j)+beta(:));
%         upper_limit = lower_limit + prob(j);
%         num = rand(1);
%         if (num>lower_limit && num<=upper_limit)
%             zvec_mod(i) = j;
%             break;
%         end
%         lower_limit = prob(j);
    end
    prev_topic = zvec_mod(i);
    zvec_mod(i) = getbesttopic(prob./sum(prob)); %sum(prob) = Z
    q(wvec(i),zvec_mod(i)) = q(wvec(i),zvec_mod(i)) + 1;
    nm(mvec(i),zvec_mod(i)) = nm(mvec(i),zvec_mod(i)) + 1;
end
end
[phis,thetas, derived_labels] = get_phisthetas(zvec_mod,mvec,wvec,nm,K,n);
toc
% Visualization stuff and calculating whatever report asks for
% Highest probability words for each topic are obtained from phis
save('derived_labels','derived_labels','truelabels');

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
[F_measure] = compare_results(derived_labels,truelabels);

%Visualization of the topic model based on documents
