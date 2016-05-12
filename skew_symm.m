function [ output_mat ] = skew_symm( input_vec )
%SKEW_SYMM makes a skew-symmetric matrix out of a vector
%   x=[a b c]' is a 3*1 vector, and its 3*3 skew symmetric matrix is 
%     X=[0   -c   b ;
%        c    0  -a ;
%       -b    a   0 ];
output_mat = [0 -input_vec(3) input_vec(2);
              input_vec(3) 0 -input_vec(1);
              -input_vec(2) input_vec(1) 0];

end

