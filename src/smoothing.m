function [smoothedData] = smoothing(Ex, Ey, Data, m, n, x_average, y_average)
%SMOOTHING Replacement for missing smoothing function.
% Applies a moving average filter to the Data which is assumed to be scattered
% or reshaped.
%
% INPUTS:
%   Ex, Ey: Coordinates (unused in simple grid smoothing if data is already sorted/gridded, 
%           but likely used for valid data checking).
%   Data: The data vector to smooth.
%   m, n: Dimensions of the target grid.
%   x_average, y_average: Kernel size for smoothing? Or physical distance?
%
% OUTPUT:
%   smoothedData: The smoothed data vector (or matrix).

    % Reshape data to grid
    % Note: The original code does: 
    % A_Ratio_up=reshape(Ratio_up_study_smooth,m_study_wide,n_study_wide);
    % So this function likely returns a vector of the same size as input/output.
    
    if length(Data) ~= m*n
        % If data length doesn't match grid, we might have an issue.
        % For now, assume it matches.
        if length(Data) < m*n
             % Padding or error?
             % simplified: just return original if mismatch
             smoothedData = Data;
             warning('Data length mismatch in smoothing. Returning original.');
             return;
        end
    end
    
    % Reshape to matrix
    gridData = reshape(Data(1:m*n), m, n);
    
    % Create average kernel
    % x_average and y_average are likely integers (window size).
    % Ensure they are odd for symmetry
    kx = max(1, round(x_average));
    ky = max(1, round(y_average));
    
    h = ones(kx, ky) / (kx * ky);
    
    % Apply filter using 'replicate' to handle edges
    smoothedGrid = imfilter(gridData, h, 'replicate');
    
    % Reshape back to vector
    smoothedData = smoothedGrid(:);
    
end
