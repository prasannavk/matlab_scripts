function [OpCoord, hartNorm] = hartley_norm(x, y)
% Performs Hartley Normalization and returns the Hartley normalized
% coordinates and the Normalization matrix

x = reshape(x, numel(x), []);
y = reshape(y, numel(y), []);

sigX = std(x);
sigY = std(y);

figure
plot(x, y, '.r');
hartNorm = [ 1/sigX      0 -mean(x)/sigX;
             0       1/sigY -mean(y)/sigY;
             0           0             1];
OpCoord = hartNorm*[x y ones(length(x), 1)]';
figure
plot(OpCoord(1,:), OpCoord(2, :), '.');