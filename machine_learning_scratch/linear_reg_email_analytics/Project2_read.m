filename = 'HillstromData_NormRealVal_NoemailNewFeat.csv';
data = csvread(filename,1,0,[1,0,21306,37]);
% Code with X is input. Y is label. 
% For y = visit and X features = all except visit, purchase, spend
%% Creating data.
dim = size(data,1);
Bt = zeros(10,38);
P_i = zeros(10,19176);
LCL_test = zeros(2130,1);
lambda = 1; %Parameter for Stochastic Gradient
mu = 0.000001;%Parameter for regularization
thr = 1e-30;
epochs = 7;
for cv = 1:10
[Train, Test] = crossvalind('HoldOut',dim,0.1);
train = find(Train==1);
test = find(Train==0);
X = data(train,1:36);
y = data(train,37);
X(:,37) = X(:,6).*X(:,6);
X(:,37) = (X(:,37)-mean(X(:,37)))/std(X(:,37));

%% Parameters
d = size(X,2) + 1; % Feature size
n = size(X,1); %Number of training examples
X = horzcat(ones(n,1),X);
beta = zeros(d,1);
sum_betai_xi = X*beta;
p_i = logsig(sum_betai_xi);
LCL = 0;

%% Update betas based on the p_i now such that each beta is updated using 1
% example sequentially
for e = 1 : epochs
%   Change lambda here
    lambda = 1/(1 + e);
    for i = 1:n
%         k = randsample(n,1);
%       beta = beta + lambda * (y(i,1)-p_i(i,1)).*X(i,:).';
%       With regularization        
        beta(:,1) = beta(:,1) + lambda * ((y(i,1)-p_i(i,1)).*X(i,:).'-2*mu*beta(:,1));       
        sum_betai_xi = X*beta;
        p_i = logsig(sum_betai_xi);
    
%         LCL_old = LCL;
%         LCL = 0;
%         for s = 1 : size(p_i,1)
%             LCL = LCL + log(p_i(s,1))*y(s,1) + log(1-p_i(s,1))*(1-y(s,1));
%         end
%         LCL
%         diff =LCL - LCL_old
%         if(diff<0.1)
%             break;
%         end
    end
    LCL_old = LCL;
    LCL = 0;
    for s = 1 : size(p_i,1)
        LCL = LCL + log(p_i(s,1))*y(s,1) + log(1-p_i(s,1))*(1-y(s,1));
    end
    LCL
    diff =LCL - LCL_old
    if(abs(diff)<10)
        break;
    end
end
Bt(cv,:) = beta;
P_i(cv,:) = p_i;
disp('cv no over');
cv

%% Verify betas based on the labels. 
sum_betai_xi_test = sum_betai_xi;
p_i_test = logsig(sum_betai_xi_test);
val_predicted = zeros(d,1);
val_expected = zeros(d,1);
for i = 1 : n 
val_predicted = val_predicted + p_i_test(i,1).*X(i,:).';
val_expected = val_expected + y(i,1).*X(i,:).';
end

%% Test on remaining data - for parameters not related to regularization
% [m,n] = size(data);
test_data = horzcat(ones(size(test,1),1),data(test,1:36));
test_data(:,38) = test_data(:,7).*test_data(:,7);
sum_beta_x = test_data(:,1:38)*beta;
y_test(:,1) = logsig(sum_beta_x);
y_test(:,2) = data(test,37);
for k = 1:size(y_test,1)
    LCL_test(k,1) = LCL_test(k,1) + log(y_test(k,1))*y_test(k,2) + log(1-y_test(k,1))*(1-y_test(k,1));
end
end
save('final_nomail_betas and probs','Bt','P_i','y');
%% Use later for optimizing regularization parameter mu

%% Save outputs
