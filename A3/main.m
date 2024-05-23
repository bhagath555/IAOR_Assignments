close all;
clear all;

%% Variable parameters
% Values for parametric study
% Numeber of peaks, used in  Finding peaks section below.
num_peaks = 10;
% Gaussian standard diviation
sigma = 0.5;

%% Reading an image and computing its Gradients
% Reading an image
I = imread('input_ex3.jpg'); % convert uint8 to double
% Color to gray
I_gray = rgb2gray(I);
% Double precision range [0,1]
I_gray = im2double(I_gray);

% Plotting original and gray image
% figure; subplot(1, 2, 1); imshow(I, []); title('original');
% subplot(1, 2, 2); imshow(I_gray, []); title('Gray');

% Gradient in X and Y directions, gradient Magnitude. see the file image_gradient
[Ix,Iy, mag] = image_gradient(I_gray, sigma);

% Plotting magnitude of the gradient
figure; subplot(1,2,1); imshow(mag, []); title('Gradient');

%% Thresholding gradient magnitude image.
% Threshold to eliminate weak pixels for Hough transformation
level = graythresh(mag);
% mt = imbinarize(mag,level);
mt = edge(I_gray,'canny');
% mt = 1*(mag > 0.03);
subplot(1,2,2); imshow(mt, []); title('Gradient Threshold');

%% Calling a function that computes 
% Hough array H, Theta array T, Rho array R
[H,T,R] = hough_array(mt, Ix, Iy);

% Plotting H array
figure;
imshow(imadjust(rescale(H)),'XData',T,'YData',R,...
      'InitialMagnification','fit');
title('Hough transform of gantrycrane');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(gca,hot)

%% Finding peaks
P  = houghpeaks(H,num_peaks);
figure;
imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');

xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
plot(T(P(:,2)),R(P(:,1)),'s','color','white');

%% Houghlines plotting
plot_houghlines(I_gray, mt, T, R, P)