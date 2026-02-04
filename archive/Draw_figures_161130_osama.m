   %--------------------Figures-----------------------------------------------
   show_fig_number=[1 1 1 1 0 1 0 0];
   
   %--------------------------------------------------------------------------
   fig_next=0;
   for side=1:4
       
     if side==1
           X_SIDE=X_UP;
           Y_SIDE=Y_UP;
           Fi1_SIDE=Fi1_UP;
           Fi2_SIDE=Fi2_UP;
           
           DX=H;
           im_RedSide_red=im_RedUp_red;
           X_raw=X_raw_Up;
           Y_raw=Y_raw_Up;
           
     elseif side==2
           X_SIDE=X_DOWN;
           Y_SIDE=Y_DOWN;
           Fi1_SIDE=Fi1_DOWN;
           Fi2_SIDE=Fi2_DOWN;
           
           DX=H;
           im_RedSide_red=im_RedDown_red;
           X_raw=X_raw_Down;
           Y_raw=Y_raw_Down;
           
     elseif side==3
           X_SIDE=X_LEFT;
           Y_SIDE=Y_LEFT;
           Fi1_SIDE=Fi1_LEFT;
           Fi2_SIDE=Fi2_LEFT;
           
           DX=B;
           im_RedSide_red=im_RedLeft_red;
           X_raw=X_raw_Left;
           Y_raw=Y_raw_Left;
           
     elseif side==4
           X_SIDE=X_RIGHT;
           Y_SIDE=Y_RIGHT;
           Fi1_SIDE=Fi1_RIGHT;
           Fi2_SIDE=Fi2_RIGHT;
           
           DX=B;
           
      end
 
       
       
       
      if side==1
           %fig_next=fig_next+1; 
           %figure(fig_next)
           if show_fig_number(1)==1
               figure(1) %4 Color picture of Fi1, Fi2, total angle to pith ...
               clf
               hold on
               colormap('jet')
               aa=surf(ones(length(Y_SIDE),1)*X_SIDE'+(1000*DX+20)*0,Y_SIDE*ones(1,length(X_SIDE)),ones(length(Y_SIDE),length(X_SIDE))*B*1000,abs(Fi1_SIDE)*180/pi);
               set(aa,'edgecolor','none','facecolor','interp')
               %axis equal
               aa=surf(ones(length(Y_SIDE),1)*X_SIDE'+1*(1000*DX+20),Y_SIDE*ones(1,length(X_SIDE)),ones(length(Y_SIDE),length(X_SIDE))*B*1000,abs(Fi2_SIDE)*180/pi);
               set(aa,'edgecolor','none','facecolor','interp')
               quiver(X_SIDE+(1000*DX+20)*3,Y_SIDE,-sin(Fi2_SIDE),cos(Fi2_SIDE),1,'k.');
               aa=surf(ones(length(Y_raw),1)*X_raw'+(1000*DX+20)*4,Y_raw*ones(1,length(X_raw)),im_RedSide_red*0-1,im_RedSide_red*100);
               set(aa,'edgecolor','none','facecolor','interp')
               
               colorbar
               axis equal
           end
      end
      if side==2
           %fig_next=fig_next+1; 
           %figure(fig_next)
           if show_fig_number(2)==1
               figure(2) %4 Color picture of Fi1, Fi2, total angle to pith ...
               clf
               hold on
               colormap('jet')
               aa=surf(ones(length(Y_SIDE),1)*X_SIDE'+(1000*DX+20)*0,Y_SIDE*ones(1,length(X_SIDE)),ones(length(Y_SIDE),length(X_SIDE))*B*1000,abs(Fi1_SIDE)*180/pi);
               set(aa,'edgecolor','none','facecolor','interp')
               aa=surf(ones(length(Y_SIDE),1)*X_SIDE'+1*(1000*DX+20),Y_SIDE*ones(1,length(X_SIDE)),ones(length(Y_SIDE),length(X_SIDE))*B*1000,abs(Fi2_SIDE)*180/pi);
               set(aa,'edgecolor','none','facecolor','interp')
               quiver(X_SIDE+(1000*DX+20)*3,Y_SIDE,-sin(Fi2_SIDE),cos(Fi2_SIDE),1,'k.');
               aa=surf(ones(length(Y_raw),1)*X_raw'+(1000*DX+20)*4,Y_raw*ones(1,length(X_raw)),im_RedSide_red*0-1,im_RedSide_red*100);
               set(aa,'edgecolor','none','facecolor','interp')
               
               colorbar
               axis equal
           end
      end
      if side==3
           %fig_next=fig_next+1; 
           %figure(fig_next)
           if show_fig_number(3)==1
               figure(3) %4 Color picture of Fi1, Fi2, total angle to pith ...
               clf
               hold on
               colormap('jet')
               aa=surf(ones(length(Y_SIDE),1)*X_SIDE'+(1000*DX+20)*0,Y_SIDE*ones(1,length(X_SIDE)),ones(length(Y_SIDE),length(X_SIDE))*B*1000,abs(Fi1_SIDE)*180/pi);
               set(aa,'edgecolor','none','facecolor','interp')
               aa=surf(ones(length(Y_SIDE),1)*X_SIDE'+1*(1000*DX+20),Y_SIDE*ones(1,length(X_SIDE)),ones(length(Y_SIDE),length(X_SIDE))*B*1000,abs(Fi2_SIDE)*180/pi);
               set(aa,'edgecolor','none','facecolor','interp')
               quiver(X_SIDE+(1000*DX+20)*3,Y_SIDE,-sin(Fi2_SIDE),cos(Fi2_SIDE),1,'k.');
               aa=surf(ones(length(Y_raw),1)*X_raw'+(1000*DX+20)*4,Y_raw*ones(1,length(X_raw)),im_RedSide_red*0-1,im_RedSide_red*100);
               set(aa,'edgecolor','none','facecolor','interp')
               
               colorbar
               axis equal
           end
       end
       if side==4
           %fig_next=fig_next+1; 
           %figure(fig_next)
           if show_fig_number(4)==1
               figure(4) %4 Color picture of Fi1, Fi2, total angle to pith ...
               clf
               hold on
               colormap('jet')
               aa=surf(ones(length(Y_SIDE),1)*X_SIDE'+(1000*DX+20)*0,Y_SIDE*ones(1,length(X_SIDE)),ones(length(Y_SIDE),length(X_SIDE))*B*1000,abs(Fi1_SIDE)*180/pi);
               set(aa,'edgecolor','none','facecolor','interp')
               aa=surf(ones(length(Y_SIDE),1)*X_SIDE'+1*(1000*DX+20),Y_SIDE*ones(1,length(X_SIDE)),ones(length(Y_SIDE),length(X_SIDE))*B*1000,abs(Fi2_SIDE)*180/pi);
               set(aa,'edgecolor','none','facecolor','interp')
               quiver(X_SIDE+(1000*DX+20)*3,Y_SIDE,-sin(Fi2_SIDE),cos(Fi2_SIDE),1,'k.');
               aa=surf(ones(length(Y_raw),1)*X_raw'+(1000*DX+20)*4,Y_raw*ones(1,length(X_raw)),im_RedSide_red*0-1,im_RedSide_red*100);
               set(aa,'edgecolor','none','facecolor','interp')
               contour(X_SIDE+(1000*DX+20)*4,Y_SIDE,mark_knot_side,1,'m')
              
               colorbar
               axis equal
           end
       end
       if side==4
           %fig_next=fig_next+1; 
           %figure(fig_next)
           if show_fig_number(4)==1
               figure(4) %4 Color picture of Fi1, Fi2, total angle to pith ...
               clf
               hold on
               colormap('jet')
               aa=surf(ones(length(Y_SIDE),1)*X_SIDE'+(1000*DX+20)*0,Y_SIDE*ones(1,length(X_SIDE)),ones(length(Y_SIDE),length(X_SIDE))*B*1000,abs(Fi1_SIDE)*180/pi);
               set(aa,'edgecolor','none','facecolor','interp')
               axis equal
               aa=surf(ones(length(Y_SIDE),1)*X_SIDE'+1*(1000*DX+20),Y_SIDE*ones(1,length(X_SIDE)),ones(length(Y_SIDE),length(X_SIDE))*B*1000,abs(Fi2_SIDE)*180/pi);
               set(aa,'edgecolor','none','facecolor','interp')
               quiver(X_SIDE+(1000*DX+20)*3,Y_SIDE,-sin(Fi2_SIDE),cos(Fi2_SIDE),1,'k.');
               aa=surf(ones(length(Y_raw),1)*X_raw'+(1000*DX+20)*4,Y_raw*ones(1,length(X_raw)),im_RedSide_red*0-1,im_RedSide_red*100);
               set(aa,'edgecolor','none','facecolor','interp')

               colorbar
               axis equal
           end
       end
     

       %%%%%%%%%%%%%%%%%%%%%%
       if side==4
           if show_fig_number(5)==1
               figure(5) %6  Photo with indicated red fields for fibre disturbance and green or blue for knots ...
               clf
               hold on
               %colormap('gray')
               colormap([0.006 0.0056 0.0001;0.018 0.0054 0.0001;0.03 0.0051 0.0001;0.0419 0.0049 0.0001;0.0539 0.0047 0.0001;0.0659 0.0045 0.0001;0.0779 0.0043 0.0001;0.0899 0.004 0.0001;0.1018 0.0038 0.0001;0.1138 0.0036 0.0001;0.1258 0.0034 0.0001;0.1378 0.0032 0.0001;0.1498 0.003 0.0001;0.1618 0.0027 0.0001;0.1737 0.0025 0.0001;0.1857 0.0023 0.0001;0.1977 0.0021 0.0001;0.2097 0.0019 0;0.2217 0.0016 0;0.2336 0.0014 0;0.2456 0.0012 0;0.2576 0.001 0;0.2696 0.0008 0;0.2816 0.0005 0;0.2936 0.0003 0;0.3055 0.0001 0;0.3155 0.0017 0;0.3235 0.005 0.0001;0.3315 0.0083 0.0001;0.3394 0.0116 0.0001;0.3474 0.0149 0.0002;0.3554 0.0182 0.0002;0.3633 0.0215 0.0003;0.3713 0.0248 0.0003;0.3793 0.0281 0.0004;0.3873 0.0314 0.0004;0.3952 0.0347 0.0004;0.4032 0.038 0.0005;0.4112 0.0414 0.0005;0.4191 0.0447 0.0006;0.4271 0.048 0.0006;0.4351 0.0513 0.0007;0.4431 0.0546 0.0007;0.451 0.0579 0.0007;0.459 0.0612 0.0008;0.467 0.0645 0.0008;0.4749 0.0678 0.0009;0.4829 0.0711 0.0009;0.4909 0.0744 0.001;0.4988 0.0778 0.001;0.5068 0.0811 0.001;0.5148 0.0844 0.0011;0.5216 0.0892 0.0011;0.5272 0.0955 0.001;0.5329 0.1018 0.001;0.5385 0.1081 0.001;0.5442 0.1143 0.0009;0.5498 0.1206 0.0009;0.5555 0.1269 0.0008;0.5611 0.1332 0.0008;0.5668 0.1395 0.0007;0.5724 0.1458 0.0007;0.5781 0.1521 0.0007;0.5837 0.1584 0.0006;0.5894 0.1647 0.0006;0.595 0.171 0.0005;0.6007 0.1773 0.0005;0.6063 0.1836 0.0004;0.612 0.1899 0.0004;0.6176 0.1962 0.0004;0.6232 0.2024 0.0003;0.6289 0.2087 0.0003;0.6345 0.215 0.0002;0.6402 0.2213 0.0002;0.6458 0.2276 0.0001;0.6515 0.2339 0.0001;0.6571 0.2402 0.0001;0.6628 0.2465 0;0.6675 0.253 0.0005;0.6714 0.2598 0.0015;0.6752 0.2666 0.0025;0.6791 0.2734 0.0035;0.6829 0.2802 0.0044;0.6867 0.287 0.0054;0.6906 0.2938 0.0064;0.6944 0.3006 0.0074;0.6983 0.3074 0.0084;0.7021 0.3142 0.0094;0.706 0.321 0.0104;0.7098 0.3278 0.0114;0.7137 0.3346 0.0124;0.7175 0.3414 0.0133;0.7214 0.3482 0.0143;0.7252 0.355 0.0153;0.729 0.3618 0.0163;0.7329 0.3686 0.0173;0.7367 0.3754 0.0183;0.7406 0.3822 0.0193;0.7444 0.389 0.0203;0.7483 0.3958 0.0213;0.7521 0.4026 0.0222;0.756 0.4094 0.0232;0.7598 0.4162 0.0242;0.7636 0.423 0.0252;0.7667 0.4287 0.0282;0.769 0.4331 0.0333;0.7713 0.4375 0.0384;0.7735 0.4419 0.0435;0.7758 0.4463 0.0485;0.7781 0.4507 0.0536;0.7803 0.4552 0.0587;0.7826 0.4596 0.0638;0.7849 0.464 0.0688;0.7872 0.4684 0.0739;0.7894 0.4728 0.079;0.7917 0.4772 0.084;0.794 0.4817 0.0891;0.7963 0.4861 0.0942;0.7985 0.4905 0.0993;0.8008 0.4949 0.1043;0.8031 0.4993 0.1094;0.8054 0.5037 0.1145;0.8076 0.5082 0.1195;0.8099 0.5126 0.1246;0.8122 0.517 0.1297;0.8145 0.5214 0.1348;0.8167 0.5258 0.1398;0.819 0.5302 0.1449;0.8213 0.5347 0.15;0.8236 0.5391 0.155;0.8262 0.5433 0.1599;0.8292 0.5474 0.1646;0.8322 0.5515 0.1692;0.8352 0.5556 0.1739;0.8382 0.5597 0.1786;0.8412 0.5638 0.1832;0.8442 0.5679 0.1879;0.8472 0.572 0.1926;0.8502 0.5761 0.1972;0.8533 0.5802 0.2019;0.8563 0.5842 0.2066;0.8593 0.5883 0.2112;0.8623 0.5924 0.2159;0.8653 0.5965 0.2206;0.8683 0.6006 0.2252;0.8713 0.6047 0.2299;0.8743 0.6088 0.2346;0.8773 0.6129 0.2392;0.8803 0.617 0.2439;0.8833 0.6211 0.2486;0.8863 0.6252 0.2532;0.8893 0.6292 0.2579;0.8923 0.6333 0.2626;0.8954 0.6374 0.2672;0.8984 0.6415 0.2719;0.9014 0.6456 0.2766;0.9042 0.6496 0.2815;0.9069 0.6535 0.2867;0.9096 0.6574 0.2918;0.9123 0.6613 0.297;0.915 0.6652 0.3022;0.9176 0.6691 0.3074;0.9203 0.673 0.3126;0.923 0.6769 0.3177;0.9257 0.6808 0.3229;0.9284 0.6847 0.3281;0.9311 0.6886 0.3333;0.9338 0.6925 0.3385;0.9365 0.6963 0.3436;0.9391 0.7002 0.3488;0.9418 0.7041 0.354;0.9445 0.708 0.3592;0.9472 0.7119 0.3643;0.9499 0.7158 0.3695;0.9526 0.7197 0.3747;0.9553 0.7236 0.3799;0.9579 0.7275 0.3851;0.9606 0.7314 0.3902;0.9633 0.7353 0.3954;0.966 0.7392 0.4006;0.9687 0.7431 0.4058;0.9714 0.747 0.411;0.9732 0.751 0.4169;0.9741 0.7552 0.4236;0.9751 0.7593 0.4302;0.976 0.7635 0.4369;0.9769 0.7676 0.4436;0.9779 0.7718 0.4503;0.9788 0.7759 0.457;0.9797 0.7801 0.4636;0.9807 0.7842 0.4703;0.9816 0.7884 0.477;0.9825 0.7925 0.4837;0.9835 0.7967 0.4903;0.9844 0.8008 0.497;0.9853 0.805 0.5037;0.9863 0.8091 0.5104;0.9872 0.8133 0.517;0.9881 0.8174 0.5237;0.9891 0.8216 0.5304;0.99 0.8257 0.5371;0.991 0.8299 0.5437;0.9919 0.834 0.5504;0.9928 0.8382 0.5571;0.9938 0.8423 0.5638;0.9947 0.8465 0.5705;0.9956 0.8506 0.5771;0.9966 0.8548 0.5838;0.997 0.8583 0.5916;0.997 0.8612 0.6005;0.997 0.8641 0.6093;0.997 0.867 0.6182;0.997 0.8699 0.6271;0.9969 0.8729 0.636;0.9969 0.8758 0.6448;0.9969 0.8787 0.6537;0.9969 0.8816 0.6626;0.9969 0.8845 0.6715;0.9969 0.8874 0.6804;0.9968 0.8903 0.6892;0.9968 0.8932 0.6981;0.9968 0.8962 0.707;0.9968 0.8991 0.7159;0.9968 0.902 0.7247;0.9968 0.9049 0.7336;0.9967 0.9078 0.7425;0.9967 0.9107 0.7514;0.9967 0.9136 0.7603;0.9967 0.9165 0.7691;0.9967 0.9195 0.778;0.9967 0.9224 0.7869;0.9966 0.9253 0.7958;0.9966 0.9282 0.8046;0.9966 0.9311 0.8135;0.9967 0.9336 0.8221;0.9968 0.9357 0.8304;0.997 0.9378 0.8386;0.9971 0.9399 0.8469;0.9973 0.942 0.8552;0.9975 0.944 0.8635;0.9976 0.9461 0.8717;0.9978 0.9482 0.88;0.9979 0.9503 0.8883;0.9981 0.9524 0.8966;0.9982 0.9545 0.9048;0.9984 0.9566 0.9131;0.9985 0.9587 0.9214;0.9987 0.9607 0.9297;0.9988 0.9628 0.9379;0.999 0.9649 0.9462;0.9992 0.967 0.9545;0.9993 0.9691 0.9628;0.9995 0.9712 0.971;0.9996 0.9733 0.9793;0.9998 0.9754 0.9876;0.9999 0.9774 0.9959])

               aa=surf(ones(length(Y_raw_Left_flat_ldru),1)*X_raw_Left_flat_ldru',Y_raw_Left_flat_ldru*ones(1,length(X_raw_Left_flat_ldru)),im_RedLeft_red_flat_ldru*0-1,im_RedLeft_red_flat_ldru);
               %%%contour(X_LEFT_flat_ldru,Y_LEFT_flat_ldru,mark_knot_left_flat_ldru,1,'m')
               [nr,nk]=size(knot_data_min_max_left_flat_ldru);
               for r=1:nr
                   plot(knot_data_min_max_left_flat_ldru(r,[1 2 2 1 1]),knot_data_min_max_left_flat_ldru(r,[3 3 4 4 3]),'-r');
               end
               set(aa,'edgecolor','none','facecolor','interp')
               % Color
               %%%contour(X_raw_Left_flat_ldru,Y_raw_Left_flat_ldru,mark_Left_restricted_flat_ldru,1,'c')
               [nf,tusen]=size(Left_Y_conv_hull_flat_ldru);
               for f=1:nf 
                   if Left_A_conv_hull_flat_ldru(f)>0
                       [a,b]=find((Left_Y_conv_hull_flat_ldru(f,:)+abs(Left_Y_conv_hull_flat_ldru(f,:)))/2);
                       la=length(a);
                       plot(Left_X_conv_hull_flat_ldru(f,1:la),Left_Y_conv_hull_flat_ldru(f,1:la),'g')
                   end
                   if Left_A_conv_hull_Fi2_dark_flat_ldru(f)>0
                        [a,b]=find((Left_Y_conv_hull_Fi2_dark_flat_ldru(f,:)+abs(Left_Y_conv_hull_Fi2_dark_flat_ldru(f,:)))/2);
                        la=length(a);
                        plot(Left_X_conv_hull_Fi2_dark_flat_ldru(f,1:la),Left_Y_conv_hull_Fi2_dark_flat_ldru(f,1:la),'b')
                   end
               end

               aa=surf(ones(length(Y_raw_Down_flat_ldru),1)*X_raw_Down_flat_ldru'+B*1000+20,Y_raw_Down_flat_ldru*ones(1,length(X_raw_Down_flat_ldru)),im_RedDown_red_flat_ldru*0-1,im_RedDown_red_flat_ldru);
               %%%contour(X_DOWN_flat_ldru+B*1000+20,Y_DOWN_flat_ldru,mark_knot_down_flat_ldru,1,'m')
               [nr,nk]=size(knot_data_min_max_down_flat_ldru);
               for r=1:nr
                   plot(knot_data_min_max_down_flat_ldru(r,[1 2 2 1 1])+B*1000+20,knot_data_min_max_down_flat_ldru(r,[3 3 4 4 3]),'-r');
               end
               set(aa,'edgecolor','none','facecolor','interp')
               % Color
               %%%contour(X_raw_Down_flat_ldru+B*1000+20,Y_raw_Down_flat_ldru,mark_Down_restricted_flat_ldru,1,'c')
               [nf,tusen]=size(Down_Y_conv_hull_flat_ldru);
               for f=1:nf 
                   if Down_A_conv_hull_flat_ldru(f)>0
                       [a,b]=find((Down_Y_conv_hull_flat_ldru(f,:)+abs(Down_Y_conv_hull_flat_ldru(f,:)))/2);
                       la=length(a);
                       plot(Down_X_conv_hull_flat_ldru(f,1:la)+B*1000+20,Down_Y_conv_hull_flat_ldru(f,1:la),'g')
                   end
                   if Down_A_conv_hull_Fi2_dark_flat_ldru(f)>0
                       [a,b]=find((Down_Y_conv_hull_Fi2_dark_flat_ldru(f,:)+abs(Down_Y_conv_hull_Fi2_dark_flat_ldru(f,:)))/2);
                       la=length(a);
                       plot(Down_X_conv_hull_Fi2_dark_flat_ldru(f,1:la)+B*1000+20,Down_Y_conv_hull_Fi2_dark_flat_ldru(f,1:la),'b')
                   end
              end

               aa=surf(ones(length(Y_raw_Right_flat_ldru),1)*X_raw_Right_flat_ldru'+(H+B)*1000+40,Y_raw_Right_flat_ldru*ones(1,length(X_raw_Right_flat_ldru)),im_RedRight_red_flat_ldru*0-1,im_RedRight_red_flat_ldru);
               %%%contour(X_RIGHT_flat_ldru+(H+B)*1000+40,Y_RIGHT_flat_ldru,mark_knot_right_flat_ldru,1,'m')
               [nr,nk]=size(knot_data_min_max_right_flat_ldru);
               for r=1:nr
                   plot(knot_data_min_max_right_flat_ldru(r,[1 2 2 1 1])+(H+B)*1000+40,knot_data_min_max_right_flat_ldru(r,[3 3 4 4 3]),'-r');
               end
               set(aa,'edgecolor','none','facecolor','interp')
               % Color
               %%%contour(X_raw_Right_flat_ldru+(H+B)*1000+40,Y_raw_Right_flat_ldru,mark_Right_restricted_flat_ldru,1,'c')
               [nf,tusen]=size(Right_Y_conv_hull_flat_ldru);
               for f=1:nf 
                   if Right_A_conv_hull_flat_ldru(f)>0
                       [a,b]=find((Right_Y_conv_hull_flat_ldru(f,:)+abs(Right_Y_conv_hull_flat_ldru(f,:)))/2);
                       la=length(a);
                       plot(Right_X_conv_hull_flat_ldru(f,1:la)+(H+B)*1000+40,Right_Y_conv_hull_flat_ldru(f,1:la),'g')
                   end
                   if Right_A_conv_hull_Fi2_dark_flat_ldru(f)>0
                       [a,b]=find((Right_Y_conv_hull_Fi2_dark_flat_ldru(f,:)+abs(Right_Y_conv_hull_Fi2_dark_flat_ldru(f,:)))/2);
                       la=length(a);
                       plot(Right_X_conv_hull_Fi2_dark_flat_ldru(f,1:la)+(H+B)*1000+40,Right_Y_conv_hull_Fi2_dark_flat_ldru(f,1:la),'b')
                   end
               end

               aa=surf(ones(length(Y_raw_Up_flat_ldru),1)*X_raw_Up_flat_ldru'+(H+2*B)*1000+60,Y_raw_Up_flat_ldru*ones(1,length(X_raw_Up_flat_ldru)),im_RedUp_red_flat_ldru*0-1,im_RedUp_red_flat_ldru);
               %%%contour(X_UP_flat_ldru+(H+2*B)*1000+60,Y_UP_flat_ldru,mark_knot_up_flat_ldru,1,'m')
               [nr,nk]=size(knot_data_min_max_up_flat_ldru);
               for r=1:nr
                   plot(knot_data_min_max_up_flat_ldru(r,[1 2 2 1 1])+(H+2*B)*1000+60,knot_data_min_max_up_flat_ldru(r,[3 3 4 4 3]),'-r');
               end
               set(aa,'edgecolor','none','facecolor','interp')
               % Color
               %%%contour(X_raw_Up_flat_ldru+(H+2*B)*1000+60,Y_raw_Up_flat_ldru,mark_Up_restricted_flat_ldru,1,'c')
               [nf,tusen]=size(Up_Y_conv_hull_flat_ldru);
               for f=1:nf 
                   if Up_A_conv_hull_flat_ldru(f)>0
                       [a,b]=find((Up_Y_conv_hull_flat_ldru(f,:)+abs(Up_Y_conv_hull_flat_ldru(f,:)))/2);
                       la=length(a);
                       plot(Up_X_conv_hull_flat_ldru(f,1:la)+(H+2*B)*1000+60,Up_Y_conv_hull_flat_ldru(f,1:la),'g')
                   end
                   if Up_A_conv_hull_Fi2_dark_flat_ldru(f)>0
                       [a,b]=find((Up_Y_conv_hull_Fi2_dark_flat_ldru(f,:)+abs(Up_Y_conv_hull_Fi2_dark_flat_ldru(f,:)))/2);
                       la=length(a);
                       plot(Up_X_conv_hull_Fi2_dark_flat_ldru(f,1:la)+(H+2*B)*1000+60,Up_Y_conv_hull_Fi2_dark_flat_ldru(f,1:la),'b')
                   end
               end
               axis equal
           end
           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
           if show_fig_number(6)==1
               figure(6) %7    Photo with indicated red fields for fibre disturbance and green or blue for knots ... AND Fi2 AND criteria for prhibited cut areas AND IP-indicator
               clf
               hold on
               %colormap('gray')
               colormap([0.006 0.0056 0.0001;0.018 0.0054 0.0001;0.03 0.0051 0.0001;0.0419 0.0049 0.0001;0.0539 0.0047 0.0001;0.0659 0.0045 0.0001;0.0779 0.0043 0.0001;0.0899 0.004 0.0001;0.1018 0.0038 0.0001;0.1138 0.0036 0.0001;0.1258 0.0034 0.0001;0.1378 0.0032 0.0001;0.1498 0.003 0.0001;0.1618 0.0027 0.0001;0.1737 0.0025 0.0001;0.1857 0.0023 0.0001;0.1977 0.0021 0.0001;0.2097 0.0019 0;0.2217 0.0016 0;0.2336 0.0014 0;0.2456 0.0012 0;0.2576 0.001 0;0.2696 0.0008 0;0.2816 0.0005 0;0.2936 0.0003 0;0.3055 0.0001 0;0.3155 0.0017 0;0.3235 0.005 0.0001;0.3315 0.0083 0.0001;0.3394 0.0116 0.0001;0.3474 0.0149 0.0002;0.3554 0.0182 0.0002;0.3633 0.0215 0.0003;0.3713 0.0248 0.0003;0.3793 0.0281 0.0004;0.3873 0.0314 0.0004;0.3952 0.0347 0.0004;0.4032 0.038 0.0005;0.4112 0.0414 0.0005;0.4191 0.0447 0.0006;0.4271 0.048 0.0006;0.4351 0.0513 0.0007;0.4431 0.0546 0.0007;0.451 0.0579 0.0007;0.459 0.0612 0.0008;0.467 0.0645 0.0008;0.4749 0.0678 0.0009;0.4829 0.0711 0.0009;0.4909 0.0744 0.001;0.4988 0.0778 0.001;0.5068 0.0811 0.001;0.5148 0.0844 0.0011;0.5216 0.0892 0.0011;0.5272 0.0955 0.001;0.5329 0.1018 0.001;0.5385 0.1081 0.001;0.5442 0.1143 0.0009;0.5498 0.1206 0.0009;0.5555 0.1269 0.0008;0.5611 0.1332 0.0008;0.5668 0.1395 0.0007;0.5724 0.1458 0.0007;0.5781 0.1521 0.0007;0.5837 0.1584 0.0006;0.5894 0.1647 0.0006;0.595 0.171 0.0005;0.6007 0.1773 0.0005;0.6063 0.1836 0.0004;0.612 0.1899 0.0004;0.6176 0.1962 0.0004;0.6232 0.2024 0.0003;0.6289 0.2087 0.0003;0.6345 0.215 0.0002;0.6402 0.2213 0.0002;0.6458 0.2276 0.0001;0.6515 0.2339 0.0001;0.6571 0.2402 0.0001;0.6628 0.2465 0;0.6675 0.253 0.0005;0.6714 0.2598 0.0015;0.6752 0.2666 0.0025;0.6791 0.2734 0.0035;0.6829 0.2802 0.0044;0.6867 0.287 0.0054;0.6906 0.2938 0.0064;0.6944 0.3006 0.0074;0.6983 0.3074 0.0084;0.7021 0.3142 0.0094;0.706 0.321 0.0104;0.7098 0.3278 0.0114;0.7137 0.3346 0.0124;0.7175 0.3414 0.0133;0.7214 0.3482 0.0143;0.7252 0.355 0.0153;0.729 0.3618 0.0163;0.7329 0.3686 0.0173;0.7367 0.3754 0.0183;0.7406 0.3822 0.0193;0.7444 0.389 0.0203;0.7483 0.3958 0.0213;0.7521 0.4026 0.0222;0.756 0.4094 0.0232;0.7598 0.4162 0.0242;0.7636 0.423 0.0252;0.7667 0.4287 0.0282;0.769 0.4331 0.0333;0.7713 0.4375 0.0384;0.7735 0.4419 0.0435;0.7758 0.4463 0.0485;0.7781 0.4507 0.0536;0.7803 0.4552 0.0587;0.7826 0.4596 0.0638;0.7849 0.464 0.0688;0.7872 0.4684 0.0739;0.7894 0.4728 0.079;0.7917 0.4772 0.084;0.794 0.4817 0.0891;0.7963 0.4861 0.0942;0.7985 0.4905 0.0993;0.8008 0.4949 0.1043;0.8031 0.4993 0.1094;0.8054 0.5037 0.1145;0.8076 0.5082 0.1195;0.8099 0.5126 0.1246;0.8122 0.517 0.1297;0.8145 0.5214 0.1348;0.8167 0.5258 0.1398;0.819 0.5302 0.1449;0.8213 0.5347 0.15;0.8236 0.5391 0.155;0.8262 0.5433 0.1599;0.8292 0.5474 0.1646;0.8322 0.5515 0.1692;0.8352 0.5556 0.1739;0.8382 0.5597 0.1786;0.8412 0.5638 0.1832;0.8442 0.5679 0.1879;0.8472 0.572 0.1926;0.8502 0.5761 0.1972;0.8533 0.5802 0.2019;0.8563 0.5842 0.2066;0.8593 0.5883 0.2112;0.8623 0.5924 0.2159;0.8653 0.5965 0.2206;0.8683 0.6006 0.2252;0.8713 0.6047 0.2299;0.8743 0.6088 0.2346;0.8773 0.6129 0.2392;0.8803 0.617 0.2439;0.8833 0.6211 0.2486;0.8863 0.6252 0.2532;0.8893 0.6292 0.2579;0.8923 0.6333 0.2626;0.8954 0.6374 0.2672;0.8984 0.6415 0.2719;0.9014 0.6456 0.2766;0.9042 0.6496 0.2815;0.9069 0.6535 0.2867;0.9096 0.6574 0.2918;0.9123 0.6613 0.297;0.915 0.6652 0.3022;0.9176 0.6691 0.3074;0.9203 0.673 0.3126;0.923 0.6769 0.3177;0.9257 0.6808 0.3229;0.9284 0.6847 0.3281;0.9311 0.6886 0.3333;0.9338 0.6925 0.3385;0.9365 0.6963 0.3436;0.9391 0.7002 0.3488;0.9418 0.7041 0.354;0.9445 0.708 0.3592;0.9472 0.7119 0.3643;0.9499 0.7158 0.3695;0.9526 0.7197 0.3747;0.9553 0.7236 0.3799;0.9579 0.7275 0.3851;0.9606 0.7314 0.3902;0.9633 0.7353 0.3954;0.966 0.7392 0.4006;0.9687 0.7431 0.4058;0.9714 0.747 0.411;0.9732 0.751 0.4169;0.9741 0.7552 0.4236;0.9751 0.7593 0.4302;0.976 0.7635 0.4369;0.9769 0.7676 0.4436;0.9779 0.7718 0.4503;0.9788 0.7759 0.457;0.9797 0.7801 0.4636;0.9807 0.7842 0.4703;0.9816 0.7884 0.477;0.9825 0.7925 0.4837;0.9835 0.7967 0.4903;0.9844 0.8008 0.497;0.9853 0.805 0.5037;0.9863 0.8091 0.5104;0.9872 0.8133 0.517;0.9881 0.8174 0.5237;0.9891 0.8216 0.5304;0.99 0.8257 0.5371;0.991 0.8299 0.5437;0.9919 0.834 0.5504;0.9928 0.8382 0.5571;0.9938 0.8423 0.5638;0.9947 0.8465 0.5705;0.9956 0.8506 0.5771;0.9966 0.8548 0.5838;0.997 0.8583 0.5916;0.997 0.8612 0.6005;0.997 0.8641 0.6093;0.997 0.867 0.6182;0.997 0.8699 0.6271;0.9969 0.8729 0.636;0.9969 0.8758 0.6448;0.9969 0.8787 0.6537;0.9969 0.8816 0.6626;0.9969 0.8845 0.6715;0.9969 0.8874 0.6804;0.9968 0.8903 0.6892;0.9968 0.8932 0.6981;0.9968 0.8962 0.707;0.9968 0.8991 0.7159;0.9968 0.902 0.7247;0.9968 0.9049 0.7336;0.9967 0.9078 0.7425;0.9967 0.9107 0.7514;0.9967 0.9136 0.7603;0.9967 0.9165 0.7691;0.9967 0.9195 0.778;0.9967 0.9224 0.7869;0.9966 0.9253 0.7958;0.9966 0.9282 0.8046;0.9966 0.9311 0.8135;0.9967 0.9336 0.8221;0.9968 0.9357 0.8304;0.997 0.9378 0.8386;0.9971 0.9399 0.8469;0.9973 0.942 0.8552;0.9975 0.944 0.8635;0.9976 0.9461 0.8717;0.9978 0.9482 0.88;0.9979 0.9503 0.8883;0.9981 0.9524 0.8966;0.9982 0.9545 0.9048;0.9984 0.9566 0.9131;0.9985 0.9587 0.9214;0.9987 0.9607 0.9297;0.9988 0.9628 0.9379;0.999 0.9649 0.9462;0.9992 0.967 0.9545;0.9993 0.9691 0.9628;0.9995 0.9712 0.971;0.9996 0.9733 0.9793;0.9998 0.9754 0.9876;0.9999 0.9774 0.9959])

               aa=surf(ones(length(Y_raw_Left_flat_ldru),1)*X_raw_Left_flat_ldru',Y_raw_Left_flat_ldru*ones(1,length(X_raw_Left_flat_ldru)),im_RedLeft_red_flat_ldru*0-1,im_RedLeft_red_flat_ldru);
               %quiver(X_LEFT_flat_ldru,Y_LEFT_flat_ldru,sin(Fi_left_flat_ldru),cos(Fi_left_flat_ldru),1,'k.');
               %%%contour(X_LEFT_flat_ldru,Y_LEFT_flat_ldru,mark_knot_left_flat_ldru,1,'m')
               
% ----- Utkommenterat av Andreas (släcker kvist dekt.)---------------------
%                [nr,nk]=size(knot_data_min_max_left_flat_ldru);
%                for r=1:nr
%                    plot(knot_data_min_max_left_flat_ldru(r,[1 2 2 1 1]),knot_data_min_max_left_flat_ldru(r,[3 3 4 4 3]),'-r');
%                end
% -------------------------------------------------------------------------
               set(aa,'edgecolor','none','facecolor','interp')
               % Color
               %%%contour(X_raw_Left_flat_ldru,Y_raw_Left_flat_ldru,mark_Left_restricted_flat_ldru,1,'c')

% ----- Utkommenterat av Andreas (släcker kvist dekt.)---------------------
%                [nf,tusen]=size(Left_Y_conv_hull_flat_ldru);
%                for f=1:nf 
%                    if Left_A_conv_hull_flat_ldru(f)>0
%                        [a,b]=find((Left_Y_conv_hull_flat_ldru(f,:)+abs(Left_Y_conv_hull_flat_ldru(f,:)))/2);
%                        la=length(a);
%                        plot(Left_X_conv_hull_flat_ldru(f,1:la),Left_Y_conv_hull_flat_ldru(f,1:la),'g')
%                    end
%                    if Left_A_conv_hull_Fi2_dark_flat_ldru(f)>0
%                         [a,b]=find((Left_Y_conv_hull_Fi2_dark_flat_ldru(f,:)+abs(Left_Y_conv_hull_Fi2_dark_flat_ldru(f,:)))/2);
%                         la=length(a);
%                         plot(Left_X_conv_hull_Fi2_dark_flat_ldru(f,1:la),Left_Y_conv_hull_Fi2_dark_flat_ldru(f,1:la),'b')
%                    end
%                end
% -------------------------------------------------------------------------
               aa=surf(ones(length(Y_raw_Down_flat_ldru),1)*X_raw_Down_flat_ldru'+B*1000+20,Y_raw_Down_flat_ldru*ones(1,length(X_raw_Down_flat_ldru)),im_RedDown_red_flat_ldru*0-1,im_RedDown_red_flat_ldru);
               %quiver(X_DOWN_flat_ldru+B*1000+20,Y_DOWN_flat_ldru,sin(Fi_down_flat_ldru),cos(Fi_down_flat_ldru),1,'k.');
               %%%contour(X_DOWN_flat_ldru+B*1000+20,Y_DOWN_flat_ldru,mark_knot_down_flat_ldru,1,'m')
               
% ----- Utkommenterat av Andreas (släcker kvist dekt.)---------------------
%                for r=1:nr
%                    plot(knot_data_min_max_down_flat_ldru(r,[1 2 2 1 1])+B*1000+20,knot_data_min_max_down_flat_ldru(r,[3 3 4 4 3]),'-r');
%                end
% -------------------------------------------------------------------------
               set(aa,'edgecolor','none','facecolor','interp')
               % Color
               %%%contour(X_raw_Down_flat_ldru+B*1000+20,Y_raw_Down_flat_ldru,mark_Down_restricted_flat_ldru,1,'c')
               
 % ----- Utkommenterat av Andreas (släcker kvist dekt.)---------------------
%                [nf,tusen]=size(Down_Y_conv_hull_flat_ldru);
%                for f=1:nf 
%                    if Down_A_conv_hull_flat_ldru(f)>0
%                        [a,b]=find((Down_Y_conv_hull_flat_ldru(f,:)+abs(Down_Y_conv_hull_flat_ldru(f,:)))/2);
%                        la=length(a);
%                        plot(Down_X_conv_hull_flat_ldru(f,1:la)+B*1000+20,Down_Y_conv_hull_flat_ldru(f,1:la),'g')
%                    end
%                    if Down_A_conv_hull_Fi2_dark_flat_ldru(f)>0
%                        [a,b]=find((Down_Y_conv_hull_Fi2_dark_flat_ldru(f,:)+abs(Down_Y_conv_hull_Fi2_dark_flat_ldru(f,:)))/2);
%                        la=length(a);
%                        plot(Down_X_conv_hull_Fi2_dark_flat_ldru(f,1:la)+B*1000+20,Down_Y_conv_hull_Fi2_dark_flat_ldru(f,1:la),'b')
%                    end
%               end
% -------------------------------------------------------------------------
               aa=surf(ones(length(Y_raw_Right_flat_ldru),1)*X_raw_Right_flat_ldru'+(H+B)*1000+40,Y_raw_Right_flat_ldru*ones(1,length(X_raw_Right_flat_ldru)),im_RedRight_red_flat_ldru*0-1,im_RedRight_red_flat_ldru);
               %quiver(X_RIGHT_flat_ldru+(H+B)*1000+40,Y_RIGHT_flat_ldru,-sin(Fi_right_flat_ldru),cos(Fi_right_flat_ldru),1,'k.');
               %%%contour(X_RIGHT_flat_ldru+(H+B)*1000+40,Y_RIGHT_flat_ldru,mark_knot_right_flat_ldru,1,'m')

% ----- Utkommenterat av Andreas (släcker kvist dekt.)---------------------               
%                for r=1:nr
%                    plot(knot_data_min_max_right_flat_ldru(r,[1 2 2 1 1])+(H+B)*1000+40,knot_data_min_max_right_flat_ldru(r,[3 3 4 4 3]),'-r');
%                end
% -------------------------------------------------------------------------

               set(aa,'edgecolor','none','facecolor','interp')
               % Color
               %%%contour(X_raw_Right_flat_ldru+(H+B)*1000+40,Y_raw_Right_flat_ldru,mark_Right_restricted_flat_ldru,1,'c')
               
% ----- Utkommenterat av Andreas (släcker kvist dekt.)---------------------              
%                [nf,tusen]=size(Right_Y_conv_hull_flat_ldru);
%                for f=1:nf 
%                    if Right_A_conv_hull_flat_ldru(f)>0
%                        [a,b]=find((Right_Y_conv_hull_flat_ldru(f,:)+abs(Right_Y_conv_hull_flat_ldru(f,:)))/2);
%                        la=length(a);
%                        plot(Right_X_conv_hull_flat_ldru(f,1:la)+(H+B)*1000+40,Right_Y_conv_hull_flat_ldru(f,1:la),'g')
%                    end
%                    if Right_A_conv_hull_Fi2_dark_flat_ldru(f)>0
%                        [a,b]=find((Right_Y_conv_hull_Fi2_dark_flat_ldru(f,:)+abs(Right_Y_conv_hull_Fi2_dark_flat_ldru(f,:)))/2);
%                        la=length(a);
%                        plot(Right_X_conv_hull_Fi2_dark_flat_ldru(f,1:la)+(H+B)*1000+40,Right_Y_conv_hull_Fi2_dark_flat_ldru(f,1:la),'b')
%                    end
%                end
% -------------------------------------------------------------------------

               aa=surf(ones(length(Y_raw_Up_flat_ldru),1)*X_raw_Up_flat_ldru'+(H+2*B)*1000+60,Y_raw_Up_flat_ldru*ones(1,length(X_raw_Up_flat_ldru)),im_RedUp_red_flat_ldru*0-1,im_RedUp_red_flat_ldru);
               %quiver(X_UP_flat_ldru+(H+2*B)*1000+60,Y_UP_flat_ldru,-sin(Fi_up_flat_ldru),cos(Fi_up_flat_ldru),1,'k.');
               %%%contour(X_UP_flat_ldru+(H+2*B)*1000+60,Y_UP_flat_ldru,mark_knot_up_flat_ldru,1,'m')
            
% ----- Utkommenterat av Andreas (släcker kvist dekt.)--------------------- 
%                for r=1:nr
%                    plot(knot_data_min_max_up_flat_ldru(r,[1 2 2 1 1])+(H+2*B)*1000+60,knot_data_min_max_up_flat_ldru(r,[3 3 4 4 3]),'-r');
%                end

% -------------------------------------------------------------------------
               set(aa,'edgecolor','none','facecolor','interp')
               % Color
               %%%contour(X_raw_Up_flat_ldru+(H+2*B)*1000+60,Y_raw_Up_flat_ldru,mark_Up_restricted_flat_ldru,1,'c')
               
% ----- Utkommenterat av Andreas (släcker kvist dekt.)---------------------                
%                [nf,tusen]=size(Up_Y_conv_hull_flat_ldru);
%                for f=1:nf 
%                    if Up_A_conv_hull_flat_ldru(f)>0
%                        [a,b]=find((Up_Y_conv_hull_flat_ldru(f,:)+abs(Up_Y_conv_hull_flat_ldru(f,:)))/2);
%                        la=length(a);
%                        plot(Up_X_conv_hull_flat_ldru(f,1:la)+(H+2*B)*1000+60,Up_Y_conv_hull_flat_ldru(f,1:la),'g')
%                    end
%                    if Up_A_conv_hull_Fi2_dark_flat_ldru(f)>0
%                        [a,b]=find((Up_Y_conv_hull_Fi2_dark_flat_ldru(f,:)+abs(Up_Y_conv_hull_Fi2_dark_flat_ldru(f,:)))/2);
%                        la=length(a);
%                        plot(Up_X_conv_hull_Fi2_dark_flat_ldru(f,1:la)+(H+2*B)*1000+60,Up_Y_conv_hull_Fi2_dark_flat_ldru(f,1:la),'b')
%                    end
%                end
% -------------------------------------------------------------------------

%                lp_1=length(prohib_pos_knot_1);
%                lp_2=length(prohib_pos_knot_2);
%                plot(ones(lp_1,1)*(-5),prohib_pos_knot_1,'r*')
%                plot(ones(lp_2,1)*(-10),prohib_pos_knot_2,'c*')
%                [n,c]=size(accept_fibre_along);
%                for k=1:n
%                    if accept_fibre_along(k)==0
%                        plot([1 1]*(-20),segment_pos_along(k,:),'g-')
%                    elseif accept_fibre_along(k)==1
%                        plot([1 1]*(-20),segment_pos_along(k,:),'k-')
%                        plot([-20 +(2*H+2*B)*1000+60],segment_pos_along(k,1)*[1 1],'k-')
%                        plot([-20 +(2*H+2*B)*1000+60],segment_pos_along(k,2)*[1 1],'k-')
%                    elseif accept_fibre_along(k)==2
%                        plot([1 1]*(-20),segment_pos_along(k,:),'b-')
%                        plot([-20 +(2*H+2*B)*1000+60],segment_pos_along(k,1)*[1 1],'b-')
%                        plot([-20 +(2*H+2*B)*1000+60],segment_pos_along(k,2)*[1 1],'b-')
%                    elseif accept_fibre_along(k)==3
%                        plot([1 1]*(-20),segment_pos_along(k,:),'r-')
%                        plot([-20 +(2*H+2*B)*1000+60],segment_pos_along(k,1)*[1 1],'r-')
%                        plot([-20 +(2*H+2*B)*1000+60],segment_pos_along(k,2)*[1 1],'r-')
%                    end
%                end
%                if IP_available==1
%                    plot((-40)*ones(length(pos_above_IP_limit(:,1)),1),pos_above_IP_limit(:,1)*1000,'gs')
%                    plot((-40)*ones(length(pos_below_IP_limit(:,1)),1),pos_below_IP_limit(:,1)*1000,'rs')
%                end
               %mark_too_close_knot_all
               axis equal
           end
           
           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
           if show_fig_number(7)==1
               figure(7) %8 Photo vertical
               clf
               hold on
               colormap([0.006 0.0056 0.0001;0.018 0.0054 0.0001;0.03 0.0051 0.0001;0.0419 0.0049 0.0001;0.0539 0.0047 0.0001;0.0659 0.0045 0.0001;0.0779 0.0043 0.0001;0.0899 0.004 0.0001;0.1018 0.0038 0.0001;0.1138 0.0036 0.0001;0.1258 0.0034 0.0001;0.1378 0.0032 0.0001;0.1498 0.003 0.0001;0.1618 0.0027 0.0001;0.1737 0.0025 0.0001;0.1857 0.0023 0.0001;0.1977 0.0021 0.0001;0.2097 0.0019 0;0.2217 0.0016 0;0.2336 0.0014 0;0.2456 0.0012 0;0.2576 0.001 0;0.2696 0.0008 0;0.2816 0.0005 0;0.2936 0.0003 0;0.3055 0.0001 0;0.3155 0.0017 0;0.3235 0.005 0.0001;0.3315 0.0083 0.0001;0.3394 0.0116 0.0001;0.3474 0.0149 0.0002;0.3554 0.0182 0.0002;0.3633 0.0215 0.0003;0.3713 0.0248 0.0003;0.3793 0.0281 0.0004;0.3873 0.0314 0.0004;0.3952 0.0347 0.0004;0.4032 0.038 0.0005;0.4112 0.0414 0.0005;0.4191 0.0447 0.0006;0.4271 0.048 0.0006;0.4351 0.0513 0.0007;0.4431 0.0546 0.0007;0.451 0.0579 0.0007;0.459 0.0612 0.0008;0.467 0.0645 0.0008;0.4749 0.0678 0.0009;0.4829 0.0711 0.0009;0.4909 0.0744 0.001;0.4988 0.0778 0.001;0.5068 0.0811 0.001;0.5148 0.0844 0.0011;0.5216 0.0892 0.0011;0.5272 0.0955 0.001;0.5329 0.1018 0.001;0.5385 0.1081 0.001;0.5442 0.1143 0.0009;0.5498 0.1206 0.0009;0.5555 0.1269 0.0008;0.5611 0.1332 0.0008;0.5668 0.1395 0.0007;0.5724 0.1458 0.0007;0.5781 0.1521 0.0007;0.5837 0.1584 0.0006;0.5894 0.1647 0.0006;0.595 0.171 0.0005;0.6007 0.1773 0.0005;0.6063 0.1836 0.0004;0.612 0.1899 0.0004;0.6176 0.1962 0.0004;0.6232 0.2024 0.0003;0.6289 0.2087 0.0003;0.6345 0.215 0.0002;0.6402 0.2213 0.0002;0.6458 0.2276 0.0001;0.6515 0.2339 0.0001;0.6571 0.2402 0.0001;0.6628 0.2465 0;0.6675 0.253 0.0005;0.6714 0.2598 0.0015;0.6752 0.2666 0.0025;0.6791 0.2734 0.0035;0.6829 0.2802 0.0044;0.6867 0.287 0.0054;0.6906 0.2938 0.0064;0.6944 0.3006 0.0074;0.6983 0.3074 0.0084;0.7021 0.3142 0.0094;0.706 0.321 0.0104;0.7098 0.3278 0.0114;0.7137 0.3346 0.0124;0.7175 0.3414 0.0133;0.7214 0.3482 0.0143;0.7252 0.355 0.0153;0.729 0.3618 0.0163;0.7329 0.3686 0.0173;0.7367 0.3754 0.0183;0.7406 0.3822 0.0193;0.7444 0.389 0.0203;0.7483 0.3958 0.0213;0.7521 0.4026 0.0222;0.756 0.4094 0.0232;0.7598 0.4162 0.0242;0.7636 0.423 0.0252;0.7667 0.4287 0.0282;0.769 0.4331 0.0333;0.7713 0.4375 0.0384;0.7735 0.4419 0.0435;0.7758 0.4463 0.0485;0.7781 0.4507 0.0536;0.7803 0.4552 0.0587;0.7826 0.4596 0.0638;0.7849 0.464 0.0688;0.7872 0.4684 0.0739;0.7894 0.4728 0.079;0.7917 0.4772 0.084;0.794 0.4817 0.0891;0.7963 0.4861 0.0942;0.7985 0.4905 0.0993;0.8008 0.4949 0.1043;0.8031 0.4993 0.1094;0.8054 0.5037 0.1145;0.8076 0.5082 0.1195;0.8099 0.5126 0.1246;0.8122 0.517 0.1297;0.8145 0.5214 0.1348;0.8167 0.5258 0.1398;0.819 0.5302 0.1449;0.8213 0.5347 0.15;0.8236 0.5391 0.155;0.8262 0.5433 0.1599;0.8292 0.5474 0.1646;0.8322 0.5515 0.1692;0.8352 0.5556 0.1739;0.8382 0.5597 0.1786;0.8412 0.5638 0.1832;0.8442 0.5679 0.1879;0.8472 0.572 0.1926;0.8502 0.5761 0.1972;0.8533 0.5802 0.2019;0.8563 0.5842 0.2066;0.8593 0.5883 0.2112;0.8623 0.5924 0.2159;0.8653 0.5965 0.2206;0.8683 0.6006 0.2252;0.8713 0.6047 0.2299;0.8743 0.6088 0.2346;0.8773 0.6129 0.2392;0.8803 0.617 0.2439;0.8833 0.6211 0.2486;0.8863 0.6252 0.2532;0.8893 0.6292 0.2579;0.8923 0.6333 0.2626;0.8954 0.6374 0.2672;0.8984 0.6415 0.2719;0.9014 0.6456 0.2766;0.9042 0.6496 0.2815;0.9069 0.6535 0.2867;0.9096 0.6574 0.2918;0.9123 0.6613 0.297;0.915 0.6652 0.3022;0.9176 0.6691 0.3074;0.9203 0.673 0.3126;0.923 0.6769 0.3177;0.9257 0.6808 0.3229;0.9284 0.6847 0.3281;0.9311 0.6886 0.3333;0.9338 0.6925 0.3385;0.9365 0.6963 0.3436;0.9391 0.7002 0.3488;0.9418 0.7041 0.354;0.9445 0.708 0.3592;0.9472 0.7119 0.3643;0.9499 0.7158 0.3695;0.9526 0.7197 0.3747;0.9553 0.7236 0.3799;0.9579 0.7275 0.3851;0.9606 0.7314 0.3902;0.9633 0.7353 0.3954;0.966 0.7392 0.4006;0.9687 0.7431 0.4058;0.9714 0.747 0.411;0.9732 0.751 0.4169;0.9741 0.7552 0.4236;0.9751 0.7593 0.4302;0.976 0.7635 0.4369;0.9769 0.7676 0.4436;0.9779 0.7718 0.4503;0.9788 0.7759 0.457;0.9797 0.7801 0.4636;0.9807 0.7842 0.4703;0.9816 0.7884 0.477;0.9825 0.7925 0.4837;0.9835 0.7967 0.4903;0.9844 0.8008 0.497;0.9853 0.805 0.5037;0.9863 0.8091 0.5104;0.9872 0.8133 0.517;0.9881 0.8174 0.5237;0.9891 0.8216 0.5304;0.99 0.8257 0.5371;0.991 0.8299 0.5437;0.9919 0.834 0.5504;0.9928 0.8382 0.5571;0.9938 0.8423 0.5638;0.9947 0.8465 0.5705;0.9956 0.8506 0.5771;0.9966 0.8548 0.5838;0.997 0.8583 0.5916;0.997 0.8612 0.6005;0.997 0.8641 0.6093;0.997 0.867 0.6182;0.997 0.8699 0.6271;0.9969 0.8729 0.636;0.9969 0.8758 0.6448;0.9969 0.8787 0.6537;0.9969 0.8816 0.6626;0.9969 0.8845 0.6715;0.9969 0.8874 0.6804;0.9968 0.8903 0.6892;0.9968 0.8932 0.6981;0.9968 0.8962 0.707;0.9968 0.8991 0.7159;0.9968 0.902 0.7247;0.9968 0.9049 0.7336;0.9967 0.9078 0.7425;0.9967 0.9107 0.7514;0.9967 0.9136 0.7603;0.9967 0.9165 0.7691;0.9967 0.9195 0.778;0.9967 0.9224 0.7869;0.9966 0.9253 0.7958;0.9966 0.9282 0.8046;0.9966 0.9311 0.8135;0.9967 0.9336 0.8221;0.9968 0.9357 0.8304;0.997 0.9378 0.8386;0.9971 0.9399 0.8469;0.9973 0.942 0.8552;0.9975 0.944 0.8635;0.9976 0.9461 0.8717;0.9978 0.9482 0.88;0.9979 0.9503 0.8883;0.9981 0.9524 0.8966;0.9982 0.9545 0.9048;0.9984 0.9566 0.9131;0.9985 0.9587 0.9214;0.9987 0.9607 0.9297;0.9988 0.9628 0.9379;0.999 0.9649 0.9462;0.9992 0.967 0.9545;0.9993 0.9691 0.9628;0.9995 0.9712 0.971;0.9996 0.9733 0.9793;0.9998 0.9754 0.9876;0.9999 0.9774 0.9959])
               aa=surf(ones(length(Y_raw_Left_flat_ldru),1)*X_raw_Left_flat_ldru',Y_raw_Left_flat_ldru*ones(1,length(X_raw_Left_flat_ldru)),im_RedLeft_red_flat_ldru*0-1,im_RedLeft_red_flat_ldru);
               set(aa,'edgecolor','none','facecolor','interp')
               aa=surf(ones(length(Y_raw_Down_flat_ldru),1)*X_raw_Down_flat_ldru'+B*1000+20,Y_raw_Down_flat_ldru*ones(1,length(X_raw_Down_flat_ldru)),im_RedDown_red_flat_ldru*0-1,im_RedDown_red_flat_ldru);
               set(aa,'edgecolor','none','facecolor','interp')
               aa=surf(ones(length(Y_raw_Right_flat_ldru),1)*X_raw_Right_flat_ldru'+(H+B)*1000+40,Y_raw_Right_flat_ldru*ones(1,length(X_raw_Right_flat_ldru)),im_RedRight_red_flat_ldru*0-1,im_RedRight_red_flat_ldru);
               set(aa,'edgecolor','none','facecolor','interp')
               aa=surf(ones(length(Y_raw_Up_flat_ldru),1)*X_raw_Up_flat_ldru'+(H+2*B)*1000+60,Y_raw_Up_flat_ldru*ones(1,length(X_raw_Up_flat_ldru)),im_RedUp_red_flat_ldru*0-1,im_RedUp_red_flat_ldru);
               set(aa,'edgecolor','none','facecolor','interp')
               axis equal
           end
           if show_fig_number(8)==1
               figure(8) %9 Photo horizontal
               clf
               hold on
               colormap([0.006 0.0056 0.0001;0.018 0.0054 0.0001;0.03 0.0051 0.0001;0.0419 0.0049 0.0001;0.0539 0.0047 0.0001;0.0659 0.0045 0.0001;0.0779 0.0043 0.0001;0.0899 0.004 0.0001;0.1018 0.0038 0.0001;0.1138 0.0036 0.0001;0.1258 0.0034 0.0001;0.1378 0.0032 0.0001;0.1498 0.003 0.0001;0.1618 0.0027 0.0001;0.1737 0.0025 0.0001;0.1857 0.0023 0.0001;0.1977 0.0021 0.0001;0.2097 0.0019 0;0.2217 0.0016 0;0.2336 0.0014 0;0.2456 0.0012 0;0.2576 0.001 0;0.2696 0.0008 0;0.2816 0.0005 0;0.2936 0.0003 0;0.3055 0.0001 0;0.3155 0.0017 0;0.3235 0.005 0.0001;0.3315 0.0083 0.0001;0.3394 0.0116 0.0001;0.3474 0.0149 0.0002;0.3554 0.0182 0.0002;0.3633 0.0215 0.0003;0.3713 0.0248 0.0003;0.3793 0.0281 0.0004;0.3873 0.0314 0.0004;0.3952 0.0347 0.0004;0.4032 0.038 0.0005;0.4112 0.0414 0.0005;0.4191 0.0447 0.0006;0.4271 0.048 0.0006;0.4351 0.0513 0.0007;0.4431 0.0546 0.0007;0.451 0.0579 0.0007;0.459 0.0612 0.0008;0.467 0.0645 0.0008;0.4749 0.0678 0.0009;0.4829 0.0711 0.0009;0.4909 0.0744 0.001;0.4988 0.0778 0.001;0.5068 0.0811 0.001;0.5148 0.0844 0.0011;0.5216 0.0892 0.0011;0.5272 0.0955 0.001;0.5329 0.1018 0.001;0.5385 0.1081 0.001;0.5442 0.1143 0.0009;0.5498 0.1206 0.0009;0.5555 0.1269 0.0008;0.5611 0.1332 0.0008;0.5668 0.1395 0.0007;0.5724 0.1458 0.0007;0.5781 0.1521 0.0007;0.5837 0.1584 0.0006;0.5894 0.1647 0.0006;0.595 0.171 0.0005;0.6007 0.1773 0.0005;0.6063 0.1836 0.0004;0.612 0.1899 0.0004;0.6176 0.1962 0.0004;0.6232 0.2024 0.0003;0.6289 0.2087 0.0003;0.6345 0.215 0.0002;0.6402 0.2213 0.0002;0.6458 0.2276 0.0001;0.6515 0.2339 0.0001;0.6571 0.2402 0.0001;0.6628 0.2465 0;0.6675 0.253 0.0005;0.6714 0.2598 0.0015;0.6752 0.2666 0.0025;0.6791 0.2734 0.0035;0.6829 0.2802 0.0044;0.6867 0.287 0.0054;0.6906 0.2938 0.0064;0.6944 0.3006 0.0074;0.6983 0.3074 0.0084;0.7021 0.3142 0.0094;0.706 0.321 0.0104;0.7098 0.3278 0.0114;0.7137 0.3346 0.0124;0.7175 0.3414 0.0133;0.7214 0.3482 0.0143;0.7252 0.355 0.0153;0.729 0.3618 0.0163;0.7329 0.3686 0.0173;0.7367 0.3754 0.0183;0.7406 0.3822 0.0193;0.7444 0.389 0.0203;0.7483 0.3958 0.0213;0.7521 0.4026 0.0222;0.756 0.4094 0.0232;0.7598 0.4162 0.0242;0.7636 0.423 0.0252;0.7667 0.4287 0.0282;0.769 0.4331 0.0333;0.7713 0.4375 0.0384;0.7735 0.4419 0.0435;0.7758 0.4463 0.0485;0.7781 0.4507 0.0536;0.7803 0.4552 0.0587;0.7826 0.4596 0.0638;0.7849 0.464 0.0688;0.7872 0.4684 0.0739;0.7894 0.4728 0.079;0.7917 0.4772 0.084;0.794 0.4817 0.0891;0.7963 0.4861 0.0942;0.7985 0.4905 0.0993;0.8008 0.4949 0.1043;0.8031 0.4993 0.1094;0.8054 0.5037 0.1145;0.8076 0.5082 0.1195;0.8099 0.5126 0.1246;0.8122 0.517 0.1297;0.8145 0.5214 0.1348;0.8167 0.5258 0.1398;0.819 0.5302 0.1449;0.8213 0.5347 0.15;0.8236 0.5391 0.155;0.8262 0.5433 0.1599;0.8292 0.5474 0.1646;0.8322 0.5515 0.1692;0.8352 0.5556 0.1739;0.8382 0.5597 0.1786;0.8412 0.5638 0.1832;0.8442 0.5679 0.1879;0.8472 0.572 0.1926;0.8502 0.5761 0.1972;0.8533 0.5802 0.2019;0.8563 0.5842 0.2066;0.8593 0.5883 0.2112;0.8623 0.5924 0.2159;0.8653 0.5965 0.2206;0.8683 0.6006 0.2252;0.8713 0.6047 0.2299;0.8743 0.6088 0.2346;0.8773 0.6129 0.2392;0.8803 0.617 0.2439;0.8833 0.6211 0.2486;0.8863 0.6252 0.2532;0.8893 0.6292 0.2579;0.8923 0.6333 0.2626;0.8954 0.6374 0.2672;0.8984 0.6415 0.2719;0.9014 0.6456 0.2766;0.9042 0.6496 0.2815;0.9069 0.6535 0.2867;0.9096 0.6574 0.2918;0.9123 0.6613 0.297;0.915 0.6652 0.3022;0.9176 0.6691 0.3074;0.9203 0.673 0.3126;0.923 0.6769 0.3177;0.9257 0.6808 0.3229;0.9284 0.6847 0.3281;0.9311 0.6886 0.3333;0.9338 0.6925 0.3385;0.9365 0.6963 0.3436;0.9391 0.7002 0.3488;0.9418 0.7041 0.354;0.9445 0.708 0.3592;0.9472 0.7119 0.3643;0.9499 0.7158 0.3695;0.9526 0.7197 0.3747;0.9553 0.7236 0.3799;0.9579 0.7275 0.3851;0.9606 0.7314 0.3902;0.9633 0.7353 0.3954;0.966 0.7392 0.4006;0.9687 0.7431 0.4058;0.9714 0.747 0.411;0.9732 0.751 0.4169;0.9741 0.7552 0.4236;0.9751 0.7593 0.4302;0.976 0.7635 0.4369;0.9769 0.7676 0.4436;0.9779 0.7718 0.4503;0.9788 0.7759 0.457;0.9797 0.7801 0.4636;0.9807 0.7842 0.4703;0.9816 0.7884 0.477;0.9825 0.7925 0.4837;0.9835 0.7967 0.4903;0.9844 0.8008 0.497;0.9853 0.805 0.5037;0.9863 0.8091 0.5104;0.9872 0.8133 0.517;0.9881 0.8174 0.5237;0.9891 0.8216 0.5304;0.99 0.8257 0.5371;0.991 0.8299 0.5437;0.9919 0.834 0.5504;0.9928 0.8382 0.5571;0.9938 0.8423 0.5638;0.9947 0.8465 0.5705;0.9956 0.8506 0.5771;0.9966 0.8548 0.5838;0.997 0.8583 0.5916;0.997 0.8612 0.6005;0.997 0.8641 0.6093;0.997 0.867 0.6182;0.997 0.8699 0.6271;0.9969 0.8729 0.636;0.9969 0.8758 0.6448;0.9969 0.8787 0.6537;0.9969 0.8816 0.6626;0.9969 0.8845 0.6715;0.9969 0.8874 0.6804;0.9968 0.8903 0.6892;0.9968 0.8932 0.6981;0.9968 0.8962 0.707;0.9968 0.8991 0.7159;0.9968 0.902 0.7247;0.9968 0.9049 0.7336;0.9967 0.9078 0.7425;0.9967 0.9107 0.7514;0.9967 0.9136 0.7603;0.9967 0.9165 0.7691;0.9967 0.9195 0.778;0.9967 0.9224 0.7869;0.9966 0.9253 0.7958;0.9966 0.9282 0.8046;0.9966 0.9311 0.8135;0.9967 0.9336 0.8221;0.9968 0.9357 0.8304;0.997 0.9378 0.8386;0.9971 0.9399 0.8469;0.9973 0.942 0.8552;0.9975 0.944 0.8635;0.9976 0.9461 0.8717;0.9978 0.9482 0.88;0.9979 0.9503 0.8883;0.9981 0.9524 0.8966;0.9982 0.9545 0.9048;0.9984 0.9566 0.9131;0.9985 0.9587 0.9214;0.9987 0.9607 0.9297;0.9988 0.9628 0.9379;0.999 0.9649 0.9462;0.9992 0.967 0.9545;0.9993 0.9691 0.9628;0.9995 0.9712 0.971;0.9996 0.9733 0.9793;0.9998 0.9754 0.9876;0.9999 0.9774 0.9959])
               aa=surf(Y_raw_Left_flat_ldru*ones(1,length(X_raw_Left_flat_ldru)),-(ones(length(Y_raw_Left_flat_ldru),1)*X_raw_Left_flat_ldru'),im_RedLeft_red_flat_ldru*0-1,im_RedLeft_red_flat_ldru);
               set(aa,'edgecolor','none','facecolor','interp')
               aa=surf(Y_raw_Down_flat_ldru*ones(1,length(X_raw_Down_flat_ldru)),-(ones(length(Y_raw_Down_flat_ldru),1)*X_raw_Down_flat_ldru'+B*1000+20),im_RedDown_red_flat_ldru*0-1,im_RedDown_red_flat_ldru);
               set(aa,'edgecolor','none','facecolor','interp')
               aa=surf(Y_raw_Right_flat_ldru*ones(1,length(X_raw_Right_flat_ldru)),-(ones(length(Y_raw_Right_flat_ldru),1)*X_raw_Right_flat_ldru'+(H+B)*1000+40),im_RedRight_red_flat_ldru*0-1,im_RedRight_red_flat_ldru);
               set(aa,'edgecolor','none','facecolor','interp')
               aa=surf(Y_raw_Up_flat_ldru*ones(1,length(X_raw_Up_flat_ldru)),-(ones(length(Y_raw_Up_flat_ldru),1)*X_raw_Up_flat_ldru'+(H+2*B)*1000+60),im_RedUp_red_flat_ldru*0-1,im_RedUp_red_flat_ldru);
               set(aa,'edgecolor','none','facecolor','interp')
               axis equal
           end
           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%           
       end
       %%%%%%%%%%%%%%%%%%%%%%
       
       %%%%%%%%%%%%%%%%%%%%%%
          

   end


