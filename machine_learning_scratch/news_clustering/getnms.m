function nm = getnms(zvec,n,K,m,mvec)
for i=1 : m 
    for k=1:K
        mdoc_idx=find(mvec==i);
        nm(i,k)=length(find(zvec(mdoc_idx)==k));
    end
end