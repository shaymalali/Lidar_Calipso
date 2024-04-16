function [F,cr] =DeconvolutionProcess(pbscf,prpbscf,landflag,alt)
%use function to calculate the Transient Response from the land surface return
%[F (zj)] = B'(zi)/sum(B(zj)) where j=[1...12]

%create the F matrix that is a square matrix with size that is equal to the rows of 
%the bsc matrix 

val=zeros(1,583);
j=[10,10E-1,10E-2,(9:-1:1)*(10^-3)]; 
val(1:12)=j;
sum_val=sum(val); val_norm=val/sum_val; %normalize the function

F=toeplitz(val_norm,[val_norm(1), zeros(1,numel(val_norm)-1  )]);


%Deconvalute the signal 
%Bsc Corrected =F(inv)*Bsc observed -> Bsc Corrected=F\Bsc Observed

%create a for loop to deconvolute every column in the matrix 
sz=size(pbscf);
cr.pbsc=zeros(sz);
for i=1:length(pbscf)
    cr.pbsc(:,i)=mldivide(F,pbscf(:,i));
end

%deconvolute for perpendicular bsc
cr.prpbsc=zeros(sz);
for i=1:length(prpbscf)
    cr.prpbsc(:,i)=F\prpbscf(:,i);
end



end 