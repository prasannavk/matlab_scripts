function [x, y]= hclick(img,n)
%HAND-CLICKED POINT COORDINATES
%hclick returns the x and y coordinates of the points clicked on the input
%image.
% It also plots and labels them on the image
%Use normal button clicks to show point coordinates
if nargin == 1
n=10; %default number of points
end
h=figure
imshow(img);
hold on;
i=1;
x=zeros(n,1);
y=zeros(n,1);
while (i<=n)
    [x(i) y(i)]=ginput(1);
    plot(x(i),y(i),'+');
    s=sprintf(' (%d,%d)',uint8(x(i)),uint8(y(i)));
    text(x(i),y(i), s);
    i=i+1;
end
hold off;