function [sflag]=SurfaceFlag(pbscf,prpbscf)
%
%use function to find the indexes of points where peak is not at the
%surface
% find the peak for each column in matrix
id.p=[]; id.q=[]; id.k=[];
for i=1:length(pbscf)
    x=pbscf(:,i);
    [k,idx]=max(x);
    max2=max(x(x<max(x)));
    id.k=[id.k;k];
    id.p=[id.p;idx];
    id.q=[id.q;max2];
end
%find the outliers of each point
p_flag=[];
for i=1:length(id.p)
    j=0.3*id.k(i);
    if id.p(i)==563 
        %&& id.q(i)<=j 
        p_flag(i)=1;
        id.p(i)
    else
        p_flag(i)=0;
        
    end 
end
    
%intersect the flags
sflag=find(p_flag==1);
end 