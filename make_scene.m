% 3D coordinates of original shape
XYZ=[0.7071    1.0000    8.7753
     0.7071   -1.0000    8.7753
    -1.2247   -1.0000    9.2929
    -1.2247    1.0000    9.2929
    -0.7071    1.0000   11.2247
    -0.7071   -1.0000   11.2247
     1.2247   -1.0000   10.7071
     1.2247    1.0000   10.7071
     0.2588    1.0000   10.9659
     0.2588         0   10.9659
    -0.2588         0    9.0341
    -0.2588    1.0000    9.0341
          0    1.0000   10.0000
          0         0   10.0000]';
npts=size(XYZ,2);
X=XYZ(1,:);
Y=XYZ(2,:);
Z=XYZ(3,:);
figure(1)
plot3(X,Y,Z,'.-')
axis('equal');
xlabel('X')
ylabel('Y')
zlabel('Z')
text(X,Y,Z,int2str((1:npts)'))
grid on
axis([-1.5 1.5 -1.5 1.5 0 12])

% projection matrix for left camera:
P1 = [ 1     0     0     0
       0     1     0     0
       0     0     1     0 ];

% projection matrix for right camera:
% T=[-2 0 0]';
% th=10*pi/180; % angle
% w=[0 1 0]'; % axis
P2 = [ 0.9848         0    0.1736   -2.0000
            0    1.0000         0         0
      -0.1736         0    0.9848         0 ];

% compute projections in both cameras:
xy1=P1*[XYZ; ones(1,npts)];
xy2=P2*[XYZ; ones(1,npts)];
xL=xy1(1,:)./xy1(3,:);
yL=xy1(2,:)./xy1(3,:);
xR=xy2(1,:)./xy2(3,:);
yR=xy2(2,:)./xy2(3,:);

figure(2)
plot(xL,yL,'.-')
text(xL,yL,int2str((1:npts)'))
axis('equal');
title('left image')

figure(3)
plot(xR,yR,'.-')
text(xR,yR,int2str((1:npts)'))
axis('equal');
title('right image')
