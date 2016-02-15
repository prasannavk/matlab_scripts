function [lcl]=lcl_func(phis,thetas,mvec,wvec,nm,K,n)
lcl=0;
for i=1:length(wvec)
   lcl=lcl+log(thetas(mvec(i),:) *phis(wvec(i),:)');
end
end