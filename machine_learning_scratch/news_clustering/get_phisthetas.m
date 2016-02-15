function [phis,thetas, derived_labels] = get_phisthetas(zvec,mvec,wvec,nm,K,n)
nm_final = getnms(zvec,n,K,size(nm,1),mvec);
qs_final = getqs(zvec,wvec,n,K);
thetas = nm_final./(repmat(sum(nm_final,2),1,K));
q_sum = (repmat(sum(qs_final,2),1,K));
[m,n]=find(q_sum~=0);
phis(m,:) = qs_final(m,:)./q_sum(m,:);
for i = 1:size(nm,1)
    derived_labels(i,1) = find(thetas(i,:)==max(thetas(i,:)),1);
end
