im = imread('wall.tif');
% top = 1;
% bottom = 300;
% left = 300;
% right = 600;
top = 700;
bottom = 1024;
left = 1;
right = 384;
noiseAnalCrop(im,top,bottom,left,right)

%convert im  from unint16 to double which is in [0, 1]
%use im2double(im)
%

function noise = noiseAnalCrop(im,top,bottom,left,right)
%Accepts RGB image and pixel coordinates of corners of region of interest
%Returns estimate of noise level, as standard deviation divided by mean luminance.
    im = im2double(im);
    crop = im(top:bottom, left:right, :);
    lum = repmat(crop, 1);
    for r = 1:size(lum, 1)
        for c = 1:size(lum, 2)
            lum(r, c) = (lum(r, c, 1) + lum(r, c, 2) + lum(r, c, 3)) / 3;
        end
    end
    lum = lum(:, :, 1);
    std_lum = std(lum(:));
    mean_lum = mean(lum(:));
    noise = std_lum / mean_lum;
end