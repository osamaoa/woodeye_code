board_knot_data_ldru=[];
for side=1:4
    if side==1 % up
        X_SIDE=X_UP;
        Y_SIDE=Y_UP;
        Fi1_SIDE=Fi1_UP;
        Fi2_SIDE=Fi2_UP;
        DX=H;
        im_RedSide_red=im_RedUp_red;
        X_raw=X_raw_Up;
        Y_raw=Y_raw_Up;

        [r,k]=size(Fi2_SIDE);
        Fi_up_flat_ldru=Fi2_SIDE;
        [r,k]=size(im_RedSide_red);
        im_RedUp_red_flat_ldru=im_RedSide_red;
        X_raw_Up_flat_ldru=X_raw;
        Y_raw_Up_flat_ldru=Y_raw;
        X_UP_flat_ldru=X_SIDE;
        Y_UP_flat_ldru=Y_SIDE;

    elseif side==2 % down
        X_SIDE=X_DOWN;
        Y_SIDE=Y_DOWN;
        Fi1_SIDE=Fi1_DOWN;
        Fi2_SIDE=Fi2_DOWN;

        DX=H;
        im_RedSide_red=im_RedDown_red;
        X_raw=X_raw_Down;
        Y_raw=Y_raw_Down;

        [r,k]=size(Fi2_SIDE);
        Fi_down_flat_ldru=Fi2_SIDE(:,k+1-[1:k]);

        [r,k]=size(im_RedSide_red);
        im_RedDown_red_flat_ldru=im_RedSide_red(:,k+1-[1:k]);
        X_raw_Down_flat_ldru=X_raw;
        Y_raw_Down_flat_ldru=Y_raw;
        X_DOWN_flat_ldru=X_SIDE;
        Y_DOWN_flat_ldru=Y_SIDE;

    elseif side==4 % left blir right
        X_SIDE=X_RIGHT;
        Y_SIDE=Y_RIGHT;
        Fi1_SIDE=Fi1_RIGHT;
        Fi2_SIDE=Fi2_RIGHT;
        DX=B;
        im_RedSide_red=im_RedRight_red;
        X_raw=X_raw_Right;
        Y_raw=Y_raw_Right;

        [r,k]=size(Fi2_SIDE);
        Fi_left_flat_ldru=Fi2_SIDE(:,k+1-[1:k]);

        [r,k]=size(im_RedSide_red);
        im_RedLeft_red_flat_ldru=im_RedSide_red(:,k+1-[1:k]);
        %im_RedLeft_red_flat_ldru=im_RedSide_red;


        X_raw_Left_flat_ldru=X_raw;
        Y_raw_Left_flat_ldru=Y_raw;
        X_LEFT_flat_ldru=X_SIDE;
        Y_LEFT_flat_ldru=Y_SIDE;

    elseif side==3 % right blir left
        X_SIDE=X_LEFT;
        Y_SIDE=Y_LEFT;
        Fi1_SIDE=Fi1_LEFT;
        Fi2_SIDE=Fi2_LEFT;

        DX=B;
        im_RedSide_red=im_RedLeft_red;
        X_raw=X_raw_Left;
        Y_raw=Y_raw_Left;

        [r,k]=size(Fi2_SIDE);
        %Fi_right_flat_ldru=Fi2_SIDE(:,k+1-[1:k]);
        %mark_knot_right_flat_ldru=mark_knot_side(:,k+1-[1:k]);
        Fi_right_flat_ldru=Fi2_SIDE;
        [r,k]=size(im_RedSide_red);
        %im_RedRight_red_flat_ldru=im_RedSide_red(:,k+1-[1:k]);
        im_RedRight_red_flat_ldru=im_RedSide_red;
        X_raw_Right_flat_ldru=X_raw;
        Y_raw_Right_flat_ldru=Y_raw;
        X_RIGHT_flat_ldru=X_SIDE;
        Y_RIGHT_flat_ldru=Y_SIDE;
    end
end

correct_cd_300
cd(dir_WoodEye_project)
cd(DIRstr)
save board_knot_data_ldru
cd(WD);

%%%%%%%%%%%%%%%%%%%%%%%%%%



