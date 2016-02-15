% %binary classifier
% 
% %0 vs all
% 
% clear FullMat;
% fname=['dotProd_',int2str(0),'.mat'];
% load(fname);
% posSampl=FullMat;
% 
% DbsDwnSmpl_factor=1;
% FullMat=[];
% for i=0:0
%     i
%     fname=['zip_train_',int2str(i),'.mat'];
%     clear tempMat;
%     load(fname);
%     SampMat1 = tempMat(:,1:257);
%     for j=0:1
%         clear tempMat;
%         if j==i
%             continue;
%         end
%         fname=['zip_train_',int2str(j),'.mat'];
%         load(fname);
%                 
%         [m2,n2]=size(tempMat);%tempMat is loaded by the fname
%         idx_SampMat2=randsample(1:m2,ceil(m2/DbsDwnSmpl_factor));
%         SampMat2 = tempMat(idx_SampMat2,1:257);
%         
%         
%         %get the subsample sizes
%         [m1sub,n1sub]=size(SampMat1);
%         [m2sub,n2sub]=size(SampMat2);
%         %The following loop gets the combinations between the subsampled
%         %matrices SampMat1 and SampMat2
%         
        
        for k=926:m1sub-1
            
            SampMat1_subset=repmat(SampMat1(k,:),[m2sub, 1]);
            SampMat2_subset=SampMat2(1:m2sub,:);%here it is not actually a
            %subset....just full
            final=SampMat1_subset.*SampMat2_subset;
            final(:,1)=-1;
            FullMat=vertcat(FullMat,final);
        end
    
          
 %   end
%end
negSampl=FullMat;

save(['train_dotProd_NegSmpls_SubSmpl10_0_vs_1','.mat'],'negSampl'); 
save(['train_dotProd_NegSmpls_SubSmpl10_0_vs_1','.mat'],'posSampl'); 
