   
   correct_cd_300
   do_show=0;
   
   path_and_file=sprintf('%s\\%s\\%s\\%s',dir_WoodEye_project,DIRstr,'D_raw','RedDown.raw')
   [im_RedDown header_RedDown]=IvRawRead_AO(path_and_file,do_show);
   path_and_file=sprintf('%s\\%s\\%s\\%s',dir_WoodEye_project,DIRstr,'D_raw','RedUp.raw')
   [im_RedUp header_RedUp]=IvRawRead_AO(path_and_file,do_show);
   path_and_file=sprintf('%s\\%s\\%s\\%s',dir_WoodEye_project,DIRstr,'D_raw','RedLeft.raw')
   [im_RedLeft header_RedLeft]=IvRawRead_AO(path_and_file,do_show);
   path_and_file=sprintf('%s\\%s\\%s\\%s',dir_WoodEye_project,DIRstr,'D_raw','RedRight.raw')
   [im_RedRight header_RedRight]=IvRawRead_AO(path_and_file,do_show);
   
   for side=1:4
       if side==1
           im_RedSide=double(im_RedUp);
       elseif side==2
           im_RedSide=double(im_RedDown);
       elseif side==3
           im_RedSide=double(im_RedLeft);
       elseif side==4
           im_RedSide=double(im_RedRight);
       end     
       %rel_pos_indicator=im_double_RedSide(13,:)'+im_double_RedSide(14,:)'*256+im_double_RedSide(15,:)'*256^2+im_double_RedSide(16,:)'*256^3;
       rel_pos_indicator=im_RedSide(13,:)'+im_RedSide(14,:)'*256+im_RedSide(15,:)'*256^2+im_RedSide(16,:)'*256^3;
       
%        aaa=333
%        pause

       [r,k]=size(im_RedSide);
       mim=mean(im_RedSide');
       rmim=-sort(-mim);
       type_level=rmim(round(0.02*length(rmim)));
       [a1,erase_rows]=find(mim<type_level*0.75);
       im_RedSide(erase_rows,:)=[];
       
       nin=mean(im_RedSide);
       rnin=-sort(-nin);
       type_level=rnin(round(0.02*length(rnin)));
       [a1,erase_cols]=find(nin<type_level*0.75);
       lec=length(erase_cols);
       for a=1:lec
           if erase_cols(lec+1-a)<length(nin)*0.99
               if erase_cols(lec+1-a)>length(nin)*0.01
                   erase_cols(lec+1-a)=[];
               end
           end
       end
       im_RedSide(:,erase_cols)=[];
       rel_pos_indicator(erase_cols)=[];
       
       if side==1
           im_RedUp=im_RedSide;
           rel_pos_indicator_Up=rel_pos_indicator;
       elseif side==2
           im_RedDown=im_RedSide;
           rel_pos_indicator_Down=rel_pos_indicator;
       elseif side==3
           im_RedLeft=im_RedSide;
           rel_pos_indicator_Left=rel_pos_indicator;
       elseif side==4
           im_RedRight=im_RedSide;
           rel_pos_indicator_Right=rel_pos_indicator;
       end     
   end
   
   %--------------------------------------
   % Change orientation and flip left-right in the sam way as is done for
   % the fibre orientation files.
   [nr,nk]=size(im_RedUp);
   im_RedUp=(im_RedUp(nr+1-[1:nr],:))';
   
   [nr,nk]=size(im_RedRight);
   im_RedRight=(im_RedRight(nr+1-[1:nr],:))';
   im_RedDown=im_RedDown';
   im_RedLeft=im_RedLeft';
   im_Redtemp=im_RedRight;
   rel_pos_indicator_temp=rel_pos_indicator_Right;
   im_RedRight=im_RedLeft;
   rel_pos_indicator_Right=rel_pos_indicator_Left;
   im_RedLeft=im_Redtemp;
   rel_pos_indicator_Left=rel_pos_indicator_temp;

 %-------------------

   for side=1:4
        if side==1
           im_RedSide=im_RedUp;
           [nk,nr]=size(im_RedSide);
           X_raw=((0:nr-1)/(nr-1)*H)'*1000; 
           %Y_raw=(rel_pos_indicator_Up-rel_pos_indicator_Up(1))*L/rel_pos_indicator_Up(length(rel_pos_indicator_Up))*1000; 
           Y_raw=(rel_pos_indicator_Up)*L/rel_pos_indicator_Up(length(rel_pos_indicator_Up))*1000; 
       elseif side==2
           im_RedSide=im_RedDown;
           [nk,nr]=size(im_RedSide);
           X_raw=((0:nr-1)/(nr-1)*H)'*1000; 
           %Y_raw=(rel_pos_indicator_Down-rel_pos_indicator_Down(1))*L/rel_pos_indicator_Down(length(rel_pos_indicator_Down))*1000; 
           Y_raw=(rel_pos_indicator_Down)*L/rel_pos_indicator_Down(length(rel_pos_indicator_Down))*1000; 
        elseif side==3
           im_RedSide=im_RedLeft;
           [nk,nr]=size(im_RedSide);
           X_raw=((0:nr-1)/(nr-1)*B)'*1000; 
           %Y_raw=(rel_pos_indicator_Left-rel_pos_indicator_Left(1))*L/rel_pos_indicator_Left(length(rel_pos_indicator_Left))*1000; 
           Y_raw=(rel_pos_indicator_Left)*L/rel_pos_indicator_Left(length(rel_pos_indicator_Left))*1000; 
      elseif side==4
           im_RedSide=im_RedRight;
           [nk,nr]=size(im_RedSide);
           X_raw=((0:nr-1)/(nr-1)*B)'*1000; 
           %Y_raw=(rel_pos_indicator_Right-rel_pos_indicator_Right(1))*L/rel_pos_indicator_Right(length(rel_pos_indicator_Right))*1000; 
           Y_raw=(rel_pos_indicator_Right)*L/rel_pos_indicator_Right(length(rel_pos_indicator_Right))*1000; 
       end
       im_RedSide_red=double(im_RedSide(1:skipp_along:nk,1:skipp_across:nr));
       %im_RedSide_red=(im_RedSide(1:skipp_along:nk,1:skipp_across:nr));
       X_raw=X_raw(1:skipp_across:nr);
       Y_raw=Y_raw(1:skipp_along:nk);
       [nk,nr]=size(im_RedSide_red);
%        im_AllSide_red=zeros(nk,nr,3);
%        im_AllSide_red(:,:,1)=(im_RedSide_red+1)/256;
%        im_AllSide_red(:,:,2)=(im_GreenSide_red+1)/256;
%        im_AllSide_red(:,:,3)=(im_BlueSide_red+1)/256;
       
%        im_AllSide_photo_ind=(im_AllSide_red(:,:,1)+im_AllSide_red(:,:,2)+im_AllSide_red(:,:,3))*100/3;
%        [m,n]=size(im_AllSide_photo_ind);
%        mn=m*n;
%        im_AllSide_photo_ind_vector=sort(reshape(im_AllSide_photo_ind,mn,1));
%        treshold_AllSide_dark=im_AllSide_photo_ind_vector(round(treshold_dark_percent*mn));
%        mark_Side_dark=ceil(-(im_AllSide_photo_ind-treshold_AllSide_dark)/100);

       movavr_m_RedSide=(median(im_RedSide'))';
       lm=length(movavr_m_RedSide);
       movavr_mm_RedSide=zeros(length(movavr_m_RedSide),1);
       movavr_mm_RedSide(1:300)=median(movavr_m_RedSide(1:300));  
       movavr_mm_RedSide((lm-299):lm)=median(movavr_m_RedSide((lm-299):lm));  
       for i=301:(lm-300)
           movavr_mm_RedSide(i)=median(movavr_m_RedSide((i-300):(i+299)));
       end
       movavr_mm_RedSide_red=movavr_mm_RedSide(1:skipp_along:length(movavr_mm_RedSide));
       
       [lm,lk]=size(im_RedSide_red);
       %mark_Side_dark_WE=ceil(-(im_RedSide_red-movavr_mm_RedSide_red*ones(1,lk)*730/1024)/300);
       mark_Side_dark_WE=ceil(-(im_RedSide_red-movavr_mm_RedSide_red*ones(1,lk)*BrownTresh/1024)/300);
       mark_Side_very_dark_WE=ceil(-(im_RedSide_red-movavr_mm_RedSide_red*ones(1,lk)*BlackTresh/1024)/300); % OBS
       %----------
       
       
       if cancel_black_edges>0
           
           cols_adjust_left=find(X_raw-cancel_black_edges-abs(X_raw-cancel_black_edges));
           if side<3
                cols_adjust_right=find(H*1000-(X_raw)-cancel_black_edges-abs(H*1000-(X_raw)-cancel_black_edges));
           else
                cols_adjust_right=find(B*1000-(X_raw)-cancel_black_edges-abs(B*1000-(X_raw)-cancel_black_edges));
           end
           rows_adjust_bottom=find(Y_raw-cancel_black_edges-abs(Y_raw-cancel_black_edges));
           rows_adjust_top=find(L*1000-(Y_raw)-cancel_black_edges-abs(L*1000-(Y_raw)-cancel_black_edges));
           
           if length(cols_adjust_left)>0
               cols_adjust_left_to_use=max(cols_adjust_left)+1;
               for c=1:length(cols_adjust_left)
                  %[aaa,bbb]=find(mark_Side_dark_WE(:,cols_adjust_left(c)));
                  [aaa,bbb]=find(mark_Side_very_dark_WE(:,cols_adjust_left(c)));
                  im_RedSide_red(aaa,cols_adjust_left(c))=im_RedSide_red(aaa,cols_adjust_left_to_use);
               end
           end
           if length(cols_adjust_right)>0
               cols_adjust_right_to_use=min(cols_adjust_right)-1;
               for c=1:length(cols_adjust_right)
                  %[aaa,bbb]=find(mark_Side_dark_WE(:,cols_adjust_right(c)));
                  [aaa,bbb]=find(mark_Side_very_dark_WE(:,cols_adjust_right(c)));
                  im_RedSide_red(aaa,cols_adjust_right(c))=im_RedSide_red(aaa,cols_adjust_right_to_use);
               end
           end
           if length(rows_adjust_bottom)>0
               rows_adjust_bottom_to_use=max(rows_adjust_bottom)+1;
               for c=1:length(rows_adjust_bottom)
                  %[aaa,bbb]=find(mark_Side_dark_WE(rows_adjust_bottom(c),:));
                  [aaa,bbb]=find(mark_Side_very_dark_WE(rows_adjust_bottom(c),:));
                  im_RedSide_red(rows_adjust_bottom(c),aaa)=im_RedSide_red(rows_adjust_bottom_to_use,aaa);
               end
           end
           if length(rows_adjust_top)>0
               rows_adjust_top_to_use=min(rows_adjust_top)-1;
               for c=1:length(rows_adjust_top)
                  %[aaa,bbb]=find(mark_Side_dark_WE(rows_adjust_top(c),:));
                  [aaa,bbb]=find(mark_Side_very_dark_WE(rows_adjust_top(c),:));
                  im_RedSide_red(rows_adjust_top(c),aaa)=im_RedSide_red(rows_adjust_top_to_use,aaa);
               end
           end
           mark_Side_dark_WE=ceil(-(im_RedSide_red-movavr_mm_RedSide_red*ones(1,lk)*BrownTresh/1024)/300);
           %mark_Side_very_dark_WE=ceil(-(im_RedSide_red-movavr_mm_RedSide_red*ones(1,lk)*BrownTresh/2/1024)/300);
           %mark_Side_dark_WE=ceil((mark_Side_dark_WE+mark_Side_very_dark_WE)/10);
       end
           
           
% % %        if cancel_black_edges(2)>0
% % % %            if side==1
% % % %                figure(9)
% % % %                clf
% % % %                hold on
% % % %                colormap('gray')
% % % %                aa=surf(ones(length(Y_raw),1)*X_raw',Y_raw*ones(1,length(X_raw)),im_RedSide_red*0-1,im_RedSide_red);
% % % %                set(aa,'edgecolor','none','facecolor','interp')
% % % %                axis equal
% % % %            end
% % % 
% % % %            cols_adjust_left_1=cols_adjust_left;
% % % %            cols_adjust_right_1=cols_adjust_right;
% % % %            rows_adjust_top_1=rows_adjust_top;
% % % %            rows_adjust_bottom_1=rows_adjust_bottom;
% % % 
% % % 
% % %            cols_adjust_left=find(X_raw-cancel_black_edges-abs(X_raw-cancel_black_edges));
% % %            
% % %            if side<3
% % %                 cols_adjust_right=-sort(-(find(H*1000-(X_raw)-cancel_black_edges-abs(H*1000-(X_raw)-cancel_black_edges))));
% % %            else
% % %                 cols_adjust_right=-sort(-(find(B*1000-(X_raw)-cancel_black_edges-abs(B*1000-(X_raw)-cancel_black_edges))));
% % %            end
% % %            rows_adjust_bottom=find(Y_raw-cancel_black_edges-abs(Y_raw-cancel_black_edges));
% % %            rows_adjust_top=-sort(-(find(L*1000-(Y_raw)-cancel_black_edges-abs(L*1000-(Y_raw)-cancel_black_edges))));
% % % 
% % %            [nr,nk]=size(mark_Side_dark_WE);
% % % 
% % %            if length(cols_adjust_left)>0
% % %                cols_adjust_left_to_use=max(cols_adjust_left)+1;
% % %                prev_cols=ones(nr,1);
% % %                for c=1:length(cols_adjust_left)
% % %                   for cc=(1:(c-1))
% % %                       prev_cols=prev_cols.*mark_Side_dark_WE(:,cols_adjust_left(cc));
% % %                   end
% % %                   [aaa,bbb]=find(prev_cols.*(mark_Side_dark_WE(:,cols_adjust_left(c))));
% % %                   im_RedSide_red(aaa,cols_adjust_left(c))=im_RedSide_red(aaa,cols_adjust_left_to_use);
% % %                end
% % %            end
% % %            
% % % %            if side==1
% % % %                figure(10)
% % % %                clf
% % % %                hold on
% % % %                colormap('gray')
% % % %                aa=surf(ones(length(Y_raw),1)*X_raw',Y_raw*ones(1,length(X_raw)),im_RedSide_red*0-1,im_RedSide_red);
% % % %                set(aa,'edgecolor','none','facecolor','interp')
% % % %                axis equal
% % % % 
% % % %                eee=444
% % % %                pause
% % % %            end
% % %            
% % %            if length(cols_adjust_right)>0
% % %                cols_adjust_right_to_use=min(cols_adjust_right)-1;
% % %                prev_cols=ones(nr,1); 
% % %                for c=1:length(cols_adjust_right)
% % %                   for cc=(1:(c-1))
% % %                       prev_cols=prev_cols.*mark_Side_dark_WE(:,cols_adjust_right(cc));
% % %                   end
% % %                   [aaa,bbb]=find(prev_cols.*(mark_Side_dark_WE(:,cols_adjust_right(c))));
% % %                   im_RedSide_red(aaa,cols_adjust_right(c))=im_RedSide_red(aaa,cols_adjust_right_to_use);
% % %                end
% % %            end
% % %            if length(rows_adjust_bottom)>0
% % %                rows_adjust_bottom_to_use=max(rows_adjust_bottom)+1;
% % %                prev_rows=ones(1,nk);  
% % %                for c=1:length(rows_adjust_bottom)
% % %                   for cc=(1:(c-1))
% % %                       prev_rows=prev_rows.*mark_Side_dark_WE(rows_adjust_bottom(cc),:);
% % %                   end
% % %                   [aaa,bbb]=find(prev_rows.*(mark_Side_dark_WE(rows_adjust_bottom(c),:)));
% % %                   im_RedSide_red(rows_adjust_bottom(c),bbb)=im_RedSide_red(rows_adjust_bottom_to_use,bbb);
% % %                end
% % %            end
% % %            if length(rows_adjust_top)>0
% % %                rows_adjust_top_to_use=min(rows_adjust_top)-1;
% % %                prev_rows=ones(1,nk);  
% % %                for c=1:length(rows_adjust_top)
% % %                   for cc=(1:(c-1))
% % %                       prev_rows=prev_rows.*mark_Side_dark_WE(rows_adjust_bottom(cc),:);
% % %                   end
% % %                   [aaa,bbb]=find(mark_Side_dark_WE(rows_adjust_top(c),:));
% % %                   im_RedSide_red(rows_adjust_top(c),bbb)=im_RedSide_red(rows_adjust_top_to_use,bbb);
% % %                end
% % %            end
% % %            mark_Side_dark_WE=ceil(-(im_RedSide_red-movavr_mm_RedSide_red*ones(1,lk)*BrownTresh/1024)/300);
% % %        end


       %----------
       %----------
       
       if side==1
           im_RedUp_red=(im_RedSide_red+1)/256;
           mark_Up_dark_WE=mark_Side_dark_WE;
           X_raw_Up=X_raw;
           Y_raw_Up=double(Y_raw);
       elseif side==2
           %mark_Down_dark=mark_Side_dark;
           im_RedDown_red=(im_RedSide_red+1)/256;
           mark_Down_dark_WE=mark_Side_dark_WE;
           X_raw_Down=X_raw;
           Y_raw_Down=double(Y_raw);
       elseif side==3
           %mark_Left_dark=mark_Side_dark;
           im_RedLeft_red=(im_RedSide_red+1)/256;
           mark_Left_dark_WE=mark_Side_dark_WE;
           X_raw_Left=X_raw;
           Y_raw_Left=double(Y_raw);
       elseif side==4
           %mark_Right_dark=mark_Side_dark;
           im_RedRight_red=(im_RedSide_red+1)/256;
           mark_Right_dark_WE=mark_Side_dark_WE;
           X_raw_Right=X_raw;
           Y_raw_Right=double(Y_raw);
       end
   end
   
   max_Y_diff(board)=abs(max([max(Y_raw_Up)-max(Y_raw_Down) max(Y_raw_Up)-max(Y_raw_Left) max(Y_raw_Up)-max(Y_raw_Right)]));
   
   max_Y_diff_this_board=max_Y_diff(board)
   