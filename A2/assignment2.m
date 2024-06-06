% This code is for finding corners in an image. Here's what we have understood so far

% First, we load the image. This one is called 'ampelmaennchen.png' which is the traffic light man
image_rgb = imread('ampelmaennchen.png');

% Since we're looking for edges, Here we convert the colorful image to grayscale.
image_gray = rgb2gray(image_rgb);
imwrite(image_gray,"grayscaleimage.png");

% For better numerical stability, we convert the image to double precision from the range [0,1]
image_gray = im2double(image_gray);

% This part aims to identify areas with significant intensity changes, potentially corresponding to edges and corners
sigma = 0.5; % Defines the standard deviation of the Gaussian filter, controlling its blurriness.
r = 3 * sigma;
c = -r:r;
[X, Y] = meshgrid(c, c);
Gx = -(X./(2*pi*sigma^4)) .* exp(-(X.^2 + Y.^2) / (2 * sigma^2));
Gy = Gx';
Ix = conv2(image_gray, Gx, 'same');
Iy = conv2(image_gray, Gy, 'same');
gradient_magnitude = sqrt(Ix.^2 + Iy.^2);
gog_image = gradient_magnitude;
imwrite(gog_image,"GoG_Image.png");

% Förstner Interest Operator. 
% This step analyzes local image neighborhoods to identify corners.
M = zeros(size(image_gray, 1), size(image_gray, 2), 2, 2);
for i = 3:size(image_gray, 1)-2 % A loop iterates through each pixel and extracts a small 5x5 window centered at that pixel from both the horizontal and vertical gradients.
    for j = 3:size(image_gray, 2)-2
        Ix_window = Ix(i-2:i+2, j-2:j+2);
        Iy_window = Iy(i-2:i+2, j-2:j+2);
        M(i, j, 1, 1) = sum(Ix_window(:).^2);
        M(i, j, 1, 2) = sum(Ix_window(:).*Iy_window(:));
        M(i, j, 2, 1) = M(i, j, 1, 2);
        M(i, j, 2, 2) = sum(Iy_window(:).^2);
    end
end

% Based on this matrix (M), we calculate two values, W and Q, that tell us how much of a corner a certain pixel is. 
% A high W means a sharp corner and high Q means a round corner. 
W = zeros(size(image_gray));
Q = zeros(size(image_gray));
for i = 3:size(image_gray, 1)-2
    for j = 3:size(image_gray, 2)-2
        M_matrix = reshape(M(i, j, :, :), 2, 2);
        trace_M = trace(M_matrix);
        det_M = det(M_matrix);
        W(i, j) = det_M / trace_M;
        Q(i, j) = 4 * det_M / (trace_M^2);
    end
end

% Not all points are created equal! We set a threshold for both W and Q to decide which pixels are likely corners.
threshold_w = 0.004;
threshold_q = 0.5;
interest_points_mask = (W > threshold_w) & (Q > threshold_q);
imwrite(interest_points_mask,"Interest Point Mask.png")

% Finally, to see the corners, we overlay red plus signs on the original image wherever our corner detector thinks there's a corner.
[rows, cols] = find(interest_points_mask);
imshow(image_rgb);
hold on;
plot(cols, rows, 'r+');
hold off;
