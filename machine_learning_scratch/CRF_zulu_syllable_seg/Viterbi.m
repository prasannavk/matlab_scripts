function [bst_seq,score]=Viterbi_mine(xbar,gi_mat, tags)
%% Viterbi Algorithm
% Input: Example (xbar)
%        gi s for xbar
%        Set of tags tags
% Output: Best sequence for xbar
%         Value of the Score (if needed)


% for one example, find U(k,u) in order : U(1,u) for all u, U(2,u) for all u and so on.
for k = 1:size(xbar,2)
for u = tags
    if k==1
        if xbar(1,1)==u
        U(1,u+1) = 1;
        else
            U(1,u+1) = 0;
        end
    else
       for v = tags 
           tmp(v+1,1) = U(k-1,v+1) + gi_mat(v+1,u+1,k);
       end
       U(k,u+1) = max(tmp); 
       y(k,:) = find(tmp==max(tmp));
    end
end
end