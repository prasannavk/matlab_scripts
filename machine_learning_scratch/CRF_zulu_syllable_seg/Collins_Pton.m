function [wt_final] = Collins_Pton(X,Y,tags,J,frac)
%%% Input: X is the entire training set - probably sent as a cell
%          Y is the set of labels for the training set- again sent as a
%          cell
%          F_vect_vals should be function pointers of J feature functions
%          tags is possible set of tags
%J = size(f_vals,2);
F_sum = zeros(J,1);
F_hat_sum =zeros(J,1);
wt = zeros(J,1);
alpha = 0.05;
epochs = 3;
for e = 1:epochs
    F_sum = zeros(J,1);
    F_hat_sum =zeros(J,1);
    for i = 1 : size(X,1)
%     for i = 1 : frac
        %%% Create a random and wrong tag sequence y_hat
        y_hat = Argmax(X{i},wt,tags);
        y_hat = [2,y_hat,3];
        %%% Get feature function values for y and y_hat for example X(i)
        F = Find_F_vals(X{i},Y{i},J);        
        F_hat = Find_F_vals_hat(X{i},y_hat,J);
        %%% positive update for the right tag sequence
        wt = wt + alpha*F;
        %%% negative update for y_hat
        wt = wt - alpha*F_hat;
        F_sum = F_sum+F;
        F_hat_sum = F_hat_sum + F_hat;
        diff = F_hat_sum - F_sum;
    end
    sum (abs(diff))
end
wt_final = wt;



