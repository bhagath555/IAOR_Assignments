function image_plot(C)
% Plot the padded binary image
figure;
imagesc(C);
colormap("gray");  % Use grayscale colormap
axis equal;      % Ensure equal scaling
grid on;         % Display grid lines

% Customize the grid lines
ax = gca;
ax.GridColor = [1, 0, 0];  % Set the grid color (e.g., red)
ax.GridAlpha = 1;          % Set the grid transparency
ax.LineWidth = 1;          % Set the grid line width

% Ensure the grid lines are placed between pixels
ax.XTick = 0.5:1:size(C, 2)-0.5;
ax.YTick = 0.5:1:size(C, 1)-0.5;
ax.XTickLabel = [];
ax.YTickLabel = [];