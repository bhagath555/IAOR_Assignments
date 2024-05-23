sigma = 0.5;
num_peaks = 70;
% Reading an image
I = imread('input_ex3.jpg'); % convert uint8 to double
% Color to gray
I_gray = rgb2gray(I);
% Double precision range [0,1]
I_gray = im2double(I_gray);

[Ix,Iy, mag] = image_gradient(I_gray, sigma);

level = graythresh(mag);
mt = imbinarize(mag,level);

BW = edge(I_gray,'canny');

[H,T,R] = hough(BW,'RhoResolution',1,'Theta',-90:1:89);

figure; subplot(1, 3, 1); imshow(I_gray, []); title('original');
subplot(1, 3, 2); imshow(mt, []); title('Threshold');
subplot(1, 3, 3); imshow(BW, []); title('Builtin');

figure;
imshow(imadjust(rescale(H)),'XData',T,'YData',R,...
      'InitialMagnification','fit');
title('Hough transform of gantrycrane.png');
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

post_houghlines(I_gray, BW, T, R, P)