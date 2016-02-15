clear all
filename = 'HillstromData_NormAll_men.csv';
data = csvread(filename,1,0,[1,0,21307,18]);
% Code with X is input. Y is label. 
% For y = visit and X features = all except visit, purchase, spend
%% Creating data.
X = data(1:20000,1:18);
y = data(1:20000,19);
%% Parameters
lambda = 0.1; %Parameter for Stochastic Gradient
mu = 0.00000001;%Parameter for regularization
thr = 1e-18;
epochs = 500;
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
    lambda = 1/(9+e);
%     for i = 1:n
        k = randsample(n,1);
%       beta = beta + lambda * (y(i,1)-p_i(i,1)).*X(i,:).';
%       With regularization
        beta = beta + lambda * ((y(k,1)-p_i(k,1)).*X(k,:).'-2*mu*beta);
        sum_betai_xi = X*beta;
        p_i = logsig(sum_betai_xi);
        LCL_old = LCL;
        LCL = 0;
        for s = 1 : size(p_i,1)
            LCL = LCL + log10(p_i(s,1))*y(s,1) + log10(1-p_i(s,1))*(1-y(s,1));
        end
        LCL
        diff =LCL - LCL_old
%     end
end

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
[m,n] = size(data);
test_data = horzcat(ones((m-20000),1),data(20001:m,1:19));
sum_beta_x = test_data(:,1:19)*beta;
y_test(:,1) = logsig(sum_beta_x);
y_test(:,2) = data(20001:m,19);

%% Use later for optimizing regularization parameter mu
%% Save outputs
save('beta_Womens_email.mat','beta');