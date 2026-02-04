function [Fi1_matrix]=make_fi1_from_ratio(ratio_matrix,limits)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

   %limits=ratio_limits;
   dl=limits(2)-limits(1);
   sl=sum(limits);
   e02=1;
   [ru,cu]=size(ratio_matrix);
   Fi1_matrix=zeros(ru,cu);
   for r=1:ru 
       for c=1:cu
           if ratio_matrix(r,c)<limits(1)
              Fi1_matrix(r,c)=0;
           elseif ratio_matrix(r,c)>limits(2)
              Fi1_matrix(r,c)=90;
           else
              rr=(ratio_matrix(r,c)-sl/2)/(dl/2);
              Fi1_matrix(r,c)=(rr/abs(rr)*real(acos(sqrt((1-rr^2)/e02))*180/pi)+90)/2;
           end
       end
   end

end

