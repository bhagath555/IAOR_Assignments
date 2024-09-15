% Step 1: Read the image
img = imread('training/2.jpg');

% Step 2: Convert to grayscale
img_gray = rgb2gray(img);


% Step 4: Suppress texture using Gaussian blur (reduce noise and texture)
img_blur = imgaussfilt(img_gray, 2);  % sigma=2 for moderate smoothing

% Step 5: Edge detection using Canny for more accurate crack edges
edges = edge(img_blur, 'sobel');  % Canny with tuned thresholds and sigma

% Step 6: Morphological operations to enhance and clean up the cracks
se_dilate = strel('square', 5);  % Structuring element for dilation
dilated_edges = imdilate(edges, se_dilate);  % Dilate to make the crack stronger

% Step 7: Remove small objects that are likely noise
cleaned_img = bwareaopen(dilated_edges, 500);  % Remove small noise smaller than 100 pixels

% Step 8: Perform morphological closing to ensure the cracks are continuous
se_close = strel('disk', 6);
cleaned_img = imclose(cleaned_img, se_close);  % Close small gaps in the crack

% Step 9: Fill small holes inside the cracks
% cleaned_img = imfill(cleaned_img, 'holes');

% Step 10: Display the result
figure;
subplot(1, 2, 1), imshow(img_gray), title('Original Grayscale Image');
subplot(1, 2, 2), imshow(cleaned_img), title('Enhanced Crack Detection');

% Step 1: Get connected components
CC = bwconncomp(cleaned_img);

% Step 2: Extract features using regionprops
pp = regionprops(CC, 'Extent', 'Eccentricity', 'Area', 'Perimeter');

Num_comps = CC.NumObjects;
features = zeros(Num_comps, 2); % Two features: 'Eccentricity' and 'Extent'
labels = zeros(Num_comps, 1);   % Labels: 1 for crack, 0 otherwise

% Step 4: Assign features and labels
for i = 1:Num_comps
    features(i, 1) = pp(i).Eccentricity;  % Eccentricity
    features(i, 2) = pp(i).Extent;        % Extent

    % Label as crack based on conditions:
    if pp(i).Eccentricity > 0.8 || pp(i).Extent < 0.4
        labels(i) = 1; % Crack
    else
        labels(i) = 0; % Non-crack
    end
end


% Step 5: Split data into training and testing sets (e.g., 80% train, 20% test)
train_ratio = 0.8;
train_size = round(Num_comps * train_ratio);
idx = randperm(Num_comps);
train_idx = idx(1:train_size);
test_idx = idx(train_size+1:end);

train_features = features(train_idx, :);
train_labels = labels(train_idx);

test_features = features(test_idx, :);
test_labels = labels(test_idx);

% Step 6: Train an SVM model
SVMModel = fitcsvm(train_features, train_labels);

% Step 7: Test the SVM model on the test set
predicted_labels = predict(SVMModel, test_features);

% Step 8: Calculate accuracy or other performance metrics
accuracy = sum(predicted_labels == test_labels) / length(test_labels);
disp(['Test Accuracy: ', num2str(accuracy * 100), '%']);
