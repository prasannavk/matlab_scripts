%load('train_dotProd_NegSmpls_SubSmpl10_0_vs_1')
reg_param=0.4;%%%%%%%
load 'train_dotProd_PosSmpls_SubSmpl10_0_vs_1.mat'
train_reg=[posSampl(1:350000,1:257)];
clear posSampl;
load 'train_dotProd_NegSmpls_SubSmpl10_0_vs_1.mat'
train_reg=vertcat(train_reg,negSampl(1:500000,1:257));
clear negSampl
train_reg=train_reg(200000:800000,:);
[m_t n_t]=size(train_reg);
train_reg(m_t+1:m_t+256,1:257)=[zeros(256,1) reg_param*eye(256)];
train_reg(:,258)=ones(size(train_reg,1),1);
%b_0 comes in the last column
coeff=train_reg(:,2:258)\train_reg(:,1);

save('zero_vs_1_coeff_file_pt1.mat','coeff')