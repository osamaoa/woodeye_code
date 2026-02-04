function runWoodEyeAnalysis(config)
%RUNWOODEYEANALYSIS Core workflow function.
%   1. Checks/Runs Data Organization.
%   2. Iterates over ALL boards in the set.
%   3. Loads and Processes each board.
%   4. Saves processed data to 'organized/B_XXX/processedData.mat'.
%   5. Visualizes results if requested.

    projectDir = config.projectDir;
    
    %% 0. Auto-run Data Organization
    organizedDir = fullfile(projectDir, 'organized');
    shouldOrganize = false;
    if ~exist(organizedDir, 'dir')
        shouldOrganize = true;
    else
        d = dir(organizedDir);
        d = d(~ismember({d.name}, {'.', '..'}));
        if isempty(d), shouldOrganize = true; end
    end
    
    if shouldOrganize
        fprintf('  "organized" folder missing or empty. Running data organization script...\n');
        organizeWoodEyeData(projectDir);
    end
    
    %% 1. Find All Boards & Map Paths
    % We assume 'organized' folder contains 'B_XXX' folders.
    items = dir(fullfile(organizedDir, 'B_*'));
    boardDirs = items([items.isdir]);
    
    if isempty(boardDirs)
        warning('No board folders (B_*) found in %s', organizedDir);
        return;
    end
    
    boardNames = {boardDirs.name};
    nBoards = length(boardDirs);
    fprintf('Found %d boards to process.\n', nBoards);
    
    % Pre-scan Source Paths for Loading
    % loadWoodEyeData originally scanned recursively. We do it ONCE here.
    fprintf('  Indexing source folders... ');
    allSpecimenPaths = findSpecimenFolders(projectDir); 
    % Note: organizeWoodEyeData creates symlinks or copies? 
    % Actually, loadWoodEyeData expects the ORIGINAL source path usually, 
    % or the organized path?
    % The original loadWoodEyeData searched 'projectDir'.
    % The 'organized' folder likely links raw data or just contains outputs?
    % Let's look at how organizeWoodEyeData works. 
    % If it copied data, we load from there. 
    % If it just organized output structure, we still need source.
    % Assuming 'organized' B_XXX maps to specific specimens.
    % But we need to know WHICH specimen corresponds to B_XXX.
    % If B_001 is the 1st found specimen...
    % Let's assume boardIndex maps to allSpecimenPaths index.
    
    if length(allSpecimenPaths) < nBoards
        warning('Found fewer source specimen folders (%d) than organized B_ folders (%d).', length(allSpecimenPaths), nBoards);
    end
    fprintf('Done. Found %d source paths.\n', length(allSpecimenPaths));

    % Load Excel Table ONCE
    dimTable = {};
    if config.useExcelDimensions
        excelPath = fullfile(projectDir, config.dimensionExcelFile);
        if exist(excelPath, 'file')
            try
                 rawSheet = readcell(excelPath);
                 firstRowVal = rawSheet{1, 2};
                 if ischar(firstRowVal) || isstring(firstRowVal)
                    dimTable = rawSheet(2:end, :);
                 else
                    dimTable = rawSheet;
                 end
            catch
                warning('Failed to load dimensions Excel. Using default dims.');
            end
        end
    end
    
    % Use Parallel Processing if not visualizing
    useParallel = ~config.showFigs;
    
    if useParallel && isempty(gcp('nocreate'))
        try
            parpool; 
        catch
            useParallel = false;
        end
    end
    
    %% 2. Process Loop
    % We iterate boardDirs.
    
    if useParallel
        fprintf('  Starting PARALLEL processing...\n');
        parfor i = 1:nBoards
            processSingleBoard(i, boardDirs(i).name, organizedDir, allSpecimenPaths, dimTable, config);
        end
    else
        fprintf('  Starting SEQUENTIAL processing...\n');
        for i = 1:nBoards
            processSingleBoard(i, boardDirs(i).name, organizedDir, allSpecimenPaths, dimTable, config);
        end
    end
    
    fprintf('========================================\n');
    fprintf('Analysis Complete.\n');

end

function processSingleBoard(i, boardName, organizedDir, allSpecimenPaths, dimTable, config)
    % Helper function for processing one board
    
    % Extract index from name B_001 -> 1
    boardIndex = sscanf(boardName, 'B_%d');
    if isempty(boardIndex), boardIndex = i; end

    fprintf('Processing %s...\n', boardName);
    
    try
        % Resolve Source Path
        if boardIndex <= length(allSpecimenPaths)
            specimenPath = allSpecimenPaths{boardIndex};
        else
            warning('No source path for Index %d', boardIndex);
            return;
        end

        % A. Load Data (Pass DIRECT PATH)
        rawData = loadWoodEyeData(specimenPath, config);
        
        % B. Configure Dimensions
        currentConfig = config;
        if config.useExcelDimensions && ~isempty(dimTable) && size(dimTable, 1) >= i
            rowIdx = i; 
            valB = dimTable{rowIdx, 2};
            valH = dimTable{rowIdx, 3};
            valL = dimTable{rowIdx, 4};
            
            if ~isnumeric(valB), valB = str2double(valB); end
            if ~isnumeric(valH), valH = str2double(valH); end
            if ~isnumeric(valL), valL = str2double(valL); end
            
            currentConfig.B = valB;
            currentConfig.H = valH;
            currentConfig.L = valL;
        end
        
        % C. Process
        processedData = processBoardData(rawData, currentConfig);
        
        % D. Save
        savePath = fullfile(organizedDir, boardName, 'processedData.mat');
        parsave(savePath, processedData, currentConfig);
        
        % E. Visualize (Only if NOT parallel, logic handled by caller choice)
        if config.showFigs
             plotBoardData(processedData, currentConfig);
             drawnow;
             if config.pauseFigs
                 fprintf('  Paused. Press any key to continue...\n');
                 pause; 
             end
        end
        
    catch ME
        fprintf('  ERROR processing %s: %s\n', boardName, ME.message);
    end
end

function parsave(fname, processedData, currentConfig)
    % save() is not valid in parfor directly
    save(fname, 'processedData', 'currentConfig');
end

function validPaths = findSpecimenFolders(currentDir)
    % Recursive finder helper (Copied from loadWoodEyeData to run once here)
    validPaths = {};
    markerFile = fullfile(currentDir, 'FibreDirDown_PosXRelative.txt');
    if exist(markerFile, 'file') == 2
        validPaths{end+1} = currentDir;
        return; 
    end
    items = dir(currentDir);
    subDirs = items([items.isdir]);
    for i = 1:length(subDirs)
        dName = subDirs(i).name;
        if strcmp(dName, '.') || strcmp(dName, '..'), continue; end
        fullPath = fullfile(currentDir, dName);
        validPaths = [validPaths, findSpecimenFolders(fullPath)]; 
    end
end
