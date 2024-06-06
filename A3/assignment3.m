% Step a: Read the input image and convert it to grayscale
img = imread('input_ex3.jpg');
gray_img = rgb2gray(img);
gray_img = im2double(gray_img); % Convert to range [0, 1]

% Plot the grayscale image
figure;
imshow(gray_img);
title('Grayscale Image');

% Step b: Apply a GoG filter to derive gradient images
sigma = 0.5; % Standard deviation for Gaussian filter
Gx = fspecial('sobel'); % Sobel filter for x direction
Gy = Gx'; % Sobel filter for y direction

% Apply filters to get gradients
gradient_x = imfilter(gray_img, Gx, 'replicate');
gradient_y = imfilter(gray_img, Gy, 'replicate');

% Compute gradient magnitude
gradient_magnitude = sqrt(gradient_x.^2 + gradient_y.^2);

% Step c: Threshold the gradient magnitude to extract edge pixels
threshold = 0.2; % Adjust this threshold as necessary
binary_edge_mask = gradient_magnitude > threshold;

% Plot the binary edge mask
figure;
imshow(binary_edge_mask);
title('Binary Edge Mask');

% Step d: Implement Hough line detection
function [H, theta_range, rho_range] = hough_transform(binary_edge_mask, gradient_x, gradient_y)
    [rows, cols] = size(binary_edge_mask);
    rho_max = round(sqrt(rows^2 + cols^2));
    rho_range = -rho_max:rho_max;
    theta_range = -90:1:89; % Angle in degrees
    num_thetas = numel(theta_range);
    num_rhos = numel(rho_range);

    H = zeros(num_rhos, num_thetas);

    [edge_y, edge_x] = find(binary_edge_mask); % Find edge pixels

    for k = 1:length(edge_x)
        x = edge_x(k);
        y = edge_y(k);
        gradient_theta = atan2d(gradient_y(y, x), gradient_x(y, x));

        for theta_idx = 1:num_thetas
            theta = theta_range(theta_idx);
            rho = x * cosd(theta) + y * sind(theta);
            rho_idx = round(rho + rho_max) + 1;
            H(rho_idx, theta_idx) = H(rho_idx, theta_idx) + 1;
        end
    end
end

[H, theta_range, rho_range] = hough_transform(binary_edge_mask, gradient_x, gradient_y);

% Step e: Plot the resulting Hough voting array
figure;
imshow(imadjust(mat2gray(H)), 'XData', theta_range, 'YData', rho_range, ...
      'InitialMagnification', 'fit');
title('Hough Transform');
xlabel('\theta (degrees)');
ylabel('\rho');
axis on;
axis normal;
hold on;

% Step f: Find local maxima of H
num_peaks = 20; % Number of peaks to identify
peaks = houghpeaks(H, num_peaks, 'threshold', ceil(0.3 * max(H(:)))); % Detect peaks

% Step g: Plot the found extrema
plot(theta_range(peaks(:, 2)), rho_range(peaks(:, 1)), 's', 'color', 'red');

% Step h: Use houghlines to derive the corresponding line segments
lines = houghlines(binary_edge_mask, theta_range, rho_range, peaks);

% Step i: Plot the lines on the original image
figure, imshow(gray_img), hold on % Plotting original image
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
end
