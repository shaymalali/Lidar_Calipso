function [c]=CalipsoData(latmin,latmax,lonmin,lonmax,yr)
% use function to get collocated data from Calipso Satellite
% Input Variables: Latmin/Latmax: Latitude limits
%                  lonmin/lonmax: Longitude limits
%                  yr: Year that data was measured
%
%Output Variables: c = contains backscatter,wind speed,etc from calipso 
c.bsc=[]; c.prpbsc=[]; c.timeutc=[]; c.lat=[]; c.lon=[]; c.daynight=[];
c.noise=[]; c.landwater=[]; c.sflagprp=[]; c.sflagp=[]; c.negprp=[]; c.negp=[];
c.alt=[]; c.dt=[]; c.xp=[]; c.bsc1064=[]; c.sflag1064=[];
% create direc for data
cd('F:\LIDAR\2018')
direc=dir('*.hdf');
% start reading in data
for i=1:length(direc)
    finfo=hdfinfo(direc(i).name);
    sdsinfo=finfo.SDS;
    
    %read  in data from files
    bsc=hdfread(sdsinfo(31));
    prpbsc=hdfread(sdsinfo(32));
    timeutc=hdfread(sdsinfo(2));
    lat=hdfread(sdsinfo(58));
    lon=hdfread(sdsinfo(59));
    bsc1064=hdfread(sdsinfo(39));
    daynight=hdfread(sdsinfo(7));
    landwater=hdfread(sdsinfo(4));
    sflagprp=hdfread(sdsinfo(16));
    sflagp=hdfread(sdsinfo(13));
    negprp=hdfread(sdsinfo(18));
    negp=hdfread(sdsinfo(15));
    sflag1064=hdfread(sdsinfo(19));
    
    %get alt data from meta
    metadata=hdfread(direc(i).name,'/metadata','Fields', 'Lidar_Data_Altitudes', 'FirstRecord',1 ,'NumRecords',1);
    alt=metadata{1};
    
    %get collocated data
    v_lat=lat<=latmax & lat >=latmin;
    v_lon=lon<=lonmax & lon >=lonmin;
    v_both= v_lon==1 & v_lat==1;
    if max(max(v_both)==1)
        xx=1;
    end
    %save the data 
    c.bsc=[c.bsc; bsc(v_both==1,:)];
    c.prpbsc=[c.prpbsc; prpbsc(v_both==1,:)];
    c.timeutc=[c.timeutc; timeutc(v_both==1)];
    c.lat=[c.lat;lat(v_both==1)];
    c.lon=[c.lon;lon(v_both==1)];
    c.daynight=[c.daynight;daynight(v_both==1)];
    c.landwater=[c.landwater;landwater(v_both==1)];
    c.sflagprp=[c.sflagprp;sflagprp(v_both==1)];
    c.sflagp=[c.sflagp;sflagp(v_both==1)];
    c.negprp=[c.negprp;negprp(v_both==1)];
    c.negp=[c.negp;negp(v_both==1)];
    c.bsc1064=[c.bsc1064; bsc1064(v_both==1,:)];
    c.sflag1064=[c.sflag1064; sflag1064(v_both==1)];
    %displayy if any data was found
    if size(bsc(v_both==1),1) > 0
                    disp(['data found...' num2str(size(bsc(v_both==1),1))]);
    end 
    
end 
end 
    
    
            
    