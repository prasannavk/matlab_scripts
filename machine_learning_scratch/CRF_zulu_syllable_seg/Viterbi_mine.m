function [y,score]=Viterbi_mine(xbar,gi_mat, tags)
%% Viterbi Algorithm
% Input: Example (xbar)
%        gi s for xbar
%        Set of tags tags
% Output: Best sequence for xbar
%         Value of the Score (if needed)


% for one example, find U(k,u) in order : U(1,u) for all u, U(2,u) for all u and so on.
n=length(xbar); %length of x
U=zeros(n+1,length(tags)); % U(0,u)<->U(n,u) for all u
y=zeros(1,n); % Should be same as length of x


k=1;
for v = [0,1] % since v = tags for positions k = 1 to n only, their only possible tags are 0,1
    tags_set =[0,1];
%     tmp=zeros(1,length(tags));
%     % Only when position is k = 1, i.e. when start tag at position 0
%     % matters, tag_set is ranged over 0,1,2,3. For all other cases,
%     % u = 0,1 only. Hence size of tmp has to be (1,4) though only
%     % (1,2) will be in use for k = 2:n
     U(2,v+1) = sum(gi_mat(:,v+1,k));  % this is equivalent to U(k,v)=max over u = 0,1 of {U(k-1,u) + g(u,v)}
end
% m = find(U(2,:)==max(U(2,:)));   %this is argmax. But since matrix indices for matlab start from 1, the actual tag is 1 less
% % this is equivalent to U(k,v)=max over u = 0,1 of {U(k-1,u) + g(u,v)}
% y(k) = m(1,1)-1;
% U(k+1,:)=ones(1,2);
% y(k)=1;
%     
for k = 2:n
    tmp=zeros(2,length(tags));
    for v = [0,1] % since v = tags for positions k = 1 to n only, their only possible tags are 0,1
        tags_set = [0,1];        
        for u = tags_set
            % Only when position is k = 1, i.e. when start tag at position 0
            % matters, tag_set is ranged over 0,1,2,3. For all other cases,
            % u = 0,1 only. Hence size of tmp has to be (1,4) though only
            % (1,2) will be in use for k = 2:n
            tmp(u+1,v+1) = U(k,u+1) + gi_mat(u+1,v+1,k);
        end
        U(k+1,v+1) = max(tmp(:,v+1));  % this is equivalent to U(k,v)=max over u = 0,1 of {U(k-1,u) + g(u,v)}
    end
    m = find(U(k+1,:)==max(U(k+1,:))); 
    tmp_yk_1 = find(tmp(:,m(1))== U(k+1,m(1))); %this is argmax. But since matrix indices for matlab start from 1, the actual tag is 1 less
    y(k-1) = tmp_yk_1(1,1)-1;   % when conflicts occur, for ex, in the beginning, v = 0 and v=1 get same score. Then first one is chosen. i.e. v=0 is assigned
end
y(k) = m(1)-1;
score=U(n+1,y(n)+1);
