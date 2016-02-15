function [wt_final] = SGA_fb(X,Y,tags,J,frac)
%%% Input: X is the entire training set - probably sent as a cell
%          Y is the set of labels for the training set- again sent as a
%          cell
%          F_vect_vals should be function pointers of J feature functions
%          tags is possible set of tags
%J = size(f_vals,2);
F_sum = zeros(J,1);
F_hat_sum =zeros(J,1);
wt = rand(J,1);
alpha = 0.01;
epochs = 3;
for e = 1:epochs
    F_sum = zeros(J,1);
    F_hat_sum =zeros(J,1);
    e
    for i = 1 : size(X,1)
%     for i = 1 : frac
        %%% Create a random and wrong tag sequence y_hat
        %%% Get feature function values for y and y_hat for example X(i)
        E = foward_backward(X{i},wt,tags,J);
        F = Find_F_vals(X{i},Y{i},J);
        wt = wt + alpha*(F-E); 
        F_sum = F_sum+F;
        F_hat_sum = F_hat_sum + E;
        diff = F_hat_sum - F_sum;
    end
    sum (abs(diff))    
end
wt_final = wt;