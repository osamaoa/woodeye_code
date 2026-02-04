function [x_vec,y_vec,fi,r]=sdfix_A(L,W,use_relative_X,adjust_par_xy_side,x,y,fi,r)
%--------------------------------------------------------------------
%
% LAST MODIFIED: A Olsson    2015-01-06
% Copyright (c)  Building technology,
%                Faculty of Technology,
%                Linnaeus University
%-------------------------------------------------------------
%    PURPOSE
%    Calculate interpolated values of any parameter in specified position in two dimensions
%
%    INPUT:  L                  Known lencht of board being scanned
%            W                  Known width of the side of the board being
%                               considered
%
%            use_relative_X     use_relative_X==1 corresponds to Woodeye files
%                               PosXrelative being used. It is then assumed
%                               that x-coordinates of the input file can be
%                               trusted regarding the distance to the edge (unless
%                               an adjustment value is given in the first row of adjust_par_xy_side).
%                               If another value is assigned to use_relative_X the file
%                               PosX from the scanning can used instedad and
%                               it is assumed that the board is centred in
%                               the scanning.
%
%           adjust_par_xy_side  this is a matrix of size 2x1. The first row contains a value [mm] to be added
%                               to the x-coordinates of a file from WoodEye
%                               (UP, DOWN, LEFT or RIGHT) and the
%                               second row contains a value [mm] to be added
%                               to the y-coordinates of a file from WoodEye
%                               (UP, DOWN, LEFT or RIGHT).
%                               
%            x                  File from scanner (PosXrelative or PosX) giving raw data regarding x-coordinates (matrix)
%            y                  File from scanner (PosY) giving raw data regarding y-coordinates (matrix)
%            fi                 File from scanner giving raw data regarding fibre angles in the scanned plane (matrix)
%            r                  File from scanner giving raw data regarding the ratios indicating the diving angles (matrix)
%            Eval_in            parameter values valid for the coordinates (matrix)
%                               given by X_in and Y_in
%
%    OUTPUT: x_vec              adjusted vector x
%            y_vec              adjusted vector y
%            fi                 adjusted matrix fi
%            r                  adjusted matrix r
%                               
%--------------------------------------------------------------------

[nr,nk]=size(x);
dx=x(:,2:nk)-x(:,1:(nk-1));
[ih,jh,valh]=find(dx>4000);
Sh=sparse(ih,jh,valh,nr,nk-1);
[il,jl,vall]=find(dx<5000);
Sl=sparse(il,jl,vall,nr,nk-1);
[i,j,val]=find(Sl.*Sh.*dx);
dx_valid_1=mean(val);
dx_typical=4500;
test_x_1=round((x(:,2:nk)-x(:,1:(nk-1)))/dx_valid_1);
test_x_2=[round((x(:,1)-median(x(:,1)))/dx_valid_1)+1 test_x_1];
test_x_2=(abs(test_x_2)+test_x_2)/2;

nk_new=max(sum(abs(test_x_2')+test_x_2')/2);

if round(dx_valid_1/dx_typical)==1
else
    disp('problem in sdfix_AAA')
    return
    dx_valid_1=dx_typical;
end
x_new=ones(nr,1)*[0:(nk_new-1)]*dx_valid_1+median(x(:,1));

y_new=y(:,1)*ones(1,nk_new);
fi_new=zeros(nr,nk_new);
fi_new=zeros(nr,nk_new);
if nargin==8
   r_new=zeros(nr,nk_new);
end

for row=1:nr
    if test_x_2(row,1)==0
        test_x_2(row,1)=1;
    end
    pp=[];
    for k=1:nk
        if k==1
            p=test_x_2(row,k);
        elseif k>0
            p=(sum(test_x_2(row,1:(k-1)))+1:sum(test_x_2(row,1:k)));
        end
%         [row k]

%             if max(p)==33
%                aaa=444
%                 pause
%             end

%         p
        fi_new(row,p)=fi(row,k);
        if length(p)==0
            fi_new(row,(max(pp)+1):nk_new)=fi_new(row,max(pp));
        end
        if nargin==8
            r_new(row,p)=r(row,k);
            if length(p)==0
                r_new(row,(max(pp)+1):nk_new)=r_new(row,max(pp));
            end
        end        
        pp=p;
    end
end
fi_new(:,1)=fi(:,1);

[nrfi,ncfi]=size(fi_new);
[nrx,ncx]=size(x_new);
if ncfi>ncx
    fi_new(:,(ncx+1):ncfi)=[];
    if nargin==8
        r_new(:,(ncx+1):ncfi)=[];
    end
end

        % continue to make the output from sdfix_AAA comparable with the one from
        % sdfix_AA (0:L, 0:H ...)

x=x_new/1e6;
y=y_new/1e6;
fi=fi_new;
if nargin==8
   r=r_new;
end

% %x
% min(min(x))
% max(max(x))
% min(min(y))
% max(max(y))
% %y
% pause

x=x+adjust_par_xy_side(1)/1000;
y=y+adjust_par_xy_side(2)/1000;

x_vec=x(1,:);
y_vec=y(:,1);

[waste_rows_low,val]=find(y_vec-abs(y_vec));
[waste_rows_high,val]=find((y_vec-L)+abs(y_vec-L));
   
[val,waste_cols_low]=find(x_vec-abs(x_vec));
[val,waste_cols_high]=find((x_vec-W)+abs(x_vec-W));
   
waste_rows=[waste_rows_low; waste_rows_high];
waste_cols=[waste_cols_low; waste_cols_high];
   
x(waste_rows,:)=[];
x(:,waste_cols)=[];
y(waste_rows,:)=[];
y(:,waste_cols)=[];
fi(waste_rows,:)=[];
fi(:,waste_cols)=[];
if nargin==8
    r(waste_rows,:)=[];
    r(:,waste_cols)=[];
end

[tny,tnx]=size(x);

x=[0 x(1,:) W; zeros(tny,1) x  ones(tny,1)*W; 0 x(tny,:) W];
y=[zeros(1,tnx+2); y(:,1) y  y(:,tnx); ones(1,tnx+2)*L];
fi=[fi(1,1) fi(1,:) fi(1,tnx); fi(:,1) fi  fi(:,tnx); fi(tny,1) fi(tny,:) fi(tny,tnx)];
if nargin==8
    r=[r(1,1) r(1,:) r(1,tnx); r(:,1) r  r(:,tnx); r(tny,1) r(tny,:) r(tny,tnx)];
end

x_vec=x(1,:);
y_vec=y(:,1);


% test_x_2
% W
% pause



% % % %---------------------------------------------------------------------
% % % 
% % % 
% % % 
% % % 
% % % x=x+adjust_par_xy_side(1)*1000*(abs((x-abs(x))/(-2)-1));
% % % y=y+adjust_par_xy_side(2)*1000*(abs((y-abs(y))/(-2)-1));
% % % 
% % %     [itny,itnx]=size(x);
% % %     
% % %     [itny,itnx]=size(x);
% % %     spy_x=(x-abs(x))/(-2);
% % %     spy_y=(y-abs(y))/(-2);
% % % 
% % %     crit_proc=99;   % Borde nog vara indata parameter till funktion...
% % %     crit_cols=round(sum(spy_y)/itny+(0.50-crit_proc/100));    %en kolumn som saknar mer är crit_proc% av värdena tas bort
% % %     crit_rows=round(sum(spy_x')/itnx+(0.50-crit_proc/100));   %en rad som saknar mer är crit_proc% av värdena tas bort
% % %     
% % % %     spy_y
% % % %     size(spy_y)
% % % %     find(crit_cols)
% % % %     find(crit_rows)
% % % %     sum(spy_y)/itny
% % % %     sum(spy_x')/itnx
% % %     
% % %     for k=1:itnx
% % %         kk=itnx-k+1;
% % %         if crit_cols(kk)==1
% % %             x(:,kk)=[];
% % %             y(:,kk)=[];
% % %             fi(:,kk)=[];
% % %             if nargin==8
% % %                 r(:,kk)=[];
% % %             end
% % %             spy_x(:,kk)=[];
% % %             spy_y(:,kk)=[];
% % %         end
% % %     end
% % %     for k=1:itny
% % %         kk=itny-k+1;
% % %         if crit_rows(kk)==1
% % %             x(kk,:)=[];
% % %             y(kk,:)=[];
% % %             fi(kk,:)=[];
% % %             if nargin==8
% % %                 r(kk,:)=[];
% % %             end
% % %             spy_x(kk,:)=[];
% % %             spy_y(kk,:)=[];
% % %         end
% % %     end
% % %     [rr,c,s]=find(spy_x);
% % %     n_missing=length(rr);
% % % 
% % %     [tny,tnx]=size(x);
% % % 
% % %     
% % %     save temp_spy_y spy_y
% % %     
% % %     not_ok=1;
% % %     for k=1:n_missing
% % %         kp=0;
% % %         while not_ok==1
% % %             if rr(k)<tny/2 
% % %                 if min(spy_x(rr(k)+1:tny,c(k)))==0  
% % %                     kp=kp+1;    
% % %                 else
% % %                     kp=kp-1;
% % %                 end
% % %             else
% % %                 if min(spy_x(1:(rr(k)-1),c(k)))==0  
% % %                     kp=kp-1;  
% % %                 else
% % %                     kp=kp+1;
% % %                 end
% % %             end
% % %             %if sum(spy_x(rr(k)+kp,:))==0
% % %             if sum(spy_x(rr(k)+kp,c(k)))==0
% % %                 x(rr(k),c(k))=x(rr(k)+kp,c(k));
% % %                 not_ok=0;
% % %             end
% % %         end
% % %         not_ok=1;
% % %     end
% % % 
% % %     not_ok=1;
% % %     for k=1:n_missing
% % %         kp=0;
% % %         while not_ok==1
% % %             
% % %             if c(k)<tnx/2 
% % %                 if min(spy_y(rr(k),c(k)+1:tnx))==0  
% % %                     kp=kp+1;    
% % %                 else
% % %                     kp=kp-1;
% % %                 end
% % %             else
% % %                 if min(spy_y(rr(k),1:(c(k)-1)))==0  
% % %                     kp=kp-1;  
% % %                 else
% % %                     kp=kp+1;
% % %                 end
% % %             end
% % %             
% % %             if sum(spy_y(rr(k),c(k)+kp))==0
% % %                 y(rr(k),c(k))=y(rr(k),c(k)+kp);
% % %                 fi(rr(k),c(k))=fi(rr(k),c(k)+kp);
% % %                 if nargin==7
% % %                     r(rr(k),c(k))=r(rr(k),c(k)+kp);
% % %                 end
% % %                 not_ok=0;
% % %             end
% % %         end
% % %         not_ok=1;
% % %     end
% % % %     for k=1:n_missing
% % % %         fi(rr(k),c(k))=fi(rr(k),c(k)-1);
% % % %         if nargin==7
% % % %             r(rr(k),c(k))=r(rr(k),c(k)-1);
% % % %         end
% % % %     end
% % %         
% % % %---
% % %     
% % %     x=x/1e6;
% % %     y=y/1e6;
% % % 
% % %     y=mean(y')'*ones(1,tnx);
% % %     if use_relative_X==1
% % %         x=ones(tny,1)*mean(x);
% % %     else
% % %         x=x-mean(mean(x))+W/2;
% % %         y=y-y(1,1)+(y(2,1)-y(1,1)); % Tveksam rad, tänker Anders 160103
% % %     end
% % % 
% % % 
% % % %---
% % % 
% % %    x_vec=mean(x);
% % %    y_vec=mean(y')';
% % % 
% % %    [waste_rows_low,val]=find(y_vec-abs(y_vec));
% % %    [waste_rows_high,val]=find((y_vec-L)+abs(y_vec-L));
% % %    
% % %    [waste_cols_low,val]=find(x_vec-abs(x_vec));
% % %    [waste_cols_high,val]=find((x_vec-W)+abs(x_vec-W));
% % %    
% % %    waste_rows=[waste_rows_low; waste_rows_high];
% % %    waste_cols=[waste_cols_low; waste_cols_high];
% % %    
% % %    x(waste_rows,:)=[];
% % %    x(:,waste_cols)=[];
% % %    y(waste_rows,:)=[];
% % %    y(:,waste_cols)=[];
% % %    fi(waste_rows,:)=[];
% % %    fi(:,waste_cols)=[];
% % %    if nargin==8
% % %        r(waste_rows,:)=[];
% % %        r(:,waste_cols)=[];
% % %    end
% % % 
% % %    [tny,tnx]=size(x);
% % % 
% % %    x=[0 x(1,:) W; zeros(tny,1) x  ones(tny,1)*W; 0 x(tny,:) W];
% % %    y=[zeros(1,tnx+2); y(:,1) y  y(:,tnx); ones(1,tnx+2)*L];
% % %    fi=[fi(1,1) fi(1,:) fi(1,tnx); fi(:,1) fi  fi(:,tnx); fi(tny,1) fi(tny,:) fi(tny,tnx)];
% % %    if nargin==8
% % %        r=[r(1,1) r(1,:) r(1,tnx); r(:,1) r  r(:,tnx); r(tny,1) r(tny,:) r(tny,tnx)];
% % %    end
% % % 
% % %    x_vec=mean(x);
% % %    y_vec=mean(y')';
% % %    
% % %    % Nytt 2016-10-10
% % %    [i,j]=max(x_vec)
% % %    l=length(x_vec);
% % %    if j==l
% % %        x_vec(j)=[];
% % %        fi(:,j)=[];
% % %        if nargin==8
% % %           r(:,j)=[];
% % %        end
% % %    end
% % %    
% % %    y_vec
% % %    L
% % %    
% % %    [i,j]=max(y_vec)
% % %    l=length(y_vec);
% % %    if j==l
% % %        y_vec(j)=[];
% % %        fi(j,:)=[];
% % %        if nargin==8
% % %           r(j,:)=[];
% % %        end
% % %    end
% % %    
% % %    
% % % 
% % % %    [ny,nx]=size(x);
% % % %    typical_dx_up=mean(x(:,round(nx/2))-x(:,round(nx/2)-1));
% % % %    typical_dy_up=mean(y(round(ny/2),:)-y((round(ny/2)-1),:));
% % % %    for row=1:ny+2
% % % %        if x(row,1)>=x(row,2)
% % % %            x(row,2)=x(row,1)+0.2*typical_dx_up;
% % % %        end
% % % %        if x(row,2)>=x(row,3)
% % % %            x(row,3)=x(row,2)+0.2*typical_dx_up;
% % % %        end
% % % %        if x(row,nx+2)<=x(row,nx+1)
% % % %            x(row,nx+1)=x(row,nx+2)-0.2*typical_dx_up;
% % % %        end
% % % %        if x(row,nx+1)<=x(row,nx)
% % % %            x(row,nx)=x(row,nx+1)-0.2*typical_dx_up;
% % % %        end
% % % %    end
% % % %    for k=1:nx+2
% % % %        if y(1,k)>=y(2,k)
% % % %            y(2,k)=y(1,k)+0.2*typical_dy_up;
% % % %        end
% % % %        if y(2,k)>=y(3,k)
% % % %            y(3,k)=y(3,k)+0.2*typical_dy_up;
% % % %        end
% % % %        if y(ny+2,k)<=y(ny+1,k)
% % % %            y(ny+1,k)=y(ny+2,k)-0.2*typical_dy_up;
% % % %        end
% % % %        if y(ny+1,k)<=y(ny,k)
% % % %            y(ny,k)=y(ny+1,k)-0.2*typical_dy_up;
% % % %        end
% % % %    end
% % % %    
% % % %    [ny,nx]=size(x);
% % % %    
% % % %    dx_matrix=x(:,2:nx)-x(:,1:(nx-1));
% % % %    
% % % %    spy_dx_matrix=floor(dx_matrix/1e8)*(-1);
% % % %    [i,j,s]=find(spy_dx_matrix);
% % % %    li=length(i);
% % % %    for p=1:li
% % % %       %x_temp=x(i(p),[j(p)+1 j(p) ]);
% % % %       x(i(p),[j(p) j(p)+1])=x(i(p),[j(p)+1 j(p)]);
% % % %    end
% % % %    
% % % %  start_l=0;
% % % %  end_l=L;
