% Calculating houghlines
function plot_houghlines(I_gray, mt, T, R, P)
    % This function plots the houghlines on the input image I_gray. 
    % Input parameters : 
    % I_gray    : Gray image
    % mt        : Magnitude threshold
    % T         : Theta array
    % R         : Rho array
    % P         : Hough peaks array

    lines = houghlines(mt,T,R,P);
    figure, imshow(I_gray), hold on % Plotting original image
    
    for k = 1:length(lines)
       xy = [lines(k).point1; lines(k).point2];
       plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
    
       % Plot beginnings and ends of lines
       plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
       plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

    end
end
