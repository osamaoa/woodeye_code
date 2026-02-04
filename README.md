# WoodEye Data Analysis

This project contains a refactored and optimized MATLAB pipeline for processing and visualizing WoodEye scanner data.

## Key Features

### 1. Automated Data Management
-   **Automatic Organization**: The pipeline is designed to handle raw input data automatically. It expects raw scanner data (e.g., in a `Raw` subfolder) and simulation results (in `simulation`). The system detects these inputs and automatically indexes and structures them into a standardized `organized` directory (`organized/B_XXX/...`), eliminating the need for manual file management.

### 2. Performance
-   **Parallel Processing**: Automatically switches to `parfor` (parallel loops) when visualization is disabled (`showFigs = false`), utilizing all CPU cores.
-   **Fast I/O**: Refactored data loading (`loadWoodEyeData`) uses `textscan` instead of `dlmread`, resulting in significantly faster import times.
-   **Optimized Indexing**: Scans the project directory structure **once** at startup instead of recursively searching for every board.

### 3. Image Processing
-   **Configurable Cleaning**: Parameters to fine-tune background removal.
-   **Exposure Adjustment**: `config.exposure_gain` allows brightening of underexposed images post-processing.
-   **Feed Direction Handling**: `config.feed_direction` ('root_first' or 'top_first') handles board orientation, automatically rotating images and data plots 180 degrees if needed.

### 4. Visualization
The analysis generates three key figures for each board:
-   **Figure 1: 3D Board Model**: An interactive 3D representation of the board showing all four sides. It features zoom and scroll controls (`<<<`, `>>>`) to traverse the board length in detail. Now with corrected length scaling and orientation.
-   **Figure 2: Unfolded View**: Displays the four sides (Left, Bottom, Right, Top) flattened side-by-side. This allows for easy comparison of surface features across the entire board perimeter.
-   **Figure 3: Fibre Angle Map**: Visualizes the grain direction using a quiver plot (vector field) overlaid on the board surfaces. Features:
    -   **Full Resolution**: Uses all available scan lines across the board width.
    -   **Configurable Density**: Control the arrow density along the board length.
    -   **Configurable Scale**: Adjust the size of the arrows.

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

% --- Visualization Appearance ---
config.target_arrows_length = 300; % Number of fiber arrows along the board length
config.arrow_scale = 0.5;          % Size of the fiber arrows (0.3 - 1.0 recommended)

% --- Execution Control ---
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
2.  Edit the **Settings** section at the top of the file:
    ```matlab
    targetBoardIndex = 1;         % Board index to visualize
    target_arrows_length = 300;   % Fiber density override
    arrow_scale = 0.3;            % Arrow size override
    ```
3.  Run the script. These local settings will override any configuration saved in the data file, allowing you to tweak the visualization on the fly.

## Project Structure

*   **`main.m`**: Main configuration and execution script.
*   **`visualize_board.m`**: Standalone visualization tool with real-time parameter tweaking.
*   **`src/`**: Core function library.
    *   `runWoodEyeAnalysis.m`: Main workflow engine.
    *   `loadWoodEyeData.m`: optimized data loader.
    *   `processBoardData.m`: Logic for coordinate mapping and data processing.
    *   `plotBoardData.m`: Visualization logic (3D, Unfolded, Fibre Angles).
    *   `cleanWoodEyeImage.m`: Image cleaning algorithms.
    *   `organizeWoodEyeData.m`: Helper to structure raw data folders.
