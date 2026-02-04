% This script was last updated 2016-08-02 by AO

% % In this script the knots location and area are calculated and is given in 
% % matrices where one row represents one knot. The input
% % values are from Andreas_startskript_141104.m and pith_angle_script.m. In
% % Andreas_startscript_141104.m the angle indicating a knot can be changed.
% % The fibers direction is calculate in pith_angle_script.m. 
% 
% % Reduce the information of all the fibers direction and only keeps the
% % information about the knots.

skip_data_this_close_to_end=skip_data_this_close_to_end_mm/1000;

if Anders_modified_knot_detection==1
   for side=1:4
       if side==1
           pith_angle_side_degrees=pith_angle_up_degrees_unsmoothed;
           Fi2_side=abs(Fi2_UP)*180/pi;
       elseif side==2
           pith_angle_side_degrees=pith_angle_down_degrees_unsmoothed;
           Fi2_side=abs(Fi2_DOWN)*180/pi;
       elseif side==3
           pith_angle_side_degrees=pith_angle_left_degrees_unsmoothed;
           Fi2_side=abs(Fi2_LEFT)*180/pi;
       elseif side==4
           pith_angle_side_degrees=pith_angle_right_degrees_unsmoothed;
           Fi2_side=abs(Fi2_RIGHT)*180/pi;
       end

       mark_knot_side__pith_angle=ceil(floor(pith_angle_side_degrees/fiber_dir_indicating_knot)/10);
       mark_knot_side__pith_angle_m2=ceil(floor(pith_angle_side_degrees/(fiber_dir_indicating_knot-fiber_dv))/10);
       mark_knot_side__pith_angle_p2=ceil(floor(pith_angle_side_degrees/(fiber_dir_indicating_knot+fiber_dv))/10);
       
       % Om maximalt en laserpunkt, i ett nät om 3x3 punkter runt den
       % studerade punkten, har en vinkel Fi2 som överstiger ett gränsvärde
       % så betraktas inte punkten som en kvistyta (alltså en kvistyta baserat på
       % fibvervinkeldata)
       [nrs,nks]=size(Fi2_side);
       Fi2_side_with_margin=[zeros(nrs+2,1) [zeros(1,nks); Fi2_side; zeros(1,nks)] zeros(nrs+2,1)];
       mark_knot_side__Fi2=ones(nrs,nks);
       
       for r=2:(nrs+1)
           for k=2:(nks+1)
                ind_larg_Fi2=ceil((Fi2_side_with_margin((r-1):(r+1),(k-1):(k+1))-Fi2_limit_knot)/100);
                if sum(sum(ind_larg_Fi2))<2
                    mark_knot_side__Fi2(r-1,k-1)=0;
                end
           end
       end
       mark_knot_side=mark_knot_side__pith_angle.*mark_knot_side__Fi2;
       mark_knot_side_m2=mark_knot_side__pith_angle_m2.*mark_knot_side__Fi2;
       mark_knot_side_p2=mark_knot_side__pith_angle_p2.*mark_knot_side__Fi2;
     
       %--- En extra fibervinkelmarkör som enbart bygger på fibervinkeln i
       %--- planet tillskapas här, som möjligt komplement till
       %--- kvistindikator baserad på mörkhet. Om fibervinkeln i planet i en viss punkt,
       %--- är större än Fi2_limit_as_dark OCH punkten har minst req_nbr_neighbours
       %--- grannar som har en fibervinkel i planet som avviker mindre än
       %--- Fi2_limit_as_dark_delta så markeras punkten som kvistyta i den
       %--- särskilda matrisen mark_knot_side_Fi2_as_dark
       Fi2_side_with_margin=[zeros(nrs+2,1) [zeros(1,nks); Fi2_side; zeros(1,nks)] zeros(nrs+2,1)];
       mark_knot_side_Fi2_as_dark=ceil((Fi2_side-Fi2_limit_as_dark_1)/100);
       
%        aaa=333
%        pause
       
       %if side<4  % OBS TILLFÄLLIGT !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
       for r=2:(nrs+1)
           for k=2:(nks+1)
               ind_larg_Fi2=ceil((Fi2_side_with_margin(r,k)-Fi2_limit_as_dark_2)/100);
               if ind_larg_Fi2==1
                   similar_Fi2_neighbors=abs(Fi2_side_with_margin((r-1):(r+1),(k-1):(k+1))-Fi2_side_with_margin(r,k));
                   neighbors_ind=abs(ceil(floor(similar_Fi2_neighbors/Fi2_limit_as_dark_delta)/100)-1);
                   if sum(sum(neighbors_ind))>(req_nbr_neighbors)
                       mark_knot_side_Fi2_as_dark(r-1,k-1)=1;
                   end
               end
           end
       end
       %end
       
       %---

       if side==1
            mark_knot_up=mark_knot_side;                                % bygger på kriterier som omfatta "pith angle" OCH "Fi2"  
            mark_knot_up_m2=mark_knot_side_m2;
            mark_knot_up_p2=mark_knot_side_p2;
            mark_knot_up_Fi2=mark_knot_side__Fi2;
            mark_knot_up_pith_angle=mark_knot_side__pith_angle;         % bygger på kriterium som omfatta "pith angle"  
            mark_knot_up_pith_angle_m2=mark_knot_side__pith_angle_m2;
            mark_knot_up_pith_angle_p2=mark_knot_side__pith_angle_p2;
            mark_knot_up_Fi2_as_dark=mark_knot_side_Fi2_as_dark;        % I vissa fall (oftast på märgsidor) kan det finnas anledning att slutligen defeniera en yta som kvistyta trots(!) att den är för ljus map på mörkhetskriteriet
       elseif side==2
            mark_knot_down=mark_knot_side;
            mark_knot_down_m2=mark_knot_side_m2;
            mark_knot_down_p2=mark_knot_side_p2;
            mark_knot_down_Fi2=mark_knot_side__Fi2;
            mark_knot_down_pith_angle=mark_knot_side__pith_angle;
            mark_knot_down_pith_angle_m2=mark_knot_side__pith_angle_m2;
            mark_knot_down_pith_angle_p2=mark_knot_side__pith_angle_p2;
            mark_knot_down_Fi2_as_dark=mark_knot_side_Fi2_as_dark; %(2:nrs,2:nks);
       elseif side==3
            mark_knot_left=mark_knot_side;
            mark_knot_left_m2=mark_knot_side_m2;
            mark_knot_left_p2=mark_knot_side_p2;
            mark_knot_left_Fi2=mark_knot_side__Fi2;
            mark_knot_left_pith_angle=mark_knot_side__pith_angle;
            mark_knot_left_pith_angle_m2=mark_knot_side__pith_angle_m2;
            mark_knot_left_pith_angle_p2=mark_knot_side__pith_angle_p2;
            mark_knot_left_Fi2_as_dark=mark_knot_side_Fi2_as_dark; %(2:nrs,2:nks);
       elseif side==4
            mark_knot_right=mark_knot_side;
            mark_knot_right_m2=mark_knot_side_m2;
            mark_knot_right_p2=mark_knot_side_p2;
            mark_knot_right_Fi2=mark_knot_side__Fi2;
            mark_knot_right_pith_angle=mark_knot_side__pith_angle;
            mark_knot_right_pith_angle_m2=mark_knot_side__pith_angle_m2;
            mark_knot_right_pith_angle_p2=mark_knot_side__pith_angle_p2;
            mark_knot_right_Fi2_as_dark=mark_knot_side_Fi2_as_dark; %(2:nrs,2:nks);
       end
   end
   
else
   mark_knot_up=ceil(floor(pith_angle_up_degrees_unsmoothed/fiber_dir_indicating_knot)/10);         % Enklare kriterium som bl.a. Andreas har använt ...
   mark_knot_down=ceil(floor(pith_angle_down_degrees_unsmoothed/fiber_dir_indicating_knot)/10);
   mark_knot_left=ceil(floor(pith_angle_left_degrees_unsmoothed/fiber_dir_indicating_knot)/10);
   mark_knot_right=ceil(floor(pith_angle_right_degrees_unsmoothed/fiber_dir_indicating_knot)/10);
end
   
positions_knot_up=[];
positions_knot_down=[];
positions_knot_left=[];
positions_knot_right=[];

for side=1:4
     
     if side==1
         mark_knot=mark_knot_up;
         X_SIDE=X_UP;
         Y_SIDE=Y_UP;
         mark_knot_side_Fi2_as_dark=mark_knot_up_Fi2_as_dark;
     elseif side==2
         mark_knot=mark_knot_down;
         X_SIDE=X_DOWN;
         Y_SIDE=Y_DOWN;
         mark_knot_side_Fi2_as_dark=mark_knot_down_Fi2_as_dark;
     elseif side==3
         mark_knot=mark_knot_left;
         X_SIDE=X_LEFT;
         Y_SIDE=Y_LEFT;
         mark_knot_side_Fi2_as_dark=mark_knot_left_Fi2_as_dark;
     elseif side==4
         mark_knot=mark_knot_right;
         X_SIDE=X_RIGHT;
         Y_SIDE=Y_RIGHT;
         mark_knot_side_Fi2_as_dark=mark_knot_right_Fi2_as_dark;
     end
     [m_study,n_study]=size(mark_knot);
     rows_to_skip=round(skip_data_this_close_to_end/L*m_study);
     if rows_to_skip>0
         mark_knot(1:rows_to_skip,:)=zeros(rows_to_skip,n_study);
         mark_knot((m_study-rows_to_skip+1):m_study,:)=zeros(rows_to_skip,n_study);
     end

     [fibre_fields_cXcYA,knot_data_min_max_side,Side_X_conv_hull_fibre,Side_Y_conv_hull_fibre,Side_A_conv_hull_fibre]=make_fields_160801(X_SIDE,Y_SIDE,mark_knot,trans_marg_fi_knot_surf,long_marg_fi_knot_surf);
     %Fortsätt här! (160407) använd nedanstående funktion/rad för ett fält
     %(röd rektangel) itaget. Spara bera det största blåa fältet inom varje
     %röd rektangel. Jämför sedan gröna fält och blåa fält. Om det gröna
     %fältet är större än ca 50% av det blåa fältet så är det grönt fält
     %som representerar kvisten. I annat fall är det blått fält som gäller.
     %Gör en ny figur (motsavarnde figur 5) där kvistar markeras på detta
     %sätt. Provkör skriptet på olika plankor och kolla rimligheten.
     %Justera eventuellt parametrar och städa därefter upp i filerna.
     %Inaktuella filer placeras i en katalog "old". Fortsätt sedan med att
     %spara data om "kvistdiameter", "area" (olika alternativa definitioner bör
     %användas) och lägsta och högsta punkt längs plankan där kvisten
     %börjar/slutar. Sedan är det dags att ta fram kriterier för "ostörda fibrer i sågsnittet" och att simulera defekteliminering ... 
     % OCH just det. De gröna fälten kan ibland bli vädigt fel/stora vid
     % kanten där svarta ränder uppträder. Fixa till detta genom att kolla
     % mörkheten i kantpixlar, typ yttersat 0.5 cm. Om det är VÄLDIGT mörkt
     % där så görs pixlarna ljusa ...

     fibre_fields_cXcYA_Fi2_as_dark=[];
     Side_X_conv_hull_Fi2_dark=[];
     Side_Y_conv_hull_Fi2_dark=[];
     
     [n_fields,four]=size(knot_data_min_max_side);
     
%       if side==1
%           aaa=333
%           pause
%       end

     lX=length(X_SIDE);
     lY=length(Y_SIDE);
     dx=mean(X_SIDE(2:lX)-X_SIDE(1:(lX-1)));
     dy=mean(Y_SIDE(2:lY)-Y_SIDE(1:(lY-1)));
     
     for f=1:n_fields
        [abs_X_SIDE_sub_1,pos_x1]=min(abs(X_SIDE-(knot_data_min_max_side(f,1)-0)));
        [abs_X_SIDE_sub_2,pos_x2]=min(abs(X_SIDE-(knot_data_min_max_side(f,2)+0)));
        [abs_Y_SIDE_sub_1,pos_y1]=min(abs(Y_SIDE-(knot_data_min_max_side(f,3)-0)));
        [abs_Y_SIDE_sub_2,pos_y2]=min(abs(Y_SIDE-(knot_data_min_max_side(f,4)+0)));
        X_SIDE_sub=X_SIDE(pos_x1:pos_x2);
        Y_SIDE_sub=Y_SIDE(pos_y1:pos_y2);
        mark_knot_side_Fi2_as_dark_sub=mark_knot_side_Fi2_as_dark(pos_y1:pos_y2,pos_x1:pos_x2);
        
        [nr,nc]=size(mark_knot_side_Fi2_as_dark_sub);
        X_SIDE_sub=[X_SIDE_sub(1)-dx; X_SIDE_sub; X_SIDE_sub(nc)+dx];
        Y_SIDE_sub=[Y_SIDE_sub(1)-dy; Y_SIDE_sub; Y_SIDE_sub(nr)+dy];
        mark_knot_side_Fi2_as_dark_sub=[zeros(1,nc+2); zeros(nr,1) mark_knot_side_Fi2_as_dark_sub zeros(nr,1); zeros(1,nc+2)];
        
        [fibre_fields_cXcYA_Fi2_as_dark_sub,knot_data_min_max_side_Fi2_as_dark_sub,Side_X_conv_hull_Fi2_dark_sub,Side_Y_conv_hull_Fi2_dark_sub,Side_A_conv_hull_Fi2_dark_sub]=make_fields_160801(X_SIDE_sub,Y_SIDE_sub,mark_knot_side_Fi2_as_dark_sub,0,0);
        
        if Side_A_conv_hull_Fi2_dark_sub==0
            fibre_fields_cXcYA_Fi2_as_dark=[fibre_fields_cXcYA_Fi2_as_dark; 0 0 0];
            Side_X_conv_hull_Fi2_dark=[Side_X_conv_hull_Fi2_dark; ones(1,1000)*-1e6];
            Side_Y_conv_hull_Fi2_dark=[Side_Y_conv_hull_Fi2_dark; ones(1,1000)*-1e6];
        else
            [v,fm]=max(fibre_fields_cXcYA_Fi2_as_dark_sub(:,3));
            fibre_fields_cXcYA_Fi2_as_dark=[fibre_fields_cXcYA_Fi2_as_dark; fibre_fields_cXcYA_Fi2_as_dark_sub(fm,:)];
            Side_X_conv_hull_Fi2_dark=[Side_X_conv_hull_Fi2_dark; Side_X_conv_hull_Fi2_dark_sub(fm,:)];
            Side_Y_conv_hull_Fi2_dark=[Side_Y_conv_hull_Fi2_dark; Side_Y_conv_hull_Fi2_dark_sub(fm,:)];
        end
        if f==length(fibre_fields_cXcYA_Fi2_as_dark(:,1))
            
        else
             board
             side
             [f length(fibre_fields_cXcYA_Fi2_as_dark(:,1))]
             pause
        end
     end

     
% % %      figure(100)
% % %      clf
% % %      hold on
% % %      CM=contour(X_SIDE,Y_SIDE,mark_knot,1,'r');
% % %      [two,kk]=size(CM);
% % %      CM_mark=zeros(two,kk);
% % %      f=0;
% % %      for k=1:kk
% % %         if CM(1,k)==0.5 & CM(2,k)==round(CM(2,k))
% % %             CM_mark(1,k)=1;
% % %             f=f+1;
% % %             CM_mark(2,k)=f;
% % %         end
% % %      end
% % %      start_pos_in_CM=(find(CM_mark(1,:))+1)';
% % %      end_pos_in_CM=([start_pos_in_CM(2:length(start_pos_in_CM))-2; kk]);
% % %      n_fields=length(start_pos_in_CM);
% % %      A_CM=zeros(n_fields,5);
% % %      knot_data_min_max_side_no_marg=zeros(n_fields,4);
% % %      for k=1:n_fields
% % %          A_CM(k,4)=polyarea(CM(1,start_pos_in_CM(k):end_pos_in_CM(k)),CM(2,start_pos_in_CM(k):end_pos_in_CM(k)));
% % %          [centroid, area] = polygonCentroid([CM(1,start_pos_in_CM(k):end_pos_in_CM(k)); CM(2,start_pos_in_CM(k):end_pos_in_CM(k))]');
% % %          knot_data_min_max_side_no_marg(k,:)=[min(CM(1,start_pos_in_CM(k):end_pos_in_CM(k))) max(CM(1,start_pos_in_CM(k):end_pos_in_CM(k))) min(CM(2,start_pos_in_CM(k):end_pos_in_CM(k))) max(CM(2,start_pos_in_CM(k):end_pos_in_CM(k)))];
% % %           A_CM(k,1:3)=[-area centroid];
% % %      end
% % %      for k1=1:n_fields
% % %          in=0;
% % %          for k2=1:n_fields
% % %             if k1==k2
% % %             else
% % %                 in=inpolygon(A_CM(k1,2),A_CM(k1,3),CM(1,start_pos_in_CM(k2):end_pos_in_CM(k2)),CM(2,start_pos_in_CM(k2):end_pos_in_CM(k2)));
% % %                 if in==1
% % %                     A_CM(k1,5)=1;
% % %                 end
% % %             end
% % %          end
% % %      end
% % %      aa=find(A_CM(:,5));
% % % %      plot(A_CM(:,2),A_CM(:,3),'b+')
% % % %      plot(A_CM(aa,2),A_CM(aa,3),'g+')
% % % %      axis equal
% % %      A_CM(:,[1 5])=[];
% % %      A_CM(aa,:)=[];
% % %      knot_data_min_max_side_no_marg(aa,:)=[];
% % %      [a,b]=sort(A_CM(:,1),'descend');
% % % 
% % %      fibre_fields_cXcYA=A_CM(b,:);
% % %      knot_data_min_max_side_no_marg=knot_data_min_max_side_no_marg(b,:); % OBS
% % % %      
% % %      [la,b]=size(knot_data_min_max_side_no_marg);
% % %      fibre_fields_min_max_side=knot_data_min_max_side_no_marg+ones(la,1)*[-trans_marg_fi_knot_surf  trans_marg_fi_knot_surf  -long_marg_fi_knot_surf  long_marg_fi_knot_surf];
% % %      change=1;
% % %      c=0;
% % %      
% % %      while change==1
% % %          remove_ind=zeros(la,2);
% % %          change=0;
% % %          c=c+1
% % %          for k=1:la
% % %             for kk=1:la
% % %                 if k==kk
% % %                 elseif fibre_fields_cXcYA(k,1)>fibre_fields_min_max_side(kk,1) & fibre_fields_cXcYA(k,1)<fibre_fields_min_max_side(kk,2) & fibre_fields_cXcYA(k,2)>fibre_fields_min_max_side(kk,3) & fibre_fields_cXcYA(k,2)<fibre_fields_min_max_side(kk,4) & fibre_fields_cXcYA(k,3)<fibre_fields_cXcYA(kk,3)
% % %                     remove_ind(k,:)=[k kk];
% % %                     fibre_fields_min_max_side(kk,:)=[min([fibre_fields_min_max_side(kk,1) fibre_fields_min_max_side(k,1)]) ...
% % %                                                              max([fibre_fields_min_max_side(kk,2) fibre_fields_min_max_side(k,2)]) ...
% % %                                                              min([fibre_fields_min_max_side(kk,3) fibre_fields_min_max_side(k,3)]) ...
% % %                                                              max([fibre_fields_min_max_side(kk,4) fibre_fields_min_max_side(k,4)])];
% % %                     if c<10
% % %                        change=1;
% % %                     end
% % %                 end
% % %             end
% % %          end
% % %          %fibre_fields_min_max_side=fibre_fields_min_max_side_updated;
% % %          fibre_fields_min_max_side(find(remove_ind(:,1)),:)=[];
% % %          fibre_fields_cXcYA(find(remove_ind(:,1)),:)=[];
% % %          [la,f]=size(fibre_fields_min_max_side);
% % %      end
     

     %knot_data_min_max_side=fibre_fields_min_max_side;
     if side==1
        knot_data_min_max_up=knot_data_min_max_side;
        Up_X_conv_hull_Fi2_dark=Side_X_conv_hull_Fi2_dark;
        Up_Y_conv_hull_Fi2_dark=Side_Y_conv_hull_Fi2_dark;
        if length(knot_data_min_max_side)==0
            Up_A_conv_hull_Fi2_dark=[];
        else
            Up_A_conv_hull_Fi2_dark=fibre_fields_cXcYA_Fi2_as_dark(:,3);
        end
     elseif side==2
        knot_data_min_max_down=knot_data_min_max_side;
        Down_X_conv_hull_Fi2_dark=Side_X_conv_hull_Fi2_dark;
        Down_Y_conv_hull_Fi2_dark=Side_Y_conv_hull_Fi2_dark;
        if length(knot_data_min_max_side)==0
            Down_A_conv_hull_Fi2_dark=[];
        else
            Down_A_conv_hull_Fi2_dark=fibre_fields_cXcYA_Fi2_as_dark(:,3);
        end
     elseif side==3
        knot_data_min_max_left=knot_data_min_max_side;
        Left_X_conv_hull_Fi2_dark=Side_X_conv_hull_Fi2_dark;
        Left_Y_conv_hull_Fi2_dark=Side_Y_conv_hull_Fi2_dark;
        if length(knot_data_min_max_side)==0
            Left_A_conv_hull_Fi2_dark=[];
        else
            Left_A_conv_hull_Fi2_dark=fibre_fields_cXcYA_Fi2_as_dark(:,3);
        end
     elseif side==4
        knot_data_min_max_right=knot_data_min_max_side;
        Right_X_conv_hull_Fi2_dark=Side_X_conv_hull_Fi2_dark;
        Right_Y_conv_hull_Fi2_dark=Side_Y_conv_hull_Fi2_dark;
        if length(knot_data_min_max_side)==0
            Right_A_conv_hull_Fi2_dark=[];
        else
            Right_A_conv_hull_Fi2_dark=fibre_fields_cXcYA_Fi2_as_dark(:,3);
        end
     end
 end
     
%      %------------------------------------------------------------- 
%      not_ready=1;
%      while still_knots==1
%        [i,j,s]=find(mark_knot);
%        im=i(1);
%        ip=i(1);
%        jj=j(1);
%        pos_this_knot=[];
%        while not_ready==1
%          while im>1
%            im=im-1;
%            if mark_knot(im,jj)==0 
%              im=im+1;
%              break
%            end
%          end
%          while ip<m_study
%            ip=ip+1;
%            if mark_knot(ip,jj)==0
%               ip=ip-1;
%               break
%            end
%          end
%          pos_this_knot=[pos_this_knot;[[im:ip]' ones(length([im:ip]),1)*jj]];
%          if jj<n_study
%            jj=jj+1;
%            ii=(find(mark_knot([im:ip],jj))+im-1);
%            if length(ii)==0
%               break
%            else
%               im=round(median(ii));
%               ip=im;
%            end
%          else
%            break
%          end
%        end
%        %------------------------------------------------------------------------------------------------
%        %                     x-koordinat(tyngdpunkt)                 y-koordinat                             z-koordinat      area
%        if max(pos_this_knot(:,2))-min(pos_this_knot(:,2))>1
%           dX=(X_SIDE(max(pos_this_knot(:,2)))-X_SIDE(min(pos_this_knot(:,2))))/(max(pos_this_knot(:,2))-min(pos_this_knot(:,2)));
%        else
%            dX=(X_SIDE(length(X_SIDE))-X_SIDE(1))/(length(X_SIDE)-1);
%        end
%        if max(pos_this_knot(:,1))-min(pos_this_knot(:,1))>1
%           dY=(Y_SIDE(max(pos_this_knot(:,1)))-Y_SIDE(min(pos_this_knot(:,1))))/(max(pos_this_knot(:,1))-min(pos_this_knot(:,1)));
%        else
%            dY=(Y_SIDE(length(Y_SIDE))-Y_SIDE(1))/(length(Y_SIDE)-1);
%        end
%        knot_data=[knot_data; mean(X_SIDE(pos_this_knot(:,2)))  mean(Y_SIDE(pos_this_knot(:,1)))    B*1000       length(pos_this_knot(:,1))*(dX*dY)]; % okej med z-koord B*1000 för UP men konstigt för DOWN ...
%        knot_data_min_max=[knot_data_min_max; X_SIDE(min(pos_this_knot(:,2)))-trans_marg_fi_knot_surf ...        
%                                              X_SIDE(max(pos_this_knot(:,2)))+trans_marg_fi_knot_surf ...
%                                              Y_SIDE(min(pos_this_knot(:,1)))-long_marg_fi_knot_surf ...         
%                                              Y_SIDE(max(pos_this_knot(:,1)))+long_marg_fi_knot_surf];
% %         knot_data=[knot_data; mean(pos_this_knot(:,2))/n_study*H*1000 mean(pos_this_knot(:,1))/m_study*L*1000 B*1000           length(pos_this_knot(:,1))/(m_study*n_study)*L*H*1e6] % okej med z-koord B*1000 för UP men konstigt för DOWN ...
% %         knot_data_min_max=[knot_data_min_max; min(pos_this_knot(:,2))/n_study*H*1000-trans_marg_fi_knot_surf ...        
% %                                              max(pos_this_knot(:,2))/n_study*H*1000+trans_marg_fi_knot_surf ...
% %                                              min(pos_this_knot(:,1))/m_study*L*1000-long_marg_fi_knot_surf ...         
% %                                              max(pos_this_knot(:,1))/m_study*L*1000+long_marg_fi_knot_surf]
% % aaa=333
% % pause
%                                         
%        for k=1:length(pos_this_knot(:,1))
%          mark_knot(pos_this_knot(k,1),pos_this_knot(k,2))=0;
%        end
%        if sum(sum(mark_knot))==0
%          still_knots=0;
%        end
%        
%  % ---------Added by Andreas 2015-01-13----------------------------------
%  
%  % pos_this_knot contains information about a single knot. pos_this_knot is
%  % created in a loop and for each loop it is a new knot. In the below
%  % section, for each loop, pos_this_knot information is gathered in a
%  % global matrix that will be used later on. The global matrix
%  % positions_knot_X contains information on which rows and columns the knot is
%  % present. Also the knots Centre of Gravity (x-y-z) and the total area are
%  % presented i.e. the information from knot_data. 
%  % [row_nr column_nr knot_number x_coordinate_for_the_knot y_coordinate_for_the_knot z_coordinate_for_the_knot knot_area] 
%  % the knot_number tells which knot the specific row belongs to. 
%  
%        size_kd=size(knot_data);
%        if side==1
%            if isempty(positions_knot_up);
%                positions_knot_up=pos_this_knot;
%                positions_knot_up(:,3)=size_kd(1,1);
%                positions_knot_up(:,4)=knot_data(size_kd(1,1),1);
%                positions_knot_up(:,5)=knot_data(size_kd(1,1),2);
%                positions_knot_up(:,6)=knot_data(size_kd(1,1),3);
%                positions_knot_up(:,7)=knot_data(size_kd(1,1),4);
%            else
%                copy_pts=pos_this_knot;
%                copy_pts(:,3)=size_kd(1,1);
%                copy_pts(:,4)=knot_data(size_kd(1,1),1);
%                copy_pts(:,5)=knot_data(size_kd(1,1),2);
%                copy_pts(:,6)=knot_data(size_kd(1,1),3);
%                copy_pts(:,7)=knot_data(size_kd(1,1),4);
%                positions_knot_up=[positions_knot_up; copy_pts];
%                
%            end
%        elseif side==2
%            if isempty(positions_knot_down);
%                positions_knot_down=pos_this_knot;
%                positions_knot_down(:,3)=size_kd(1,1);
%                positions_knot_down(:,4)=knot_data(size_kd(1,1),1);
%                positions_knot_down(:,5)=knot_data(size_kd(1,1),2);
%                positions_knot_down(:,6)=0; % down side => z=0
%                positions_knot_down(:,7)=knot_data(size_kd(1,1),4);
%            else
%                copy_pts=pos_this_knot;
%                copy_pts(:,3)=size_kd(1,1);
%                copy_pts(:,4)=knot_data(size_kd(1,1),1);
%                copy_pts(:,5)=knot_data(size_kd(1,1),2);
%                copy_pts(:,6)=0; % down side => z=0
%                copy_pts(:,7)=knot_data(size_kd(1,1),4);
%                positions_knot_down=[positions_knot_down; copy_pts];
%            end
%        end
%        
%     
%  % Output for this part of the script are 
%  % [row_nr column_nr knot_number]
%  % -----------------------------------------------------------------------      
%      end 
%     end
%     if side==3 | side==4
%      not_ready=1;
%          if max(max(mark_knot))>0
%      while still_knots==1
%        [i,j,s]=find(mark_knot);
%        im=i(1);
%        ip=i(1);
%        jj=j(1);
%        pos_this_knot=[];
%        while not_ready==1
%          while im>1
%            im=im-1;
%            if mark_knot(im,jj)==0 
%              im=im+1;
%              break
%            end
%          end
%          while ip<m_study
%            ip=ip+1;
%            if mark_knot(ip,jj)==0
%               ip=ip-1;
%               break
%            end
%          end
%          pos_this_knot=[pos_this_knot;[[im:ip]' ones(length([im:ip]),1)*jj]];
%          if jj<n_study
%            jj=jj+1;
%            ii=(find(mark_knot([im:ip],jj))+im-1);
%            if length(ii)==0
%               break
%            else
%               %im=ii(round(mean(ii))-ii(1)+1);
%               %ip=ii(round(mean(ii))-ii(1)+1);
%               im=round(median(ii));
%               ip=im;
%            end
%          else
%            break
%          end
%        end
%        % pos_x, pos_y, pos_z, area
%        %pos_this_knot
%        %pause
%        if max(pos_this_knot(:,2))-min(pos_this_knot(:,2))>1
%           dX=(X_SIDE(max(pos_this_knot(:,2)))-X_SIDE(min(pos_this_knot(:,2))))/(max(pos_this_knot(:,2))-min(pos_this_knot(:,2)));
%        else
%            dX=(X_SIDE(length(X_SIDE))-X_SIDE(1))/(length(X_SIDE)-1);
%        end
%        if max(pos_this_knot(:,1))-min(pos_this_knot(:,1))>1
%           dY=(Y_SIDE(max(pos_this_knot(:,1)))-Y_SIDE(min(pos_this_knot(:,1))))/(max(pos_this_knot(:,1))-min(pos_this_knot(:,1)));
%        else
%            dY=(Y_SIDE(length(Y_SIDE))-Y_SIDE(1))/(length(Y_SIDE)-1);
%        end
%        knot_data=[knot_data; mean(X_SIDE(pos_this_knot(:,2)))  mean(Y_SIDE(pos_this_knot(:,1)))    B*1000       length(pos_this_knot(:,1))*(dX*dY)]; % okej med z-koord B*1000 för UP men konstigt för DOWN ...
%        knot_data_min_max=[knot_data_min_max; X_SIDE(min(pos_this_knot(:,2)))-trans_marg_fi_knot_surf ...        
%                                              X_SIDE(max(pos_this_knot(:,2)))+trans_marg_fi_knot_surf ...
%                                              Y_SIDE(min(pos_this_knot(:,1)))-long_marg_fi_knot_surf ...         
%                                              Y_SIDE(max(pos_this_knot(:,1)))+long_marg_fi_knot_surf];
%        %knot_data_old=[knot_data; H*1000 mean(pos_this_knot(:,1))/m_study*L*1000 mean(pos_this_knot(:,2))/n_study*B*1000 length(pos_this_knot(:,1))/(m_study*n_study)*B*L*1e6];
%        %knot_data_min_max_old=[knot_data_min_max; min(pos_this_knot(:,2))/n_study*B*1000-trans_marg_fi_knot_surf ...        
%        %                                      max(pos_this_knot(:,2))/n_study*B*1000+trans_marg_fi_knot_surf ...
%        %                                      min(pos_this_knot(:,1))/m_study*L*1000-long_marg_fi_knot_surf ...         
%        %                                      max(pos_this_knot(:,1))/m_study*L*1000+long_marg_fi_knot_surf];
%       
%        for k=1:length(pos_this_knot(:,1))
%          mark_knot(pos_this_knot(k,1),pos_this_knot(k,2))=0;
%        end
%        if sum(sum(mark_knot))==0
%          still_knots=0;
%        end
% % ---------Added by Andreas 2015-01-13----------------------------------
% 
% % See description for up and down side.
% 
%        size_kd=size(knot_data);
%        if side==3
%            if isempty(positions_knot_left);
%                positions_knot_left=pos_this_knot;
%                positions_knot_left(:,3)=size_kd(1,1);
%                positions_knot_left(:,4)=0; % left side => x=0
%                positions_knot_left(:,5)=knot_data(size_kd(1,1),2);
%                positions_knot_left(:,6)=knot_data(size_kd(1,1),3);
%                positions_knot_left(:,7)=knot_data(size_kd(1,1),4);
%            else
%                copy_pts=pos_this_knot;
%                copy_pts(:,3)=size_kd(1,1);
%                copy_pts(:,4)=0; % left side => x=0
%                copy_pts(:,5)=knot_data(size_kd(1,1),2);
%                copy_pts(:,6)=knot_data(size_kd(1,1),3);
%                copy_pts(:,7)=knot_data(size_kd(1,1),4);
%                positions_knot_left=[positions_knot_left; copy_pts];
%                
%            end
%        elseif side==4
%            if isempty(positions_knot_right);
%                positions_knot_right=pos_this_knot;
%                positions_knot_right(:,3)=size_kd(1,1);
%                positions_knot_right(:,4)=knot_data(size_kd(1,1),1);
%                positions_knot_right(:,5)=knot_data(size_kd(1,1),2);
%                positions_knot_right(:,6)=knot_data(size_kd(1,1),3);
%                positions_knot_right(:,7)=knot_data(size_kd(1,1),4);
%            else
%                copy_pts=pos_this_knot;
%                copy_pts(:,3)=size_kd(1,1);
%                copy_pts(:,4)=knot_data(size_kd(1,1),1);
%                copy_pts(:,5)=knot_data(size_kd(1,1),2);
%                copy_pts(:,6)=knot_data(size_kd(1,1),3);
%                copy_pts(:,7)=knot_data(size_kd(1,1),4);
%                positions_knot_right=[positions_knot_right; copy_pts];
%            end
%        end
%        
%  % ----------------------------------------------------------------------- 
%      end
%      else
%          knot_data=[0 0 0 0];
%         end
%     end
%      [i,j]=sort(knot_data(:,4),'descend');
%      knot_data=knot_data(j,:);
%      knot_data_min_max=knot_data_min_max(j,:); % new 160308
%    
%      [numb_knots,k]=size(knot_data);
%      copy_kd=knot_data;
%      copy_kd_not_reduced=knot_data;
%      copy_kd_min_max=knot_data_min_max; % new 160308
%      copy_kd_min_max_not_reduced=knot_data_min_max; % new 160308
%      
% % ----------------- Added by Andreas 2015-01-14 --------------------------    
% 
% % Will be used to check if any knots are erased due to krit_knot_area or if
% % two knots are one and the same knot i.e. max_dist_identify_as_same_knot 
% % (on the same side).
%      if side==1
%          copy_kd_up=copy_kd;
%          positions_knot_study=positions_knot_up;
%          copy_kd_min_max_up=copy_kd_min_max; % new 160308
%      elseif side==2
%          copy_kd_down=copy_kd;
%          positions_knot_study=positions_knot_down;
%          copy_kd_min_max_down=copy_kd_min_max; % new 160308
%      elseif side==3
%          copy_kd_left=copy_kd;
%          positions_knot_study=positions_knot_left;
%          copy_kd_min_max_left=copy_kd_min_max; % new 160308
%      elseif side==4
%          copy_kd_right=copy_kd;
%          positions_knot_study=positions_knot_right;
%          copy_kd_min_max_right=copy_kd_min_max; % new 160308
%      end
% % -------------------------------------------------------------------------
%      for k=1:numb_knots
%        if copy_kd(k,:)==[1 1 1 1]
%            
%        else
%           knot_dist=sqrt((knot_data(:,1)-knot_data(k,1)).^2+(knot_data(:,2)-knot_data(k,2)).^2);
%           knot_dist(k)=1e6;
%           knot_area=knot_data(:,4);
%           knot_area_k=knot_data(k,4);
%           mdi=max_dist_identify_as_same_knot;
%           crit_dist=mdi(1)*((knot_area/pi).^0.5+(knot_area_k/pi)^0.5)+mdi(2);
%           [index]=find(floor((crit_dist)./knot_dist));
%           copy_kd(k,1)=sum(copy_kd([k; index],1).*copy_kd([k; index],4))/sum(copy_kd([k; index],4));  
%           copy_kd(k,2)=sum(copy_kd([k; index],2).*copy_kd([k; index],4))/sum(copy_kd([k; index],4));
%           copy_kd(k,3)=sum(copy_kd([k; index],3).*copy_kd([k; index],4))/sum(copy_kd([k; index],4));
%           copy_kd(k,4)=sum(copy_kd([k; index],4));
%           copy_kd_min_max(k,1)=min(copy_kd_min_max([k; index],1)); % new 160308
%           copy_kd_min_max(k,2)=max(copy_kd_min_max([k; index],2)); % new 160308
%           copy_kd_min_max(k,3)=min(copy_kd_min_max([k; index],3)); % new 160308
%           copy_kd_min_max(k,4)=max(copy_kd_min_max([k; index],4)); % new 160308
%           
%           copy_kd_one_and_the_same_knot=copy_kd_not_reduced([k;index],:);
%           size_ckdb=size(copy_kd_one_and_the_same_knot);
%           size_pk=size(positions_knot_study);
%           
% % The positions of knots in the positions_knot matrix is connected to the
% % COG and arean of the knot i.e. all positions along the board that has
% % indicating that there is a knot are associated with the corresponding
% % information in knot_data.
%           
%               for i=1:size_ckdb(1,1);
%                   for j=1:size_pk(1,1);
%                        if prod(round(copy_kd_one_and_the_same_knot(i,2))==round(positions_knot_study(j,5)))==1
%                            if prod(round(copy_kd_one_and_the_same_knot(i,4))==round(positions_knot_study(j,7)))==1
% %                       if prod((copy_kd_one_and_the_same_knot(i,:))==(positions_knot_study(j,4:7)))==1
%                               positions_knot_study(j,4)=copy_kd(k,1);
%                               positions_knot_study(j,5)=copy_kd(k,2);
%                               positions_knot_study(j,6)=copy_kd(k,3);
%                               positions_knot_study(j,7)=copy_kd(k,4);
%                            end
%                       end
%                   end
%               end
%           
%           if length(index)>0
%              copy_kd(index,:)=ones(length(index),1)*[1 1 1 1];
%           end
%        end
%      end
%      for k=1:numb_knots
%        if copy_kd(numb_knots+1-k,:)==[1 1 1 1] | copy_kd(numb_knots+1-k,4)<krit_knot_area
%            copy_kd(numb_knots+1-k,:)=[];
%            copy_kd_min_max(numb_knots+1-k,:)=[];
%        end
%      end
%  
%      if side==1
%         knot_data_up=copy_kd;
%         positions_knot_up_study=positions_knot_study;
%         knot_data_min_max_up=copy_kd_min_max;
%      elseif side==2
%         knot_data_down=copy_kd;
%         knot_data_down(:,3)=0;
%         positions_knot_down_study=positions_knot_study;
%         knot_data_min_max_down=copy_kd_min_max;
%      elseif side==3
%          knot_data_left=copy_kd;
%          knot_data_left(:,1)=0;
%          positions_knot_left_study=positions_knot_study;
%         knot_data_min_max_left=copy_kd_min_max;
%      elseif side==4
%          knot_data_right=copy_kd;
%          positions_knot_right_study=positions_knot_study;
%         knot_data_min_max_right=copy_kd_min_max;
%      end
%  end 
%  
% % -------------------------------------------------------------------------                                     
% %% Transform the positions in positions_knot to X-Y-Z coordinates. 
% 
% for side=1:4
%     if side==1
%         positions_knot_study_xyz=positions_knot_up_study;
%     elseif side==2
%         positions_knot_study_xyz=positions_knot_down_study;
%     elseif side==3
%         positions_knot_study_xyz=positions_knot_left_study;
%     elseif side==4
%         positions_knot_study_xyz=positions_knot_right_study;
%     end
%     
%     if length(positions_knot_study_xyz)==0
%         positions_knot_study_xyz=[0 0 0 0 0 0 0];
%     end
%     
%     size_pk=size(positions_knot_study_xyz);
%     for n=1:size_pk;
%         if positions_knot_study_xyz(n,7)<krit_knot_area;
%             positions_knot_study_xyz(n,:)=0;
%         end
%     end
% 
%     positions_knot_study_xyz(all(positions_knot_study_xyz==0,2),:)=[];
%     positions_knot_study_xyz(:,3)=[];
% 
%     if side==1
%         positions_knot_up_COG_study=positions_knot_study_xyz;
%     elseif side==2
%         positions_knot_down_COG_study=positions_knot_study_xyz;
% 
%     elseif side==3
%         positions_knot_left_COG_study=positions_knot_study_xyz;
% 
%     elseif side==4
%         positions_knot_right_COG_study=positions_knot_study_xyz;
%     end
% end
% 
%     positions_knot_up_COG_knot=[positions_knot_up_COG_study(:,2) positions_knot_up_COG_study(:,1) positions_knot_up_COG_study(:,5) positions_knot_up_COG_study(:,3) positions_knot_up_COG_study(:,4) positions_knot_up_COG_study(:,5) positions_knot_up_COG_study(:,6)];
%     positions_knot_down_COG_knot=[positions_knot_down_COG_study(:,2) positions_knot_down_COG_study(:,1) positions_knot_down_COG_study(:,5) positions_knot_down_COG_study(:,3) positions_knot_down_COG_study(:,4) positions_knot_down_COG_study(:,5) positions_knot_down_COG_study(:,6)];
%     positions_knot_left_COG_knot=[positions_knot_left_COG_study(:,3) positions_knot_left_COG_study(:,1) positions_knot_left_COG_study(:,2) positions_knot_left_COG_study(:,3) positions_knot_left_COG_study(:,4) positions_knot_left_COG_study(:,5) positions_knot_left_COG_study(:,6)];
%     positions_knot_right_COG_knot=[positions_knot_right_COG_study(:,3) positions_knot_right_COG_study(:,1) positions_knot_right_COG_study(:,2) positions_knot_right_COG_study(:,3) positions_knot_right_COG_study(:,4) positions_knot_right_COG_study(:,5) positions_knot_right_COG_study(:,6)];
% 
% 
% 
% for side=1:2;
%     if side==1;
%         positions_knot_COG_knot=positions_knot_up_COG_knot;
%         X=X_UP;
%         Y=Y_UP;
%     elseif side==2
%         positions_knot_COG_knot=positions_knot_down_COG_knot;
%         X=X_DOWN;
%         Y=Y_DOWN;
%     end
%     
%     size_X=size(X);
%     size_Y=size(Y);
%     size_pk=size(positions_knot_COG_knot);
% 
%     for i=1:size_pk(1,1);
%         for j=1:size_X(1,1)
%             if positions_knot_COG_knot(i,1)==j
%                 positions_knot_COG_knot(i,1)=X(j,1);
%             end
%         end
%     end
% 
%     for i=1:size_pk(1,1);
%         for j=1:size_Y(1,1)
%             if positions_knot_COG_knot(i,2)==j
%                 positions_knot_COG_knot(i,2)=Y(j,1);
%             end
%         end
%     end
%     if side==1
%         positions_knot_XYZ_COG_knot_up=positions_knot_COG_knot;
%     elseif side==2
%         positions_knot_XYZ_COG_knot_down=positions_knot_COG_knot;
%         positions_knot_XYZ_COG_knot_down(:,3)=0;
%         positions_knot_XYZ_COG_knot_down(:,6)=0;
%         
%     end
% end
% 
% for side=3:4;
%     if side==3;
%         positions_knot_COG_knot=positions_knot_left_COG_knot;
%         Y=Y_LEFT;
%         Z=Z_LEFT;
%     elseif side==4
%         positions_knot_COG_knot=positions_knot_right_COG_knot;
%         Y=Y_RIGHT;
%         Z=Z_RIGHT;
%     end
%     
%     size_Y=size(Y);
%     size_Z=size(Z);
%     size_pk=size(positions_knot_COG_knot);
% 
%     for i=1:size_pk(1,1);
%         for j=1:size_Y(1,1)
%             if positions_knot_COG_knot(i,2)==j
%                 positions_knot_COG_knot(i,2)=Y(j,1);
%             end
%         end
%     end
% 
%     for i=1:size_pk(1,1);
%         for j=1:size_Z(1,1)
%             if positions_knot_COG_knot(i,3)==j
%                 positions_knot_COG_knot(i,3)=Z(j,1);
%             end
%         end
%     end
%     if side==3
%         positions_knot_XYZ_COG_knot_left=positions_knot_COG_knot;
%         positions_knot_XYZ_COG_knot_left(:,1)=0;
%         positions_knot_XYZ_COG_knot_left(:,4)=0;
%     elseif side==4
%         positions_knot_XYZ_COG_knot_right=positions_knot_COG_knot;
%     end
% end      
      