function image_enhancement = contrast_enhancement(image);
    image = imread('input_sat_image.jpg');
    gray_image = rgb2gray(image);
    figure(1);
    imshow(image); title('Starting Image');
    figure(2);
    imhist(gray_image); title('Starting Histogram');
    min_intensity = min(gray_image(:));
    max_intensity = max(gray_image(:));
    image_enhancement = (gray_image - min_intensity) * (255/(max_intensity-min_intensity));
    image_enhancement = uint8(image_enhancement);
    figure(3);
    imhist(image_enhancement); title('Enhanched Histogram');
    figure(4);
    imshow(image_enhancement); title('Enhanced Image');
    imwrite(image_enhancement, 'high_contrast_image.jpg')
end