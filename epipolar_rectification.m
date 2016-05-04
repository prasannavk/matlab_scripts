%function [F, e1,e2,corresp]=epipolarCalib(img1,img2)
% function that returns fundamental matrix and the epipo...
% and a matrix containing the correspondences

% this function needs work!
o=size(img1)./2;
Gt=eye(3);
Gt1=Gt;
Gt1(1,3)= o(1); Gt1(2,3)=o(2);
theta=atan(e2(2)/e2(1));
Gr=[ cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1];
G=eye(3);
ex=e2(1)*cos(theta) + e2(2)*sin(theta);
G(3,1)=-1/ex;
H2=G*Gr*Gt;
H=lsquares(F,c);%performs least squares
H1=H2*H;
%%
[xin yin]= meshgrid(1:size(img1, 2), 1:size(img1, 1));
N1 = size(xin, 1);
N2 = size(xin, 2);
xxin = [xin(:) yin(:) ones(N1*N2, 1)]';
xxout = H2*xxin;
xxout(1,:) = round(xxout(1,:)./xxout(3,:));
xxout(2,:) = round(xxout(2,:)./xxout(3,:));
I = griddata(xxout(1,:), xxout(2,:), img1(:), xin(:), yin(:));
Iout = reshape(I, N1, N2);
figure
imshow(uint8(Iout));