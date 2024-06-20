clear all;
close all;

%% taskA function has the implementation of taskA. 
% % Reducting noise of the image
% taskA();

%% taskB function has the implementation of shape detection
taskB();

function taskA()

    % Step a: Read the input image and convert it to grayscale
    img = imread('taskA.png');
    gray_img = rgb2gray(img);
    gray_img = im2double(gray_img); % Convert to range [0, 1]
    figure;
    imshow(gray_img);
    title("Grayscale image");
    %% Image gaussian noise and fft
    J = imnoise(gray_img,'gaussian', 0, 0.01);
    figure;
    subplot(2,2,1);
    imshow(J);
    title('Image with G-noise');
    
    % Applying FFT to the image.
    image_fft = fft2(J);
    subplot(2,2,2); 
    imagesc(log(abs(fftshift(image_fft))));
    title('Image FFT');
    
    %% Gaussina noise mask
    % Plotting the values
    sigma = 1.8;
    r = round( 3 * sigma );         % Mask radius
    i = -r:r;                  % this represents x and y. both are same here.
    % 1D Gaussian 
    g = exp(-i.^2 / (2*sigma^2)) / (sqrt(2*pi)*sigma);
    gaussian = g'*g;
    % Normalizing the gaussian mask
    gaussian = gaussian/sum(gaussian(:));
    
    %% Adjusting the padding and shifting 
    extend_pad = size(J)-size(gaussian);
    padding = padarray(gaussian,extend_pad, 0, "post");
    padding = circshift(padding, -1 * round(size(gaussian)/2));
    
    subplot(2,2,3); 
    imshow(padding, []);
    title('Padding gaussian mask');
    
    % Applying FFT to Gaussian mask
    fft_padding = fft2(padding);
    subplot(2,2,4); 
    imagesc(log(abs(fftshift(fft_padding))));
    title('Mask FFT');
    
    %% Convolution of mask and image
    Guv = image_fft .* fft_padding;
    figure; 
    subplot(1,2,1); imagesc(log(abs(fftshift(Guv))));% plotting above result
    title("Final result in frequency domain")
    pbaspect([1 1 1])
    % Inverse FFT
    final = ifft2(Guv);
    % Plotting the image
    
    subplot(1,2,2);
    imshow(final);
    title(strcat("\sigma = ", num2str(sigma)));
    ax = gca; 
    ax.FontSize = 6;

end


function taskB()
    % Computing the image boundary
    [boundary, image] = image_boundary('trainB.png'); % see below for implementation
    
    % Computing position, rotation, scale invariant descriptors
    F = get_fft(boundary{1}); % see below for implementation
    figure;
    imshow(image);
    title("trainB");
    hold on; plot(boundary{1}(:,1), boundary{1}(:,2), 'r',  'LineWidth',2);
    % Add image file names below run the test. 
    image_list = ["test1B.jpg", "test2B.jpg", "test3B.jpg"];
    %% Testing the images to find the trained shape.
    for ims = 1:3
        [t_boundary, t_image] = image_boundary(image_list(ims));
        figure;
        imshow(t_image);
        title(image_list(ims));
        num_bs = size(t_boundary, 1);
        for i = 1: num_bs
            bi = t_boundary{i};
            if (size(bi, 1)  > 24)
                Fi = get_fft(bi);
                if norm(F - Fi) < 0.09
                    hold on; plot(bi(:,1), bi(:,2), 'r', 'LineWidth',2);
                end
            end
        end
    end
end


% Fixing the error
function F = get_fft(boundary_pixels)
    D = boundary_pixels(:, 1) + j * boundary_pixels(:, 2);
    F = fft(D);
    F = F(2:24);    % Removing first descriptor to make the array positoin invarient 
    % Scale - Divide all the descriptors with second descriptor (Here, F1) 
    F = F/(F(1));
    % Rotation - Consider the absolute value only. neglect the orientation.
    F = abs(F);
end

function [boundary, binary_img] = image_boundary(name)
    % Step a: Read the input image and convert it to grayscale
    img = imread(name);
    gray_img = rgb2gray(img);
    gray_img = im2double(gray_img); % Convert to range [0, 1]
    % binarization
    level = graythresh(gray_img);
    binary_img = imbinarize(gray_img, level); 
    % boundary calculation
    boundary = bwboundaries(binary_img, "noholes", CoordinateOrder="xy");
end