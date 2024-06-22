dim = 5;
img = double(imread("1.png"));
k = 4;

[l, w, d] = size(img);
num_pixels = l * w;
% plot(img(:,:,1))
a = reshape(img(:,:,:), [num_pixels, 3]);
spacial = rowcols(l,w);
a = [a, spacial];

n = [];
for i=1:k
    n = [n; 255.00*rand([1,dim])];
end
n
% n = [3, 2, 4;
%      7, 9, 6];
n_old = n - 1;

while norm(n-n_old) ~= 0
    dll = []; % size (num_pixels, k). Distance of each points from k's. 
    for i=1:k
        % ik = [kk, round(10*rand([1,2]))];
        scatter3(n(i,1), n(i,2), n(i,3), 100, n(i,1:3)/255.0);
        hold on;
        temp = dist(a, n(i,:));
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
    k_mean = [];
    sty = {'r', 'b'};
    for i=1:k
        vot_inds = find(cluster_voting(:,i));
        if length(vot_inds) > 0
            p1 = a( vot_inds, 1 );
            p2 = a( vot_inds, 2 );
            p3 = a( vot_inds, 3 );
            ss = 1*ones(size(p3));
            hold on;
            scatter3( p1, p2, p3, ss, n(i,1:3)/255.0)
            hold on;
            new_avg = mean( a( vot_inds , : ), 1);
            k_mean = [k_mean; new_avg];
        else 
            k_mean = [k_mean; n(i,:)];
        end
    end
    pause(0.1);
    drawnow;
    % We assign this k_mean to n matrix and do the procedure until we find the
    % match.
    n_old = n;
    n = k_mean;
    hold off;
    loli = 5;
end
k_mean
% Update the image colors with cluster centers
for i=1:k
    vot_inds = find(cluster_voting(:,i));
    if width(vot_inds) > 0
        a(vot_inds, :) = repmat(n(i,:), size(vot_inds));
    end
end

img2 = reshape(a(:,1:3), [l,w,d]);
figure; imshow(img/255.);
figure; imshow(img2/255.);

% 

function [] = k_mean(data_mat, dim)


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
