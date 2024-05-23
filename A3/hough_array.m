function [H,T,R] = hough_array(mt, Ix, Iy)
    % mt matrix with edge information
    % Number of rows and columns of image matrix
    rows = size(mt, 1); % Represents y direction (height)
    cols = size(mt, 2); % Represents x direction (width)
    % Maximum possible rho length = diagonal of the image.
    rho_max = round(sqrt(rows^2 + cols^2));
    
    % Constructing rho array 
    R = -rho_max:1:rho_max;
    % Constructing Theta array
    T = -90:1:89;

    % H matrix columns will be -90 to 89 (180 entries including 0).
    H = zeros(numel(R), numel(T));
    for i = 1:rows % height y
        for j= 1:cols % width x
           if (mt(i,j) == 1)
               theta = atan(Iy(i,j)/Ix(i,j)); % Range from (-pi/2, pi/2)
               rho = j * cos(theta) + i * sin(theta);
               d_theta = round(theta * 180 / pi) ;
               % Values from -90 to 89 are accepted. so 90 will be -90
               if (d_theta == 90)
                   d_theta = -90;
               end
               % Now map theta values from (-90, 89) to (1, 180)
               d_theta_i = d_theta + 90 + 1; 
               % Map r_rho value from -rho_max to rho_max
               r_rho = round(rho)+rho_max+1;
               % Storing the voting hough matrix
               H(r_rho, d_theta_i) = H(r_rho, d_theta_i) + 1;
           end
        end
    end
    
end

