function cleanedIm = cleanWoodEyeImage(im, config)
%CLEANWOODEYEIMAGE Clean image using manual heuristic logic.
%   cleanedIm = cleanWoodEyeImage(im, config)
%   
%   Uses config.clean_shift_px and config.clean_remove_factor to 
%   crop hard margins and adaptive remove dark rows.

    im = double(im);
    
    % Default params if config missing (fallback)
    if nargin < 2 || ~isstruct(config)
        shift_px = 75;
        remove_pxl_factor = 0.7;
    else
        if isfield(config, 'clean_shift_px')
            shift_px = config.clean_shift_px;
        else
            shift_px = 75;
        end
        if isfield(config, 'clean_remove_factor')
            remove_pxl_factor = config.clean_remove_factor;
        else
            remove_pxl_factor = 0.7;
        end
    end

    % Normalize to 0-1
    im = im / 255;
    
    % Grayscale for analysis
    im_gray = im(:,:,1); 
    
    % Check size safety
    if size(im, 1) <= 2*shift_px
        warning('Image height too small for shift_px %d. returning original.', shift_px);
        cleanedIm = im;
        return;
    end

    % Logic from User:
    % 1. Calculate Mean of Rows (avg_col) excluding top/bottom shift margins
    avg_col = mean(im_gray(shift_px:end-shift_px, :), 2);
    
    % 2. Calculate threshold based on Global Mean of that profile
    m_avg_col = mean(avg_col);
    
    % 3. Identify Rows to remove
    remove_pxl = avg_col < (remove_pxl_factor * m_avg_col);

    % 4. Crop image hard at margins
    im = im(shift_px:end-shift_px, :, :);
    
    % 5. Adaptive remove
    cleanedIm = im(~remove_pxl, :, :);

end
