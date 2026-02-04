 for side=1:4
       if side==1
           %im_side_red=im_RedUp_red;
           mark_Side_dark_WE=mark_Up_dark_WE;
           X_raw_Side=X_raw_Up;
           Y_raw_Side=Y_raw_Up;
           knot_data_min_max_side=knot_data_min_max_up;
       elseif side==2
           %im_side_red=im_RedDown_red;
           mark_Side_dark_WE=mark_Down_dark_WE;
           X_raw_Side=X_raw_Down;
           Y_raw_Side=Y_raw_Down;
           knot_data_min_max_side=knot_data_min_max_down;
       elseif side==3
           %im_side_red=im_RedLeft_red;
           mark_Side_dark_WE=mark_Left_dark_WE;
           X_raw_Side=X_raw_Left;
           Y_raw_Side=Y_raw_Left;
           knot_data_min_max_side=knot_data_min_max_left;
       elseif side==4
           %im_side_red=im_RedRight_red;
           mark_Side_dark_WE=mark_Right_dark_WE;
           X_raw_Side=X_raw_Right;
           Y_raw_Side=Y_raw_Right;
           knot_data_min_max_side=knot_data_min_max_right;
       end
       [ri,ki]=size(mark_Side_dark_WE);
       mark_Side_dark_restricted=zeros(ri,ki);
       [nf,dummy]=size(knot_data_min_max_side);

       % QUICK FIX (see also below ...)!!!
       % X_raw_Side=X_raw_Side+10;
       % Y_raw_Side=Y_raw_Side+10;
       % knot_data_min_max_side=knot_data_min_max_side+10;
       %%%%%%%%%%%%%%%%%%%%
       
       
%        eee=555
%        pause
       
       
       %clear Side_X_conv_hull Side_Y_conv_hull Side_A_conv_hull 
       Side_X_conv_hull=-ones(nf,1000)*1e6;
       Side_Y_conv_hull=-ones(nf,1000)*1e6;
       Side_A_conv_hull=-ones(nf,1)*1e6;
       
       lX=length(X_raw_Side);
       lY=length(Y_raw_Side);
       dx=mean(X_raw_Side(2:lX)-X_raw_Side(1:(lX-1)));
       dy=mean(Y_raw_Side(2:lY)-Y_raw_Side(1:(lY-1)));
       
       for f=1:nf
           [valkm,km]=min(abs(X_raw_Side-knot_data_min_max_side(f,1)));
           [valkp,kp]=min(abs(X_raw_Side-knot_data_min_max_side(f,2)));
           [valrm,rm]=min(abs(Y_raw_Side-knot_data_min_max_side(f,3)));
           [valrp,rp]=min(abs(Y_raw_Side-knot_data_min_max_side(f,4)));
           %[km kp rm rp]
           %[X_raw_Side(km) X_raw_Side(kp) Y_raw_Side(rm) Y_raw_Side(rp)]
           mark_Side_dark_restricted(rm:rp,km:kp)=mark_Side_dark_WE(rm:rp,km:kp);
                  %%%%%%%%%%%%%%%%%%%%%%%%
           mark_Side_dark_sub=mark_Side_dark_restricted(rm:rp,km:kp);
           X_raw_Side_sub=X_raw_Side(km:kp);
           Y_raw_Side_sub=Y_raw_Side(rm:rp);
%              figure(100)
%              clf
%              hold on
           %CM=contourc(X_raw_Side_sub,Y_raw_Side_sub,mark_Side_dark_sub,1); %,'r');
           [nr,nc]=size(mark_Side_dark_sub);
           X_raw_Side_sub_2=[X_raw_Side_sub(1)-dx; X_raw_Side_sub; X_raw_Side_sub(nc)+dx];
           Y_raw_Side_sub_2=[Y_raw_Side_sub(1)-dy; Y_raw_Side_sub; Y_raw_Side_sub(nr)+dy];
           mark_Side_dark_sub_2=[zeros(1,nc+2); zeros(nr,1) mark_Side_dark_sub zeros(nr,1); zeros(1,nc+2)];
           CM2=contourc(X_raw_Side_sub_2,Y_raw_Side_sub_2,mark_Side_dark_sub_2,1);
           %contour(X_raw_Side_sub_2,Y_raw_Side_sub_2,mark_Side_dark_sub_2,1,'b');
           X_raw_Side_sub=X_raw_Side_sub_2;
           Y_raw_Side_sub=Y_raw_Side_sub_2;
           mark_Side_dark_sub=mark_Side_dark_sub_2;
           CM=CM2;
           
           [two,kk]=size(CM);
           CM_mark=zeros(two,kk);
           p=0;
           if kk>0
               for k=1:kk
                  if CM(1,k)==0.5 & CM(2,k)==round(CM(2,k))
                      CM_mark(1,k)=1;
                      p=p+1;
                      CM_mark(2,k)=p;
                  end
               end
               start_pos_in_CM=(find(CM_mark(1,:))+1)';
               end_pos_in_CM=([start_pos_in_CM(2:length(start_pos_in_CM))-2; kk]);
               %[start_pos_in_CM end_pos_in_CM]
               n_fields=length(start_pos_in_CM);
               Area_CM=zeros(n_fields,1);
               %Area_centroid_CM=zeros(n_fields,3);
               for k=1:n_fields
                   Area_CM(k,1)=polyarea(CM(1,start_pos_in_CM(k):end_pos_in_CM(k)),CM(2,start_pos_in_CM(k):end_pos_in_CM(k)));
                   %[centroid, area] = polygonCentroid([CM(1,start_pos_in_CM(k):end_pos_in_CM(k)); CM(2,start_pos_in_CM(k):end_pos_in_CM(k))]');
                   %Area_centroid_CM(k,1:3)=[area centroid];
               end
               [A,nbr]=max(Area_CM);
               if A>1e-6  % OBS !!!!!!!!!!!!!!!
                   [K,A_conv_hull]=convhull(CM(1,start_pos_in_CM(nbr):end_pos_in_CM(nbr)),CM(2,start_pos_in_CM(nbr):end_pos_in_CM(nbr)));
                   %XY_conv_hull=[CM(1,start_pos_in_CM(nbr)-1+K)' CM(2,start_pos_in_CM(nbr)-1+K)'] 
%                    if K(1)~=K(length(K))
%                       aaa=333
%                       K
%                       pause
%                    end
                   Side_X_conv_hull(f,1:length(K))=CM(1,start_pos_in_CM(nbr)-1+K);
                   Side_Y_conv_hull(f,1:length(K))=CM(2,start_pos_in_CM(nbr)-1+K);
                   Side_A_conv_hull(f,1)=A_conv_hull;
                    if side==3
%                          CM
%                          start_pos_in_CM(nbr)
%                          nbr
%                          K
%                          Side_X_conv_hull(:,1:100)
%                          Side_Y_conv_hull(:,1:100)
%                          pause
                         CM_right_temp=CM;
                    end

                   
                   %plot(CM(1,start_pos_in_CM(nbr)-1+K),CM(2,start_pos_in_CM(nbr)-1+K),'g')
               else
                   Side_X_conv_hull(f,:)=ones(1,1000)*-1e6;
                   Side_Y_conv_hull(f,:)=ones(1,1000)*-1e6;
                   Side_A_conv_hull(f,1)=0;               
               end
           else
                   Side_X_conv_hull(f,:)=ones(1,1000)*-1e6;
                   Side_Y_conv_hull(f,:)=ones(1,1000)*-1e6;
                   Side_A_conv_hull(f,1)=0;               
           end
         %pause
       %%%%%%%%%%%%%%%%%%%%%%%%
       end
       
%        [pos_reject]=find(Side_X_conv_hull(:,1)-abs(Side_X_conv_hull(:,1)));
%        Side_X_conv_hull(pos_reject,:)=[];
%        Side_Y_conv_hull(pos_reject,:)=[];
%        Side_A_conv_hull(pos_reject,:)=[];
       
       % QUICK FIX (see also above)
       %Side_X_conv_hull=Side_X_conv_hull-10;
       %Side_Y_conv_hull=Side_Y_conv_hull-10;
       %knot_data_min_max_side=knot_data_min_max_side-10
       %%%%%%%%%%%%%%%%%%
       
       if side==1
           mark_Up_dark_restricted=mark_Side_dark_restricted;
           Up_X_conv_hull=Side_X_conv_hull;
           Up_Y_conv_hull=Side_Y_conv_hull;
           Up_A_conv_hull=Side_A_conv_hull;
       elseif side==2
           mark_Down_dark_restricted=mark_Side_dark_restricted;
           Down_X_conv_hull=Side_X_conv_hull;
           Down_Y_conv_hull=Side_Y_conv_hull;
           Down_A_conv_hull=Side_A_conv_hull;
       elseif side==3
           mark_Left_dark_restricted=mark_Side_dark_restricted;
           Left_X_conv_hull=Side_X_conv_hull;
           Left_Y_conv_hull=Side_Y_conv_hull;
           Left_A_conv_hull=Side_A_conv_hull;
       elseif side==4
           mark_Right_dark_restricted=mark_Side_dark_restricted;
           Right_X_conv_hull=Side_X_conv_hull;
           Right_Y_conv_hull=Side_Y_conv_hull;
           Right_A_conv_hull=Side_A_conv_hull;
       end
 end

 
 
 
