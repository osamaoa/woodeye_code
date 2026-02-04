% VISUALIZE_BOARD
% Utility to load and visualize saved WoodEye data without re-processing.

clear; close all; clc;
addpath(genpath('src'));

%% Settings
projectDir = 'M:\WoodEye5_NyStruktur\Musaab_aau_patch3'; 

% Board to visualize (Index or Name)
% Set to empty [] to select interactively (if implemented) or loop
targetBoardIndex = 8; 

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

if ~exist(dataFile, 'file')
    error('Data file not found: %s. \n  Possible reasons:\n  - Run main.m to process data first.\n  - Check board index.', dataFile);
end

%% Load and Plot
fprintf('Loading data for %s...\n', boardName);
loaded = load(dataFile); % contains 'processedData' and 'currentConfig'

if ~isfield(loaded, 'processedData')
    error('File does not contain processedData.');
end

processedData = loaded.processedData;
if isfield(loaded, 'currentConfig')
    config = loaded.currentConfig;
else
    % Fallback config if missing
    config = struct('showFigs', true);
end
config.showFigs = true; % Force on

fprintf('Plotting...\n');
plotBoardData(processedData, config);

fprintf('Done.\n');
