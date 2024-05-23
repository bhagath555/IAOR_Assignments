function filtered_mask = morphological_operations(binarized)
  binarized = imread('binarized_image.jpg');
  % Define a small kernel for morphological operations
  se = strel('disk', 4);

  % Apply opening followed by closing
  filtered_mask = imopen(binarized, se);
  filtered_mask = imclose(filtered_mask, se);
  imshow(filtered_mask)
  title('Image after opening and closing');
  imwrite(filtered_mask, 'opened_and_closed_image.jpg')

  % Apply overlay
  high_contrast_image = imread('high_contrast_image.jpg');
  closed_image = imread("opened_and_closed_image.jpg");
  overlay_image = imoverlay(high_contrast_image, closed_image, [1,1,1]); 
  imshow(overlay_image);
  title('Overlay of Enhanced Image and Filtered Mask');
end