%get collocated HSRL data from Calipso during Nov 2015
clear all
close all 
%get collocated data
latmin=-40;
latmax=-60;
lonmin=-130;
lonmax=-80;
yr=2012;
[c]=CalipsoData(latmin,latmax,lonmin,lonmax,yr);
cd('G:\Shared drives\Saltzman Aydin lab data\Shayma\LIDAR\CALIPSO\2012')
save('c_2012.mat','c')

%% Look at Data
%clear all
load('c_2012.mat','c')
c_2012=c;
randk=rand(length(c.lat),1);
figure(1)
geoscatter(c.lat,c.lon,randk,'*')
title('Calipso Orbit (12-Feb-2012 to 4-Mar-2012)')

%convert time to datetime 
c.datetime=[];c.datenum=[];
for i=1:length(c.timeutc)
    x=c.timeutc(i);
    
    g=datetime(string(floor(x)),'InputFormat','yyMMdd');
    t=days(x-floor(x));
    
    dt=g+t;
    k=datenum(dt);
    c.datenum=[c.datenum;k];
end
c.datetime=datetime(c.datenum,'ConvertFrom','datenum');

%calculate the parallel backscatter 
%parallel bsc= total bsc-perp bsc
c.bsc=c.bsc';
c.prpbsc=c.prpbsc';
c.pbsc=c.bsc-c.prpbsc;

%find data without flags for both pbsc and prpbsc
waterflag=find(c.landwater==7 | c.landwater==0);
sflagp=find(c.sflagp==0);
sflagprp=find(c.sflagprp==0);
%selevflag=find(c.selev<=0.02);
negp=find(c.negp==-1);
negprp=find(c.negprp==-1);
%daynight=find(c.daynight==1);

flags=intersect(sflagp,sflagprp);
flags=intersect(flags,waterflag);
%flags=intersect(flags,daynight);
% flags=intersect(flags,selevflag);
%flags=intersect(flags,negp);

c.latf=c.lat(flags); c.lonf=c.lon(flags);
c.dtf=c.datetime(flags);
c.pbscf=c.pbsc(:,(flags));
c.prpbscf=c.prpbsc(:,(flags));
c.bscf=c.bsc(:,(flags));
c_2012.lonf=c.lon(flags);
c_2012.latf=c.lat(flags);
%filter out the data where peak isn't at surface
[sflag,p]=SurfaceFlag(c.pbscf,c.prpbscf);


c.pbscf=c.pbscf(:,(sflag.y)); c.latf=c.latf(sflag.y); c.lonf=c.lonf(sflag.y);
c.prpbscf=c.prpbscf(:,(sflag.y));
c.dtf=c.dtf(sflag.y);

%Get the corrected backscatter data by deconvulating the observed
%backscatter
[F,cr_2012]=DeconvolutionProcess(c.pbscf,c.prpbscf,c.landwater,c.alt);

%sum the backscatter from both parallel and perpendicular channels to
%remove signals dominated by atmosphere
cr_2012.tbsc=cr_2012.pbsc+cr_2012.prpbsc;
sumr_2012.pbsc=sum(cr_2012.pbsc(1:563,:)); sumr_2012.prpbsc=sum(cr_2012.prpbsc(1:563,:));
sumr_2012.tbsc=sum(cr_2012.tbsc(1:563,:));
cr_2012.timeutc=c.timeutc(flags); cr_2012.timeutc=cr_2012.timeutc(sflag.y);
%calculate total integrated depolarization 
surf_2012.pbsc=cr_2012.pbsc(563,:); surf_2012.prpbsc=cr_2012.prpbsc(563,:); surf_2012.tbsc=cr_2012.tbsc(563,:);
dep_cal2012=surf_2012.prpbsc./surf_2012.pbsc;

cr_2012.latf=c_2012.latf(sflag.y);
cr_2012.lonf=c_2012.lonf(sflag.y);

c_2012=c; 
dep_stats12.max=max(dep_cal2012);
dep_stats12.min=min(dep_cal2012);
dep_stats12.mean=mean(dep_cal2012);
dep_stats12.std=std(dep_cal2012);
save('dep_stats12.mat','dep_stats12')
save('CalipsoData_2012.mat','c_2012','cr_2012','sumr_2012','dep_cal2012','surf_2012')


%% Depolarization vs Backscatter 
%Get collocated wind speeds from CCMP and compare with SOAP wind speeds 
%Step 1: Extract the wind speeds from CCMP from specific region
%Step 2: Extract the collocated CCMP and SOAP wind speeds

%cd('G:\Shared drives\Saltzman Aydin lab data\Shayma\LIDAR\SOAP')
cd('/Volumes/GoogleDrive/Shared drives/Saltzman Aydin lab data/Shayma/LIDAR/SOAP')
%load('CalipsoData_2012.mat')

latmin=-50;
latmax=-40;
lonmin=170;
lonmax=182;
yr=2012;

[d,ccmp]=CCMPLidar(latmin,latmax,lonmin,lonmax,yr);
d.lat=d.lat'; d.lon=d.lon';
ccmp.wind1=pagetranspose(ccmp.wind1);
ccmp.wind2=pagetranspose(ccmp.wind2);
ccmp.wind3=pagetranspose(ccmp.wind3);
ccmp.wind4=pagetranspose(ccmp.wind4);

%plot the CCMP wind speeds throughout March 2012 
%Also plot the CALIPSO overpass during the same period

%get the CALIPSO measurements for each day during March
m2.idx=[781:953]; m2.lat=c.latf(m2.idx); m2.lon=c.lonf(m2.idx);
m4.idx=[954:977]; m4.lat=c.latf(m4.idx); m4.lon=c.lonf(m4.idx);
rand2=rand(length(m2.idx),1); rand4=rand(length(m4.idx),1);

lat1=d.lat(1); lat2=d.lat(628); lon1=d.lon(1); lon2=d.lon(1440);
figure(400)
subplot(2,2,1)
worldmap([lat1 lat2], [lon1 lon2])
load coastlines
geoshow(ccmp.wind4(:,:,1),'DisplayType','surface')
h=colorbar;
caxis([0 25])
ylabel(h,'CCMP Wind Speeds')
title('CCMP Winds at 12 AM on 12-Feb-2012');
subplot(2,2,2)
worldmap([lat1 lat2], [lon1 lon2])
pcolorm(d.lat,d.lon,ccmp.wind4(:,:,9));
h=colorbar;
caxis([0 25])
ylabel(h,'CCMP Wind Speeds')
title('CCMP Winds at 12 AM on 20-Feb-2012');
subplot(2,2,3)
worldmap([lat1 lat2], [lon1 lon2])
pcolorm(d.lat,d.lon,ccmp.wind4(:,:,13))
h=colorbar;
caxis([0 25])
ylabel(h,'CCMP Wind Speeds')
title('CCMP Winds at 12 AM on 24-Feb-2012');
subplot(2,2,4)
worldmap([lat1 lat2], [lon1 lon2])
pcolorm(d.lat,d.lon,ccmp.wind4(:,:,12)); 
h=colorbar;
caxis([0 25])
ylabel(h,'CCMP Wind Speeds')
title('CCMP Winds at 12 AM on 1-Mar-2012');

%plot calipso over pass during the storm 
%storm occured 






%%
%Get SOAP wind speeds, lat, lon, and time
cd('/Volumes/GoogleDrive/Shared drives/Saltzman Aydin lab data/Tom/SOAP/SOAP_KBub processing_ForEric_20200814')
tbl=readtable('NWW3_shiptrackV1.dat','FileType','text');
ship.datenum=tbl(:,1); ship.datenum=table2array(ship.datenum);
ship.lat=tbl(:,2); ship.lat=table2array(ship.lat);
ship.lon=tbl(:,3); ship.lon=table2array(ship.lon);
ship.datetime=datetime(ship.datenum,'ConvertFrom','datenum');
%get the indexes for when ship was between 13-Feb to Mar 4
ship.datetime=ship.datetime(1:504,:);
ship.lat=ship.lat(1:504,:); ship.lon=ship.lon(1:504,:);
cd('/Volumes/GoogleDrive/Shared drives/Saltzman Aydin lab data/Shayma/LIDAR/SOAP')



save('CCMPLidar_2012.mat','wspd_CCMP2012','d');
