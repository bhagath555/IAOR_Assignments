A = [0, 0, 0, 0, 0, 0, 0;
     0, 0, 0, 0, 0, 0, 0;
     0, 0, 0, 1, 1, 0, 0;
     0, 0, 1, 1, 1, 0, 0;
     0, 0, 1, 1, 0, 0, 0;
     0, 0, 0, 1, 1, 0, 0;
     0, 0, 0, 1, 1, 0, 0;
     0, 0, 1, 1, 1, 0, 0;
     0, 0, 0, 0, 0, 0, 0;
     0, 0, 0, 0, 0, 0, 0];

imshow(A, 'InitialMagnification', 'fit');
se = [1, 1;
      0, 1];

dial = imdilate(A, se);

figure;
imshow(dial, 'InitialMagnification', 'fit');


