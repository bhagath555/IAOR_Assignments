A = [0, 0, 0, 0, 0, 0, 0, 0;
     0, 0, 0, 0, 0, 0, 0, 0;
     0, 0, 1, 1, 1, 0, 0, 0;
     0, 0, 0, 0, 1, 1, 0, 0;
     0, 0, 0, 1, 1, 1, 0, 0;
     0, 0, 0, 0, 0, 0, 0, 0;
     0, 0, 0, 0, 0, 1, 0, 0;
     0, 0, 0, 0, 0, 0, 0, 0;];

image_plot(A);
title("Original")
se = [0, 0;
      0, 1];

A = imdilate(A, se);
image_plot(A);
title("After dilation")