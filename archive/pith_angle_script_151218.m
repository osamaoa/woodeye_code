% This script was last updated 2014-12-01 by Andreas Briggert


% Make vectors of before given angle information.

    U_DOWN=-cos(Fi1_DOWN).*sin(Fi2_DOWN);
    V_DOWN=cos(Fi1_DOWN).*cos(Fi2_DOWN);
    W_DOWN=sin(Fi1_DOWN);
       
    U_UP=-cos(Fi1_UP).*sin(Fi2_UP);
    V_UP=cos(Fi1_UP).*cos(Fi2_UP);
    W_UP=sin(Fi1_UP);
    
    U_LEFT=-sin(Fi1_LEFT);
    V_LEFT=cos(Fi1_LEFT).*cos(Fi2_LEFT);
    W_LEFT=-cos(Fi1_LEFT).*sin(Fi2_LEFT);
    
    U_RIGHT=-sin(Fi1_RIGHT);
    V_RIGHT=cos(Fi1_RIGHT).*cos(Fi2_RIGHT);
    W_RIGHT=-cos(Fi1_RIGHT).*sin(Fi2_RIGHT);
    
    
% Pith vector created. The pith vector will follow the length of the board
% i.e. the unit pith vector will have the coordinates 0,1,0 in the x-y-z
% directions, respectivetly.

pith_vector=[0,1,0];

% Absolute value of the pith vector. This is used in DOT product calculation. 

absolute_pith_vector=sqrt(pith_vector(1,1).^2+pith_vector(1,2).^2+pith_vector(1,3).^2);

% The Dot product is calculate as:
% pith_angle=arccos(U¤V)/(abs(U)*abs(V))
% where the pith_angle is the angle between two random vectors U and V. 

% In the following equations the angles between the pith vector and the
% fibers direction are calculated. 

% PITH_ANGLE_-_DEGREES is used for max och min plot of boundries given in
% Andreas_startskript_141104.m

% --------------- Down -----------------------------
U_DOWN_STUDY=U_DOWN*pith_vector(1,1);
V_DOWN_STUDY=V_DOWN*pith_vector(1,2);
W_DOWN_STUDY=W_DOWN*pith_vector(1,3);

DOT_product_down=U_DOWN_STUDY+V_DOWN_STUDY+W_DOWN_STUDY;

absolute_UVW_down=sqrt(U_DOWN.^2+V_DOWN.^2+W_DOWN.^2);

pith_angle_down_degrees_unsmoothed=acosd(rdivide(DOT_product_down,(absolute_UVW_down*absolute_pith_vector)));

% Smoothing function applied. The smoothing functions is applied on the
% angles between the direction of the fibers and the direction of the pith.
% The coordinates for the smoothing is picked from
% P_make_X_Y_Fi1_Fi2_141104.m i.e. Ex_-_study and Ey_-_study from the mesh created in the beginning of the calculation procedure.

%%%size_pith_angle_down_degrees_unsmoothed=size(pith_angle_down_degrees_unsmoothed);
%%%pith_angle_down_degrees_study=reshape(pith_angle_down_degrees_unsmoothed,size_pith_angle_down_degrees_unsmoothed(1,1)*size_pith_angle_down_degrees_unsmoothed(1,2),1);
%%%[pith_angle_down_degrees_study_smooth]=smoothing(Ex_down_study,Ey_down_study,pith_angle_down_degrees_study,m_study_wide,n_study_wide,x_average,y_average); 
%%%pith_angle_down_degrees=reshape(pith_angle_down_degrees_study_smooth',m_study_wide,n_study_wide);

%%%PITH_ANGLE_DOWN_DEGREES=pith_angle_down_degrees;
PITH_ANGLE_DOWN_DEGREES=pith_angle_down_degrees_unsmoothed;
    
% --------------- Up -----------------------------
U_UP_STUDY=U_UP*pith_vector(1,1);
V_UP_STUDY=V_UP*pith_vector(1,2);
W_UP_STUDY=W_UP*pith_vector(1,3);

DOT_product_up=U_UP_STUDY+V_UP_STUDY+W_UP_STUDY;

absolute_UVW_up=sqrt(U_UP.^2+V_UP.^2+W_UP.^2);

pith_angle_up_degrees_unsmoothed=acosd(rdivide(DOT_product_up,(absolute_UVW_up*absolute_pith_vector)));

% Smoothing function applied. A more detailed description is given above under the down-side explanation

%%%size_pith_angle_up_degrees_unsmoothed=size(pith_angle_up_degrees_unsmoothed);
%%%pith_angle_up_degrees_study=reshape(pith_angle_up_degrees_unsmoothed,size_pith_angle_up_degrees_unsmoothed(1,1)*size_pith_angle_up_degrees_unsmoothed(1,2),1);
%%%[pith_angle_up_degrees_study_smooth]=smoothing(Ex_up_study,Ey_up_study,pith_angle_up_degrees_study,m_study_wide,n_study_wide,x_average,y_average); 
%%%pith_angle_up_degrees=reshape(pith_angle_up_degrees_study_smooth,m_study_wide,n_study_wide);

%%%PITH_ANGLE_UP_DEGREES=pith_angle_up_degrees;
PITH_ANGLE_UP_DEGREES=pith_angle_up_degrees_unsmoothed;

% --------------- Left -----------------------------
U_LEFT_STUDY=U_LEFT*pith_vector(1,1);
V_LEFT_STUDY=V_LEFT*pith_vector(1,2);
W_LEFT_STUDY=W_LEFT*pith_vector(1,3);

DOT_product_left=U_LEFT_STUDY+V_LEFT_STUDY+W_LEFT_STUDY;

absolute_UVW_left=sqrt(U_LEFT.^2+V_LEFT.^2+W_LEFT.^2);

pith_angle_left_degrees_unsmoothed=acosd(rdivide(DOT_product_left,(absolute_UVW_left*absolute_pith_vector)));


% Smoothing function applied. A more detailed description is given above under the down-side explanation

%%%size_pith_angle_left_degrees_unsmoothed=size(pith_angle_left_degrees_unsmoothed);
%%%pith_angle_left_degrees_study=reshape(pith_angle_left_degrees_unsmoothed,size_pith_angle_left_degrees_unsmoothed(1,1)*size_pith_angle_left_degrees_unsmoothed(1,2),1);
%%%[pith_angle_left_degrees_study_smooth]=smoothing(Ex_left_study,Ey_left_study,pith_angle_left_degrees_study,m_study_narrow,n_study_narrow,x_average,y_average); 
%%%pith_angle_left_degrees=reshape(pith_angle_left_degrees_study_smooth,m_study_narrow,n_study_narrow);

%%%PITH_ANGLE_LEFT_DEGREES=pith_angle_left_degrees; 
PITH_ANGLE_LEFT_DEGREES=pith_angle_left_degrees_unsmoothed; 

% --------------- Right -----------------------------
U_RIGHT_STUDY=U_RIGHT*pith_vector(1,1);
V_RIGHT_STUDY=V_RIGHT*pith_vector(1,2);
W_RIGHT_STUDY=W_RIGHT*pith_vector(1,3);

DOT_product_right=U_RIGHT_STUDY+V_RIGHT_STUDY+W_RIGHT_STUDY;

absolute_UVW_right=sqrt(U_RIGHT.^2+V_RIGHT.^2+W_RIGHT.^2);

pith_angle_right_degrees_unsmoothed=acosd(rdivide(DOT_product_right,(absolute_UVW_right*absolute_pith_vector)));


% Smoothing function applied. A more detailed description is given above under the down-side explanation

%%%size_pith_angle_right_degrees_unsmoothed=size(pith_angle_right_degrees_unsmoothed);
%%%pith_angle_right_degrees_study=reshape(pith_angle_right_degrees_unsmoothed,size_pith_angle_right_degrees_unsmoothed(1,1)*size_pith_angle_right_degrees_unsmoothed(1,2),1);
%%%[pith_angle_right_degrees_study_smooth]=smoothing(Ex_right_study,Ey_right_study,pith_angle_right_degrees_study,m_study_narrow,n_study_narrow,x_average,y_average); 
%%%pith_angle_right_degrees=reshape(pith_angle_right_degrees_study_smooth,m_study_narrow,n_study_narrow);

%%%PITH_ANGLE_RIGHT_DEGREES=pith_angle_right_degrees; 
PITH_ANGLE_RIGHT_DEGREES=pith_angle_right_degrees_unsmoothed; 

% Transforming the angles in the matrices from degrees to radians, for all sides of the boards.  

%%%pith_angle_down_rad=pith_angle_down_degrees*pi/180;
%%%pith_angle_up_rad=pith_angle_up_degrees*pi/180;
%%%pith_angle_left_rad=pith_angle_left_degrees*pi/180;
%%%pith_angle_right_rad=pith_angle_right_degrees*pi/180;
pith_angle_down_rad=pith_angle_down_degrees_unsmoothed*pi/180;
pith_angle_up_rad=pith_angle_up_degrees_unsmoothed*pi/180;
pith_angle_left_rad=pith_angle_left_degrees_unsmoothed*pi/180;
pith_angle_right_rad=pith_angle_right_degrees_unsmoothed*pi/180;



% Use this algorithm to make checks at a single position. 
% This algorithm was used in the developement of the script. In this
% algortihm the angle between the fiberdirection and the pith vector can be
% calculated for a single element.  
 
%  UVW=[U_UP(5,5),V_UP(5,5),W_UP(5,5)];
%  UVW_dot_pithplacement=dot(UVW,pith_vector);
%  abs_UVW_pithplacement=(sqrt(U_UP(5,5).^2+V_UP(5,5).^2+W_UP(5,5).^2)*1);
%  pith_angle_check=acosd(UVW_dot_pithplacement/abs_UVW_pithplacement);



