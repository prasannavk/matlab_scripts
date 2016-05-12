function []=epipolar_rectification(img1,img2, F, e2, pts1, pts2)
% function that rectifies one of the image (need to figure out which!)

% Step 1: Compute the Fundamental Matrix F for the two views and the
% epipole e_2
% These come in as arguments.


% Step 2: Compute the rectifying transform H_2 for the second view from
% equation (11.29)
% this function needs work!
o=size(img1)./2;
ox = o(2);
oy = o(1);
Gt=eye(3);
%Gt1=Gt;
Gt(1,3)= -o(1); Gt(2,3)=-o(2);

theta = atan((oy - e2(2))/(e2(1) - ox));
%theta=atan(e2(2)/e2(1));
Gr=[ cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1];
G=eye(3);
x_e = e2(1)*cos(theta) - e2(2)*sin(theta) - ox*cos(theta) + oy*sin(theta);
% ex=e2(1)*cos(theta) + e2(2)*sin(theta);
G(3,1)=-1/x_e;
H2=G*Gr*Gt;
%% Finding H
T = e2;
T_hat= skew_symm(e2);
A = [];
b = [];

% why are you working with c1 and c2? Shouldn't you be working with x1 and
% x2?
for i = 1:size(pts2, 2)
  A_curr = skew_symm(pts2(:,i))*T*pts1(:,i)';
  b_curr  = -skew_symm(pts2(:,i))*T_hat*F*pts1(:,i);
  A = vertcat(A, A_curr);
  b = vertcat(b, b_curr);
end
v = A\b;
H = T_hat*F + T*v';
 %%
% H=lsquares(F,c);%performs least squares
H1=H2*H;

[xin yin]= meshgrid(1:size(img1, 2), 1:size(img1, 1));
N1 = size(xin, 1);
N2 = size(xin, 2);
xxin = [xin(:) yin(:) ones(N1*N2, 1)]';
xxout = H1*xxin;
xxout(1,:) = round(xxout(1,:)./xxout(3,:)) + 100;
xxout(2,:) = round(xxout(2,:)./xxout(3,:)) + 150;
I = griddata(xxout(1,:), xxout(2,:), img1(:), xin(:), yin(:));

Iout = reshape(I, N1, N2);
figure
imshow(uint8(Iout));
%%
[xin yin]= meshgrid(1:size(img2, 2), 1:size(img2, 1));
N1 = size(xin, 1);
N2 = size(xin, 2);
xxin = [xin(:) yin(:) ones(N1*N2, 1)]';
xxout = H2*xxin;
xxout(1,:) = round(xxout(1,:)./xxout(3,:)) + 75;
xxout(2,:) = round(xxout(2,:)./xxout(3,:)) + 175;
I = griddata(xxout(1,:), xxout(2,:), img2(:), xin(:), yin(:));

Iout = reshape(I, N1, N2);
figure
imshow(uint8(Iout));