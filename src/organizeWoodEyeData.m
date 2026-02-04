function organizeWoodEyeData(projectDir)
%ORGANIZEWOODEYEDATA Replicates the legacy folder creation logic.
%   Takes 'simulation' and 'raw' folders within projectDir and organizes 
%   files into 'organized/B_XXX' structure.
%
%   Replaces: create_folders_step_1.m and create_folders_step_2.m

    simulationDir = fullfile(projectDir, 'simulation');
    rawDir = fullfile(projectDir, 'raw');
    organizedDir = fullfile(projectDir, 'organized');
    
    if ~exist(simulationDir, 'dir')
        error('Simulation directory not found: %s', simulationDir);
    end
    
    if ~exist(rawDir, 'dir')
        error('Raw directory not found: %s', rawDir);
    end
    
    if ~exist(organizedDir, 'dir')
        mkdir(organizedDir);
        fprintf('Created organized directory: %s\n', organizedDir);
    end
    
    %% Step 1: Process Simulation Data (.txt)
    fprintf('Processing Simulation Data (.txt)...\n');
    processSimulationData(simulationDir, organizedDir);
    
    %% Step 2: Process Raw Data (.raw)
    fprintf('Processing Raw Data (.raw)...\n');
    processRawData(rawDir, organizedDir);
    
    fprintf('Organization complete.\n');

end

function processSimulationData(sourceDir, targetBaseDir)
    files = dir(sourceDir);
    files = {files.name};
    % Remove . and .. (and maybe others? Legacy removed 1:2)
    files(1:2) = []; 
    
    % Legacy logic assumes blocks of 60
    filesPerBoard = 60;
    nboards = floor(length(files) / filesPerBoard);
    
    % Verify count
    if mod(length(files), filesPerBoard) ~= 0
        warning('File count in simulation (%d) is not divisible by %d. Last partial board might be skipped or cause error.', length(files), filesPerBoard);
    end
    
    % Reshape (Legacy logic assumes alphabetical sort order matches this shape)
    % files = reshape(files, nboards, filesPerBoard); 
    % Matlab reshape takes column-wise. Files are row vector?
    % files is 1xN cell. Reshape(files, N, 60) -> column 1 is first N files?
    % Legacy: files=reshape(files,nboards,60);
    % If default dir() return is sorted: [B1_1, B1_2... B1_60, B2_1...]
    % Then reshape(files, nboards, 60) would take [1, 1+N, 2+N...]?
    % NO. Matlab's DIR returns 1xN struct/cell.
    % If I reshape to (N, 60), it fills columns first.
    % So col 1 has indices 1, 2, 3... N.
    % This implies the file list is NOT sorted by board sequentially [B1... B1, B2... B2].
    % It implies sorting is [B1_file1, B2_file1, B3_file1...]?
    % Let's look at legacy index array. 
    % index=[1 10 100...] -> Suggests alphabetical sorting: 1, 10, 100, 101...
    % So files are likely: [Board1_FileA, Board10_FileA, Board100_FileA...]
    
    sortedFiles = sort(files); % Ensure consistent sorting
    % Note: dir() usually sorts, but case sensitivity varies.
    
    % Reconstruct Legacy Index Mapping
    % This maps the alphabetical index (row in reshape) to physical board number.
    % e.g. Row 1 corresponds to Board 1. Row 2 -> Board 10.
    index = generateLegacyIndexMap(nboards);
    
    fileMatrix = reshape(sortedFiles(1:nboards*filesPerBoard), nboards, filesPerBoard);
    
    for k = 1:nboards
        boardNum = index(k);
        boardDirName = sprintf('B_%03d', boardNum);
        targetDir = fullfile(targetBaseDir, boardDirName);
        
        if ~exist(targetDir, 'dir')
            mkdir(targetDir);
        end
        
        for j = 1:filesPerBoard
            fn = fileMatrix{k, j};
            % Stripping logic
            % If index < 10: remove last 6 chars
            % If index < 100: remove last 7 chars
            % If index < 1000: remove last 8 chars
            
            % Replicate strict legacy logic
            fno = fn;
            lfn = length(fn);
            
            if boardNum < 10
                newName = fn(1:(lfn-6));
            elseif boardNum < 100
                newName = fn(1:(lfn-7));
            elseif boardNum < 1000
                newName = fn(1:(lfn-8));
            else
                newName = fn; % Fallback
            end
            
            newName = [newName '.txt'];
            
            sourceFile = fullfile(sourceDir, fno);
            destFile = fullfile(targetDir, newName);
            
            copyfile(sourceFile, destFile);
        end
    end
end

function processRawData(sourceDir, targetBaseDir)
    files = dir(sourceDir);
    files = {files.name};
    files(1:2) = []; 
    
    % Filter out excluded files (Legacy Step 2)
    excludes = {'Moisture.raw', 'Frequency.txt', 'Weight.txt', 'rawsplit.bat'};
    keepMask = true(size(files));
    for i = 1:length(files)
        if any(strcmp(files{i}, excludes))
            keepMask(i) = false;
        end
    end
    files = files(keepMask);
    
    filesPerBoard = 28;
    nboards = floor(length(files) / filesPerBoard);
    
    if mod(length(files), filesPerBoard) ~= 0
        warning('File count in raw (%d) is not divisible by %d.', length(files), filesPerBoard);
    end
    
    sortedFiles = sort(files);
    
    index = generateLegacyIndexMap(nboards);
    fileMatrix = reshape(sortedFiles(1:nboards*filesPerBoard), nboards, filesPerBoard);
    
    for k = 1:nboards
        boardNum = index(k);
        boardDirName = sprintf('B_%03d', boardNum);
        targetDir = fullfile(targetBaseDir, boardDirName, 'D_raw');
        
        if ~exist(targetDir, 'dir')
            mkdir(targetDir);
        end
        
        for j = 1:filesPerBoard
            fn = fileMatrix{k, j};
            fno = fn;
            lfn = length(fn);
            
            % Step 2 Stripping Logic (slightly different counts in legacy?)
            % Legacy Step 2: <10: -5, <100: -6, <1000: -7
            
            if boardNum < 10
                newName = fn(1:(lfn-5));
            elseif boardNum < 100
                newName = fn(1:(lfn-6));
            elseif boardNum < 1000
                newName = fn(1:(lfn-7));
            else
                newName = fn;
            end
            
            newName = [newName '.raw'];
            
            sourceFile = fullfile(sourceDir, fno);
            destFile = fullfile(targetDir, newName);
            
            copyfile(sourceFile, destFile);
        end
    end
end

function index = generateLegacyIndexMap(nboards)
    % Generates the sorting index array used in original code
    % to map alphabetical file order to board IDs.
    % 1, 10, 100..109, 11, 110..119 ...
    
    % We can generate this dynamically or use the hardcoded list.
    % Hardcoded ensures exact match.
    
    indexBase=[1 10 100:109 11 110:119 12 120:129 13 130:139 14 140:149 15 150:159 16 160:169 17 170:179 18 180:189 19 190:199 ...
               2 20 200:209 21 210:219 22 220:229 23 230:239 24 240:249 25 250:259 26 260:269 27 270:279 28 280:289 29 290:299 ...
               3 30 300:309 31 310:319 32 320:329 33 330:339 34 340:349 35 350:359 36 360:369 37 370:379 38 380:389 39 390:399 ...
               4 40 400:409 41 410:419 42 420:429 43 430:439 44 440:449 45 450:459 46 460:469 47 470:479 48 480:489 49 490:499 ...
               5 50 500:509 51 510:519 52 520:529 53 530:539 54 540:549 55 550:559 56 560:569 57 570:579 58 580:589 59 590:599 ...
               6 60 600:609 61 610:619 62 620:629 63 630:639 64 640:649 65 650:659 66 660:669 67 670:679 68 680:689 69 690:699 ...
               7 70 700:709 71 710:719 72 720:729 73 730:739 74 740:749 75 750:759 76 760:769 77 770:779 78 780:789 79 790:799 ...
               8 80 800:809 81 810:819 82 820:829 83 830:839 84 840:849 85 850:859 86 860:869 87 870:879 88 880:889 89 890:899 ...
               9 90 900:909 91 910:919 92 920:929 93 930:939 94 940:949 95 950:959 96 960:969 97 970:979 98 980:989 99 990:999];
           
    % Filter to nboards
    validIndices = indexBase <= nboards;
    index = indexBase(validIndices);
    
    % If nboards > max in list, we might have issues.
    % Also check if length matches.
    if length(index) < nboards
        warning('Legacy Index Map could not cover all %d boards. Check hardcoded limits.', nboards);
    end
    
    % Crop to exact nboards needed (since files are filtered)
    index = index(1:nboards);
end
