function [d,ccmp]=CCMPLidar(latmin,latmax,lonmin,lonmax,yr)
cd('/Volumes/GoogleDrive/Shared drives/Saltzman Aydin lab data/Shayma/LIDAR/CCMP/2012')
d.lat=[]; d.lon=[]; d.wspd=[];d.time=[];d.dirname=[];d.fname=[]; d.uwind=[];
d.vwind=[];
direc=dir('*.nc');
direc=direc(1:22);
 for j=1:length(direc) %get data from each file
                %disp(['working on...' scat_dir(j).name]);
                fname={direc(j).name}; %file name as cell array
                ccmp_lon=ncread(direc(j).name,'longitude');
                ccmp_lat=ncread(direc(j).name,'latitude');
                ccmp_time=ncread(direc(j).name,'time');
                ccmp_uwind=ncread(direc(j).name,'uwnd');
                ccmp_vwind=ncread(direc(j).name,'vwnd');
                
                %get datenum and datetime
                d.datenum=[];
                for i=1:length(ccmp_time)
                    d.datenum(i,:)=addtodate(datenum(1987,1,1),fix(ccmp_time(i,:)),'hour');
                end
                d.datenum=d.datenum';
                dt=datetime(d.datenum,'ConvertFrom','datenum');
                
                %%get the data from two time dimensions and then average
                %average two vectors from uwind and vwnd
                uwnd1=squeeze(ccmp_uwind(:,:,1));
                uwnd2=squeeze(ccmp_uwind(:,:,2));
                uwnd3=squeeze(ccmp_uwind(:,:,3));
                uwnd4=squeeze(ccmp_uwind(:,:,4));
                
                vwnd1=squeeze(ccmp_vwind(:,:,1));
                vwnd2=squeeze(ccmp_vwind(:,:,2));
                vwnd3=squeeze(ccmp_vwind(:,:,3));
                vwnd4=squeeze(ccmp_vwind(:,:,4));
                
                
                wind1=sqrt(uwnd1.^2+vwnd1.^2); %calculate wind speed for first one
                wind2=sqrt(uwnd2.^2+vwnd2.^2);
                wind3=sqrt(uwnd3.^2+vwnd4.^2);
                wind4=sqrt(uwnd4.^2+vwnd4.^2);
                %calculate wind speedsfor every point
                %wspd=(wind1+wind2+wind3+wind4)/4;
                
                %find if scat lon and lat are valid and where
                v_lat=ccmp_lat<=latmax & ccmp_lat >=latmin;
                v_lat=find(v_lat==1); ccmp.lat=ccmp_lat(v_lat);
                
                v_lon=ccmp_lon<=lonmax & ccmp_lon >=lonmin;
                v_lon=find(v_lon==1); ccmp.lon=ccmp_lon(v_lon);
                
                %extract the wind speeds for specific region
                %wspd dimensions is lonxlat so flip 
                wind1=wind1(v_lon,v_lat);
                wind2=wind2(v_lon,v_lat);
                wind3=wind3(v_lon,v_lat);
                wind4=wind4(v_lon,v_lat);
                %create 3 dimensional matrix of lat lon with time
                %so (lat x lon x time) dimensions
                ccmp.wind1(:,:,j)=wind1;
                ccmp.wind2(:,:,j)=wind2;
                ccmp.wind3(:,:,j)=wind3;
                ccmp.wind4(:,:,j)=wind4;
                
                %transpose the winds
%                 wind1=pagetranspose(wind1);
%                 wind2=pagetranspose(wind2);
%                 wind3=pagetranspose(wind3);
%                 wind4=pagetranspose(wind4);
                %Get windspeeds for valid lat and lon
                d.lat=ccmp_lat;
                d.lon=ccmp_lon;
                d.time=[d.time;dt];
 end 
%save('ccpwind_2012.mat','d','ccmp_wspd')  
end