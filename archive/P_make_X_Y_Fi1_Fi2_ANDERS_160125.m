% This script was last updated 2015-12-17 by Anders Olsson

% The function read_WoodEye_data import results from the scanning and establishes matrises with information of fibre orientation "ratio" and coordinates in x- and y-direction.    
%[xin_up,yin_up,fiin_up,ratioin_up,xin_down,yin_down,fiin_down,ratioin_down,xin_left,yin_left,fiin_left,ratioin_left,xin_right,yin_right,fiin_right,ratioin_right]=read_WoodEye4_data(dir_WoodEye_project,board);
if WE5==1
    [xin_up,yin_up,fiin_up,ratioin_up,xin_down,yin_down,fiin_down,ratioin_down,xin_left,yin_left,fiin_left,ratioin_left,xin_right,yin_right,fiin_right,ratioin_right]=read_WoodEye5_data_relative(dir_WoodEye_project,board);
else
    [xin_up,yin_up,fiin_up,ratioin_up,xin_down,yin_down,fiin_down,ratioin_down,xin_left,yin_left,fiin_left,ratioin_left,xin_right,yin_right,fiin_right,ratioin_right]=read_WoodEye4_data_relative(dir_WoodEye_project,board);
end

% yin_up=yin_up+10000*(abs((yin_up-abs(yin_up))/(-2)-1));  % Adds 10 mm%%%%
% on all y-coordinates BORTTAGET 160103. ERSÄTTAS MED
% KORRIGERINGSPARAMETRAR I FILEN Specific_project_path_and_settings_151222
% samt att sdfix_A ersätts med sdfix_AAA...

%---------------------------------------------------------------------------
%---------------------------------------------------------------------------
%trust_edge=1;
[X_s,Y_s,Fi_s,Ratio_s]=sdfix_AAA(L,H,use_relative_X,adjust_par_xy(:,1),xin_up,yin_up,fiin_up,ratioin_up);  % FYLLER I SAKNADE VÄRDEN (KONSTATERAT 151217)
AA_X_up=X_s';
AA_Y_up=Y_s';
AA_Ratio_up=Ratio_s;
AA_Fi2_up=-Fi_s+90;
% if WE5==1   % OBS !!!!!!!!!!!!!!
%     AA_Fi2_up=-AA_Fi2_up;       
% end
AA_Ratio_up=AA_Ratio_up(:,length(AA_X_up)+1-[1:length(AA_X_up)]);
AA_Fi2_up=-AA_Fi2_up(:,length(AA_X_up)+1-[1:length(AA_X_up)]);
[AA_Fi1_up]=make_fi1_from_ratio(AA_Ratio_up,ratio_limits);

[X_s,Y_s,Fi_s,Ratio_s]=sdfix_AAA(L,H,use_relative_X,adjust_par_xy(:,2),xin_down,yin_down,fiin_down,ratioin_down);  % FYLLER I SAKNADE VÄRDEN (KONSTATERAT 151217)
AA_X_down=X_s';
AA_Y_down=Y_s';
AA_Ratio_down=Ratio_s;
AA_Fi2_down=-Fi_s+90;
[AA_Fi1_down]=make_fi1_from_ratio(AA_Ratio_down,ratio_limits);

[X_s,Y_s,Fi_s,Ratio_s]=sdfix_AAA(L,B,use_relative_X,adjust_par_xy(:,3),xin_right,yin_right,fiin_right,ratioin_right);  % FYLLER I SAKNADE VÄRDEN (KONSTATERAT 151217)
AA_X_right=X_s';
AA_Y_right=Y_s';
AA_Ratio_right=Ratio_s;
AA_Fi2_right=-Fi_s+90;
AA_Ratio_right=AA_Ratio_right(:,length(AA_X_right)+1-[1:length(AA_X_right)]);
AA_Fi2_right=-AA_Fi2_right(:,length(AA_X_right)+1-[1:length(AA_X_right)]);
[AA_Fi1_right]=make_fi1_from_ratio(AA_Ratio_right,ratio_limits);

[X_s,Y_s,Fi_s,Ratio_s]=sdfix_AAA(L,B,use_relative_X,adjust_par_xy(:,4),xin_left,yin_left,fiin_left,ratioin_left);  % FYLLER I SAKNADE VÄRDEN (KONSTATERAT 151217)
AA_X_left=X_s';
AA_Y_left=Y_s';
AA_Ratio_left=Ratio_s;
AA_Fi2_left=-Fi_s+90;
[AA_Fi1_left]=make_fi1_from_ratio(AA_Ratio_left,ratio_limits);

X_DOWN=AA_X_down*1000;
Y_DOWN=AA_Y_down'*1000; 
Fi1_DOWN=AA_Fi1_down*pi/180;
Fi2_DOWN=AA_Fi2_down*pi/180;
A_Ratio_DOWN=AA_Ratio_down;

X_UP=AA_X_up*1000;
Y_UP=AA_Y_up'*1000; 
Fi1_UP=AA_Fi1_up*pi/180;
Fi2_UP=AA_Fi2_up*pi/180;
A_Ratio_UP=AA_Ratio_up;

X_RIGHT=AA_X_left*1000;
Y_RIGHT=AA_Y_left'*1000; 
Fi1_RIGHT=AA_Fi1_left*pi/180;
Fi2_RIGHT=AA_Fi2_left*pi/180;
A_Ratio_RIGHT=AA_Ratio_left;
   
X_LEFT=AA_X_right*1000;
Y_LEFT=AA_Y_right'*1000; 
Fi1_LEFT=AA_Fi1_right*pi/180;
Fi2_LEFT=AA_Fi2_right*pi/180;
A_Ratio_LEFT=AA_Ratio_right;

Z_DOWN=0;
Z_UP=B*1000;
%clear X_narrow
Z_LEFT=X_LEFT;
Z_RIGHT=X_RIGHT;

%---------------------------------------------------------------------------

% % % %A_Ratio_DOWN
% % % %A_Ratio_UP
% % % %A_Ratio_LEFT
% % % %A_Ratio_RIGHT
% % % [nrD,ncD]=size(A_Ratio_DOWN);
% % % [nrU,ncU]=size(A_Ratio_UP);
% % % AD1=A_Ratio_DOWN(:,1);
% % % ADn=A_Ratio_DOWN(:,ncD);
% % % AU1=A_Ratio_UP(:,1);
% % % AUn=A_Ratio_UP(:,ncU);
% % % 
% % % figure(11)
% % % plot(Y_DOWN,AD1);
% % % figure(12)
% % % plot(Y_DOWN,ADn);
% % % figure(13)
% % % plot(Y_UP,AU1);
% % % figure(14)
% % % plot(Y_UP,AUn);
% % % 
% % % if 1==1
% % %     L_moving_average_1=400;
% % %     L_moving_average_2=100;
% % %     for edge=1:4
% % %         if edge==1
% % %             [nr,nc]=size(A_Ratio_DOWN);
% % %             A_edge=A_Ratio_DOWN(:,1);
% % %             Y_SIDE=Y_DOWN;
% % %         elseif edge==2
% % %             [nr,nc]=size(A_Ratio_DOWN);
% % %             A_edge=A_Ratio_DOWN(:,nc);
% % %             Y_SIDE=Y_DOWN;
% % %         elseif edge==3
% % %             [nr,nc]=size(A_Ratio_UP);
% % %             A_edge=A_Ratio_UP(:,1);
% % %             Y_SIDE=Y_UP;
% % %         elseif edge==4
% % %             [nr,nc]=size(A_Ratio_UP);
% % %             A_edge=A_Ratio_UP(:,nc);
% % %             Y_SIDE=Y_UP;
% % %         end
% % % 
% % %         diff_A_edge=(A_edge(2:nr)-A_edge(1:(nr-1)));
% % %         if edge==1
% % %             mean_diff_1=mean(abs(diff_A_edge));
% % %         elseif edge==2
% % %             mean_diff_2=mean(abs(diff_A_edge));
% % %         elseif edge==3
% % %             mean_diff_3=mean(abs(diff_A_edge));
% % %         elseif edge==4
% % %             mean_diff_4=mean(abs(diff_A_edge));
% % %         end        
% % %         abs_deriv_A_edge=abs(diff_A_edge);
% % %         mean_maL_abs_deriv_A_edge_1=zeros(nr-1,1);
% % %         mean_maL_abs_deriv_A_edge_2=zeros(nr-1,1);
% % %         shift_percent=zeros(nr-1,1);
% % %         mean_maL_A_edge_1=zeros(nr,1);
% % %         mean_maL_A_edge_2=zeros(nr,1);
% % %         for k=1:nr
% % %             min_Y_1=max([Y_DOWN(k)-L_moving_average_1/2 0]);
% % %             max_Y_1=min([Y_DOWN(k)+L_moving_average_1/2 L*1000]);
% % %             [rr,min_k_1]=min(abs(Y_DOWN-min_Y_1));
% % %             [rr,max_k_1]=min(abs(Y_DOWN-max_Y_1));
% % %             max_k_1=min([max_k_1 nr-1]);
% % %             mean_maL_A_edge_1(k)=mean(A_edge(min_k_1:max_k_1));
% % %             mean_maL_abs_deriv_A_edge_1(k)=mean(abs_deriv_A_edge(min_k_1:max_k_1));
% % %             
% % %             min_Y_2=max([Y_DOWN(k)-L_moving_average_2/2 0]);
% % %             max_Y_2=min([Y_DOWN(k)+L_moving_average_2/2 L*1000]);
% % %             [rr,min_k_2]=min(abs(Y_DOWN-min_Y_2));
% % %             [rr,max_k_2]=min(abs(Y_DOWN-max_Y_2));
% % %             max_k_2=min([max_k_2 nr-1]);
% % %             mean_maL_A_edge_2(k)=mean(A_edge(min_k_2:max_k_2));
% % %             mean_maL_abs_deriv_A_edge_2(k)=mean(abs_deriv_A_edge(min_k_2:max_k_2));
% % %             sign_dA_2=(diff_A_edge(min_k_2:max_k_2)-mean_maL_abs_deriv_A_edge_2(k))./abs(diff_A_edge(min_k_2:max_k_2)-mean_maL_abs_deriv_A_edge_2(k));
% % % 
% % %             le=length(sign_dA_2);
% % %             shift_percent(k)=sum(abs((sign_dA_2(2:le)-sign_dA_2(1:(le-1)))/5))/(le-1);
% % %             
% % %         end
% % % 
% % %         figure(20+edge)
% % %         clf
% % %         hold on
% % %         plot(Y_SIDE,mean_maL_abs_deriv_A_edge_1.*mean_maL_A_edge_1.^1);
% % %         plot(Y_SIDE,shift_percent/10,'r');
% % %         grid on
% % %         axis([0 L*1000 0 0.1])
% % % 
% % %     end
% % % end

%pause






%---------------------------------------------------------------------------

% % Fibre orientation information is established for all four sides of the
% % board for the dimensions (L, H and B) given
% 
% [Ex_up,Ey_up,Eval_up_fi,X_up,Y_up,Eval_2D_up_fi,Eval_up_ratio,Eval_2D_up_ratio,start_l_up,end_l_up]=we_data_to_mesh_A(L,H,xin_up,yin_up,fiin_up,1,1,ratioin_up);
% [Ex_down,Ey_down,Eval_down_fi,X_down,Y_down,Eval_2D_down_fi,Eval_down_ratio,Eval_2D_down_ratio,start_l_down,end_l_down]=we_data_to_mesh_A(L,H,xin_down,yin_down,fiin_down,1,1,ratioin_down);
% [Ex_left,Ey_left,Eval_left_fi,X_left,Y_left,Eval_2D_left_fi,Eval_left_ratio,Eval_2D_left_ratio,start_l_leftp,end_l_left]=we_data_to_mesh_A(L,B,xin_left,yin_left,fiin_left,1,1,ratioin_left);
% [Ex_right,Ey_right,Eval_right_fi,X_right,Y_right,Eval_2D_right_fi,Eval_right_ratio,Eval_2D_right_ratio,start_l_right,end_l_right]=we_data_to_mesh_A(L,B,xin_right,yin_right,fiin_right,1,1,ratioin_right);
% 
% % [Ex_up,Ey_up,Eval_up_fi,X_up,Y_up,Eval_2D_up_fi,Eval_up_ratio,Eval_2D_up_ratio,start_l_up,end_l_up]=we_data_to_mesh_2(L,H,xin_up,yin_up,fiin_up,1,1,ratioin_up);
% % [Ex_down,Ey_down,Eval_down_fi,X_down,Y_down,Eval_2D_down_fi,Eval_down_ratio,Eval_2D_down_ratio,start_l_down,end_l_down]=we_data_to_mesh_2(L,H,xin_down,yin_down,fiin_down,1,1,ratioin_down);
% % [Ex_left,Ey_left,Eval_left_fi,X_left,Y_left,Eval_2D_left_fi,Eval_left_ratio,Eval_2D_left_ratio,start_l_leftp,end_l_left]=we_data_to_mesh_2(L,B,xin_left,yin_left,fiin_left,1,1,ratioin_left);
% % [Ex_right,Ey_right,Eval_right_fi,X_right,Y_right,Eval_2D_right_fi,Eval_right_ratio,Eval_2D_right_ratio,start_l_right,end_l_right]=we_data_to_mesh_2(L,B,xin_right,yin_right,fiin_right,1,1,ratioin_right);
% % Fi1 is the divingangle. Fi2 is the fiberangle in the plane. 
% 
% % Fibre orientation information is established, in the resolution decided by the user. Local cordinate systems are used for all four sides of the board.  
% 
% %------------Fiber orientation for all four sides of the board. 
% part_to_study_manipulated_wide=part_to_study_wide+[-L/(m_study_wide-1)/2 L/(m_study_wide-1)/2 -H/(n_study_wide-1)/2 H/(n_study_wide-1)/2];
% part_to_study_manipulated_narrow=part_to_study_narrow+[-L/(m_study_narrow-1)/2 L/(m_study_narrow-1)/2 -B/(n_study_narrow-1)/2 B/(n_study_narrow-1)/2];
% 
% [Ex_up_study,Ey_up_study,Ratio_up_study,X_up_study,Y_up_study,Ratio_2D_up_study]=new_mesh_A(Ex_up,Ey_up,Eval_up_ratio,m_study_wide,n_study_wide,[1 1],part_to_study_manipulated_wide);
% [Ex_up_study,Ey_up_study,Fi_up_study,X_up_study,Y_up_study,Fi_2D_up_study]=new_mesh_A(Ex_up,Ey_up,Eval_up_fi,m_study_wide,n_study_wide,[1 1],part_to_study_manipulated_wide);
% [Ex_down_study,Ey_down_study,Ratio_down_study,X_down_study,~,Ratio_2D_down_study]=new_mesh_A(Ex_down,Ey_down,Eval_down_ratio,m_study_wide,n_study_wide,[1 1],part_to_study_manipulated_wide);
% [Ex_down_study,Ey_down_study,Fi_down_study,X_down_study,Y_down_study,Fi_2D_down_study]=new_mesh_A(Ex_down,Ey_down,Eval_down_fi,m_study_wide,n_study_wide,[1 1],part_to_study_manipulated_wide);
% [Ex_left_study,Ey_left_study,Ratio_left_study,X_left_study,Y_left_study,Ratio_2D_left_study]=new_mesh_A(Ex_left,Ey_left,Eval_left_ratio,m_study_narrow,n_study_narrow,[1 1],part_to_study_manipulated_narrow);
% [Ex_left_study,Ey_left_study,Fi_left_study,X_left_study,Y_left_study,Fi_2D_left_study]=new_mesh_A(Ex_left,Ey_left,Eval_left_fi,m_study_narrow,n_study_narrow,[1 1],part_to_study_manipulated_narrow);
% [Ex_right_study,Ey_right_study,Ratio_right_study,X_right_study,Y_right_study,Ratio_2D_right_study]=new_mesh_A(Ex_right,Ey_right,Eval_right_ratio,m_study_narrow,n_study_narrow,[1 1],part_to_study_manipulated_narrow);
% [Ex_right_study,Ey_right_study,Fi_right_study,X_right_study,Y_right_study,Fi_2D_right_study]=new_mesh_A(Ex_right,Ey_right,Eval_right_fi,m_study_narrow,n_study_narrow,[1 1],part_to_study_manipulated_narrow);
% Fi_2D_up_study=Fi_2D_up_study+90;           % Ny rad 141128 !!!
% Fi_2D_down_study=Fi_2D_down_study+90; %-90;       % Ny rad 141128 !!!
% Fi_up_study=Fi_up_study+90;           % Ny rad 141128 !!!
% Fi_down_study=Fi_down_study+90; %-90;       % Ny rad 141128 !!!
% Fi_2D_left_study=Fi_2D_left_study+90;           % Ny rad 141128 !!!
% Fi_2D_right_study=Fi_2D_right_study+90; %-90;       % Ny rad 141128 !!!
% Fi_left_study=Fi_left_study+90;           % Ny rad 141128 !!!
% Fi_right_study=Fi_right_study+90; %-90;       % Ny rad 141128 !!!
% 
% if WE5==1   % OBS !!!!!!!!!!!!!!
%     Fi_2D_up_study=-Fi_2D_up_study;       
%     Fi_2D_down_study=-Fi_2D_down_study; 
%     Fi_up_study=-Fi_up_study;           
%     Fi_down_study=-Fi_down_study; 
%     Fi_2D_left_study=-Fi_2D_left_study;          
%     Fi_2D_right_study=-Fi_2D_right_study; 
%     Fi_left_study=-Fi_left_study;          
%     Fi_right_study=-Fi_right_study; 
% end
% 
% % Smoothing is applied for fibre angles and ratios, according to the choice of the user. 
% 
% % Smoothing for the up and down side.
% [Ratio_up_study_smooth]=smoothing(Ex_up_study,Ey_up_study,Ratio_up_study,m_study_wide,n_study_wide,x_average,y_average); 
% [Ratio_down_study_smooth]=smoothing(Ex_down_study,Ey_down_study,Ratio_down_study,m_study_wide,n_study_wide,x_average,y_average); 
% [Fi_up_study_smooth]=smoothing(Ex_up_study,Ey_up_study,Fi_up_study,m_study_wide,n_study_wide,x_average,y_average); 
% [Fi_down_study_smooth]=smoothing(Ex_down_study,Ey_down_study,Fi_down_study,m_study_wide,n_study_wide,x_average,y_average); 
% % Fi_up_study_smooth=Fi_up_study;
% % Fi_down_study_smooth=Fi_down_study;
% A_Ratio_up=reshape(Ratio_up_study_smooth,m_study_wide,n_study_wide);
% A_Ratio_down=reshape(Ratio_down_study_smooth,m_study_wide,n_study_wide);
% A_Ratio_up=A_Ratio_up(:,n_study_wide+1-[1:n_study_wide]);
% A_Fi2_up=-reshape(Fi_up_study_smooth,m_study_wide,n_study_wide);      
% A_Fi2_down=-reshape(Fi_down_study_smooth,m_study_wide,n_study_wide);      
% A_Fi2_up=-A_Fi2_up(:,n_study_wide+1-[1:n_study_wide]);
% A_X_wide=Y_up_study';
% A_Y_wide=X_up_study';
% 
%    %-----
%    limits=ratio_limits;
%    dl=limits(2)-limits(1);
%    sl=sum(limits);
%    e02=1;
%    [ru,cu]=size(A_Ratio_up);
%    A_Fi1_up=zeros(ru,cu);
%    A_Fi1_down=zeros(ru,cu);
%    for r=1:ru 
%        for c=1:cu
%            if A_Ratio_up(r,c)<limits(1)
%               A_Fi1_up(r,c)=0;
%            elseif A_Ratio_up(r,c)>limits(2)
%               A_Fi1_up(r,c)=90;
%            else
%               rr=(A_Ratio_up(r,c)-sl/2)/(dl/2);
%               A_Fi1_up(r,c)=(rr/abs(rr)*real(acos(sqrt((1-rr^2)/e02))*180/pi)+90)/2;
%            end
%            if A_Ratio_down(r,c)<limits(1)
%               A_Fi1_down(r,c)=0;
%            elseif A_Ratio_down(r,c)>limits(2)
%               A_Fi1_down(r,c)=90;
%            else
%               rr=(A_Ratio_down(r,c)-sl/2)/(dl/2);
%               A_Fi1_down(r,c)=(rr/abs(rr)*real(acos(sqrt((1-rr^2)/e02))*180/pi)+90)/2;
%            end
%        end
%    end
%    
%   
%    X_DOWN=Y_down_study'*1000;
%    Y_DOWN=X_down_study'*1000; 
%    Fi1_DOWN=A_Fi1_down*pi/180;
%    Fi2_DOWN=A_Fi2_down*pi/180;
%    A_Ratio_DOWN=A_Ratio_down;
% 
%    X_UP=Y_up_study'*1000;
%    Y_UP=X_up_study'*1000; 
%    Fi1_UP=A_Fi1_up*pi/180;
%    Fi2_UP=A_Fi2_up*pi/180;
%    A_Ratio_UP=A_Ratio_up;
% 
%    X_wide=Y_down_study'*1000;
%    Y_wide=X_down_study'*1000; 
%    Z_wide=[0 B]*1000;
%    Fi1_wide=[Fi1_DOWN; Fi1_UP];
%    Fi2_wide=[Fi2_DOWN; Fi2_UP];
% 
%    %%% %%% %%%
% 
%    
% % Smoothing for the left and right side.
%    
% [Ratio_right_study_smooth]=smoothing(Ex_right_study,Ey_right_study,Ratio_right_study,m_study_narrow,n_study_narrow,x_average,y_average); 
% [Ratio_left_study_smooth]=smoothing(Ex_left_study,Ey_left_study,Ratio_left_study,m_study_narrow,n_study_narrow,x_average,y_average); 
% [Fi_right_study_smooth]=smoothing(Ex_right_study,Ey_right_study,Fi_right_study,m_study_narrow,n_study_narrow,x_average,y_average); 
% [Fi_left_study_smooth]=smoothing(Ex_left_study,Ey_left_study,Fi_left_study,m_study_narrow,n_study_narrow,x_average,y_average); 
% % Fi_left_study_smooth=Fi_left_study;
% % Fi_right_study_smooth=Fi_right_study;
% A_Ratio_right=reshape(Ratio_right_study_smooth,m_study_narrow,n_study_narrow);
% A_Ratio_left=reshape(Ratio_left_study_smooth,m_study_narrow,n_study_narrow);
% A_Ratio_right=A_Ratio_right(:,n_study_narrow+1-[1:n_study_narrow]);
% A_Fi2_right=-reshape(Fi_right_study_smooth,m_study_narrow,n_study_narrow);      
% A_Fi2_left=-reshape(Fi_left_study_smooth,m_study_narrow,n_study_narrow);      
% A_Fi2_right=-A_Fi2_right(:,n_study_narrow+1-[1:n_study_narrow]);
% A_X_narrow=Y_right_study';
% A_Y_narrow=X_right_study';
%    %-----
%    limits=ratio_limits;
%    dl=limits(2)-limits(1);
%    sl=sum(limits);
%    e02=1;
%    [ru,cu]=size(A_Ratio_right);
%    A_Fi1_right=zeros(ru,cu);
%    A_Fi1_left=zeros(ru,cu);
%    for r=1:ru 
%        for c=1:cu
%            if A_Ratio_right(r,c)<limits(1)
%               A_Fi1_right(r,c)=0;
%            elseif A_Ratio_right(r,c)>limits(2)
%               A_Fi1_right(r,c)=90;
%            else
%               rr=(A_Ratio_right(r,c)-sl/2)/(dl/2);
%               A_Fi1_right(r,c)=(rr/abs(rr)*real(acos(sqrt((1-rr^2)/e02))*180/pi)+90)/2;
%            end
%            if A_Ratio_left(r,c)<limits(1)
%               A_Fi1_left(r,c)=0;
%            elseif A_Ratio_left(r,c)>limits(2)
%               A_Fi1_left(r,c)=90;
%            else
%               rr=(A_Ratio_left(r,c)-sl/2)/(dl/2);
%               A_Fi1_left(r,c)=(rr/abs(rr)*real(acos(sqrt((1-rr^2)/e02))*180/pi)+90)/2;
%            end
%        end
%    end
%    
% 
%    
% % OBS!!! Switches the right side to the left side and the opposite for both
% % fiberangles and ratio.
% 
%    X_LEFT=Y_left_study'*1000;
%    Y_LEFT=X_left_study'*1000; 
%    Fi1_RIGHT=A_Fi1_left*pi/180;
%    Fi2_RIGHT=A_Fi2_left*pi/180;
%    A_Ratio_RIGHT=A_Ratio_left;
%    
%    X_RIGHT=Y_right_study'*1000;
%    Y_RIGHT=X_right_study'*1000; 
%    Fi1_LEFT=A_Fi1_right*pi/180;
%    Fi2_LEFT=A_Fi2_right*pi/180;
%    A_Ratio_LEFT=A_Ratio_right;
% 
% % Mirror fiberangles on left side OBS!!! VARFÖR???
% %    [nr,nk]=size(Fi1_LEFT);
% %    Fi1_LEFT_temp=zeros(nr,nk);
% %    Fi2_LEFT_temp=zeros(nr,nk);
% %    for k=1:nk
% %         Fi1_LEFT_temp(:,k)=Fi1_LEFT(:,nk+1-k);
% %         Fi2_LEFT_temp(:,k)=Fi2_LEFT(:,nk+1-k);
% %    end
% %    Fi1_LEFT=Fi1_LEFT_temp;
% %    Fi2_LEFT=Fi2_LEFT_temp;
% 
% 
%    X_narrow=Y_left_study'*1000;
%    Y_narrow=X_left_study'*1000; 
%    Z_narrow=[0 H]*1000;
%    Fi1_narrow=[Fi1_LEFT; Fi1_RIGHT];
%    Fi2_narrow=[Fi2_LEFT; Fi2_RIGHT];
%    
% % -------------- From local to global cordinates--------------------------
%    Z_narrow=X_narrow;
%    clear X_narrow
%    
%    Z_LEFT=X_LEFT;
%    Z_RIGHT=X_RIGHT;
%    
%    
%    
% 
%    
%    
%    
%    
%    
%    
%    
%    
%    
%    
%    
%    %--------------------------------------------
%       %[nr,nk]=size(Fi1_RIGHT);
%    %Fi1_RIGHT_temp=zeros(nr,nk);
%    %Fi2_RIGHT_temp=zeros(nr,nk);
%    %for k=1:nk
%    %     Fi1_RIGHT_temp(:,k)=Fi1_RIGHT(:,nk+1-k);
%    %     Fi2_RIGHT_temp(:,k)=Fi2_RIGHT(:,nk+1-k);
%    %end
%    %Fi1_RIGHT=Fi1_RIGHT_temp;
%    %Fi2_RIGHT=Fi2_RIGHT_temp;
%    % Kom ihåg att ratio inte är "vänt på" 
%    % ---------------------------------------------- 
% % [nr,nk]=size(xin_right);
% % xin_right_temp=zeros(nr,nk);
% % yin_right_temp=zeros(nr,nk);
% % fiin_right_temp=zeros(nr,nk);
% % ratioin_right_temp=zeros(nr,nk);
% % for k=1:nk
% %     xin_right_temp(:,k)=xin_right(:,nk+1-k);
% %     yin_right_temp(:,k)=yin_right(:,nk+1-k);
% %     fiin_right_temp(:,k)=fiin_right(:,nk+1-k);
% %     ratioin_right_temp(:,k)=ratioin_right(:,nk+1-k);
% % end
% % xin_right=xin_right_temp;
% % yin_right=yin_right_temp;
% % fiin_right=fiin_right_temp;
% % ratioin_right=ratioin_right_temp;
% % 
% % [nr,nk]=size(xin_left);
% % xin_left_temp=zeros(nr,nk);
% % yin_left_temp=zeros(nr,nk);
% % fiin_left_temp=zeros(nr,nk);
% % ratioin_left_temp=zeros(nr,nk);
% % for k=1:nk
% %     xin_left_temp(:,k)=xin_left(:,nk+1-k);
% %     yin_left_temp(:,k)=yin_left(:,nk+1-k);
% %     fiin_left_temp(:,k)=fiin_left(:,nk+1-k);
% %     ratioin_left_temp(:,k)=ratioin_left(:,nk+1-k);
% % end    
% % xin_left=xin_left_temp;
% % yin_left=yin_left_temp;
% % fiin_left=fiin_left_temp;
% % ratioin_left=ratioin_left_temp;
% %-------------------------------------

