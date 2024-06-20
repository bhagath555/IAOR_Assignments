dim = 3;
img = double(imread("inputEx5_2.jpg"));
k = 4;

[l, w, d] = size(img);
num_pixels = l * w;
% plot(img(:,:,1))
a = reshape(img(:,:,:), [num_pixels, 3]);

n = [];
for i=1:k
    n = [n; 255.00*rand([1,dim])];
end

% n = [3, 2, 4;
%      7, 9, 6];
n
n_old = n - 1;

while norm(n-n_old) ~= 0
    dll = []; % size (num_pixels, k). Distance of each points from k's. 
    for i=1:k
        % ik = [kk, round(10*rand([1,2]))];
        n(i,:)/255
        scatter3(n(i,1), n(i,2), n(i,3), 100, n(i,:)/255.0);
        hold on;
        temp = dist(a, n(i,:));
        dll = [dll, temp];
    end
    hold on;
    % Points that closer to different k's (num_pixels, 1)
    [~, indices] = min(dll, [], 2); 
    % Buckets to store cluster points 
    % size (num_pixels, k). Distance of each points from k's. 
    up_db = zeros(size(dll));
    % Updating the points buckets
    for i = 1:length(indices)
        up_db(i, indices(i)) = 1;
    end
    % find(up_db(:,i)) gives the indices that closer to i^th cluster. 
    % We use above information in a vector to get respective points.
    % We calculate min(array, 1) component wise average. 
    k_mean = [];
    sty = {'r', 'b'};
    for i=1:k
        
        p1 = a( find(up_db(:,i)) , 1 );
        p2 = a( find(up_db(:,i)) , 2 );
        p3 = a( find(up_db(:,i)) , 3 );
        ss = 1*ones(size(p3));
        hold on;
        scatter3( p1, p2, p3, ss, n(i,:)/255.0)
        hold on;
        k_mean = [k_mean; mean( a( find(up_db(:,i)) , : ), 1)];
    end
    % We assign this k_mean to n matrix and do the procedure until we find the
    % match.
    k_mean
    n_old = n;
    n = k_mean;
    hold off;
    loli = 5;
end


function kn = dist(rgb_vec, k_vec)
    % This function return (num_elems, 1) size norm vector.
    % rgb_vec   : matrix of (num_elems, dim)
    % k_vec     : row vector (1, dim)

    % OUTPUT
    % kn        : colum vector (num_elems, 1)
    kn = vecnorm(rgb_vec-k_vec, 2, 2);
end

