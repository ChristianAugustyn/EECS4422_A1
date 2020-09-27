imin = imread('im.jpeg');
top = 2000;
bottom = 3000;
left = 612;
right = 1836;
imout = whiteBalance(imin,top,bottom,left,right);
imshow(imout);

function imout = whiteBalance(imin,top,bottom,left,right)
%Corrects white balance based upon indicated ROI of white standard.
%imin and iout are RGB images.  
    imin = im2double(imin);
    crop = imin(top:bottom, left:right, :);
    %get the luminance image of the cropped form
    lum = repmat(imin, 1);
    for r = 1:size(lum, 1)
        for c = 1:size(lum, 2)
            lum(r, c) = (lum(r, c, 1) + lum(r, c, 2) + lum(r, c, 3)) / 3;
        end
    end
    lum = lum(:, :, 1);
    red = crop(:,:,1);
    green = crop(:,:,2);
    blue = crop(:,:,3);
    mean_r = mean(red(:));
    mean_g = mean(green(:));
    mean_b = mean(blue(:));
    mean_lum = mean(lum(:));
    %apply the avg to each pixel
    new_img = repmat(imin, 1);
    for r = 1:size(new_img, 1)
        for c = 1:size(new_img, 2)
            new_img(r,c,1) = new_img(r,c,1) / mean_r;
            new_img(r,c,2) = new_img(r,c,2) / mean_g;
            new_img(r,c,3) = new_img(r,c,3) / mean_b;
        end
    end
    curr_lum = repmat(new_img, 1);
    for r = 1:size(curr_lum, 1)
        for c = 1:size(curr_lum, 2)
            curr_lum(r, c) = (curr_lum(r,c,1) + curr_lum(r,c,2) + curr_lum(r,c,3)) / 3;
        end
    end
    curr_lum = curr_lum(:,:,1);
    mean_curr_lum = mean(curr_lum(:));
    ratio = mean_lum / mean_curr_lum;
    imout = ratio * new_img;
end