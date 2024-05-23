function [Ix,Iy, mag] = image_gradient(I,sigma)
% image_gradient function calculates the gradient of a gray image.
% Input parameter are I_gray and sigma. 
% I_gray    : gray image matrix.
% sigma     : Sqaure root of standard diviation of Gaussian function
% 
% Output
% Ix        : Gradient in X direction.
% Iy        : Gradient in Y direction.

% Implementation
    r = round(3 * sigma);      % Mask radius
    i = -r:r;                  % this represents x and y. both are same here.
    % 1D Gaussian 
    g = exp(-i.^2 / (2*sigma^2)) / (sqrt(2*pi)*sigma); 
    % Gradient
    d = i.*g / sigma^2; 
    % In above lines, g and d are 1 dimensional. 
    % Convolute the image 1st with 1D function g and then 1D detivative.
    Ix = conv2(conv2(I, g', 'same'), d , 'same');
    Iy = conv2(conv2(I, g , 'same'), d', 'same');
    % Magnitude of the gradients.
    mag = sqrt(Ix.^2 + Iy.^2); 

end