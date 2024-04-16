function [d]=rapidscatLIDAR(lat,lon,delta_lat,delta_lon,yr)
% use function to get rapid scat data to compare with HSRL date from NAAMES
% Input variables: Latitudes, longitudes, +/- degrees of latitudes, year
% outputs: Wind Speeds
d.lat=[]; d.lon=[]; d.wspd=[];d.time=[];d.dirname=[];d.fname=[];
scat_dir=dir('*.nc');
 for j=1:length(scat_dir) %get data from each file
                %disp(['working on...' scat_dir(j).name]);
                fname={scat_dir(j).name}; %file name as cell array
                scat_lon=ncread(scat_dir(j).name,'lon');
                scat_lat=ncread(scat_dir(j).name,'lat');
                scat_time=ncread(scat_dir(j).name,'time');
                scat_wspd=ncread(scat_dir(j).name,'retrieved_wind_speed');
                %fix time vector
                scat_time=scat_time';
                scat_time=repmat(scat_time,152,1);
                %find if scat lon and lat are valid and where
                delta_lon=1.5;
                delta_lat=1.5;
                v_lat=scat_lat<=lat+delta_lat & scat_lat >=lat-delta_lat;
                v_lon=scat_lon<=lon+delta_lon & scat_lon >=lon-delta_lon;
                v_both= v_lon==1 & v_lat==1;
                if max(max(v_both)==1)
                    xx=1;
                end
                %Get windspeeds for valid lat and lon
                d.lat=[d.lat; scat_lat(v_both==1)];
                d.lon=[d.lon; scat_lon(v_both==1)];
                d.wspd=[d.wspd; scat_wspd(v_both==1)];
                d.time=[d.time; scat_time(v_both==1)];
                %d.dirname=[d.dirname; repmat(dirname,length(v_both==1),1)];
                %d.fname=[d.fname; repmat(fname,length(v_both==1),1)];
                if size(scat_wspd(v_both==1),1) > 0
                    disp(['data found...' num2str(size(scat_wspd(v_both==1),1))]);
                end
            end
            %figure(1);
            %contourf(scat_lon, scat_lat,scat_wspd);
            %scatter(d.lon,d.lat,4,d.wspd)
d.datenum=[];
for i=1:length(d.time)
d.datenum(i)=addtodate(datenum(1999,1,1),fix(d.time(i)),'second');
end
d.datenum=d.datenum';
cd(thisdir)
save('scat_d.mat','d')  
end