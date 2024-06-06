clear all;
close all;

[boundary, image] = image_boundary('trainB.png');
% Computing position, rotation, scale invariant descriptors
F = get_fft(boundary{1}, 24);
figure;
imshow(image);
hold on; plot(boundary{1}(:,1), boundary{1}(:,2), 'r',  'LineWidth',2);
%% Training an image
[t_boundary, t_image] = image_boundary("test1B.jpg");
figure;
imshow(t_image);
num_bs = size(t_boundary, 1);
for i = 1: num_bs
    bi = t_boundary{i};
    if (size(bi, 1)  > 24)
        Fi = get_fft(bi, 24);
        if norm(F - Fi) < 0.09
            hold on; plot(bi(:,1), bi(:,2), 'r', 'LineWidth',2);
        end
    end
end


function F = get_fft(boundary_pixels, num_descrip)
    D = boundary_pixels(:, 1) + j * boundary_pixels(:, 2);
    F = fft(D, num_descrip);
    % Positoin invarient
    F(1) = 0 + j * 0;
    % Scale - Divide all the descriptors with second descriptor (F1) 
    F = F/(F(2));
    % Rotation - Consider the absolute value only. neglect the orientation.
    F = abs(F);
end

function [boundary, binary_img] = image_boundary(name)
    % Step a: Read the input image and convert it to grayscale
    img = imread(name);
    gray_img = rgb2gray(img);
    gray_img = im2double(gray_img); % Convert to range [0, 1]
    
    % % Plot the grayscale image
    % figure;
    % subplot(1,2,1);
    % imshow(gray_img);
    % title(['Grayscale ', name]);
    level = graythresh(gray_img);
    binary_img = imbinarize(gray_img, level);
    
    % subplot(1,2,2);
    % imshow(binary_img);
    % title(['Binary mask ', name]);
    
    boundary = bwboundaries(binary_img, "noholes", CoordinateOrder="xy");
end

