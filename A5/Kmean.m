img = double(imread('1.png'));



k = 3;

[l, w, d] = size(img);
num_pix = l * w;
% plot(img(:,:,1))
cols = reshape(img(:,:,:), [num_pix, 3]);

r = reshape(img(:,:,1), [1,num_pix]);
g = reshape(img(:,:,2), [1,num_pix]);
b = reshape(img(:,:,3), [1,num_pix]);

h = scatter3(cols(:,1), cols(:,2), cols(:,3), 5*ones(1, num_pix), cols/255);
figure; imshow(img/255);
k =5;
kk = [];
%% Generate column vector of k clusters
for i=1:k
    kk = [kk, round(255*rand(3,1))];
end


dall = distNd(cols, kk);

d_buckets = update_buckets(db_all);





k1_old = [50, 50, 50];

k2_old = [10, 10, 100];

d1 = distance(cols, k1_old);
d2 = distance(cols, k2_old);

% h.MarkerFaceColor = 'k';
% set(gca,'Color','m')
xlabel('Red'); ylabel('Green'); zlabel('Blue');
l = round(10*rand(2,4,3));


function up_db = update_buckets(db_all)
    % db_all is (num_pix, k)

    [~, indices] = min(db_all, [], 2);
    up_db = zeros(size(db_all));

    for i = 1:length(indices)
        up_db(i, indices(i)) = 1;
    end

end


function dNd = distNd(col_vec, k_vec)
    dNd = [];
    for k =1:width(k_vec)
        dNd = [dNd, vecnorm(col_vec-k_vec(:,k), 2, 2)];
    end
end



function kn = distance(v, k)
    % Input
    % v matrix of (dim, num_elems)
    % k 

    kn = vecnorm(v-k);
end