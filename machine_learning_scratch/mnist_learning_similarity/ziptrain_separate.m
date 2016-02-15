%train=dlmread('C:\Users\Prasanna\Courses\winter11\cse250B\hw1\zip.train\zip.train',' ');
%test= dlmread('C:\Users\Prasanna\Courses\winter11\cse250B\hw1\zip.test\zip.test',' ');
% clear train_new;
% 
 i=1;
 [m_tr n_tr]=size(train);

for i=0:9%m_tr
    i
    clear temp_train_new
    comp_vector=repmat(i,[m_tr, 1]);
    coeffs=find(comp_vector==train(1:m_tr,1));
    tempMat=train(coeffs,:);
    fname=['zip_train_',int2str(i),'.mat'];
    save(fname,'tempMat');
end

