
%train=dlmread('C:\Users\Prasanna\Courses\winter11\cse250B\hw1\zip.train\zip.train',' ');
%test=dlmread('C:\Users\Prasanna\Courses\winter11\cse250B\hw1\zip.test\zip.test',' ');
%train1 = train;
%the first column of train and test is the class label
%train's last dimension is useless -- just 0
%val= knnclassify(vec1, dbf1', group,16,'cosine');

%Click to exit viewing
%%%Press some keyboard key to cycle images...
% for i=1:size(train,1)
%     k=(reshape(train(i,2:257),16,16))';
%     k=(k+1)/2;
%     imshow(k)
%     disp(['The Class label for this image is ' int2str(train(i,1))]);
%     w=waitforbuttonpress;
%     if w == 0
%         break;
%     end
%     
% end


% val= knnclassify(test(:,2:257), train(:,2:257), train(:,1),1,'Euclidean');
% accuracy=sum(val==test(:,1))/size(test,1)

%%% Uniform random sampling for cross-validation for k

%%% Divide training
%load(['testdotProd_NegSmpls_SubSmpl10','.mat'])

for i = 1 : 10
train_random = randsample(train1,200);
train_new = train1(train_random);
train1 = find(1:size(train1,1)~= train_random);
val= knnclassify_coeff(train_new(:,2:257), train1(:,2:257), train1(:,1),1,'Euclidean');
accuracy=sum(val==train_new(:,1))/size(train_new,1)
end
%accuracy=92.87%