% Directory paths
inputDir = 'training/';   % Input directory of trained images
outputDir = 'training_morph/'; % Output directory for morphed images

% This funciton applys morphological operations to all image in input dir.
% And, stores them in outputDir
morph_ops(inputDir, outputDir);

%% Applying morphological operators to testing images
% Directory paths
inputDir = 'testing/';   % Input directory of trained images
outputDir = 'testing_morph/'; % Output directory for morphed images

% This funciton applys morphological operations to all image in input dir.
% And, stores them in outputDir
morph_ops(inputDir, outputDir);







