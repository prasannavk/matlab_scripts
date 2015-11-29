function crnrpts = corner_detect(img, sigma, tau, smoothing_window_size, nms_window_size)
%%
% Sample Usage:
% cpts = corner_detect(imread('bt.001.png'), 1.5, 0.1, 5, 10);
% I = cpts(:, 1);
% J = cpts(:, 2);
% figure, imshow(imread('bt.001.png')), hold on, plot(J, I, 'o'), hold off

%%
% corner_detect is the refactored version of cornerpts
if min(size(img)) == 3
    disp('Converting color image to gray')
    img = rgb2gray(img);
end

H = fspecial('gaussian', [5 5], sigma);
img = imfilter(img,H,'replicate');

img = im2double(img);
img =(img-min(img(:)))/(max(img(:))-min(img(:)));
[m n]=size(img);

[grx, gry] = gradient(img);
halfw=floor(smoothing_window_size/2);
e=ones(m,n)*tau;

for i = 2 + halfw : m - halfw
    for j = 2 + halfw : n-halfw
        grx_subimg = grx(i-halfw:i+halfw,j-halfw:j+halfw);
        gry_subimg = gry(i-halfw:i+halfw,j-halfw:j+halfw);
        
        A = [grx_subimg(:) gry_subimg(:)];
        lambda = eig(A'*A);
        
        if min(lambda) < tau
            e(i, j) = tau;
        elseif lambda(1) >= tau && lambda(2) >= tau
            e(i, j) = min(lambda);
        end
    end
end

crnrpts=[];

half_nms_win = floor(nms_window_size / 2);

% Non-maximal suppression
for i = 2 + half_nms_win : m - half_nms_win
    for j=2 + half_nms_win : n-half_nms_win
        sube=e(i-half_nms_win:i+half_nms_win,...
               j-half_nms_win:j+half_nms_win);
        if max(sube(:))==e(i,j)&& e(i,j)~=tau
            crnrpts=vertcat(crnrpts,[i j]);
        end
    end
end
