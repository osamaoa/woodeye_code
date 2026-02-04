% Utility to load and visualize saved WoodEye data without re-processing.

clear; close all; clc;
addpath(genpath('src'));

%% Settings
projectDir = 'M:\WoodEye5_NyStruktur\Musaab_aau_patch1'; 

% Board to visualize (Index or Name)
% Set to empty [] to select interactively (if implemented) or loop
targetBoardIndex = 9; 

%% Logic
organizedDir = fullfile(projectDir, 'organized');
if ~exist(organizedDir, 'dir')
    error('Organized directory not found: %s. Run main.m first.', organizedDir);
end

% Construct paths
if isnumeric(targetBoardIndex)
    boardName = sprintf('B_%03d', targetBoardIndex);
else
    boardName = targetBoardIndex;
end

boardDir = fullfile(organizedDir, boardName);
dataFile = fullfile(boardDir, 'processedData.mat');

% Check if processed data exists
if ~exist(dataFile, 'file') 
    error('Data file not found: %s.\nPlease run main.m to process the board data first.', dataFile);
end

fprintf('Loading saved data for %s...\n', boardName);
loaded = load(dataFile); % contains 'processedData' and 'currentConfig'
if ~isfield(loaded, 'processedData')
    error('File does not contain processedData.');
end
processedData = loaded.processedData;
if isfield(loaded, 'currentConfig')
    config = loaded.currentConfig;
else
    config = struct('showFigs', true);
end
config.target_arrows_length = 300; % Adjust fiber density along length
config.arrow_scale = 0.3;          % Adjust fiber arrow size (0.5 = Default)
config.showFigs = true;

fprintf('Plotting...\n');

% --- Debug: Print Grid Dimensions ---
fprintf('Plotting...\n');

% Debug prints removed for cleaner output.

plotBoardData(processedData, config);

fprintf('Done.\n');
