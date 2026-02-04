function plotBoardData(processedData, config)
%PLOTBOARDDATA Visualize the processed WoodEye data (2D and 3D).
%
% INPUTS:
%   processedData: Struct from processBoardData.
%   config: Configuration struct with plot settings.


    
    H = processedData.H;
    B = processedData.B;
    
    sides = {'up', 'down', 'left', 'right'};
    
    %% Figure 1: 3D Board Model (Interactive)
    hFig1 = figure(1); clf; 
    
    % Store data in appdata for callbacks
    setappdata(hFig1, 'L_max', 0);
    
    hold on;
    title('3D Board Model (Rotatable - Scroll to Navigate)');
    axis equal; grid on;
    view(3);
    rotate3d on;
    xlabel('Length (mm)');
    ylabel('Width (mm)');
    zlabel('Height (mm)');
    
    % Determine Max Length from available sides to define the box
    L_max = 0;
    for i = 1:length(sides)
        side = sides{i};
        if isfield(processedData, side) && ~isempty(processedData.(side).X)
            L_max = max(L_max, max(processedData.(side).X(:)));
        elseif isfield(processedData, side) && isfield(processedData.(side), 'Image') && ~isempty(processedData.(side).Image)
             [dim1, dim2, ~] = size(processedData.(side).Image);
             % Verify orientation match with Image dimensions logic below
             % Assume dim1 or dim2 is length. Heuristic max.
             L_max = max(L_max, max(dim1, dim2)); 
        end
    end
    
    if L_max == 0, L_max = 3000; end % Fallback
    setappdata(hFig1, 'L_max', L_max);
    
    for i = 1:length(sides)
        side = sides{i};
        if ~isfield(processedData, side), continue; end
        
        d = processedData.(side);
        
        hasImage = isfield(d, 'Image') && ~isempty(d.Image);
        
        % Prepare Texture Data
        if hasImage
             img = d.Image;
             if size(img, 3) == 3 && max(img(:)) > 1
                 img = img / 255;
             end
        else
            img = repmat(0.8, [2, 2, 3]);
        end
        
        % Define Geometry (2x2 mesh for corners)
        % X = Length, Y = Width, Z = Height
        
        switch lower(side)
            case 'up'
                % Top Face: Z = H. X=[0..L], Y=[0..B]
                [r, c, ~] = size(img);
                if r > c % Portrait
                     X_corners = [0, 0; L_max, L_max];
                     Y_corners = [0, B; 0, B]; 
                     Z_corners = ones(2,2)*H;
                else % Landscape
                     X_corners = [0, L_max; 0, L_max]; 
                     Y_corners = [0, 0; B, B];         
                     Z_corners = ones(2,2)*H;
                end
                
            case 'down'
                % Bottom Face: Z = 0.
                [r, c, ~] = size(img);
                if r > c 
                     X_corners = [0, 0; L_max, L_max];
                     Y_corners = [0, B; 0, B]; 
                     Z_corners = zeros(2,2);
                else 
                     X_corners = [0, L_max; 0, L_max];
                     Y_corners = [0, 0; B, B];
                     Z_corners = zeros(2,2);
                end
                
            case 'left'
                % Left Face: Y=0
                [r, c, ~] = size(img);
                if r > c % Length x Thickness
                     X_corners = [0, 0; L_max, L_max]; 
                     Z_corners = [H, 0; H, 0];         
                     Y_corners = zeros(2,2);
                else
                     X_corners = [0, L_max; 0, L_max]; 
                     Z_corners = [H, H; 0, 0];         
                     Y_corners = zeros(2,2);
                end
                
            case 'right'
                % Right Face: Y=B.
                [r, c, ~] = size(img);
                if r > c 
                     X_corners = [0, 0; L_max, L_max];
                     Z_corners = [H, 0; H, 0];
                     Y_corners = ones(2,2)*B;
                else
                     X_corners = [0, L_max; 0, L_max];
                     Z_corners = [H, H; 0, 0];
                     Y_corners = ones(2,2)*B;
                end
        end
        
        surface(X_corners, Y_corners, Z_corners, img, ...
            'FaceColor', 'texturemap', 'EdgeColor', 'none', 'CDataMapping', 'direct');
            
    end
    
    view(-30, 30);
    
    % --- Interactive View Controls ---
    viewWindow = 600; % mm visible
    setappdata(hFig1, 'viewWindow', viewWindow);
    
    % Initial Zoom
    xlim([0, viewWindow]);
    
    % Buttons
    % Positions: [left bottom width height]
    uicontrol('Parent', hFig1, 'Style', 'pushbutton', 'String', '<<<', ...
              'Units', 'normalized', 'Position', [0.3 0.01 0.1 0.05], ...
              'Callback', @(src,ev) scrollBoard(src, -1));
              
    uicontrol('Parent', hFig1, 'Style', 'pushbutton', 'String', '>>>', ...
              'Units', 'normalized', 'Position', [0.6 0.01 0.1 0.05], ...
              'Callback', @(src,ev) scrollBoard(src, 1));
              
    uicontrol('Parent', hFig1, 'Style', 'pushbutton', 'String', 'Reset View', ...
              'Units', 'normalized', 'Position', [0.45 0.01 0.1 0.05], ...
              'Callback', @(src,ev) scrollBoard(src, 0));


    
    xlabel('Length (mm)');
    ylabel('Width (mm)');
    zlabel('Height (mm)');
    
    %% Figure 2: Unfolded View (Upright)
    figure(2); clf; hold on;
    title('Unfolded Board View (Upright)');
    axis equal; grid on;
    colormap(jet); 
    
    order = {'Left', 'Down', 'Right', 'Up'};
    currentXOffset = 0;
    gap = 20; 
    
    for i = 1:length(order)
        side = order{i};
        lowerSide = lower(side);
        
        if ~isfield(processedData, lowerSide), continue; end
        d = processedData.(lowerSide);
        
        if strcmpi(side, 'Up') || strcmpi(side, 'Down')
            sideW = B;
        else
            sideW = H;
        end
        
        hasImage = isfield(d, 'Image') && ~isempty(d.Image);
        
        if hasImage
             img = d.Image;
             if size(img, 3) == 3 && max(img(:)) > 1
                 img = img / 255;
             end
             [dim1, dim2, ~] = size(img);
             if dim2 > dim1 && dim2 > 1000 
                 img = permute(img, [2 1 3]);
                 [dim1, dim2, ~] = size(img);
             end
             
             if ~isempty(d.X)
                 L_mm = max(d.X(:));
             else
                 L_mm = dim1; 
             end
             x_grid = linspace(currentXOffset, currentXOffset + sideW, dim2);
             y_grid = linspace(0, L_mm, dim1);
             surface(x_grid, y_grid, zeros(dim1, dim2), img, 'EdgeColor', 'none', 'FaceColor', 'texturemap', 'CDataMapping', 'direct');
        else
             if isfield(d, 'Ratio') && ~isempty(d.Ratio)
                 val = d.Ratio;
                 if isvector(val) && ~isempty(d.X) && ~isempty(d.Y)
                      scatter(d.Y + currentXOffset, d.X, 10, val, 'filled');
                 else
                     x = d.X; y = d.Y;
                     if ~isempty(x) && ~isempty(y)
                         surface(y + currentXOffset, x, zeros(size(x)), val, 'EdgeColor', 'none', 'FaceColor', 'interp');
                     end
                 end
             end
        end
        text(currentXOffset + sideW/2, -100, side, 'Color', 'k', 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
        currentXOffset = currentXOffset + sideW + gap;
    end
    
    xlabel('Stacked Width (mm)');
    ylabel('Length (mm)');
    xlim([-50, currentXOffset]);
    set(gca, 'YDir', 'reverse', 'XDir', 'reverse'); 
    
    %% Figure 3: Fibre Angle Evaluation (Upright)
    figure(3); clf; hold on;
    title('Fibre Angles - Upright View');
    axis equal; grid on;
    xlabel('Stacked Width (mm)');
    ylabel('Length (mm)');
    
    order = {'Left', 'Down', 'Right', 'Up'};
    currentXOffset = 0;
    gap = 20; 
    
    for i = 1:length(order)
        side = order{i};
        lowerSide = lower(side);
        
        if ~isfield(processedData, lowerSide), continue; end
        d = processedData.(lowerSide);
        
        if strcmpi(side, 'Up') || strcmpi(side, 'Down')
            sideW = B;
        else
            sideW = H;
        end
        
        if isfield(d, 'Image') && ~isempty(d.Image)
             img = d.Image;
             if size(img, 3) == 3 && max(img(:)) > 1
                 img = img / 255;
             end
             [dim1, dim2, ~] = size(img);
             if dim2 > dim1 && dim2 > 1000 
                 img = permute(img, [2 1 3]);
                 [dim1, dim2, ~] = size(img);
             end
             if ~isempty(d.X)
                 L_mm = max(d.X(:));
             else
                 L_mm = dim1; 
             end
             imagesc([currentXOffset, currentXOffset + sideW], [0 L_mm], img); 
        end
        
        if isfield(d, 'Fi') && ~isempty(d.Fi) && ~isempty(d.X) && ~isempty(d.Y)
            x_q = d.X(:); 
            y_q = d.Y(:); 
            fi_q = d.Fi(:);
            X_plot = y_q + currentXOffset;
            Y_plot = x_q;
            U_plot = sind(fi_q); 
            V_plot = -cosd(fi_q); 
            stride = 10; 
            if length(x_q) > 5000, idx = 1:stride:length(x_q); else, idx = 1:length(x_q); end
            q = quiver(X_plot(idx), Y_plot(idx), U_plot(idx), V_plot(idx));
            q.Color = 'r'; q.LineWidth = 1;
            if strcmpi(side, 'Left') || strcmpi(side, 'Right')
                q.AutoScaleFactor = 0.1;
            else
                q.AutoScaleFactor = 0.2;
            end 
        end
        text(currentXOffset + sideW/2, -100, side, 'Color', 'k', 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
        currentXOffset = currentXOffset + sideW + gap;
    end
    xlim([-50, currentXOffset]);
    set(gca, 'YDir', 'reverse', 'XDir', 'reverse'); 

end

function scrollBoard(src, direction)
    hFig = ancestor(src, 'figure');
    ax = findobj(hFig, 'Type', 'axes');
    if isempty(ax), return; end
    
    currentXLim = xlim(ax);
    windowSize = getappdata(hFig, 'viewWindow');
    L_max = getappdata(hFig, 'L_max');
    
    if isempty(windowSize), windowSize = 600; end
    if isempty(L_max), L_max = 3000; end
    
    step = windowSize / 2;
    
    if direction == 0
        % Reset
        newStart = 0;
    else
        % Scroll
        currentStart = currentXLim(1);
        newStart = currentStart + (direction * step);
    end
    
    % Clamp
    if newStart < 0, newStart = 0; end
    if newStart > L_max - windowSize, newStart = L_max - windowSize; end
    if newStart < 0, newStart = 0; end % Safety if L_max < window
    
    xlim(ax, [newStart, newStart + windowSize]);
end
