# WoodEye Data Analysis (Refactored)

This project contains a refactored and optimized MATLAB pipeline for processing and visualizing WoodEye scanner data.

## Key Features

### 1. Automated Data Management
-   **Automatic Organization**: The pipeline is designed to handle raw input data automatically. It expects raw scanner data (e.g., in a `Raw` subfolder) and simulation results (in `simulation`). The system detects these inputs and automatically indexes and structures them into a standardized `organized` directory (`organized/B_XXX/...`), eliminating the need for manual file management.

### 2. High Performance
-   **Parallel Processing**: Automatically switches to `parfor` (parallel loops) when visualization is disabled (`showFigs = false`), utilizing all CPU cores.
-   **Fast I/O**: Refactored data loading (`loadWoodEyeData`) uses `textscan` instead of `dlmread`, resulting in significantly faster import times.
-   **Optimized Indexing**: Scans the project directory structure **once** at startup instead of recursively searching for every board.

### 3. Enhanced Image Processing
-   **Configurable Cleaning**: Parameters to fine-tune background removal.
-   **Exposure Adjustment**: `config.exposure_gain` allows brightening of underexposed images post-processing.
-   **Feed Direction Handling**: `config.feed_direction` ('root_first' or 'top_first') handles board orientation, automatically rotating images and data plots 180 degrees if needed.

### 4. Interactive Visualization
The analysis generates three key figures for each board:
-   **Figure 1: 3D Board Model**: An interactive 3D representation of the board showing all four sides. It features zoom and scroll controls (`<<<`, `>>>`) to traverse the board length in detail.
-   **Figure 2: Unfolded View**: Displays the four sides (Left, Bottom, Right, Top) flattened side-by-side. This allows for easy comparison of surface features across the entire board perimeter.
-   **Figure 3: Fibre Angle Map**: Visualizes the grain direction using a quiver plot (vector field) overlaid on the board surfaces. This highlights the fiber orientation relative to the board axis ("Root to Top" flow).

## Usage

### 1. Setup
Open `main.m`. This is the single entry point for the analysis.

### 2. Configuration
Adjust the `config` struct in `main.m` to control the pipeline:

```matlab
% --- Input / Output ---
config.projectDir = 'Path/To/Data'; 

% --- Image Cleaning ---
config.clean_shift_px = 75;       % Pixels to crop from top/bottom margins
config.clean_remove_factor = 0.7; % Sensitivity for dark background row removal

% --- Image Appearance ---
config.exposure_gain = 2.0;       % Brightness multiplier (1.0 = Default, >1.0 = Brighten)
config.feed_direction = 'top_first'; % 'root_first' (Default) or 'top_first' (Rotates 180)

% --- Visualization ---
config.showFigs = true;   % Set to TRUE to see plots. Set to FALSE for maximum speed (Parallel Mode).
config.pauseFigs = true;  % Pause after each board to inspect.
```

### 3. Run
Execute `main.m`. 
-   The script will organize the data (if needed), find all boards, and process them.
-   Results are saved in `organized/B_XXX/processedData.mat`.

### 4. Quick Visualization (`visualize_board.m`)
Use this script to quickly inspect a single board's saved data without re-running the analysis.
1.  Open `visualize_board.m`.
2.  Set `targetBoardIndex` to the desired board number (e.g., 8).
3.  Run the script to load `processedData.mat` and display the plots.

## Project Structure

*   **`main.m`**: Main configuration and execution script.
*   **`visualize_board.m`**: Standalone visualization tool.
*   **`src/`**: Core function library.
    *   `runWoodEyeAnalysis.m`: Main workflow engine.
    *   `loadWoodEyeData.m`: optimized data loader.
    *   `processBoardData.m`: Logic for coordinate mapping and data processing.
    *   `plotBoardData.m`: Visualization logic (3D, Unfolded, Fibre Angles).
    *   `cleanWoodEyeImage.m`: Image cleaning algorithms.
    *   `organizeWoodEyeData.m`: Helper to structure raw data folders.
