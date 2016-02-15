filename = 'HillstromData_jack_men.csv';
data = csvread(filename,1,0);
% Code with X is input. Y is label. 
% For y = visit and X features = all except visit, purchase, spend
%% Creating fake data for now.
X = data(1:20000,1:34);
y = data(1:20000,35);
%% Parameters
lambda = 0.1;
epochs = 100;
d = size(X,2) + 1; % Feature size
n = size(X,1); %Number of training examples
X = horzcat(ones(n,1),X);
beta = zeros(d,1);
sum_betai_xi = X*beta;
p_i = logsig(sum_betai_xi);


%% Update betas based on the p_i now such that each beta is updated using 1
% example sequentially
for e = 1 : epochs
%     Change lambda here
for i = 1: 2000
beta = beta + lambda * (y(i,1)-p_i(i,1)).*X(i,:).';
sum_betai_xi = X*beta;
p_i = logsig(sum_betai_xi);
end
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

%% Test on remaining data
[m,n] = size(data);
test_data = horzcat(ones((m-20000),1),data(20001:m,1:34));
sum_beta_x = test_data(:,1:35)*beta;
y_test(:,1) = logsig(sum_beta_x);
y_test(:,2) = data(20001:m,35);