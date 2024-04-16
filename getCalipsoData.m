%get collocated HSRL data from Calipso during Nov 2015
cd('G:\Shared drives\Saltzman Aydin lab data\Shayma\LIDAR\NAAMES HSRL\2015')
%cd('/Volumes/GoogleDrive/Shared drives/Saltzman Aydin lab data/Shayma/LIDAR/NAAMES HSRL/2015') %use for mac
clear all
close all 
load('variables2015.mat')
%get collocated data
latmin=min(lat);
latmax=max(lat);
lonmin=min(lon);
lonmax=max(lon);
yr=2015;
cd('G:\Shared drives\Saltzman Aydin lab data\Shayma\LIDAR\CALIPSO\2015')
[c_2015]=CalipsoData(latmin,latmax,lonmin,lonmax,yr);
save('c_2015.mat','c_2015')


%% Look at Data
clear all
load('c_2015.mat');
c=c_2015;
randk=rand(length(c.lat),1);
figure(1)
geoscatter(c.lat,c.lon,randk,'*')
title('Calipso Orbit (9-Nov-2015 to 18-Nov-2015)')

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
c_2015.lonf=c.lon(flags);
c_2015.latf=c.lat(flags);
%filter out the data where peak isn't at surface
[sflag]=SurfaceFlag(c.pbscf,c.prpbscf);


c.pbscf=c.pbscf(:,(sflag)); c.latf=c.latf(sflag); c.lonf=c.lonf(sflag);
c.prpbscf=c.prpbscf(:,(sflag));
c.dtf=c.dtf(sflag);

%Get the corrected backscatter data by deconvulating the observed
%backscatter
[F,cr_2015]=DeconvolutionProcess(c.pbscf,c.prpbscf,c.landwater,c.alt);

%sum the backscatter from both parallel and perpendicular channels to
%remove signals dominated by atmosphere
cr_2015.tbsc=cr_2015.pbsc+cr_2015.prpbsc;
sumr_2015.pbsc=sum(cr_2015.pbsc(1:563,:)); sumr_2015.prpbsc=sum(cr_2015.prpbsc(1:563,:));
sumr_2015.tbsc=sum(cr_2015.tbsc(1:563,:));
cr_2015.timeutc=c.timeutc(flags); cr_2015.timeutc=cr_2015.timeutc(sflag);
%calculate total integrated depolarization 
surf_2015.pbsc=cr_2015.pbsc(563,:); surf_2015.prpbsc=cr_2015.prpbsc(563,:); surf_2015.tbsc=cr_2015.tbsc(563,:);
dep_cal2015=surf_2015.prpbsc./surf_2015.pbsc;

cr_2015.latf=c_2015.latf(sflag);
cr_2015.lonf=c_2015.lonf(sflag);

c_2015=c; 
dep_stats15.max=max(dep_cal2015);
dep_stats15.min=min(dep_cal2015);
dep_stats15.mean=mean(dep_cal2015);
dep_stats15.std=std(dep_cal2015);
save('dep_stats15.mat','dep_stats15')
save('CalipsoData_2015.mat','c_2015','cr_2015','sumr_2015','dep_cal2015','surf_2015')


%% Calipso Datetime
%Calculate the datetime of Calipso 

cr_2015.datenum=[];
for i=1:length(cr_2015.timeutc)
    x=cr_2015.timeutc(i);
    
    g=datetime(string(floor(x)),'InputFormat','yyMMdd');
    t=days(x-floor(x));
    
    dt=g+t;
    k=datenum(dt);
    cr_2015.datenum=[cr_2015.datenum;k];
end

cr_2015.datetime=datetime(cr_2015.datenum,'ConvertFrom','datenum');

%%
%Get collocated and simulatenous wind speeds from CCMP
cd('/Volumes/GoogleDrive/Shared drives/Saltzman Aydin lab data/Shayma/LIDAR/NAAMES HSRL/2015')
load('variables2015.mat')
cd('/Volumes/GoogleDrive/Shared drives/Saltzman Aydin lab data/Shayma/LIDAR/CALIPSO/2015')
% load('CalipsoData_2015.mat')
% cd('G:\Shared drives\Saltzman Aydin lab data\Shayma\LIDAR\NAAMES HSRL\2015')
latmin=min(lat);
latmax=max(lat);
lonmin=min(lon)+360;
lonmax=max(lon)+360;
yr=2015;

[d,ccmp]=CCMPLidar(latmin,latmax,lonmin,lonmax,yr);

cd('/Volumes/GoogleDrive/Shared drives/Saltzman Aydin lab data/Shayma/LIDAR/CALIPSO/2015')

%Get the CCMP wind speed
ccmp.wind2=pagetranspose(ccmp.wind2);
[j]=getCCMPCalipso(d.lat,d.lon,cr_2015.latf,cr_2015.lonf,d.time,cr_2015.datetime,ccmp.wind2);

%% Get AMSR wind speeds
% cd('G:\Shared drives\Saltzman Aydin lab data\Shayma\LIDAR\NAAMES HSRL\2015')
%load('variables2015.mat')
latmin=min(lat);
latmax=max(lat);
lonmin=min(lon)+360;
lonmax=max(lon)+360;
yr=2015;
cd('G:\Shared drives\Saltzman Aydin lab data\Shayma\LIDAR\CALIPSO\2015')
[w]=getAMSRwinds(latmin,latmax,lonmin,lonmax,yr);

%convert the AMSR times to datetime for nighttime measurements
for i=1:length(w.time_night)
    p=[9,11,12,17,18];
    pi=p(i);
    w.night_datenum(:,:,i)=addtodate(datenum(2015,11,pi),fix(w.time_night(i),'hours'));
end
%convert times for day measurements
for i=1:length(w.time_day)
    p=[9,11,12,17,18];
    pi=p(i);
    w.day_datenum(:,:,i)=addtodate(datenum(2015,11,pi),fix(w.time_day(i),'hours'));
end

