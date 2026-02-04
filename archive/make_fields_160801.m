function [mark_field,field_rect_limits,Side_X_conv_hull,Side_Y_conv_hull,Side_A_conv_hull]=make_fields_160405(X_SIDE,Y_SIDE,mark_knot,trans_marg_fi_knot_surf,long_marg_fi_knot_surf)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%      mark_knot_test=mark_knot;
%      [nr,nk]=size(mark_knot_test);
%      mark_knot_test(1,1)=0;
%      mark_knot_test(nr,1)=0;
%      mark_knot_test(1,nk)=0;
%      mark_knot_test(nr,nk)=0;
%      if sum(sum(mark_knot_test))>0
    if sum(sum(mark_knot))>0
%          figure(100)
%          clf
%          hold on

         type_rf=2;
         if type_rf==1
            CM=contour(X_SIDE,Y_SIDE,mark_knot,1,'r');
         elseif type_rf==2      % Nytt alternativ, behövs vid genomgående kvist, fixat 2016-10-28 
            X_SIDE_marg=[2*X_SIDE(1)-X_SIDE(2); X_SIDE; X_SIDE(length(X_SIDE))*2-X_SIDE(length(X_SIDE)-1)];
            Y_SIDE_marg=[2*Y_SIDE(1)-Y_SIDE(2); Y_SIDE; Y_SIDE(length(Y_SIDE))*2-Y_SIDE(length(Y_SIDE)-1)];
            mark_knot_marg=zeros(length(Y_SIDE_marg),length(X_SIDE_marg));
            mark_knot_marg([2:(length(Y_SIDE)+1)],[2:(length(X_SIDE)+1)])=mark_knot;
%             X_SIDE
%             X_SIDE_marg
            CM=contour(X_SIDE_marg,Y_SIDE_marg,mark_knot_marg,1,'r');
         end


         [two,kk]=size(CM);
         CM_mark=zeros(two,kk);
         f=0;
         for k=1:kk
            if CM(1,k)==0.5 & CM(2,k)==round(CM(2,k))
                CM_mark(1,k)=1;
                f=f+1;
                CM_mark(2,k)=f;
            end
         end

         start_pos_in_CM=(find(CM_mark(1,:))+1)';
         end_pos_in_CM=([start_pos_in_CM(2:length(start_pos_in_CM))-2; kk]);
         n_fields=length(start_pos_in_CM);
         A_CM=zeros(n_fields,5);
         temp_A=zeros(n_fields,1);
         knot_data_min_max_side_no_marg=zeros(n_fields,4);
         for k=1:n_fields
             temp_A(k)=polyarea(CM(1,start_pos_in_CM(k):end_pos_in_CM(k)),CM(2,start_pos_in_CM(k):end_pos_in_CM(k)));
             A_CM(k,4)=temp_A(k);
             [centroid, area] = polygonCentroid([CM(1,start_pos_in_CM(k):end_pos_in_CM(k)); CM(2,start_pos_in_CM(k):end_pos_in_CM(k))]');
             knot_data_min_max_side_no_marg(k,:)=[min(CM(1,start_pos_in_CM(k):end_pos_in_CM(k))) max(CM(1,start_pos_in_CM(k):end_pos_in_CM(k))) min(CM(2,start_pos_in_CM(k):end_pos_in_CM(k))) max(CM(2,start_pos_in_CM(k):end_pos_in_CM(k)))];
              A_CM(k,1:3)=[-area centroid];
         end
         for k1=1:n_fields
             in=0;
             for k2=1:n_fields
                if k1==k2
                else
                    in=inpolygon(A_CM(k1,2),A_CM(k1,3),CM(1,start_pos_in_CM(k2):end_pos_in_CM(k2)),CM(2,start_pos_in_CM(k2):end_pos_in_CM(k2)));
                    if in==1
                        if A_CM(k1,4)<A_CM(k2,4)  % OBS nytt 2016-07-27
                            A_CM(k1,5)=1;
                        end
                    end
                end
             end
         end
         
         aa=find(A_CM(:,5));
    %      plot(A_CM(:,2),A_CM(:,3),'b+')
    %      plot(A_CM(aa,2),A_CM(aa,3),'g+')
    %      axis equal
         A_CM(:,[1 5])=[];
         A_CM(aa,:)=[];
         knot_data_min_max_side_no_marg(aa,:)=[];
         [a,b]=sort(A_CM(:,1),'descend');

        %%%%%%%


        %%%%%%%
           Area_CM=zeros(n_fields,1);
           for k=1:n_fields
               Area_CM(k,1)=temp_A(k); %%polyarea(CM(1,start_pos_in_CM(k):end_pos_in_CM(k)),CM(2,start_pos_in_CM(k):end_pos_in_CM(k)));
           end
            %        Area_CM
            %        aaa=333
            %        pause

           lf=length(Area_CM);
           %[A,nbr]=max(Area_CM);
           %if A>5  % OBS !!!!!!!!!!!!!!!

           %clear Side_X_conv_hull Side_Y_conv_hull Side_A_conv_hull 
           Side_X_conv_hull=-ones(lf,1000)*1e6;
           Side_Y_conv_hull=-ones(lf,1000)*1e6;
           Side_A_conv_hull=-ones(lf,1)*1e6;

           for f=1:lf
               CM_se=CM(:,start_pos_in_CM(f):end_pos_in_CM(f));
               this_Area=Area_CM(f);
               save temp_CM CM_se this_Area
%                if this_Area<5
%                    CM(:,start_pos_in_CM(f):end_pos_in_CM(f))
%                    pause
%                end
               if this_Area>1e-6
                   [K,A_conv_hull]=convhull(CM(1,start_pos_in_CM(f):end_pos_in_CM(f)),CM(2,start_pos_in_CM(f):end_pos_in_CM(f)));
                   Side_X_conv_hull(f,1:length(K))=CM(1,start_pos_in_CM(f)-1+K);
                   Side_Y_conv_hull(f,1:length(K))=CM(2,start_pos_in_CM(f)-1+K);
                   Side_A_conv_hull(f,1)=A_conv_hull;
               end
           end

         %%%%%%%
         Side_X_conv_hull(aa,:)=[];
         Side_Y_conv_hull(aa,:)=[];
         Side_A_conv_hull(aa,:)=[];
         Side_X_conv_hull=Side_X_conv_hull(b,:);
         Side_Y_conv_hull=Side_Y_conv_hull(b,:);
         Side_A_conv_hull=Side_A_conv_hull(b,:);
         %%%%%%%

         fibre_fields_cXcYA=A_CM(b,:);
         knot_data_min_max_side_no_marg=knot_data_min_max_side_no_marg(b,:); % OBS

         [pos_reject]=find((Side_X_conv_hull(:,1)+1000)-abs((Side_X_conv_hull(:,1))+1000));
         Side_X_conv_hull(pos_reject,:)=[];
         Side_Y_conv_hull(pos_reject,:)=[];
         Side_A_conv_hull(pos_reject,:)=[];
         fibre_fields_cXcYA(pos_reject,:)=[];               % Problemet är att 
         knot_data_min_max_side_no_marg(pos_reject,:)=[];
         %%%%%%%
         
         
         [la,b]=size(knot_data_min_max_side_no_marg);
         fibre_fields_min_max_side=knot_data_min_max_side_no_marg+ones(la,1)*[-trans_marg_fi_knot_surf  trans_marg_fi_knot_surf  -long_marg_fi_knot_surf  long_marg_fi_knot_surf];
         change=1;
         c=0;

         while change==1
             remove_ind=zeros(la,2);
             change=0;
             c=c+1;
             for k=1:la
                for kk=1:la
                    if k==kk
                    elseif fibre_fields_cXcYA(k,1)>fibre_fields_min_max_side(kk,1) & fibre_fields_cXcYA(k,1)<fibre_fields_min_max_side(kk,2) & fibre_fields_cXcYA(k,2)>fibre_fields_min_max_side(kk,3) & fibre_fields_cXcYA(k,2)<fibre_fields_min_max_side(kk,4) & fibre_fields_cXcYA(k,3)<fibre_fields_cXcYA(kk,3)
                        remove_ind(k,:)=[k kk];
                        fibre_fields_min_max_side(kk,:)=[min([fibre_fields_min_max_side(kk,1) fibre_fields_min_max_side(k,1)]) ...
                                                                 max([fibre_fields_min_max_side(kk,2) fibre_fields_min_max_side(k,2)]) ...
                                                                 min([fibre_fields_min_max_side(kk,3) fibre_fields_min_max_side(k,3)]) ...
                                                                 max([fibre_fields_min_max_side(kk,4) fibre_fields_min_max_side(k,4)])];
                        if c<10
                           change=1;
                        end
                    end
                end
             end
             %fibre_fields_min_max_side=fibre_fields_min_max_side_updated;
             fibre_fields_min_max_side(find(remove_ind(:,1)),:)=[];
             fibre_fields_cXcYA(find(remove_ind(:,1)),:)=[];
             %%%%%
             Side_X_conv_hull(find(remove_ind(:,1)),:)=[];
             Side_Y_conv_hull(find(remove_ind(:,1)),:)=[];
             Side_A_conv_hull(find(remove_ind(:,1)),:)=[];
             %%%%%
             [la,f]=size(fibre_fields_min_max_side);
         end

         mark_field=fibre_fields_cXcYA;
         field_rect_limits=fibre_fields_min_max_side;
     else
         mark_field=[];
         field_rect_limits=[];
         Side_X_conv_hull=[];
         Side_Y_conv_hull=[];
         Side_A_conv_hull=0;
     end
     
end

