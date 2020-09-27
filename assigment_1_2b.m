im1 = imread('wall.tif');
im2 = imread('wall2.tif');
noise = noiseAnalDiff(im1,im2);

function noise = noiseAnalDiff(im1, im2)
    im1 = im2double(im1);
    im2 = im2double(im2);
    %average the pixels for im1
    for r = 1:size(im1, 1)
        for c = 1:size(im1, 2)
            im1(r, c) = (im1(r, c, 1) + im1(r, c, 2) + im1(r, c, 3)) / 3;
        end
    end
    %average the pixels for im2
    for r = 1:size(im2, 1)
        for c = 1:size(im2, 2)
            im2(r, c) = (im2(r, c, 1) + im2(r, c, 2) + im2(r, c, 3)) / 3;
        end
    end
    im1 = im1(:, :, 1);
    im2 = im2(:, :, 1);
    diff = im1 - im2;
    std_diff  = std(diff(:));
    mean_im1 = mean(im1(:));
    noise = std_diff / mean_im1;
end