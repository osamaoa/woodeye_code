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
        if isfield(processedData, side) && ~isempty(processedData.(side).Y)
            L_max = max(L_max, max(processedData.(side).Y(:)));
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
                % Left Face (Swapped to Y=B based on user feedback)
                [r, c, ~] = size(img);
                if r > c % Length x Thickness
                     X_corners = [0, 0; L_max, L_max]; 
                     Z_corners = [H, 0; H, 0];         
                     Y_corners = ones(2,2)*B;
                else
                     X_corners = [0, L_max; 0, L_max]; 
                     Z_corners = [H, H; 0, 0];         
                     Y_corners = ones(2,2)*B;
                end
                
            case 'right'
                % Right Face (Swapped to Y=0 based on user feedback)
                [r, c, ~] = size(img);
                if r > c 
                     X_corners = [0, 0; L_max, L_max];
                     Z_corners = [H, 0; H, 0];
                     Y_corners = zeros(2,2);
                else
                     X_corners = [0, L_max; 0, L_max];
                     Z_corners = [H, H; 0, 0];
                     Y_corners = zeros(2,2);
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
             
             if ~isempty(d.Y)
                 L_mm = max(d.Y(:));
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
                      scatter(d.X + currentXOffset, d.Y, 10, val, 'filled');
                 else
                     x = d.X; y = d.Y;
                     if ~isempty(x) && ~isempty(y)
                         surface(x + currentXOffset, y, zeros(size(x)), val, 'EdgeColor', 'none', 'FaceColor', 'interp');
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
             if ~isempty(d.Y)
                 L_mm = max(d.Y(:));
             else
                 L_mm = dim1; 
             end
             imagesc([currentXOffset, currentXOffset + sideW], [0 L_mm], img); 
        end
        
        if isfield(d, 'Fi') && ~isempty(d.Fi) && ~isempty(d.X) && ~isempty(d.Y)
            x_q = d.X; 
            y_q = d.Y; 
            fi_q = d.Fi;
            X_plot = x_q + currentXOffset;
            Y_plot = y_q;
            U_plot = sind(fi_q); 
            V_plot = -cosd(fi_q); 
            
            % Grid Subsampling (Restored from Original Logic)
            % If X/Y/Fi are matrices, we can just subsample rows/cols directly.
            
            [nr, nk] = size(d.X);
            
            if min(nr, nk) > 1 
                % It is a Grid (Matrix)
                % Subsample to achieve visual density
                
                % Desired Density
                % Width: Use ALL available lines (stride_row = 1) as requested.
                % Length: Use target_arrows_length (default 100).
                
                stride_row = 1; 
                if isfield(config, 'target_arrows_length'), target_cols = config.target_arrows_length; else, target_cols = 100; end
                
                stride_col = max(1, floor(nk / target_cols));
                
                % Limit total arrows (Safety)
                % Increased limit since user wants full resolution
                total_est = (nr/stride_row) * (nk/stride_col); 
                limit_arrows = 20000; 
                
                if total_est > limit_arrows
                    % Only increase stride_col (Length) to meet limit, preserving width resolution
                    % total = nr * (nk / new_stride_col) <= limit
                    % new_stride_col >= (nr * nk) / limit
                    stride_col = ceil((nr * nk) / limit_arrows);
                end
                
                % Create indices
                row_idx = 1:stride_row:nr;
                col_idx = 1:stride_col:nk;
                
                % Extract grid points
                X_sub = X_plot(row_idx, col_idx);
                Y_sub = Y_plot(row_idx, col_idx);
                U_sub = U_plot(row_idx, col_idx);
                V_sub = V_plot(row_idx, col_idx);
                
                % Flatten for quiver
                q = quiver(X_sub(:), Y_sub(:), U_sub(:), V_sub(:));
                
            else
                % Vector Data (Linear Stride)
                stride = 10;
                if length(d.X) > 5000, stride = ceil(length(d.X)/4000); end
                idx = 1:stride:length(d.X);
                q = quiver(X_plot(idx), Y_plot(idx), U_plot(idx), V_plot(idx));
            end
            
            q.Color = 'r'; q.LineWidth = 1;
            % Adjust Arrow Scale
            base_scale = 0.5; % Default Larger
            if isfield(config, 'arrow_scale'), base_scale = config.arrow_scale; end
            
            if strcmpi(side, 'Left') || strcmpi(side, 'Right')
                q.AutoScaleFactor = base_scale / 2;
            else
                q.AutoScaleFactor = base_scale;
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
