
% DbsDwnSmpl_factor=10;
% FinalMat1=[];
% for i=0:9
%     clear FullMat;
%     i
%     fname=['dotProd_',int2str(i),'.mat'];
%     load(fname);
%     [m1,n1]=size(FullMat);%tempMat is loaded by the fname
%     idx_SampMat1=randsample(1:m1,ceil(m1/DbsDwnSmpl_factor));
%     SampMat1 = FullMat(idx_SampMat1,1:257);
%     FinalMat1=vertcat(FinalMat1,SampMat1);
% end
% save(['dotProd_PosSmpls_SubSmpl10','.mat'],'FinalMat1');
% disp('File saved...Now doing the regression');



clear train_reg;

for i=1:2
    i
    if i==1
        load (['dotProd_NegSmpls_SubSmpl10','.mat']);
        idx=randsample(1:size(FullMat,1),18000);
        train_reg(1:18000,:)=FullMat(idx,:);
        clear FullMat;
        clear idx;
    else
        load(['dotProd_PosSmpls_SubSmpl10','.mat']);
        idx=randsample(1:size(FinalMat1,1),10000);
        train_reg(18001:28000,:)=FinalMat1(idx,:);
        clear FinalMat1;
    end
   
end
disp('Variable in workspace...Now doing the regression');
%coeff=regress(train(:,1),train(:,2:257));
reg_param=0;%regularization parameter

train_reg(28001:28256,1:257)=[zeros(256,1) reg_param*eye(256)];
train_reg(:,258)=ones(size(train_reg,1),1);
%b_0 comes in the last column
coeff=train_reg(:,2:258)\train_reg(:,1);

save('coeff_file_pt4reg3.mat','coeff')
    