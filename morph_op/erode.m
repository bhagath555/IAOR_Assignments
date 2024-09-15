a = [0, 0, 0, 0, 0, 0, 0, 0;
     0, 0, 0, 0, 0, 0, 0, 0;
     0, 0, 1, 0, 1, 1, 0, 0;
     0, 0, 1, 1, 0, 1, 0, 0;
     0, 0, 1, 0, 1, 1, 0, 0;
     0, 0, 0, 1, 0, 0, 0, 0;
     0, 0, 0, 0, 0, 0, 0, 0;
     0, 0, 0, 0, 0, 0, 0, 0];

% Display the matrix a as an image
imshow(a, 'InitialMagnification', 'fit');

se = [1, 0, 1;
      0, 1, 0;
      1, 0, 0];

open = imerode(a, se);

figure;
% Display the matrix a as an image
imshow(open, 'InitialMagnification', 'fit');