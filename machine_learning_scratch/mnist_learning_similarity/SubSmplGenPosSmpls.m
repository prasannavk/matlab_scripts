
DbsDwnSmpl_factor=10;
FinalMat1=[];
for i=0:9
    clear FullMat;
    i
    fname=['dotProd_',int2str(i),'.mat'];
    load(fname);
    [m1,n1]=size(FullMat);%tempMat is loaded by the fname
    idx_SampMat1=randsample(1:m1,ceil(m1/DbsDwnSmpl_factor));
    SampMat1 = FullMat(idx_SampMat1,1:257);
    FinalMat1=vertcat(FinalMat1,SampMat1);
end
save(['dotProd_PosSmpls_SubSmpl10','.mat'],'FinalMat1');
disp('File saved...Now doing the regression');
load (['dotProd_PosSmpls_SubSmpl10','.mat']);
load(['dotProd_NegSmpls_SubSmpl10','.mat']);

coeff=regress([FullMat(:,1) FinalMat1(:,1)],[FullMat(:,2:257) FinalMat1(:,2:257)]);
save('coeff_file.mat','coeff')

    