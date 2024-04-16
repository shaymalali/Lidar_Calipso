day(function [j]=getCCMPCalipso(lat,lon,callat,callon,time,caltime,wind1)
%Get the collocated and simultaenous wind speeds for CCMP and Calipso
%Step 1:Extract the data based on time 
%Step2: Use interp1 to get wind speeds in between the 6 hour times
j.lat=[]; j.lon=[]; j.wspd=[]; j.dt=[];
for i=1:length(caltime)
    t=hour(caltime(i));
    d=day(caltime(i));
    p=[9,12,14,17,18];
        
    jlat=callat(i);
    jlon=callon(i); jlon=jlon+360;
    
    n= lat<=jlat+0.25 & lat >=jlat-0.25;
    nn=find(n==1); nnn=lat(nn(1)); j.lat=[j.lat;nnn];
    
    m= lon<=jlon+0.25 & lon >=jlon-0.25;
    mm=find(m==1); mmm=lon(mm(1)); j.lon=[j.lon;mmm];
    
    %find the day for wind speed
    h= p==d; hh=find(h==1);
    
    hhh=wind1(nn(1),mm(1),hh(1));
    j.wspd=[j.wspd;hhh];
    
    dt=time(h,3); j.dt=[j.dt;dt];
  
    end  
        
end