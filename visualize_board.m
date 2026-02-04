% Utility to load and visualize saved WoodEye data without re-processing.

clear; close all; clc;
addpath(genpath('src'));

%% Settings
projectDir = 'M:\WoodEye5_NyStruktur\Musaab_aau_patch1'; 

% Board to visualize (Index)
targetBoardIndex = 3; 

% --- Visualization Settings ---
target_arrows_length = 300; % Fiber density along length
arrow_scale = 0.2;          % Fiber arrow size (0.5 = Default)

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

% Override with Visualization Settings (User Priority)
config.target_arrows_length = target_arrows_length;
config.arrow_scale = arrow_scale;
config.showFigs = true;

fprintf('Plotting...\n');

plotBoardData(processedData, config);

fprintf('Done.\n');
