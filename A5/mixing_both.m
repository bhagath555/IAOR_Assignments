dim = 3;
clear all;
close all;

dim = 3;
img = double(imread("inputEx5_1.jpg"));
figure; imshow(img/255.);
title("Original");
k = 6;
RGB_k_mean(img, dim, k)
dim = 5;
RGBXY_k_mean(img, dim, k);

function RGB_k_mean(img_mat, dim, k)
    % Image dimensions
    [l, w, d] = size(img_mat);
    % Number of pixels
    num_pixels = l * w;
    % RGB space matrix
    rgb_mat = reshape(img_mat(:,:,:), [num_pixels, 3]);

    % Finding the optimal result
    rgb_mat = k_mean(rgb_mat, dim, k);

    % Plotting the results
    img2 = reshape(rgb_mat(:,1:3), [l,w,d]);
    figure; imshow(img2/255.);
    title("3D K-mean : Final")
end

function RGBXY_k_mean(img_mat, dim, k)
    % Image dimensions
    [l, w, d] = size(img_mat);
    % Number of pixels
    num_pixels = l * w;
    % RGB space matrix
    rgb_mat = reshape(img_mat(:,:,:), [num_pixels, 3]);
    % RGBXY matrix
    xy = rowcols(l,w);
    rgbxy_mat = [rgb_mat, xy];
    % Finding the optimal result
    rgbxy_mat = k_mean(rgbxy_mat, dim, k);

    % Plotting the results
    img2 = reshape(rgbxy_mat(:,1:3), [l,w,d]);
    figure; imshow(img2/255.);
    title("5D (RGBXY) K-mean : Final")
end



function [data_mat] = k_mean(data_mat, dim, k)
    if width(data_mat) ~= dim
        error("data_mat should have width of dim")
    end
    n = zeros(k,dim);
    for i=1:k
        n(i,:) =  255.00*rand([1,dim]);
    end

    n_old = n - 1; % This to compare the intial while condition 
    % n_old will be updated in the loop.

    figure; % Figure for clusting visualization
    
    hold on;
    while norm(n-n_old) ~= 0
        dll = []; % size (num_pixels, k). Distance of each points from k's. 
        for i=1:k
            % ik = [kk, round(10*rand([1,2]))];
            scatter3(n(i,1), n(i,2), n(i,3), 100, n(i,1:3)/255.0);
            hold on;
            temp = dist(data_mat, n(i,:));
            dll = [dll, temp];
        end
        hold on;
        % Points that closer to different k's (num_pixels, 1)
        [~, indices] = min(dll, [], 2); 
        % Buckets to store cluster points 
        % size (num_pixels, k). Distance of each points from k's. 
        cluster_voting = zeros(size(dll));
        % Updating the points buckets
        for i = 1:length(indices)
            cluster_voting(i, indices(i)) = 1;
        end
        % find(up_db(:,i)) gives the indices that closer to i^th cluster. 
        % We use above information in a vector to get respective points.
        % We calculate min(array, 1) component wise average. 
        k_mean = zeros(k,dim);
        for i=1:k
            vot_inds = find(cluster_voting(:,i));
            if ~isempty(vot_inds)
                p1 = data_mat( vot_inds, 1 );
                p2 = data_mat( vot_inds, 2 );
                p3 = data_mat( vot_inds, 3 );
                ss = 1*ones(size(p3));
                hold on;
                scatter3( p1, p2, p3, ss, n(i,1:3)/255.0)
                hold on;
                new_avg = mean( data_mat( vot_inds , : ), 1);
                k_mean(i,:) = new_avg;
            else 
                k_mean(i,:) = n(i,:);
            end
        end
        pause(0.1);
        drawnow;
        % Update n_old and k_mean matrix
        n_old = n;
        n = k_mean;
        hold off;
    end
    if dim == 3
        title("RGB K-mean plot")
    end
    if dim == 5
        title(" 5D K-mean plot (RGB Visualized)")
    end
    % Update the image colors with cluster centers
    for i=1:k
        vot_inds = find(cluster_voting(:,i));
        if width(vot_inds) > 0
            data_mat(vot_inds, :) = repmat(n(i,:), size(vot_inds));
        end
    end
end


function kn = dist(rgb_vec, k_vec)
    % This function return (num_elems, 1) size norm vector.
    % rgb_vec   : matrix of (num_elems, dim)
    % k_vec     : row vector (1, dim)

    % OUTPUT
    % kn        : colum vector (num_elems, 1)
    kn = vecnorm(rgb_vec-k_vec, 2, 2);
end


function mat = rowcols(rows, cols)
    mat = zeros(rows*cols, 2);
    count = 1;
    for c=1:cols
        for r=1:rows
            mat(count, :) = [r, c];
            count = count + 1;
        end
    end
end
