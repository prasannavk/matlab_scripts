%% Function gi
function [gi_matrix] = gi(x,pos_y,wj,J)
%% gi functions Input
%fjs:Cell vector of all Low level feature functions {@f1 @f2 @f3 ...}.
%x: Input row vector (Zulu Word).
%wj: Trained weight vector
%pos_y: Possible Labels eg. if pos_y ={0,1,Start,Stop}
%example: gi_mat=gi('ecsafd',[0 1 2 3]);
%% gi function output
%gi_matrix(:,:,i) is m*m Matrix for ith possition in the Zulu Word.


%% Get values to be used in gi Calculation
%Number of low level feature functions
n=numel(x);   %Length of Zulu Word.
Card_Y=numel(pos_y);  %Cardinality of Y for {0,1,Start,Stop} it is 4


%% Pre-allocating gi_matrix for speed. 
gi_matrix = zeros(Card_Y,Card_Y,n);

%%Calculating complete gi_Matrix
for i = 1:n
     for yiMinus1 = 1:2%4
            for yi = 1:2                  
                gi_matrix(yiMinus1,yi,i)=wj'*fj_gen(pos_y(yiMinus1),pos_y(yi),x,i)';
            end
    end
end
end
%% 




