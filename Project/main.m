% Implementing SVM to classify crack and non-crack regions

% Make sure there are images in 
% training_morph/crack & training_morph/non_crack
% testing_morph

% Read and process images from the 'cracked' directory
crackedDir = 'training_morph/crack/';
processDirectory(crackedDir, 1);

% Non cracked
crackedDir = 'training_morph/non_crack/';
processDirectory(nonCrackedDir, 0);

function processDirectory(directory, label)
    % processDirectory - Helper function to process all images in a directory and extract region properties
    %
    % Input:
    %    directory - Directory containing images
    %    label - A label for the type of image being processed ('Cracked' or 'Non-Cracked')
    
    % Get a list of all image files (assume png format) in the directory
    imageFiles = dir(fullfile(directory, '*.jpg'));  % You can change the extension as needed
    
    % Loop through each file in the directory
    for k = 1:length(imageFiles)
        % Get the file name
        fileName = imageFiles(k).name;
        inputFilePath = fullfile(directory, fileName);
        
        % Read the binary image
        binaryImage = imread(inputFilePath);
        binaryImage = mean(binaryImage,3);
        
        % Label connected components
        labeledImage = logical(binaryImage);

        % ( neighborhood connected components
        cc = bwconncomp(labeledImage, 8);
        % Get region properties
        stats = regionprops(cc, 'Extent', 'Solidity', 'Eccentricity', 'MinorAxisLength', 'MajorAxisLength');
        
        % Display the filename and process each region's properties
        fprintf('Processing image: %s (%s)\n', fileName, label);
        
        for i = 1:length(stats)
            % Extract region properties
            extent = stats(i).Extent;
            solidity = stats(i).Solidity;
            eccentricity = stats(i).Eccentricity;
            minorAxisLength = stats(i).MinorAxisLength;
            majorAxisLength = stats(i).MajorAxisLength;

        end
        
    end
end
