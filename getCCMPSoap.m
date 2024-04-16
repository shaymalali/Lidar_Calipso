function [k]=getCCMPSoap(lat,lon,shiplat,shiplon,time,shiptime,wind1,wind2,wind3,wind4)
%Get the collocated and simultaenous wind speeds for CCMP and SOAP 
%Step 1:Extract the data based on time 
%Step2: Use interp3 to get wind speeds in between the 6 hour times
k.lat=[]; k.lon=[]; k.wspd=[]; k.dt=[];
for i=1:6:length(shiptime)
    t=hour(shiptime(i));
    d=day(shiptime(i));
    
    p=[13:29,1:4];
    if t==0 %12 am 
        jlat=shiplat(i);
        jlon=shiplon(i);
        
        n= lat<=jlat+0.25 & lat >=jlat-0.25;
        nn=find(n==1); nnn=lat(nn(1)); k.lat=[k.lat;nnn];
                
        m= lon<=jlon+0.25 & lon >=jlon-0.25;
        mm=find(m==1); mmm=lon(mm(1)); k.lon=[k.lon;mmm];
        
        %find the day for wind speed
        h= p==d; hh=find(h==1);
        
        
        hhh=wind2(nn(1),mm(1),hh(1)); k.wspd=[k.wspd;hhh];
       
        dt=time(h,1); k.dt=[k.dt;dt];
        
    elseif t==6 %6 am
        
        jlat=shiplat(i);
        jlon=shiplon(i);
        n= lat<=jlat+0.25 & lat >=jlat-0.25;
        nn=find(n==1); nnn=lat(nn(1)); k.lat=[k.lat;nnn];
                
        m= lon<=jlon+0.25 & lon >=jlon-0.25;
        mm=find(m==1); mmm=lon(mm(1)); 
        k.lon=[k.lon;mmm];
        
        %find the day for wind speed
        h= p==d; hh=find(h==1);
        
        
        hhh=wind2(nn(1),mm(1),hh(1)); k.wspd=[k.wspd;hhh];
        dt=time(h,2); k.dt=[k.dt;dt];
    elseif t==12 %12 pm
        
        jlat=shiplat(i);
        jlon=shiplon(i);
        
        n= lat<=jlat+0.25 & lat >=jlat-0.25;
        nn=find(n==1); nnn=lat(nn(1)); k.lat=[k.lat;nnn];
                
        m= lon<=jlon+0.25 & lon >=jlon-0.25;
        mm=find(m==1); mmm=lon(mm(1)); k.lon=[k.lon;mmm];
        
        %find the day for wind speed
        h= p==d; hh=find(h==1);
        
        
        hhh=wind3(nn(1),mm(1),hh(1)); 
        k.wspd=[k.wspd;hhh];
        
        dt=time(h,3); k.dt=[k.dt;dt];
    elseif t==18 %6 pm
        
        jlat=shiplat(i);
        jlon=shiplon(i);
        n= lat<=jlat+0.25 & lat >=jlat-0.25;
        nn=find(n==1); nnn=lat(nn(1)); k.lat=[k.lat;nnn];
                
        m= lon<=jlon+0.25 & lon >=jlon-0.25;
        mm=find(m==1); mmm=lon(mm(1)); k.lon=[k.lon;mmm];
        
        %find the day for wind speed
        h= p==d; hh=find(h==1);
        
        
       hhh=wind3(nn(1),mm(1),hh(1)); k.wspd=[k.wspd;hhh];
       dt=time(h,4); k.dt=[k.dt;dt];
    end  
        
end