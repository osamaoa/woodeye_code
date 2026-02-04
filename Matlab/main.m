% MAIN WoodEye Processing
% Entry point for setting up and running the analysis.

clear; close all; clc;

%% 1. Path Setup
% Add source folders
addpath(genpath('src'));

%% 2. Global Configuration
config = struct();

% --- Input Paths ---
% Path to the project root folder
config.projectDir = 'M:\WoodEye5_NyStruktur\Musaab_aau_patch3'; 

% --- Image Appearance Settings ---
config.clean_shift_px = 75;       % Pixels to crop significantly from top/bottom
config.clean_remove_factor = 0.7;  % Factor for adaptive background removal (intensity threshold)
config.exposure_gain = 2.0;       % Exposure correction factor (1.0 = no change, >1.0 = brighten)
config.feed_direction = 'top_first'; % 'root_first' (default) or 'top_first' (rotates 180)

% --- Board Dimension Settings ---
% Option 1: Uniform dimensions (used if useExcelDimensions = false)
config.H = 75;  % Default Height/Thickness (mm)
config.B = 154; % Default Width (mm)

% Option 2: Individual Dimensions via Excel
% Set to true to read from the Excel file specified below.
config.useExcelDimensions = false; 
config.dimensionExcelFile = 'BoardDimensions.xlsx';

% --- Processing Parameters ---
% Edge Cleaning and Quality Control
config.cancel_black_edges = 10;   % Width of edge region (mm) to check for artifacts

% --- Visualization Settings ---
config.showFigs = false;   % 1 = Show figures during this run
config.pauseFigs = false;  % 1 = Pause after each board to view figures

%% 3. Run Analysis
% Calls the engine to process all boards and save results.
runWoodEyeAnalysis(config);

% Cleanup
% rmpath(genpath('src')); % Optional: keep path if you want to run other scripts
