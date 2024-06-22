dim = 3;
num_pixels = 100;
a = round(100 * rand(num_pixels,dim));
k = 2;
n = [];

for i=1:k
    n = [n; round(100*rand([1,dim]))];
end

% n = [3, 2, 4;
%      7, 9, 6];
n
n_old = n - 1;

while norm(n-n_old) ~= 0
    figure; hold on;
    scatter3(n(1,1), n(1,2),  n(1,3), 50, 'r*');
    scatter3(n(2,1), n(2,2), n(2,3), 50, 'b*');
    dll = []; % size (num_pixels, k). Distance of each points from k's. 
    for i=1:k
        % ik = [kk, round(10*rand([1,2]))];
        temp = dist(a, n(i,:));
        dll = [dll, temp];
    end
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
        ss = 15*ones(size(p3));
        scatter3( p1, p2, p3, ss, sty{i})
        k_mean = [k_mean; mean( a( find(up_db(:,i)) , : ), 1)];
    end
    % We assign this k_mean to n matrix and do the procedure until we find the
    % match.
    k_mean
    n_old = n;
    n = k_mean;
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
        end
    end
end

rows = 4;
cols = 3;
mat = zeros(4*3, 2);
count = 1;
for c=1:cols
    for r=1:rows
        mat(count, :) = [r, c];
        count = count + 1;
    end
end