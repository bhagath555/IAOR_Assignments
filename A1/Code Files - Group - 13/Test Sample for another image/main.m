function main()
    % Task 1: Image Enhancement
    color_image = imread('img.jpg');
    gray_image = rgb2gray(color_image);
    subplot(1, 5, 1);
    imshow(gray_image);
    title('Original Image');
    min_val = min(gray_image(:));
    max_val = max(gray_image(:));
    enhanced_image = uint8((gray_image - min_val) * (255 / (max_val - min_val)));
    subplot(1, 5, 2);
    imshow(enhanced_image);
    title('Enhanced Image');

    % Task 2: Binarization
    threshold = graythresh(enhanced_image);
    binary_mask = im2bw(enhanced_image, 0.3);
    subplot(1, 5, 3);
    imshow(binary_mask);
    title('Binary Mask');

    % Task 3: Morphological Operators
    SE_opening = strel('disk', 10);
    binary_mask_opened = imopen(binary_mask, SE_opening);
    SE_closing = strel('disk', 4);
    binary_mask_closed = imclose(binary_mask_opened, SE_closing);
    subplot(1, 5, 4);
    imshow(binary_mask_closed);
    title('Filtered Binary Mask');
    overlay_image_final = imoverlay(enhanced_image, binary_mask_closed, [1, 1, 1]);
    subplot(1, 5, 5);
    imshow(overlay_image_final);
    title('Overlay of Enhanced Image and Filtered Mask');
end