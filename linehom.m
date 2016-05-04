function []=linehom(a)
%Plots the line specified in homogeneous coordinates by l
%For eg. l=[a b c] => it plots ax+by+c=0
if nargin == 1
a = a./a(3);
% ensure line in z = 1 plane (not needed??)
if abs(a(1)) > abs(a(2))
% line is more vertical
ylim = get(get(gcf,'CurrentAxes'),'Ylim');
p1 = cross(a, [0 1 0]');p1=p1./p1(3);
p2 = cross(a, [0 -1/ylim(2) 1]');p2=p2./p2(3);
else
% line more horizontal
xlim = get(get(gcf,'CurrentAxes'),'Xlim');
p1 = cross(a, [1 0 0]'); p1=p1./p1(3);
p2 = cross(a, [-1/xlim(2) 0 1]');p2=p2./p2(3);
end
line([p1(1) p2(1)], [p1(2) p2(2)]);
else
error('Bad arguments passed to hline');
end