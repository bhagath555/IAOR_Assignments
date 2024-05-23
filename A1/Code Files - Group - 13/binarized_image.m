function binary_mask = binarize_image(image);
  image = imread('high_contrast_image.jpg');
  level = graythresh(image);
  binary_mask = ~im2bw(image,0.288);
  figure(1);
  imshow(binary_mask); title('Binary Mask (Inverted)');
  imwrite(binary_mask, 'binarized_image.jpg')
end