% This is script where hand selected correspondences are used to recover
% the fundamental matrix and then used to find the epipolar lines.

[x1, y1] = hclick('../blocks1.gif', 8);
[x2, y2] = hclick('../blocks2.gif', 8);

[c1, T1] = hartley_norm(x1, y1);
[c2, T2] = hartley_norm(x2, y2);

chi = zeros(length(x1), 9);
for i = 1: length(x1)
    chi(i, :) = (kron(c1(:, i), c2(:, i)))';
end

%% Find a vector Fs in R^9 of unit length such that norm(chi*Fs) is
%% minimized

[U, S, V] = svd(chi);
Fs = reshape(V(:, 9), 3, 3);
[Uf, Sf, Vf] = svd(Fs);

% setting the least eigenvalue to zero so that we get rank 2
Sf(3, 3) = 0;
F = Uf*Sf*Vf';

% de-normalize
F = T2'*F*T1;

figure;
img1 = double(imread('../blocks1.gif'));
imshow(uint8(img1));
for i = 1:4
    % homogeneous line plotter
    linehom(F'*[x2(i), y2(i), 1]');
end
e1 = cross(F'*[x2(1), y2(1), 1]', F'*[x2(3), y2(3), 1]');
e1 = e1./e1(3);

figure;
img2 = double(imread('../blocks2.gif'));
imshow(uint8(img2));
for i = 1:4
    % homogeneous line plotter
    linehom(F*[x1(i), y1(i), 1]');
end
e2 = cross(F*[x1(1), y1(1), 1]', F*[x1(3), y1(3), 1]');
e2 = e2./e2(3);

% Extra commands for preparing inputs for epipolar rectification
pts1 = (horzcat(x1, y1, ones(8,1)))';
pts2 = (horzcat(x2, y2, ones(8,1)))';


