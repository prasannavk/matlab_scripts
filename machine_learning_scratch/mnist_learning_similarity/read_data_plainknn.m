%train=dlmread('C:\Users\Manish\Desktop\Project1_learnedSimlarity\zip.train\zip.train',' ');
%test=dlmread('C:\Users\Manish\Desktop\Project1_learnedSimlarity\zip.test\zip.test',' ');
%load('trueLabels.mat');
%the first column of train and test is the class label
%train's last dimension is useless -- just 0
%val= knnclassify(vec1, dbf1', group,16,'cosine');
%mapping=getmapping(8,'u2'); 

%Click to exit viewing
%%%Press some keyboard key to cycle images...
% for i=1:size(train,1)
%     k=(reshape(train(i,2:257),16,16))';
%     k=(k+1)/2;
%       H1(i,1:59)=lbp(k,1,8,mapping,'h');
%     %imshow(k)
%     %disp(['The Class label for this image is ' int2str(train(i,1))]);
% end
% 
% for i=1:size(test,1)
%     k=(reshape(test(i,2:257),16,16))';
%     k=(k+1)/2;
%       H2(i,1:59)=lbp(k,1,8,mapping,'h');
%     %imshow(k)
%     %disp(['The Class label for this image is ' int2str(train(i,1))]);
% end

% 
% for i=0:1
%     i
%     fname=['zip_test_',int2str(i),'.mat'];
%     load(fname);
%     [m_tr,n_tr]=size(tempMat);
%      if i==2
%         tempMat(:,1)=1;        
%     end
%     if i==0
%         test=tempMat;
%     else
%         test=vertcat(test,tempMat);
%     end
% end
% 
% for i=0:1
%     i
%     fname=['zip_train_',int2str(i),'.mat'];
%     load(fname);
%     [m_tr,n_tr]=size(tempMat);
%     if i==2
%         tempMat(:,1)=1;        
%     end
%     if i==0
%         train_red=tempMat;
%     else
%         train_red=vertcat(train_red,tempMat);
%     end
%     
% end

val= knnclassify(test(:,2:257), train_red(:,2:257), train_red(:,1),15,'Euclidean','nearest');
%val= knnclassify(H2(:,1:59), H1(:,1:59), train(:,1),10,'Euclidean','nearest');
accuracy=sum(val==test(:,1))/size(test,1);
predLabel=val;
p=find(predLabel==0);
predLabel(p,1)=10;
confMatrix(trueLabels,predLabel,10);
