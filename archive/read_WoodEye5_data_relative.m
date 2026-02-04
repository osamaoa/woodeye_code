function [xin_up,yin_up,fiin_up,ratioin_up,xin_down,yin_down,fiin_down,ratioin_down,xin_left,yin_left,fiin_left,ratioin_left,xin_right,yin_right,fiin_right,ratioin_right]=read_WoodEye4_data(dir_project,specimen)
%[xin_up,yin_up,fiin_up,ratioin_up,xin_down,yin_down,fiin_down,ratioin_down]=read_WoodEye_data(dir_project,specimen)
%-------------------------------------------------------------
% PURPOSE OBS TEXTEN NEDAN (MANUALBLADET) ÄR INTE UPPDATERAT!!!
%  Select the file/files from Aramis corresponding to a certain
%  load, i.e. deliver the path/paths to these files, and the corresponding
%  load.
%
% INPUT:  dir_project:  the search path to the folder containing the project, i.e. the Aramis folders
%
%         m_and_s:      If both master and slave objects are included
%                       'm_and_s = 1', otherwise 'm_and_s = 0'.
%
%         load_fact:    the load factor by which the signal values in the top of the Aramis files should
%                       be multipled to achieve the applied load in Newton (N)
%
%         req_load_fraction: the relative load level requested, i.e. a value between 0 and 1
%                            where 0 correspoinds to zero loading and 1 to
%                            the maximum loading represented in the Aramis
%                            files of the specimen.
%
%         specimen:     The number (integer) of the specimen in the project to be investigated.
%
%       plot_displ_load: This input parameter shall be included if a plot showing the load-displacement-relation
%                       is requested. The value (integer) given by 'plot_displ_load' will be the number of the figure
%                       in which the diagram is plotted.
%
% OUTPUT:       vload:  The total load applid in the current stage.
%
%       load_fraction:  The load fraction (a number between 0 and 1) applied in the current step in relation
%                       to the maximum load applied in any step studied using Aramis. 
%
%       aramis_disp_m:  Matrix containing the current displacements, i.e. the Aramis measurement result 
%                       file (master system if two systems are used)
%
%       aramis_disp_s:  Matrix containing the current displacements, i.e. the Aramis measurement result
%                       file (representing the slave system, only assigned if two systems are used)
%
%-------------------------------------------------------------
%
% LAST MODIFIED: A Olsson  2013-02-06
% Copyright (c)  School of Engineering
%                Linnaeus University
%-------------------------------------------------------------

% Retrieve the name of the files only
dirs=dir(dir_project);
dirs={dirs([dirs.isdir]).name};
% Calculate the length of each name and the max length
len=cellfun('length',dirs);
mLen=max(len); 
idx=len>mLen-2;
len=len(idx);

n_specimens=length(len);
dirs=reshape(dirs(idx)',n_specimens,1);
current_dir_m=dirs(specimen,1);
current_dir_m=current_dir_m{1};
tot_path_m=sprintf('%s\\%s',dir_project,current_dir_m);

path_to_xin_up=sprintf('%s\\%s',tot_path_m,'FibreDirUp_PosXRelative.txt');
path_to_yin_up=sprintf('%s\\%s',tot_path_m,'FibreDirUp_PosY.txt');
path_to_fiin_up=sprintf('%s\\%s',tot_path_m,'FibreDirUp_Angle.txt');
path_to_ratioin_up=sprintf('%s\\%s',tot_path_m,'FibreDirUp_Ratio.txt');

path_to_xin_down=sprintf('%s\\%s',tot_path_m,'FibreDirDown_PosXRelative.txt');
path_to_yin_down=sprintf('%s\\%s',tot_path_m,'FibreDirDown_PosY.txt');
path_to_fiin_down=sprintf('%s\\%s',tot_path_m,'FibreDirDown_Angle.txt');
path_to_ratioin_down=sprintf('%s\\%s',tot_path_m,'FibreDirDown_Ratio.txt');

path_to_xin_left=sprintf('%s\\%s',tot_path_m,'FibreDirLeft_PosXRelative.txt');
path_to_yin_left=sprintf('%s\\%s',tot_path_m,'FibreDirLeft_PosY.txt');
path_to_fiin_left=sprintf('%s\\%s',tot_path_m,'FibreDirLeft_Angle.txt');
path_to_ratioin_left=sprintf('%s\\%s',tot_path_m,'FibreDirLeft_Ratio.txt');

path_to_xin_right=sprintf('%s\\%s',tot_path_m,'FibreDirRight_PosXRelative.txt');
path_to_yin_right=sprintf('%s\\%s',tot_path_m,'FibreDirRight_PosY.txt');
path_to_fiin_right=sprintf('%s\\%s',tot_path_m,'FibreDirRight_Angle.txt');
path_to_ratioin_right=sprintf('%s\\%s',tot_path_m,'FibreDirRight_Ratio.txt');

xin_down=textread(path_to_xin_down,'','emptyvalue',-1);
yin_down=textread(path_to_yin_down,'','emptyvalue',-1);
fiin_down=textread(path_to_fiin_down,'','emptyvalue',-1);
ratioin_down=textread(path_to_ratioin_down,'','emptyvalue',-1);

xin_left=textread(path_to_xin_left,'','emptyvalue',-1); 
yin_left=textread(path_to_yin_left,'','emptyvalue',-1);
fiin_left=textread(path_to_fiin_left,'','emptyvalue',-1);
ratioin_left=textread(path_to_ratioin_left,'','emptyvalue',-1);
xin_right=textread(path_to_xin_right,'','emptyvalue',-1);
yin_right=textread(path_to_yin_right,'','emptyvalue',-1);
fiin_right=textread(path_to_fiin_right,'','emptyvalue',-1);
ratioin_right=textread(path_to_ratioin_right,'','emptyvalue',-1);

try
    xin_up=textread(path_to_xin_up,'','emptyvalue',-1); 
    yin_up=textread(path_to_yin_up,'','emptyvalue',-1);
    fiin_up=textread(path_to_fiin_up,'','emptyvalue',-1);
    ratioin_up=textread(path_to_ratioin_up,'','emptyvalue',-1);
catch
    disp('Up surface fiber error');
    xin_up = xin_down;
    yin_up = yin_down;
    fiin_up = zeros(size(fiin_down));
    ratioin_up = zeros(size(ratioin_down));
end

