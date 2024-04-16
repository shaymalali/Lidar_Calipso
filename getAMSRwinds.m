function [w]=getAMSRwinds(latmin,latmax,lonmin,lonmax,yr)
%use function to get collocated and simultaneous wwind speeds with CALIPSO
cd('G:\Shared drives\Saltzman Aydin lab data\Shayma\LIDAR\AMSR2\2015_NA')
w.lat=[]; w.lon=[]; w.wspd_day=[];w.time_night=[];w.dirname=[];w.fname=[];
w.wspd_night=[]; w.time_day=[];
AMSR_dir=dir('*.nc');
for j=1:length(AMSR_dir) %get data from each file
    fname={AMSR_dir(j).name}; %file name as cell array
    AMSR_lon=ncread(AMSR_dir(j).name,'lon');
    AMSR_lat=ncread(AMSR_dir(j).name,'lat');
    AMSR_time=ncread(AMSR_dir(j).name,'time');
    AMSR_wspd=ncread(AMSR_dir(j).name,'wind_speed_MF');
    
    %separate the day and night measurements
    %first pass is the day measurements and second pass is the night
    %measurements
    %get the collocated wind speeds for the day time measurements
    day_time=AMSR_time(:,:,1); day_wind=AMSR_wspd(:,:,1);
    night_time=AMSR_time(:,:,2); night_wind=AMSR_wspd(:,:,2);
    
    %find if scat lon and lat are valid and where
    v_lat=AMSR_lat<=latmax & AMSR_lat >=latmin;
    v_lat=find(v_lat==1); wlat=AMSR_lat(v_lat);
    
    v_lon=AMSR_lon<=lonmax & AMSR_lon >=lonmin;
    v_lon=find(v_lon==1); wlon=AMSR_lon(v_lon);
    
    %Get windspeeds for valid lat and lon
    w.lat=[w.lat; wlat];
    w.lon=[w.lon; wlon];
    
    w.wspd_day(:,:,j)=day_wind(v_lon,v_lat); w.wspd_night(:,:,j)=night_wind(v_lon,v_lat);
    w.time_day(:,:,j)=day_time(v_lon,v_lat); w.time_night(:,:,j)= night_time(v_lon,v_lat);
    %d.dirname=[d.dirname; repmat(dirname,length(v_both==1),1)];
    %d.fname=[d.fname; repmat(fname,length(v_both==1),1)];
end
cd('G:\Shared drives\Saltzman Aydin lab data\Shayma\LIDAR\CALIPSO\2015')
save('AMSRwind_2015.mat','w')  
end