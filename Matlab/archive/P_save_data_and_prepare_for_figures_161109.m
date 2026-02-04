board_knot_data_ldru=[];
for side=1:4
      if side==1 % up
           X_SIDE=X_UP;
           Y_SIDE=Y_UP;
           Fi1_SIDE=Fi1_UP;
           Fi2_SIDE=Fi2_UP;
           pith_angle_side_degrees_unsmoothed=pith_angle_up_degrees_unsmoothed;
           mark_knot_side_pith_angle=mark_knot_up_pith_angle;
           mark_knot_side=mark_knot_up;
           mark_knot_side_m2=mark_knot_up_m2;
           mark_knot_side_p2=mark_knot_up_p2;
           DX=H;
           im_RedSide_red=im_RedUp_red;
           X_raw=X_raw_Up;
           Y_raw=Y_raw_Up;
           mark_Side_dark_WE=mark_Up_dark_WE;
           knot_data_min_max_side=knot_data_min_max_up;
           mark_Side_dark_restricted=mark_Up_dark_restricted;
           Side_X_conv_hull=Up_X_conv_hull;
           Side_Y_conv_hull=Up_Y_conv_hull;
           Side_A_conv_hull=Up_A_conv_hull;
           Side_X_conv_hull_Fi2_dark=Up_X_conv_hull_Fi2_dark;
           Side_Y_conv_hull_Fi2_dark=Up_Y_conv_hull_Fi2_dark;
           Side_A_conv_hull_Fi2_dark=Up_A_conv_hull_Fi2_dark;

           [r,k]=size(Fi2_SIDE);
           Fi_up_flat_ldru=Fi2_SIDE;
           mark_knot_up_flat_ldru=mark_knot_side;
           [r,k]=size(im_RedSide_red);
           im_RedUp_red_flat_ldru=im_RedSide_red;
           knot_data_min_max_up_flat_ldru=[knot_data_min_max_side(:,1)  knot_data_min_max_side(:,2) knot_data_min_max_side(:,3) knot_data_min_max_side(:,4)];
           X_raw_Up_flat_ldru=X_raw;
           Y_raw_Up_flat_ldru=Y_raw;
           X_UP_flat_ldru=X_SIDE;
           Y_UP_flat_ldru=Y_SIDE;
           mark_Up_restricted_flat_ldru=mark_Side_dark_restricted;
           Up_X_conv_hull_flat_ldru=Side_X_conv_hull;
           Up_Y_conv_hull_flat_ldru=Side_Y_conv_hull;
           Up_A_conv_hull_flat_ldru=Side_A_conv_hull;
           Up_X_conv_hull_Fi2_dark_flat_ldru=Side_X_conv_hull_Fi2_dark;
           Up_Y_conv_hull_Fi2_dark_flat_ldru=Side_Y_conv_hull_Fi2_dark;
           Up_A_conv_hull_Fi2_dark_flat_ldru=Side_A_conv_hull_Fi2_dark;
       elseif side==2 % down
           X_SIDE=X_DOWN;
           Y_SIDE=Y_DOWN;
           Fi1_SIDE=Fi1_DOWN;
           Fi2_SIDE=Fi2_DOWN;
           pith_angle_side_degrees_unsmoothed=pith_angle_down_degrees_unsmoothed;
           mark_knot_side_pith_angle=mark_knot_down_pith_angle;
           mark_knot_side=mark_knot_down;
           mark_knot_side_m2=mark_knot_down_m2;
           mark_knot_side_p2=mark_knot_down_p2;
           DX=H;
           im_RedSide_red=im_RedDown_red;
           X_raw=X_raw_Down;
           Y_raw=Y_raw_Down;
           mark_Side_dark_WE=mark_Down_dark_WE;
           knot_data_min_max_side=knot_data_min_max_down;
           mark_Side_dark_restricted=mark_Down_dark_restricted;
           Side_X_conv_hull=Down_X_conv_hull;
           Side_Y_conv_hull=Down_Y_conv_hull;
           Side_A_conv_hull=Down_A_conv_hull;
           Side_X_conv_hull_Fi2_dark=Down_X_conv_hull_Fi2_dark;
           Side_Y_conv_hull_Fi2_dark=Down_Y_conv_hull_Fi2_dark;
           Side_A_conv_hull_Fi2_dark=Down_A_conv_hull_Fi2_dark;

           [r,k]=size(Fi2_SIDE);
           Fi_down_flat_ldru=Fi2_SIDE(:,k+1-[1:k]);
           mark_knot_down_flat_ldru=mark_knot_side(:,k+1-[1:k]);
           mark_knot_down_flat_ldru=mark_knot_side(:,k+1-[1:k]);
           [r,k]=size(im_RedSide_red);
           im_RedDown_red_flat_ldru=im_RedSide_red(:,k+1-[1:k]);
           knot_data_min_max_down_flat_ldru=[H*1000-knot_data_min_max_side(:,2)  H*1000-knot_data_min_max_side(:,1) knot_data_min_max_side(:,3) knot_data_min_max_side(:,4)];
           X_raw_Down_flat_ldru=X_raw;
           Y_raw_Down_flat_ldru=Y_raw;
           X_DOWN_flat_ldru=X_SIDE;
           Y_DOWN_flat_ldru=Y_SIDE;
           [r,k]=size(mark_Side_dark_restricted);
           mark_Down_restricted_flat_ldru=mark_Side_dark_restricted(:,k+1-[1:k]);
           %Down_X_conv_hull_flat_ldru=H*1000*ceil(Side_X_conv_hull/1e5)-abs(Side_X_conv_hull);
           [nr,nc]=size(Side_X_conv_hull);
           Down_X_conv_hull_flat_ldru=Side_X_conv_hull;
           Down_X_conv_hull_Fi2_dark_flat_ldru=Side_X_conv_hull_Fi2_dark;
           Down_A_conv_hull_flat_ldru=Side_A_conv_hull;
           Down_A_conv_hull_Fi2_dark_flat_ldru=Side_A_conv_hull_Fi2_dark;
           for r=1:nr
               for c=1:nc
                   if Side_X_conv_hull(r,c)==-1e6
                       
                   else
                      Down_X_conv_hull_flat_ldru(r,c)=H*1000-Down_X_conv_hull_flat_ldru(r,c);
                   end
                   if Side_X_conv_hull_Fi2_dark(r,c)==-1e6
                       
                   else
                      Down_X_conv_hull_Fi2_dark_flat_ldru(r,c)=H*1000-Down_X_conv_hull_Fi2_dark_flat_ldru(r,c);
                   end
               end
           end
           Down_Y_conv_hull_flat_ldru=Side_Y_conv_hull;
           Down_Y_conv_hull_Fi2_dark_flat_ldru=Side_Y_conv_hull_Fi2_dark;
     elseif side==4 % left blir right
           X_SIDE=X_RIGHT;
           Y_SIDE=Y_RIGHT;
           Fi1_SIDE=Fi1_RIGHT;
           Fi2_SIDE=Fi2_RIGHT;
           pith_angle_side_degrees_unsmoothed=pith_angle_right_degrees_unsmoothed;
           mark_knot_side_pith_angle=mark_knot_right_pith_angle;
           mark_knot_side=mark_knot_right;
           mark_knot_side_m2=mark_knot_right_m2;
           mark_knot_side_p2=mark_knot_right_p2;
           DX=B;
           im_RedSide_red=im_RedRight_red;
           X_raw=X_raw_Right;
           Y_raw=Y_raw_Right;
           mark_Side_dark_WE=mark_Right_dark_WE;
           knot_data_min_max_side=knot_data_min_max_right;
           mark_Side_dark_restricted=mark_Right_dark_restricted;
           Side_X_conv_hull=Right_X_conv_hull;
           Side_Y_conv_hull=Right_Y_conv_hull;
           Side_A_conv_hull=Right_A_conv_hull;
           Side_X_conv_hull_Fi2_dark=Right_X_conv_hull_Fi2_dark;
           Side_Y_conv_hull_Fi2_dark=Right_Y_conv_hull_Fi2_dark;
           Side_A_conv_hull_Fi2_dark=Right_A_conv_hull_Fi2_dark;

           [r,k]=size(Fi2_SIDE);
           Fi_left_flat_ldru=Fi2_SIDE(:,k+1-[1:k]);
           mark_knot_left_flat_ldru=mark_knot_side(:,k+1-[1:k]);
           %Fi2_left_flat_ldru=Fi2_SIDE;
           %mark_knot_left_flat_ldru=mark_knot_side;
           [r,k]=size(im_RedSide_red);
           im_RedLeft_red_flat_ldru=im_RedSide_red(:,k+1-[1:k]);
           %im_RedLeft_red_flat_ldru=im_RedSide_red;
           if length(knot_data_min_max_side)==0
           knot_data_min_max_left_flat_ldru=[];
           else
                knot_data_min_max_left_flat_ldru=[B*1000-knot_data_min_max_side(:,2)  B*1000-knot_data_min_max_side(:,1) knot_data_min_max_side(:,3) knot_data_min_max_side(:,4)];
           end
X_raw_Left_flat_ldru=X_raw;
           Y_raw_Left_flat_ldru=Y_raw;
           X_LEFT_flat_ldru=X_SIDE;
           Y_LEFT_flat_ldru=Y_SIDE;
           [r,k]=size(mark_Side_dark_restricted);
           mark_Left_restricted_flat_ldru=mark_Side_dark_restricted(:,k+1-[1:k]);
           %Left_X_conv_hull_flat_ldru=B*1000*ceil(Side_X_conv_hull/1e6)-abs(Side_X_conv_hull);
           [nr,nc]=size(Side_X_conv_hull);
           Left_X_conv_hull_flat_ldru=Side_X_conv_hull;
           Left_X_conv_hull_Fi2_dark_flat_ldru=Side_X_conv_hull_Fi2_dark;
           Left_A_conv_hull_flat_ldru=Side_A_conv_hull;
           Left_A_conv_hull_Fi2_dark_flat_ldru=Side_A_conv_hull_Fi2_dark;
           for r=1:nr
               for c=1:nc
                   if Side_X_conv_hull(r,c)==-1e6
                       
                   else
                      Left_X_conv_hull_flat_ldru(r,c)=B*1000-Left_X_conv_hull_flat_ldru(r,c);
                   end
                   if Side_X_conv_hull_Fi2_dark(r,c)==-1e6
                       
                   else
                      Left_X_conv_hull_Fi2_dark_flat_ldru(r,c)=B*1000-Left_X_conv_hull_Fi2_dark_flat_ldru(r,c);
                   end
               end
           end
           Left_Y_conv_hull_flat_ldru=Side_Y_conv_hull;
           Left_Y_conv_hull_Fi2_dark_flat_ldru=Side_Y_conv_hull_Fi2_dark;
      elseif side==3 % right blir left
           X_SIDE=X_LEFT;
           Y_SIDE=Y_LEFT;
           Fi1_SIDE=Fi1_LEFT;
           Fi2_SIDE=Fi2_LEFT;
           pith_angle_side_degrees_unsmoothed=pith_angle_left_degrees_unsmoothed;
           mark_knot_side_pith_angle=mark_knot_left_pith_angle;
           mark_knot_side=mark_knot_left;
           mark_knot_side_m2=mark_knot_left_m2;
           mark_knot_side_p2=mark_knot_left_p2;
           DX=B;
           im_RedSide_red=im_RedLeft_red;
           X_raw=X_raw_Left;
           Y_raw=Y_raw_Left;
           mark_Side_dark_WE=mark_Left_dark_WE;
           knot_data_min_max_side=knot_data_min_max_left;
           mark_Side_dark_restricted=mark_Left_dark_restricted;
           Side_X_conv_hull=Left_X_conv_hull;
           Side_Y_conv_hull=Left_Y_conv_hull;
           Side_A_conv_hull=Left_A_conv_hull;
           Side_X_conv_hull_Fi2_dark=Left_X_conv_hull_Fi2_dark;
           Side_Y_conv_hull_Fi2_dark=Left_Y_conv_hull_Fi2_dark;
           Side_A_conv_hull_Fi2_dark=Left_A_conv_hull_Fi2_dark;

           [r,k]=size(Fi2_SIDE);
           %Fi_right_flat_ldru=Fi2_SIDE(:,k+1-[1:k]);
           %mark_knot_right_flat_ldru=mark_knot_side(:,k+1-[1:k]);
           Fi_right_flat_ldru=Fi2_SIDE;
           mark_knot_right_flat_ldru=mark_knot_side;
           [r,k]=size(im_RedSide_red);
           %im_RedRight_red_flat_ldru=im_RedSide_red(:,k+1-[1:k]);
           im_RedRight_red_flat_ldru=im_RedSide_red;
           knot_data_min_max_right_flat_ldru=[knot_data_min_max_side(:,1)  knot_data_min_max_side(:,2) knot_data_min_max_side(:,3) knot_data_min_max_side(:,4)];
           X_raw_Right_flat_ldru=X_raw;
           Y_raw_Right_flat_ldru=Y_raw;
           X_RIGHT_flat_ldru=X_SIDE;
           Y_RIGHT_flat_ldru=Y_SIDE;
           mark_Right_restricted_flat_ldru=mark_Side_dark_restricted;
           Right_X_conv_hull_flat_ldru=Side_X_conv_hull;
           Right_Y_conv_hull_flat_ldru=Side_Y_conv_hull;
           Right_A_conv_hull_flat_ldru=Side_A_conv_hull;
           Right_X_conv_hull_Fi2_dark_flat_ldru=Side_X_conv_hull_Fi2_dark;
           Right_Y_conv_hull_Fi2_dark_flat_ldru=Side_Y_conv_hull_Fi2_dark;
           Right_A_conv_hull_Fi2_dark_flat_ldru=Side_A_conv_hull_Fi2_dark;
      end 
end

[n_fields_Left,four]=size(knot_data_min_max_left_flat_ldru);
[n_fields_Down,four]=size(knot_data_min_max_down_flat_ldru);
[n_fields_Right,four]=size(knot_data_min_max_right_flat_ldru);
[n_fields_Up,four]=size(knot_data_min_max_up_flat_ldru);

%---------------------------------------------------------------------------
knot_data_min_max_Left_flat_ldru=knot_data_min_max_left_flat_ldru;
knot_data_min_max_Down_flat_ldru=knot_data_min_max_down_flat_ldru;
knot_data_min_max_Right_flat_ldru=knot_data_min_max_right_flat_ldru;
knot_data_min_max_Up_flat_ldru=knot_data_min_max_up_flat_ldru;

%---------------------------------------------------------------------------
if length(Up_A_conv_hull_flat_ldru)==0
    index_no_knot=[];
    index_knot=[];
    surf_type_Up=[];
    area_square_Up=[];
    area_knots_Up=[];
    min_X_area_Up_light_int=[];
    min_X_area_Up_Fi2_dark=[];
    max_X_area_Up=[];
    min_X_area_Up=[];
    min_Y_area_Up_light_int=[];
    max_Y_area_Up_light_int=[];
    min_Y_area_Up_Fi2_dark=[];
    max_Y_area_Up_Fi2_dark=[];
    pith_or_long_square_indication_factor_Up=[];
else
    [index_no_knot]=find(Up_A_conv_hull_Fi2_dark_flat_ldru+Up_A_conv_hull_flat_ldru==0);
    [index_knot]=find(Up_A_conv_hull_Fi2_dark_flat_ldru+Up_A_conv_hull_flat_ldru>0);
    surf_type_Up=zeros(n_fields_Up,1);
    surf_type_Up(index_knot)=ceil(((Up_A_conv_hull_Fi2_dark_flat_ldru(index_knot)./Up_A_conv_hull_flat_ldru(index_knot))-prefer_dark_to_fibre_knot)/1e6)+1;
    index_type_1_Up=find(surf_type_Up==1);
    index_type_2_Up=find(surf_type_Up==2);

    area_square_Up=(knot_data_min_max_Up_flat_ldru(:,2)-knot_data_min_max_Up_flat_ldru(:,1)).*(knot_data_min_max_Up_flat_ldru(:,4)-knot_data_min_max_Up_flat_ldru(:,3));
    area_knots_Up=zeros(n_fields_Up,1);
    area_knots_Up(index_type_1_Up)=Up_A_conv_hull_flat_ldru(index_type_1_Up);
    area_knots_Up(index_type_2_Up)=Up_A_conv_hull_Fi2_dark_flat_ldru(index_type_2_Up);   

    min_X_area_Up_light_int=min(abs(Up_X_conv_hull_flat_ldru'))';
    max_X_area_Up_light_int=max((Up_X_conv_hull_flat_ldru'))';
    min_X_area_Up_Fi2_dark=min(abs(Up_X_conv_hull_Fi2_dark_flat_ldru'))';
    max_X_area_Up_Fi2_dark=max((Up_X_conv_hull_Fi2_dark_flat_ldru'))';
    min_X_area_Up=zeros(n_fields_Up,1);
    max_X_area_Up=zeros(n_fields_Up,1);
    min_X_area_Up(index_type_1_Up)=min_X_area_Up_light_int(index_type_1_Up);
    max_X_area_Up(index_type_1_Up)=max_X_area_Up_light_int(index_type_1_Up);
    min_X_area_Up(index_type_2_Up)=min_X_area_Up_Fi2_dark(index_type_2_Up);
    max_X_area_Up(index_type_2_Up)=max_X_area_Up_Fi2_dark(index_type_2_Up);

    min_Y_area_Up_light_int=min(abs(Up_Y_conv_hull_flat_ldru'))';
    max_Y_area_Up_light_int=max((Up_Y_conv_hull_flat_ldru'))';
    min_Y_area_Up_Fi2_dark=min(abs(Up_Y_conv_hull_Fi2_dark_flat_ldru'))';
    max_Y_area_Up_Fi2_dark=max((Up_Y_conv_hull_Fi2_dark_flat_ldru'))';
    min_Y_area_Up=zeros(n_fields_Up,1);
    max_Y_area_Up=zeros(n_fields_Up,1);
    min_Y_area_Up(index_type_1_Up)=min_Y_area_Up_light_int(index_type_1_Up);
    max_Y_area_Up(index_type_1_Up)=max_Y_area_Up_light_int(index_type_1_Up);
    min_Y_area_Up(index_type_2_Up)=min_Y_area_Up_Fi2_dark(index_type_2_Up);
    max_Y_area_Up(index_type_2_Up)=max_Y_area_Up_Fi2_dark(index_type_2_Up);

    pith_or_long_square_indication_factor_Up=zeros(n_fields_Up,1);
    pith_or_long_square_indication_factor_Up(index_type_1_Up)=ceil(floor(((max_Y_area_Up_light_int(index_type_1_Up)-min_Y_area_Up_light_int(index_type_1_Up))./(max_X_area_Up_light_int(index_type_1_Up)-min_X_area_Up_light_int(index_type_1_Up)))/pith_indication_factor)/1e6);
    pith_or_long_square_indication_factor_Up(index_type_2_Up)=ceil(floor(((max_Y_area_Up_Fi2_dark(index_type_2_Up)-min_Y_area_Up_Fi2_dark(index_type_2_Up))./(max_X_area_Up_Fi2_dark(index_type_2_Up)-min_X_area_Up_Fi2_dark(index_type_2_Up)))/pith_indication_factor)/1e6);
    pith_or_long_square_indication_factor_Up(find(ceil(floor((knot_data_min_max_Up_flat_ldru(:,4)-knot_data_min_max_Up_flat_ldru(:,3))/square_length_limit)/1e6)))=2;
end
%---------- Left ---------------------------------------------------------
if length(Left_A_conv_hull_flat_ldru)==0
    index_no_knot=[];
    index_knot=[];
    surf_type_Left=[];
    area_square_Left=[];
    area_knots_Left=[];
    min_X_area_Left_light_int=[];
    min_X_area_Left_Fi2_dark=[];
    max_X_area_Left=[];
    min_X_area_Left=[];
    min_Y_area_Left_light_int=[];
    max_Y_area_Left_light_int=[];
    min_Y_area_Left_Fi2_dark=[];
    max_Y_area_Left_Fi2_dark=[];
    pith_or_long_square_indication_factor_Left=[];
else
    [index_no_knot]=find(Left_A_conv_hull_Fi2_dark_flat_ldru+Left_A_conv_hull_flat_ldru==0);
    [index_knot]=find(Left_A_conv_hull_Fi2_dark_flat_ldru+Left_A_conv_hull_flat_ldru>0);
    surf_type_Left=zeros(n_fields_Left,1);
    surf_type_Left(index_knot)=ceil(((Left_A_conv_hull_Fi2_dark_flat_ldru(index_knot)./Left_A_conv_hull_flat_ldru(index_knot))-prefer_dark_to_fibre_knot)/1e6)+1;
    index_type_1_Left=find(surf_type_Left==1);
    index_type_2_Left=find(surf_type_Left==2);

    area_square_Left=(knot_data_min_max_Left_flat_ldru(:,2)-knot_data_min_max_Left_flat_ldru(:,1)).*(knot_data_min_max_Left_flat_ldru(:,4)-knot_data_min_max_Left_flat_ldru(:,3));
    area_knots_Left=zeros(n_fields_Left,1);
    area_knots_Left(index_type_1_Left)=Left_A_conv_hull_flat_ldru(index_type_1_Left);
    area_knots_Left(index_type_2_Left)=Left_A_conv_hull_Fi2_dark_flat_ldru(index_type_2_Left);   

    min_X_area_Left_light_int=min(abs(Left_X_conv_hull_flat_ldru'))';
    max_X_area_Left_light_int=max((Left_X_conv_hull_flat_ldru'))';
    min_X_area_Left_Fi2_dark=min(abs(Left_X_conv_hull_Fi2_dark_flat_ldru'))';
    max_X_area_Left_Fi2_dark=max((Left_X_conv_hull_Fi2_dark_flat_ldru'))';
    min_X_area_Left=zeros(n_fields_Left,1);
    max_X_area_Left=zeros(n_fields_Left,1);
    min_X_area_Left(index_type_1_Left)=min_X_area_Left_light_int(index_type_1_Left);
    max_X_area_Left(index_type_1_Left)=max_X_area_Left_light_int(index_type_1_Left);
    min_X_area_Left(index_type_2_Left)=min_X_area_Left_Fi2_dark(index_type_2_Left);
    max_X_area_Left(index_type_2_Left)=max_X_area_Left_Fi2_dark(index_type_2_Left);

    min_Y_area_Left_light_int=min(abs(Left_Y_conv_hull_flat_ldru'))';
    max_Y_area_Left_light_int=max((Left_Y_conv_hull_flat_ldru'))';
    min_Y_area_Left_Fi2_dark=min(abs(Left_Y_conv_hull_Fi2_dark_flat_ldru'))';
    max_Y_area_Left_Fi2_dark=max((Left_Y_conv_hull_Fi2_dark_flat_ldru'))';
    min_Y_area_Left=zeros(n_fields_Left,1);
    max_Y_area_Left=zeros(n_fields_Left,1);
    min_Y_area_Left(index_type_1_Left)=min_Y_area_Left_light_int(index_type_1_Left);
    max_Y_area_Left(index_type_1_Left)=max_Y_area_Left_light_int(index_type_1_Left);
    min_Y_area_Left(index_type_2_Left)=min_Y_area_Left_Fi2_dark(index_type_2_Left);
    max_Y_area_Left(index_type_2_Left)=max_Y_area_Left_Fi2_dark(index_type_2_Left);

    pith_or_long_square_indication_factor_Left=zeros(n_fields_Left,1);
    pith_or_long_square_indication_factor_Left(index_type_1_Left)=ceil(floor(((max_Y_area_Left_light_int(index_type_1_Left)-min_Y_area_Left_light_int(index_type_1_Left))./(max_X_area_Left_light_int(index_type_1_Left)-min_X_area_Left_light_int(index_type_1_Left)))/pith_indication_factor)/1e6);
    pith_or_long_square_indication_factor_Left(index_type_2_Left)=ceil(floor(((max_Y_area_Left_Fi2_dark(index_type_2_Left)-min_Y_area_Left_Fi2_dark(index_type_2_Left))./(max_X_area_Left_Fi2_dark(index_type_2_Left)-min_X_area_Left_Fi2_dark(index_type_2_Left)))/pith_indication_factor)/1e6);
    pith_or_long_square_indication_factor_Left(find(ceil(floor((knot_data_min_max_Left_flat_ldru(:,4)-knot_data_min_max_Left_flat_ldru(:,3))/square_length_limit)/1e6)))=2;
end

%------------- Down -------------------------------------------------------
if length(Down_A_conv_hull_flat_ldru)==0
    index_no_knot=[];
    index_knot=[];
    surf_type_Down=[];
    area_square_Down=[];
    area_knots_Down=[];
    min_X_area_Down_light_int=[];
    min_X_area_Down_Fi2_dark=[];
    max_X_area_Down=[];
    min_X_area_Down=[];
    min_Y_area_Down_light_int=[];
    max_Y_area_Down_light_int=[];
    min_Y_area_Down_Fi2_dark=[];
    max_Y_area_Down_Fi2_dark=[];
    pith_or_long_square_indication_factor_Down=[];
else
    [index_no_knot]=find(Down_A_conv_hull_Fi2_dark_flat_ldru+Down_A_conv_hull_flat_ldru==0);
    [index_knot]=find(Down_A_conv_hull_Fi2_dark_flat_ldru+Down_A_conv_hull_flat_ldru>0);
    surf_type_Down=zeros(n_fields_Down,1);
    surf_type_Down(index_knot)=ceil(((Down_A_conv_hull_Fi2_dark_flat_ldru(index_knot)./Down_A_conv_hull_flat_ldru(index_knot))-prefer_dark_to_fibre_knot)/1e6)+1;
    index_type_1_Down=find(surf_type_Down==1);
    index_type_2_Down=find(surf_type_Down==2);

    area_square_Down=(knot_data_min_max_Down_flat_ldru(:,2)-knot_data_min_max_Down_flat_ldru(:,1)).*(knot_data_min_max_Down_flat_ldru(:,4)-knot_data_min_max_Down_flat_ldru(:,3));
    area_knots_Down=zeros(n_fields_Down,1);
    area_knots_Down(index_type_1_Down)=Down_A_conv_hull_flat_ldru(index_type_1_Down);
    area_knots_Down(index_type_2_Down)=Down_A_conv_hull_Fi2_dark_flat_ldru(index_type_2_Down);   

    min_X_area_Down_light_int=min(abs(Down_X_conv_hull_flat_ldru'))';
    max_X_area_Down_light_int=max((Down_X_conv_hull_flat_ldru'))';
    min_X_area_Down_Fi2_dark=min(abs(Down_X_conv_hull_Fi2_dark_flat_ldru'))';
    max_X_area_Down_Fi2_dark=max((Down_X_conv_hull_Fi2_dark_flat_ldru'))';
    min_X_area_Down=zeros(n_fields_Down,1);
    max_X_area_Down=zeros(n_fields_Down,1);
    min_X_area_Down(index_type_1_Down)=min_X_area_Down_light_int(index_type_1_Down);
    max_X_area_Down(index_type_1_Down)=max_X_area_Down_light_int(index_type_1_Down);
    min_X_area_Down(index_type_2_Down)=min_X_area_Down_Fi2_dark(index_type_2_Down);
    max_X_area_Down(index_type_2_Down)=max_X_area_Down_Fi2_dark(index_type_2_Down);

    min_Y_area_Down_light_int=min(abs(Down_Y_conv_hull_flat_ldru'))';
    max_Y_area_Down_light_int=max((Down_Y_conv_hull_flat_ldru'))';
    min_Y_area_Down_Fi2_dark=min(abs(Down_Y_conv_hull_Fi2_dark_flat_ldru'))';
    max_Y_area_Down_Fi2_dark=max((Down_Y_conv_hull_Fi2_dark_flat_ldru'))';
    min_Y_area_Down=zeros(n_fields_Down,1);
    max_Y_area_Down=zeros(n_fields_Down,1);
    min_Y_area_Down(index_type_1_Down)=min_Y_area_Down_light_int(index_type_1_Down);
    max_Y_area_Down(index_type_1_Down)=max_Y_area_Down_light_int(index_type_1_Down);
    min_Y_area_Down(index_type_2_Down)=min_Y_area_Down_Fi2_dark(index_type_2_Down);
    max_Y_area_Down(index_type_2_Down)=max_Y_area_Down_Fi2_dark(index_type_2_Down);

    pith_or_long_square_indication_factor_Down=zeros(n_fields_Down,1);
    pith_or_long_square_indication_factor_Down(index_type_1_Down)=ceil(floor(((max_Y_area_Down_light_int(index_type_1_Down)-min_Y_area_Down_light_int(index_type_1_Down))./(max_X_area_Down_light_int(index_type_1_Down)-min_X_area_Down_light_int(index_type_1_Down)))/pith_indication_factor)/1e6);
    pith_or_long_square_indication_factor_Down(index_type_2_Down)=ceil(floor(((max_Y_area_Down_Fi2_dark(index_type_2_Down)-min_Y_area_Down_Fi2_dark(index_type_2_Down))./(max_X_area_Down_Fi2_dark(index_type_2_Down)-min_X_area_Down_Fi2_dark(index_type_2_Down)))/pith_indication_factor)/1e6);
    pith_or_long_square_indication_factor_Down(find(ceil(floor((knot_data_min_max_Down_flat_ldru(:,4)-knot_data_min_max_Down_flat_ldru(:,3))/square_length_limit)/1e6)))=2;
end
%-------- Right -----------------------------------------------------------
if length(Right_A_conv_hull_flat_ldru)==0
    index_no_knot=[];
    index_knot=[];
    surf_type_Right=[];
    area_square_Right=[];
    area_knots_Right=[];
    min_X_area_Right_light_int=[];
    min_X_area_Right_Fi2_dark=[];
    max_X_area_Right=[];
    min_X_area_Right=[];
    min_Y_area_Right_light_int=[];
    max_Y_area_Right_light_int=[];
    min_Y_area_Right_Fi2_dark=[];
    max_Y_area_Right_Fi2_dark=[];
    pith_or_long_square_indication_factor_Right=[];
else
    [index_no_knot]=find(Right_A_conv_hull_Fi2_dark_flat_ldru+Right_A_conv_hull_flat_ldru==0);
    [index_knot]=find(Right_A_conv_hull_Fi2_dark_flat_ldru+Right_A_conv_hull_flat_ldru>0);
    surf_type_Right=zeros(n_fields_Right,1);
    surf_type_Right(index_knot)=ceil(((Right_A_conv_hull_Fi2_dark_flat_ldru(index_knot)./Right_A_conv_hull_flat_ldru(index_knot))-prefer_dark_to_fibre_knot)/1e6)+1;
    index_type_1_Right=find(surf_type_Right==1);
    index_type_2_Right=find(surf_type_Right==2);

    area_square_Right=(knot_data_min_max_Right_flat_ldru(:,2)-knot_data_min_max_Right_flat_ldru(:,1)).*(knot_data_min_max_Right_flat_ldru(:,4)-knot_data_min_max_Right_flat_ldru(:,3));
    area_knots_Right=zeros(n_fields_Right,1);
    area_knots_Right(index_type_1_Right)=Right_A_conv_hull_flat_ldru(index_type_1_Right);
    area_knots_Right(index_type_2_Right)=Right_A_conv_hull_Fi2_dark_flat_ldru(index_type_2_Right);   

    min_X_area_Right_light_int=min(abs(Right_X_conv_hull_flat_ldru'))';
    max_X_area_Right_light_int=max((Right_X_conv_hull_flat_ldru'))';
    min_X_area_Right_Fi2_dark=min(abs(Right_X_conv_hull_Fi2_dark_flat_ldru'))';
    max_X_area_Right_Fi2_dark=max((Right_X_conv_hull_Fi2_dark_flat_ldru'))';
    min_X_area_Right=zeros(n_fields_Right,1);
    max_X_area_Right=zeros(n_fields_Right,1);
    min_X_area_Right(index_type_1_Right)=min_X_area_Right_light_int(index_type_1_Right);
    max_X_area_Right(index_type_1_Right)=max_X_area_Right_light_int(index_type_1_Right);
    min_X_area_Right(index_type_2_Right)=min_X_area_Right_Fi2_dark(index_type_2_Right);
    max_X_area_Right(index_type_2_Right)=max_X_area_Right_Fi2_dark(index_type_2_Right);

    min_Y_area_Right_light_int=min(abs(Right_Y_conv_hull_flat_ldru'))';
    max_Y_area_Right_light_int=max((Right_Y_conv_hull_flat_ldru'))';
    min_Y_area_Right_Fi2_dark=min(abs(Right_Y_conv_hull_Fi2_dark_flat_ldru'))';
    max_Y_area_Right_Fi2_dark=max((Right_Y_conv_hull_Fi2_dark_flat_ldru'))';
    min_Y_area_Right=zeros(n_fields_Right,1);
    max_Y_area_Right=zeros(n_fields_Right,1);
    min_Y_area_Right(index_type_1_Right)=min_Y_area_Right_light_int(index_type_1_Right);
    max_Y_area_Right(index_type_1_Right)=max_Y_area_Right_light_int(index_type_1_Right);
    min_Y_area_Right(index_type_2_Right)=min_Y_area_Right_Fi2_dark(index_type_2_Right);
    max_Y_area_Right(index_type_2_Right)=max_Y_area_Right_Fi2_dark(index_type_2_Right);

    pith_or_long_square_indication_factor_Right=zeros(n_fields_Right,1);
    pith_or_long_square_indication_factor_Right(index_type_1_Right)=ceil(floor(((max_Y_area_Right_light_int(index_type_1_Right)-min_Y_area_Right_light_int(index_type_1_Right))./(max_X_area_Right_light_int(index_type_1_Right)-min_X_area_Right_light_int(index_type_1_Right)))/pith_indication_factor)/1e6);
    pith_or_long_square_indication_factor_Right(index_type_2_Right)=ceil(floor(((max_Y_area_Right_Fi2_dark(index_type_2_Right)-min_Y_area_Right_Fi2_dark(index_type_2_Right))./(max_X_area_Right_Fi2_dark(index_type_2_Right)-min_X_area_Right_Fi2_dark(index_type_2_Right)))/pith_indication_factor)/1e6);
    pith_or_long_square_indication_factor_Right(find(ceil(floor((knot_data_min_max_Right_flat_ldru(:,4)-knot_data_min_max_Right_flat_ldru(:,3))/square_length_limit)/1e6)))=2;
end

                                         % (1)board number
                                         % (2)side 1~l, 2~d, 3~r, 4~u, 5~combined % NOTE THAT LEFT/RIGHT ARE SWITCHED COMPARED TO ORIGINAL DATA FILES ... 
                                         % (3)dark or fibre~0/1/2 (0 means no knot surface detected within the "fibre distrotion field")
                                         % (4)area square
                                         % (5)low x square
                                         % (6)high x square
                                         % (7)low y square
                                         % (8)high y square
                                         % (9)area knot
                                         % (10)low x knot
                                         % (11)high x knot
                                         % (12)low y knot
                                         % (13)high y knot
                                         % (14)square/knot remark 0~nothing/1~pith_or_crack/2~large_square(may be top rupture)
                                         % (15)board_remark 0~nothing/1~large_y_diff

% series_knot_data_ldru=[series_knot_data_ldru;
%                        % 1                          2                           3                4                    5  6  7  8                           9                 10                 11                  12                 13                  14                                            15  
%                        board*ones(n_fields_Left,1)  1*ones(n_fields_Left,1)     surf_type_Left   area_square_Left     knot_data_min_max_Left_flat_ldru     area_knots_Left   min_X_area_Left    max_X_area_Left     min_Y_area_Left    max_Y_area_Left     pith_or_long_square_indication_factor_Left    zeros(n_fields_Left,1);  
%                        board*ones(n_fields_Down,1)  2*ones(n_fields_Down,1)     surf_type_Down   area_square_Down     knot_data_min_max_Down_flat_ldru     area_knots_Down   min_X_area_Down    max_X_area_Down     min_Y_area_Down    max_Y_area_Down     pith_or_long_square_indication_factor_Down    zeros(n_fields_Down,1);  
%                        board*ones(n_fields_Right,1) 3*ones(n_fields_Right,1)    surf_type_Right  area_square_Right    knot_data_min_max_Right_flat_ldru    area_knots_Right  min_X_area_Right   max_X_area_Right    min_Y_area_Right   max_Y_area_Right    pith_or_long_square_indication_factor_Right   zeros(n_fields_Right,1);  
%                        board*ones(n_fields_Up,1)    4*ones(n_fields_Up,1)       surf_type_Up     area_square_Up       knot_data_min_max_Up_flat_ldru       area_knots_Up     min_X_area_Up      max_X_area_Up       min_Y_area_Up      max_Y_area_Up       pith_or_long_square_indication_factor_Up      zeros(n_fields_Up,1)];  
%                        % CONTINUE HERE! CHECK IF RESULTSA ARE CORRECT !!!
%                        % THEN CONTINUE AND DECIDE WHERE BOARDS MAY BE S FOR
%                        % FINGER JOINTS ...

if n_fields_Left>0
    board_knot_data_ldru=[board_knot_data_ldru;
                          board*ones(n_fields_Left,1)  1*ones(n_fields_Left,1)     surf_type_Left   area_square_Left     knot_data_min_max_Left_flat_ldru     area_knots_Left   min_X_area_Left    max_X_area_Left     min_Y_area_Left    max_Y_area_Left     pith_or_long_square_indication_factor_Left    zeros(n_fields_Left,1)];  
    series_knot_data_ldru=[series_knot_data_ldru;
                           % 1                          2                           3                4                    5  6  7  8                           9                 10                 11                  12                 13                  14                                            15  
                           board*ones(n_fields_Left,1)  1*ones(n_fields_Left,1)     surf_type_Left   area_square_Left     knot_data_min_max_Left_flat_ldru     area_knots_Left   min_X_area_Left    max_X_area_Left     min_Y_area_Left    max_Y_area_Left     pith_or_long_square_indication_factor_Left    zeros(n_fields_Left,1)];  
    [i,j,s]=find(pith_or_long_square_indication_factor_Left==1)
    Left_X_conv_hull_flat_ldru(i,:)=[];
    Left_Y_conv_hull_flat_ldru(i,:)=[];
end
if n_fields_Down>0
        board_knot_data_ldru=[board_knot_data_ldru;
                              board*ones(n_fields_Down,1)  2*ones(n_fields_Down,1)     surf_type_Down   area_square_Down     knot_data_min_max_Down_flat_ldru     area_knots_Down   min_X_area_Down    max_X_area_Down     min_Y_area_Down    max_Y_area_Down     pith_or_long_square_indication_factor_Down    zeros(n_fields_Down,1)];  
        series_knot_data_ldru=[series_knot_data_ldru;
                           % 1                          2                           3                4                    5  6  7  8                           9                 10                 11                  12                 13                  14                                            15  
                           board*ones(n_fields_Down,1)  2*ones(n_fields_Down,1)     surf_type_Down   area_square_Down     knot_data_min_max_Down_flat_ldru     area_knots_Down   min_X_area_Down    max_X_area_Down     min_Y_area_Down    max_Y_area_Down     pith_or_long_square_indication_factor_Down    zeros(n_fields_Down,1)];  
    [i,j,s]=find(pith_or_long_square_indication_factor_Down==1)
    Down_X_conv_hull_flat_ldru(i,:)=[];
    Down_Y_conv_hull_flat_ldru(i,:)=[];
end
if n_fields_Right>0
        board_knot_data_ldru=[board_knot_data_ldru;
                              board*ones(n_fields_Right,1) 3*ones(n_fields_Right,1)    surf_type_Right  area_square_Right    knot_data_min_max_Right_flat_ldru    area_knots_Right  min_X_area_Right   max_X_area_Right    min_Y_area_Right   max_Y_area_Right    pith_or_long_square_indication_factor_Right   zeros(n_fields_Right,1)];  
        series_knot_data_ldru=[series_knot_data_ldru;
                           % 1                          2                           3                4                    5  6  7  8                           9                 10                 11                  12                 13                  14                                            15  
                           board*ones(n_fields_Right,1) 3*ones(n_fields_Right,1)    surf_type_Right  area_square_Right    knot_data_min_max_Right_flat_ldru    area_knots_Right  min_X_area_Right   max_X_area_Right    min_Y_area_Right   max_Y_area_Right    pith_or_long_square_indication_factor_Right   zeros(n_fields_Right,1)];  
    [i,j,s]=find(pith_or_long_square_indication_factor_Right==1)
    Right_X_conv_hull_flat_ldru(i,:)=[];
    Right_Y_conv_hull_flat_ldru(i,:)=[];
end
if n_fields_Up>0
        board_knot_data_ldru=[board_knot_data_ldru;
                              board*ones(n_fields_Up,1)    4*ones(n_fields_Up,1)       surf_type_Up     area_square_Up       knot_data_min_max_Up_flat_ldru       area_knots_Up     min_X_area_Up      max_X_area_Up       min_Y_area_Up      max_Y_area_Up       pith_or_long_square_indication_factor_Up      zeros(n_fields_Up,1)];  
        series_knot_data_ldru=[series_knot_data_ldru;
                           % 1                          2                           3                4                    5  6  7  8                           9                 10                 11                  12                 13                  14                                            15  
                           board*ones(n_fields_Up,1)    4*ones(n_fields_Up,1)       surf_type_Up     area_square_Up       knot_data_min_max_Up_flat_ldru       area_knots_Up     min_X_area_Up      max_X_area_Up       min_Y_area_Up      max_Y_area_Up       pith_or_long_square_indication_factor_Up      zeros(n_fields_Up,1)];  
    [i,j,s]=find(pith_or_long_square_indication_factor_Up==1)
    Up_X_conv_hull_flat_ldru(i,:)=[];
    Up_Y_conv_hull_flat_ldru(i,:)=[];
end

% Remove pith and cracks from knot lists
[i,j,s]=find(board_knot_data_ldru(:,14)==1);
board_knot_data_ldru(i,:)=[];
[i,j,s]=find(series_knot_data_ldru(:,14)==2)
if length(i)>0
    suspected_top_rupture_in_board=[suspected_top_rupture_in_board; board];
end
[i,j,s]=find(board_knot_data_ldru(:,14)==1);
board_knot_data_ldru(i,:)=[];
%---------------------------------------------



if requirement_EN_15497==1
    d_crit=3;
elseif requirement_EN_15497==2
    d_crit=1.5;
end

%---------------------------------------------------------------------------------------------------------------------
%--- Left
[rows_left,j]=find(board_knot_data_ldru(:,2)==1);
nr_left=length(rows_left);
pos_mark_too_close_knot=[dL_close_knot/2:dL_close_knot:round(L*1000-dL_close_knot/2)]';
n_pos=length(pos_mark_too_close_knot);
mark_too_close_knot_left_1=zeros(n_pos,1);
mark_too_close_knot_left_2=zeros(n_pos,1);
mark_too_close_knot_left__L_edge=zeros(n_pos,2);
mark_too_close_knot_left__R_edge=zeros(n_pos,2);
prohibited_left_because_knot=[board_knot_data_ldru(rows_left,12)    board_knot_data_ldru(rows_left,13)];
x_prohibited_left_because_knot=[board_knot_data_ldru(rows_left,10)    board_knot_data_ldru(rows_left,11)];
for r=1:nr_left
    if sum(prohibited_left_because_knot(r,:))==0
    
    else
        [dummy,p1]=min(abs(pos_mark_too_close_knot-prohibited_left_because_knot(r,1)));
        [dummy,p2]=min(abs(pos_mark_too_close_knot-prohibited_left_because_knot(r,2)));
        %mark_too_close_knot_left(p1:p2)=1;
        if x_prohibited_left_because_knot(r,1)<edge_tolerance
            mark_too_close_knot_left__L_edge(p1:p2,1)=1;
            mark_too_close_knot_left__L_edge(p1:p2,2)=r;
        elseif abs(x_prohibited_left_because_knot(r,2)-B*1000)<edge_tolerance
            mark_too_close_knot_left__R_edge(p1:p2,1)=1;
            mark_too_close_knot_left__R_edge(p1:p2,2)=r;
        end
    end
end

%--- Down
[rows_down,j]=find(board_knot_data_ldru(:,2)==2);
nr_down=length(rows_down);
n_pos=length(pos_mark_too_close_knot);
mark_too_close_knot_down_1=zeros(n_pos,1);
mark_too_close_knot_down_2=zeros(n_pos,1);
mark_too_close_knot_down__L_edge=zeros(n_pos,2);
mark_too_close_knot_down__R_edge=zeros(n_pos,2);
prohibited_down_because_knot=[board_knot_data_ldru(rows_down,12)    board_knot_data_ldru(rows_down,13)];
x_prohibited_down_because_knot=[board_knot_data_ldru(rows_down,10)    board_knot_data_ldru(rows_down,11)];
for r=1:nr_down
    if sum(prohibited_down_because_knot(r,:))==0
    
    else
        [dummy,p1]=min(abs(pos_mark_too_close_knot-prohibited_down_because_knot(r,1)));
        [dummy,p2]=min(abs(pos_mark_too_close_knot-prohibited_down_because_knot(r,2)));
        if x_prohibited_down_because_knot(r,1)<edge_tolerance
            mark_too_close_knot_down__L_edge(p1:p2,1)=1;
            mark_too_close_knot_down__L_edge(p1:p2,2)=r;
        elseif abs(x_prohibited_down_because_knot(r,2)-H*1000)<edge_tolerance
            mark_too_close_knot_down__R_edge(p1:p2,1)=1;
            mark_too_close_knot_down__R_edge(p1:p2,2)=r;
        end
    end
end

%--- Right
[rows_right,j]=find(board_knot_data_ldru(:,2)==3);
nr_right=length(rows_right);
n_pos=length(pos_mark_too_close_knot);
mark_too_close_knot_right_1=zeros(n_pos,1);
mark_too_close_knot_right_2=zeros(n_pos,1);
mark_too_close_knot_right__L_edge=zeros(n_pos,2);
mark_too_close_knot_right__R_edge=zeros(n_pos,2);
prohibited_right_because_knot=[board_knot_data_ldru(rows_right,12)    board_knot_data_ldru(rows_right,13)];
x_prohibited_right_because_knot=[board_knot_data_ldru(rows_right,10)    board_knot_data_ldru(rows_right,11)];
for r=1:nr_right
    if sum(prohibited_right_because_knot(r,:))==0
    
    else
        [dummy,p1]=min(abs(pos_mark_too_close_knot-prohibited_right_because_knot(r,1)));
        [dummy,p2]=min(abs(pos_mark_too_close_knot-prohibited_right_because_knot(r,2)));
        if x_prohibited_right_because_knot(r,1)<edge_tolerance
            mark_too_close_knot_right__L_edge(p1:p2,1)=1;
            mark_too_close_knot_right__L_edge(p1:p2,2)=r;
        elseif abs(x_prohibited_right_because_knot(r,2)-B*1000)<edge_tolerance
            mark_too_close_knot_right__R_edge(p1:p2,1)=1;
            mark_too_close_knot_right__R_edge(p1:p2,2)=r;
        end
    end
end

%--- Up
[rows_up,j]=find(board_knot_data_ldru(:,2)==4);
nr_up=length(rows_up);
n_pos=length(pos_mark_too_close_knot);
mark_too_close_knot_up_1=zeros(n_pos,1);
mark_too_close_knot_up_2=zeros(n_pos,1);
mark_too_close_knot_up__L_edge=zeros(n_pos,2);
mark_too_close_knot_up__R_edge=zeros(n_pos,2);
prohibited_up_because_knot=[board_knot_data_ldru(rows_up,12)    board_knot_data_ldru(rows_up,13)];
x_prohibited_up_because_knot=[board_knot_data_ldru(rows_up,10)    board_knot_data_ldru(rows_up,11)];
for r=1:nr_up
    if sum(prohibited_up_because_knot(r,:))==0
    
    else
        [dummy,p1]=min(abs(pos_mark_too_close_knot-prohibited_up_because_knot(r,1)));
        [dummy,p2]=min(abs(pos_mark_too_close_knot-prohibited_up_because_knot(r,2)));
        if x_prohibited_up_because_knot(r,1)<edge_tolerance
            mark_too_close_knot_up__L_edge(p1:p2,1)=1;
            mark_too_close_knot_up__L_edge(p1:p2,2)=r;
        elseif abs(x_prohibited_up_because_knot(r,2)-H*1000)<edge_tolerance
            mark_too_close_knot_up__R_edge(p1:p2,1)=1;
            mark_too_close_knot_up__R_edge(p1:p2,2)=r;
        end
    end
end

%---------------------------------------------------------------------------------------------------------------------

%--- Left
pos_extra_diam_left_L=find(mark_too_close_knot_left__L_edge(:,1).*mark_too_close_knot_up__R_edge(:,1));
d_adjust_extra_diam_left=[mark_too_close_knot_left__L_edge(pos_extra_diam_left_L,2)   mark_too_close_knot_up__R_edge(pos_extra_diam_left_L,2)];
[nrd_left_L,two]=size(d_adjust_extra_diam_left);
if nrd_left_L>0
    dae_left_L=d_adjust_extra_diam_left(1,:);
    for k=1:(nrd_left_L-1)
        if d_adjust_extra_diam_left(k+1,:)==d_adjust_extra_diam_left(k,:)
        else
            dae_left_L=[dae_left_L; d_adjust_extra_diam_left(k+1,:)];
        end
    end
end
pos_extra_diam_left_R=find(mark_too_close_knot_left__R_edge(:,1).*mark_too_close_knot_down__L_edge(:,1));
d_adjust_extra_diam_left=[mark_too_close_knot_left__R_edge(pos_extra_diam_left_R,2)   mark_too_close_knot_down__L_edge(pos_extra_diam_left_R,2)];
[nrd_left_R,two]=size(d_adjust_extra_diam_left);
if nrd_left_R>0
    dae_left_R=d_adjust_extra_diam_left(1,:);
    for k=1:(nrd_left_R-1)
        if d_adjust_extra_diam_left(k+1,:)==d_adjust_extra_diam_left(k,:)
        else
            dae_left_R=[dae_left_R; d_adjust_extra_diam_left(k+1,:)];
        end
    end
end
d_left_knot_1=board_knot_data_ldru(rows_left,11)-board_knot_data_ldru(rows_left,10);

%--- Down
pos_extra_diam_down_L=find(mark_too_close_knot_down__L_edge(:,1).*mark_too_close_knot_left__R_edge(:,1));
d_adjust_extra_diam_down=[mark_too_close_knot_down__L_edge(pos_extra_diam_down_L,2)   mark_too_close_knot_left__R_edge(pos_extra_diam_down_L,2)];
[nrd_down_L,two]=size(d_adjust_extra_diam_down);
if nrd_down_L>0
    dae_down_L=d_adjust_extra_diam_down(1,:);
    for k=1:(nrd_down_L-1)
        if d_adjust_extra_diam_down(k+1,:)==d_adjust_extra_diam_down(k,:)
        else
            dae_down_L=[dae_down_L; d_adjust_extra_diam_down(k+1,:)];
        end
    end
end
pos_extra_diam_down_R=find(mark_too_close_knot_down__R_edge(:,1).*mark_too_close_knot_right__L_edge(:,1));
d_adjust_extra_diam_down=[mark_too_close_knot_down__R_edge(pos_extra_diam_down_R,2)   mark_too_close_knot_right__L_edge(pos_extra_diam_down_R,2)];
[nrd_down_R,two]=size(d_adjust_extra_diam_down);
if nrd_down_R>0
    dae_down_R=d_adjust_extra_diam_down(1,:);
    for k=1:(nrd_down_R-1)
        if d_adjust_extra_diam_down(k+1,:)==d_adjust_extra_diam_down(k,:)
        else
            dae_down_R=[dae_down_R; d_adjust_extra_diam_down(k+1,:)];
        end
    end
end
d_down_knot_1=board_knot_data_ldru(rows_down,11)-board_knot_data_ldru(rows_down,10);

%--- Right
pos_extra_diam_right_L=find(mark_too_close_knot_right__L_edge(:,1).*mark_too_close_knot_down__R_edge(:,1));
d_adjust_extra_diam_right=[mark_too_close_knot_right__L_edge(pos_extra_diam_right_L,2)   mark_too_close_knot_down__R_edge(pos_extra_diam_right_L,2)];
[nrd_right_L,two]=size(d_adjust_extra_diam_right);
if nrd_right_L>0
    dae_right_L=d_adjust_extra_diam_right(1,:);
    for k=1:(nrd_right_L-1)
        if d_adjust_extra_diam_right(k+1,:)==d_adjust_extra_diam_right(k,:)
        else
            dae_right_L=[dae_right_L; d_adjust_extra_diam_right(k+1,:)];
        end
    end
end
pos_extra_diam_right_R=find(mark_too_close_knot_right__R_edge(:,1).*mark_too_close_knot_up__L_edge(:,1));
d_adjust_extra_diam_right=[mark_too_close_knot_right__R_edge(pos_extra_diam_right_R,2)   mark_too_close_knot_up__L_edge(pos_extra_diam_right_R,2)];
[nrd_right_R,two]=size(d_adjust_extra_diam_right);
if nrd_right_R>0
    dae_right_R=d_adjust_extra_diam_right(1,:);
    for k=1:(nrd_right_R-1)
        if d_adjust_extra_diam_right(k+1,:)==d_adjust_extra_diam_right(k,:)
        else
            dae_right_R=[dae_right_R; d_adjust_extra_diam_right(k+1,:)];
        end
    end
end
d_right_knot_1=board_knot_data_ldru(rows_right,11)-board_knot_data_ldru(rows_right,10);

%--- Up
pos_extra_diam_up_L=find(mark_too_close_knot_up__L_edge(:,1).*mark_too_close_knot_right__R_edge(:,1));
d_adjust_extra_diam_up=[mark_too_close_knot_up__L_edge(pos_extra_diam_up_L,2)   mark_too_close_knot_right__R_edge(pos_extra_diam_up_L,2)];
[nrd_up_L,two]=size(d_adjust_extra_diam_up);
if nrd_up_L>0
    dae_up_L=d_adjust_extra_diam_up(1,:);
    for k=1:(nrd_up_L-1)
        if d_adjust_extra_diam_up(k+1,:)==d_adjust_extra_diam_up(k,:)
        else
            dae_up_L=[dae_up_L; d_adjust_extra_diam_up(k+1,:)];
        end
    end
end
pos_extra_diam_up_R=find(mark_too_close_knot_up__R_edge(:,1).*mark_too_close_knot_left__L_edge(:,1));
d_adjust_extra_diam_up=[mark_too_close_knot_up__R_edge(pos_extra_diam_up_R,2)   mark_too_close_knot_left__L_edge(pos_extra_diam_up_R,2)];
[nrd_up_R,two]=size(d_adjust_extra_diam_up);
if nrd_up_R>0
    dae_up_R=d_adjust_extra_diam_up(1,:);
    for k=1:(nrd_up_R-1)
        if d_adjust_extra_diam_up(k+1,:)==d_adjust_extra_diam_up(k,:)
        else
            dae_up_R=[dae_up_R; d_adjust_extra_diam_up(k+1,:)];
        end
    end
end
d_up_knot_1=board_knot_data_ldru(rows_up,11)-board_knot_data_ldru(rows_up,10);

%------------------------------------------------------------
% Left
d_left_knot_2=d_left_knot_1;
if nrd_left_L>0
    d_left_knot_2(dae_left_L(:,1))=d_left_knot_2(dae_left_L(:,1))+d_up_knot_1(dae_left_L(:,2));
end
if nrd_left_R>0
    d_left_knot_2(dae_left_R(:,1))=d_left_knot_2(dae_left_R(:,1))+d_down_knot_1(dae_left_R(:,2));
end
prohibited_left_because_knot_1=[board_knot_data_ldru(rows_left,12)-d_left_knot_1*d_crit    board_knot_data_ldru(rows_left,13)+d_left_knot_1*d_crit];
prohibited_left_because_knot_2=[board_knot_data_ldru(rows_left,12)-d_left_knot_2*d_crit    board_knot_data_ldru(rows_left,13)+d_left_knot_2*d_crit];

[i,j,s]=find(ceil((disreg_smaller_knot_diam-d_left_knot_1)/1e6));
prohibited_left_because_knot_1(i,:)=zeros(length(i),2);
[i,j,s]=find(ceil((disreg_smaller_knot_diam-d_left_knot_2)/1e6));
prohibited_left_because_knot_2(i,:)=zeros(length(i),2);
for r=1:nr_left
    [dummy,p1]=min(abs(pos_mark_too_close_knot-prohibited_left_because_knot_1(r,1)));
    [dummy,p2]=min(abs(pos_mark_too_close_knot-prohibited_left_because_knot_1(r,2)));
    mark_too_close_knot_left_1(p1:p2)=1;
    [dummy,p1]=min(abs(pos_mark_too_close_knot-prohibited_left_because_knot_2(r,1)));
    [dummy,p2]=min(abs(pos_mark_too_close_knot-prohibited_left_because_knot_2(r,2)));
    mark_too_close_knot_left_2(p1:p2)=1;
end

% Down
d_down_knot_2=d_down_knot_1;
if nrd_down_L>0
    d_down_knot_2(dae_down_L(:,1))=d_down_knot_2(dae_down_L(:,1))+d_left_knot_1(dae_down_L(:,2));
end
if nrd_down_R>0
    d_down_knot_2(dae_down_R(:,1))=d_down_knot_2(dae_down_R(:,1))+d_right_knot_1(dae_down_R(:,2));
end
prohibited_down_because_knot_1=[board_knot_data_ldru(rows_down,12)-d_down_knot_1*d_crit    board_knot_data_ldru(rows_down,13)+d_down_knot_1*d_crit];
prohibited_down_because_knot_2=[board_knot_data_ldru(rows_down,12)-d_down_knot_2*d_crit    board_knot_data_ldru(rows_down,13)+d_down_knot_2*d_crit];
[i,j,s]=find(ceil((disreg_smaller_knot_diam-d_down_knot_1)/1e6));
prohibited_down_because_knot_1(i,:)=zeros(length(i),2);
[i,j,s]=find(ceil((disreg_smaller_knot_diam-d_down_knot_2)/1e6));
prohibited_down_because_knot_2(i,:)=zeros(length(i),2);
for r=1:nr_down
    [dummy,p1]=min(abs(pos_mark_too_close_knot-prohibited_down_because_knot_1(r,1)));
    [dummy,p2]=min(abs(pos_mark_too_close_knot-prohibited_down_because_knot_1(r,2)));
    mark_too_close_knot_down_1(p1:p2)=1;
    [dummy,p1]=min(abs(pos_mark_too_close_knot-prohibited_down_because_knot_2(r,1)));
    [dummy,p2]=min(abs(pos_mark_too_close_knot-prohibited_down_because_knot_2(r,2)));
    mark_too_close_knot_down_2(p1:p2)=1;
end

% Right
d_right_knot_2=d_right_knot_1;
if nrd_right_L>0
    d_right_knot_2(dae_right_L(:,1))=d_right_knot_2(dae_right_L(:,1))+d_down_knot_1(dae_right_L(:,2));
end
if nrd_right_R>0
    d_right_knot_2(dae_right_R(:,1))=d_right_knot_2(dae_right_R(:,1))+d_up_knot_1(dae_right_R(:,2));
end
prohibited_right_because_knot_1=[board_knot_data_ldru(rows_right,12)-d_right_knot_1*d_crit    board_knot_data_ldru(rows_right,13)+d_right_knot_1*d_crit];
prohibited_right_because_knot_2=[board_knot_data_ldru(rows_right,12)-d_right_knot_2*d_crit    board_knot_data_ldru(rows_right,13)+d_right_knot_2*d_crit];
[i,j,s]=find(ceil((disreg_smaller_knot_diam-d_right_knot_1)/1e6));
prohibited_right_because_knot_1(i,:)=zeros(length(i),2);
[i,j,s]=find(ceil((disreg_smaller_knot_diam-d_right_knot_2)/1e6));
prohibited_right_because_knot_2(i,:)=zeros(length(i),2);
for r=1:nr_right
    [dummy,p1]=min(abs(pos_mark_too_close_knot-prohibited_right_because_knot_1(r,1)));
    [dummy,p2]=min(abs(pos_mark_too_close_knot-prohibited_right_because_knot_1(r,2)));
    mark_too_close_knot_right_1(p1:p2)=1;
    [dummy,p1]=min(abs(pos_mark_too_close_knot-prohibited_right_because_knot_2(r,1)));
    [dummy,p2]=min(abs(pos_mark_too_close_knot-prohibited_right_because_knot_2(r,2)));
    mark_too_close_knot_right_2(p1:p2)=1;
end

% Up
d_up_knot_2=d_up_knot_1;
if nrd_up_L>0
    d_up_knot_2(dae_up_L(:,1))=d_up_knot_2(dae_up_L(:,1))+d_right_knot_1(dae_up_L(:,2));
end
if nrd_up_R>0
    d_up_knot_2(dae_up_R(:,1))=d_up_knot_2(dae_up_R(:,1))+d_left_knot_1(dae_up_R(:,2));
end
prohibited_up_because_knot_1=[board_knot_data_ldru(rows_up,12)-d_up_knot_1*d_crit    board_knot_data_ldru(rows_up,13)+d_up_knot_1*d_crit];
prohibited_up_because_knot_2=[board_knot_data_ldru(rows_up,12)-d_up_knot_2*d_crit    board_knot_data_ldru(rows_up,13)+d_up_knot_2*d_crit];
[i,j,s]=find(ceil((disreg_smaller_knot_diam-d_up_knot_1)/1e6));
prohibited_up_because_knot_1(i,:)=zeros(length(i),2);
[i,j,s]=find(ceil((disreg_smaller_knot_diam-d_up_knot_2)/1e6));
prohibited_up_because_knot_2(i,:)=zeros(length(i),2);
for r=1:nr_up
    [dummy,p1]=min(abs(pos_mark_too_close_knot-prohibited_up_because_knot_1(r,1)));
    [dummy,p2]=min(abs(pos_mark_too_close_knot-prohibited_up_because_knot_1(r,2)));
    mark_too_close_knot_up_1(p1:p2)=1;
    [dummy,p1]=min(abs(pos_mark_too_close_knot-prohibited_up_because_knot_2(r,1)));
    [dummy,p2]=min(abs(pos_mark_too_close_knot-prohibited_up_because_knot_2(r,2)));
    mark_too_close_knot_up_2(p1:p2)=1;
end


mark_too_close_knot_all_1=ceil((mark_too_close_knot_left_1+mark_too_close_knot_down_1+mark_too_close_knot_right_1+mark_too_close_knot_up_1)/5);
[prohib_pos_knot_1,dummy]=find(mark_too_close_knot_all_1);
mark_too_close_knot_all_2=ceil((mark_too_close_knot_left_2+mark_too_close_knot_down_2+mark_too_close_knot_right_2+mark_too_close_knot_up_2)/5);
[prohib_pos_knot_2,dummy]=find(mark_too_close_knot_all_2);

correct_cd_300
cd(dir_WoodEye_project)
cd(DIRstr)
save board_knot_data_ldru
cd(WD);

%%%%%%%%%%%%%%%%%%%%%%%%%%



