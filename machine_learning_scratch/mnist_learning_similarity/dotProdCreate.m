%this script is to get the combinations for +1 samples

for i=0:9
    i
    fname=['zip_test_',int2str(i),'.mat'];
    load(fname);
    [m_tr,n_tr]=size(tempMat);
    FullMat=[];
    
    for j=1:m_tr-1
        compMat=repmat(tempMat(j,:),[m_tr-j, 1]);
        tempMat_subset=tempMat(j+1:m_tr,:);
        final=compMat.*tempMat_subset;
        final(:,1)=1;
        FullMat=vertcat(FullMat,final);
    end
    save(['test_dotProd_',int2str(i),'.mat'],'FullMat');       
end