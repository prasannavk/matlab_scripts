function F = Find_F_vals_hat(x,y,J)
n = size(x,2);
F = zeros(J,1);
for i = 1:n
fj_temp=fj_gen(y(1,i),y(1,i+1),x,i);
F(:,1) = F(:,1)+ fj_temp';
end