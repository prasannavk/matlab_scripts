function E = foward_backward(x,wt,tags,J)
%% tags = [0,1]
m = size(tags,2);
n = size(x,2);
%J = size(f_vals,2);

%% Get gis and Mis for this word
gis = gi(x,tags,wt);
% for the sake of beta calculation, there has to be a Mn+1 for
% This base condition can be seen as follows:
%gi+1 = mxm vector for which only last column (stop column) is important
% gis(:,:,n+1) = zeros(m,m);
%  for yiMinus1 = 1:loopY_1%4
%             for yi = 1:2                  
%                 gis(yiMinus1,yi,n+1)=wj*fj_gen(yiMinus1,yi,x,n+1)';
%             end
%     end

Mis = exp(gis);


%% For one position i, alpha is an mx1 vector. Then for the entire word,
%%% alpha is m x n+1 where first column is used for base case 1->0, 2->1
%%% Similarly beta is m x n+1 and its last column is used as base case
%%% n+1->n, n->n-1....
alphas = zeros(n+1,m);
betas = zeros(n+1,m);


%% Calculating alphas and betas
for i = 1:n    
    if i==1
        alphas(i,:) = ones(1,2);
    else       
        alphas(i,:) = alphas(i-1,:)*Mis(:,:,i); 
    end
end

for i = n:-1:1
    if i==n
        betas(i,:) = ones(1,2);
    else    
        betas(i,:) = betas(i+1,:)*Mis(:,:,i+1);
    end
end



%%%Sanity check
Z_alpha = sum(alphas(n,:));
Z_beta = sum(betas(1,:));

%% Getting Qis
Qis = cell(J,n);
F_js = zeros(n,m,m,J); % jth feature tag y' and tag y
for i = 1:n    
    for y_prime = 1:2
        for y = 1:2
            F_js(i,y_prime,y,:) = fj_gen(y_prime,y,x,i);      %fj_gen(yiMinus1,yi,x,n+1)
        end
    end  
end

for i = 1:n
    for j = 1:J
        for y_prime = 1:2
            for y = 1:2
               Qis{j,i}(y_prime,y) = F_js(i,y_prime,y,j)*Mis(y_prime,y,i);
            end
        end
    end
end


%% Getting E finally
E = zeros(J,1);
for j = 1:J
    for i = 1:n
    E(j,1) = E(j,1)+ alphas(i,:)*Qis{j,i}*betas(i,:)';
    end
end
E = E/Z_alpha;
