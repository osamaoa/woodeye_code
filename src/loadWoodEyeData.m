function data = loadWoodEyeData(specimenPath, config)
% INPUT:
%   specimenPath: Full absolute path to the specimen folder.
%   config: Configuration struct.

    if ~exist(specimenPath, 'dir')
        error('Specimen path does not exist: %s', specimenPath);
    end
    
    sides = {'Down', 'Left', 'Right', 'Up'};
    data = struct();
    
    for i = 1:length(sides)
        side = sides{i};
        lowerSide = lower(side);
        
        files = struct(...
            'xin', sprintf('FibreDir%s_PosXRelative.txt', side), ...
            'yin', sprintf('FibreDir%s_PosY.txt', side), ...
            'fiin', sprintf('FibreDir%s_Angle.txt', side), ...
            'ratioin', sprintf('FibreDir%s_Ratio.txt', side) ...
        );
    
        try
            data.(lowerSide).xin = readDataFile(specimenPath, files.xin);
            data.(lowerSide).yin = readDataFile(specimenPath, files.yin);
            data.(lowerSide).fiin = readDataFile(specimenPath, files.fiin);
            data.(lowerSide).ratioin = readDataFile(specimenPath, files.ratioin);
            
            % Load Image Data (RGB)
            rawDir = fullfile(specimenPath, 'D_raw');
            channels = {'Red', 'Green', 'Blue'};
            loadedChannels = cell(1, 3);
            
            % Pre-check file existence to avoid try-catch overhead
            for c = 1:3
                rawFile = fullfile(rawDir, sprintf('%s%s.raw', channels{c}, side));
                if exist(rawFile, 'file')
                    loadedChannels{c} = loadRawImage(rawFile);
                end
            end
            
            R = loadedChannels{1};
            G = loadedChannels{2};
            B = loadedChannels{3};
            
            if ~isempty(R) && ~isempty(G) && ~isempty(B)
                if isequal(size(R), size(G)) && isequal(size(R), size(B))
                    data.(lowerSide).image = cat(3, R, G, B);
                else
                    data.(lowerSide).image = R;
                end
            elseif ~isempty(R)
                 data.(lowerSide).image = R;
            else
                 data.(lowerSide).image = [];
            end
            
            % Clean Image
            if ~isempty(data.(lowerSide).image)
                data.(lowerSide).image = cleanWoodEyeImage(data.(lowerSide).image, config);
                
                % Post-Cleaning Exposure Adjustment
                if isfield(config, 'exposure_gain') && config.exposure_gain ~= 1.0
                    data.(lowerSide).image = data.(lowerSide).image * config.exposure_gain;
                    data.(lowerSide).image(data.(lowerSide).image > 1) = 1;
                end
            end
            
        catch ME
            if strcmpi(side, 'Up')
                % Fallback logic...
                 if isfield(data, 'down')
                    data.up = data.down;
                    data.up.fiin(:) = 0; % Reset fields that differ
                    data.up.ratioin(:) = 0;
                 end
            else
                % rethrow(ME); % Silent fail for other sides OK?
            end
        end
    end
end

function processedIm = loadRawImage(filePath)
    [im, ~] = IvRawRead_AO(filePath, 0);
    processedIm = double(im);
end

function content = readDataFile(basePath, fileName)
    % Optimized Reader using textscan
    filePath = fullfile(basePath, fileName);
    if ~exist(filePath, 'file')
        error('File not found'); 
    end
    
    % DEBUG: Inspect file format
    if contains(fileName, 'PosXRelative.txt') && contains(basePath, 'Up') 
        fprintf('DEBUG Reading File: %s\n', filePath);
        % type(filePath); 
        % Better: read first line.
        fid_debug = fopen(filePath, 'rt');
        l1 = fgetl(fid_debug);
        l2 = fgetl(fid_debug);
        fclose(fid_debug);
        fprintf('DEBUG Header L1: %s\n', l1);
        fprintf('DEBUG Header L2: %s\n', l2);
    end
    
    fid = fopen(filePath, 'rt');
    if fid == -1, error('Cannot open file'); end
    
    % Read as float array. 'EmptyValue' -1 handled naturally?
    % textscan is much faster than dlmread for large files
    try
        C = textscan(fid, '%f'); 
        content = C{1};
    catch
        content = [];
    end
    fclose(fid);
end
