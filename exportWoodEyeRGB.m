% exportWoodEyeRGB.m
% Utility script to extract high-resolution RGB images from processed WoodEye data
% across all batches and save them as standard image files.

clear; close all; clc;
addpath(genpath('src'));

%% Settings
% Where are all the WoodEye scan batches located?
scansDir = 'D:\WoodEye_scans';

% Where should the extracted RGB images be saved?
exportRoot = 'D:\WoodEye_RGB_Exports';

% Output image format
imageFormat = 'png';

% Define the sides to extract
sides = {'up', 'down', 'left', 'right'};

%% Execution
% Create root export directory if it doesn't exist
if ~exist(exportRoot, 'dir')
    mkdir(exportRoot);
end
fprintf('Export Root: %s\n', exportRoot);

% Loop through batches 1 to 27
for batchNum = 1:27
    batchName = sprintf('Musaab_aau_patch%d', batchNum);
    projectDir = fullfile(scansDir, batchName);
    organizedDir = fullfile(projectDir, 'organized');
    
    if ~exist(organizedDir, 'dir')
        fprintf('--- Skipping Batch %d (%s) - Organized directory not found.\n', batchNum, batchName);
        continue;
    end
    
    fprintf('--- Processing Batch %d (%s) ---\n', batchNum, batchName);
    
    % Find all board folders in this batch
    d = dir(fullfile(organizedDir, 'B_*'));
    boardFolders = d([d.isdir]);
    
    if isempty(boardFolders)
        fprintf('    No boards found.\n');
        continue;
    end
    
    % Loop through boards in this batch
    for i = 1:length(boardFolders)
        boardName = boardFolders(i).name;
        boardDir = fullfile(organizedDir, boardName);
        dataFile = fullfile(boardDir, 'processedData.mat');
        
        if ~exist(dataFile, 'file')
            fprintf('    [Skip] %s: No processedData.mat\n', boardName);
            continue;
        end
        
        % Load the data file
        try
            loaded = load(dataFile, 'processedData');
            pData = loaded.processedData;
        catch ME
            fprintf('    [Error] %s: Failed to load. (%s)\n', boardName, ME.message);
            continue;
        end
        
        successCount = 0;
        
        % Extract image for each side
        for s = 1:length(sides)
            side = sides{s};
            
            if isfield(pData, side) && isfield(pData.(side), 'Image')
                img = pData.(side).Image;
                
                if isempty(img)
                    continue;
                end
                
                % --- Correct Aspect Ratio (De-stretching) ---
                % WoodEye pixels are not square. To preserve high resolution,
                % we will find which dimension has the higher pixel density 
                % and upscale the other dimension.
                if isfield(pData.(side), 'X') && isfield(pData.(side), 'Y')
                    % Get physical dimensions (mm)
                    phys_length_mm = abs(max(pData.(side).Y(:)) - min(pData.(side).Y(:)));
                    phys_width_mm  = abs(max(pData.(side).X(:)) - min(pData.(side).X(:)));
                    
                    if phys_width_mm > 0 && phys_length_mm > 0
                         orig_width_px = size(img, 1); % rows
                         orig_length_px = size(img, 2); % cols
                         
                         % Calculate pixel density (pixels per mm)
                         density_width = orig_width_px / phys_width_mm;
                         density_length = orig_length_px / phys_length_mm;
                         
                         % Upscale the dimension with the LOWER density to match the HIGHER density
                         % so we never throw away pixels.
                         if density_width > density_length
                             % Width is higher resolution. Upscale length columns.
                             target_length_px = round(phys_length_mm * density_width);
                             target_width_px = orig_width_px;
                         else
                             % Length is higher resolution. Upscale width rows.
                             target_width_px = round(phys_width_mm * density_length);
                             target_length_px = orig_length_px;
                         end
                         
                         % Apply resize
                         img = imresize(img, [target_width_px, target_length_px], 'bicubic');
                    end
                end
                
                % Ensure image is proper proper visible uint8 for PNG/JPG
                if isa(img, 'double')
                     % Data is usually [0, 1]. Clamp it safely just in case bicubic
                     % interpolation caused slight over/undershoots.
                     img(img < 0) = 0;
                     img(img > 1) = 1;
                     
                     % Optionally boost brightness slightly if they are naturally very dark
                     % img = imadjust(img, stretchlim(img)); % Uncomment if still too dark
                     
                     img = uint8(img * 255.0);
                elseif isa(img, 'uint16')
                     % Manually scale 16-bit to 8-bit to avoid im2uint8 dependency
                     img = uint8(double(img) * (255.0 / 65535.0));
                end
                
                % Create a specific folder for this board
                % e.g. D:\WoodEye_RGB_Exports\Batch01_B_003\
                boardExportDir = fullfile(exportRoot, sprintf('Batch%02d_%s', batchNum, boardName));
                if ~exist(boardExportDir, 'dir')
                    mkdir(boardExportDir);
                end
                
                % Construct output filename: up.png, down.png, left.png, right.png
                % (We don't need the batch prefix in the filename anymore since it's in the folder name)
                outFilename = sprintf('%s.%s', side, imageFormat);
                outPath = fullfile(boardExportDir, outFilename);
                
                % Save the image
                imwrite(img, outPath);
                successCount = successCount + 1;
            end
        end
        
        % Only print if we actually extracted something
        if successCount > 0
            fprintf('    Exported %s (%d sides)\n', boardName, successCount);
        end
    end
end

fprintf('\nExport Complete! Files saved to: %s\n', exportRoot);

