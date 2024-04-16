%% read CALIPSO data

fileinfo=hdfinfo('CAL_LID_L1-Standard-V4-10.2015-01-01T00-08-22ZD.hdf');

sds_info=fileinfo.SDS;

%% read in variables

total_backscatter=hdfread(sds_info(31));
perp_backscatter=hdfread(sds_info(32));
depolarization_gainratio=hdfread(sds_info(27));
time=hdfread(sds_info(1));
time_utc=hdfread(sds_info(2));
latitude=hdfread(sds_info(58));
longitude=hdfread(sds_info(59));
day_night=hdfread(sds_info(7));

%% read night time data 

fileinfo_night=hdfinfo('CAL_LID_L1-Standard-V4-10.2015-11-09T11-44-54ZN.hdf');
sdsinfo_night=fileinfo_night.SDS;

total_backscatternight=hdfread(sdsinfo_night(31));
perp_backscatternight=hdfread(sdsinfo_night(32));
depolarization_gainrationight=hdfread(sdsinfo_night(27));
time_night=hdfread(sdsinfo_night(1));
time_utcnight=hdfread(sdsinfo_night(2));
latitude_night=hdfread(sdsinfo_night(58));
longitude_night=hdfread(sdsinfo_night(59));
day_night2=hdfread(sdsinfo_night(7));
QCflag_night=hdfread(sdsinfo_night(56));
QCflag2_night=hdfread(sdsinfo_night(57));
noise_night=hdfread(sdsinfo_night(49));
landwatermask=hdfread(sdsinfo_night(4));
number_bins_shift=hdfread(sdsinfo_night(67));
ParSurface_saturationflag=hdfread(sdsinfo_night(13));
PerpSurface_saturationflag=hdfread(sdsinfo_night(16));
ParNegative_flag=hdfread(sdsinfo_night(15));
PerpNegative_flag=hdfread(sdsinfo_night(18));
profileID=hdfread(sdsinfo_night(3));

% read meta data

metadata = hdfread('CAL_LID_L1-Standard-V4-10.2015-11-09T11-44-54ZN.hdf', '/metadata', 'Fields', 'Lidar_Data_Altitudes', 'FirstRecord',1 ,'NumRecords',1);
altitudes=metadata{1};

%% read another night file 
fileinfo_night38ZD=hdfinfo('CAL_LID_L1-Standard-V4-10.2015-01-01T12-33-04ZN.hdf');
sdsinfo_night38ZD=fileinfo_night38ZD.SDS;

total_backscatternight38ZD=hdfread(sdsinfo_night38ZD(31));
perp_backscatternight38ZD=hdfread(sdsinfo_night38ZD(32));
depolarization_gainrationight38ZD=hdfread(sdsinfo_night38ZD(27));
time_night38ZD=hdfread(sdsinfo_night38ZD(1));
time_utcnight38ZD=hdfread(sdsinfo_night38ZD(2));
latitude_night38ZD=hdfread(sdsinfo_night38ZD(58));
longitude_night38ZD=hdfread(sdsinfo_night38ZD(59));
day_night38ZD=hdfread(sdsinfo_night38ZD(7));
QCflag_night38ZD=hdfread(sdsinfo_night38ZD(56));
QCflag2_night38ZD=hdfread(sdsinfo_night38ZD(57));
noise_night38ZD=hdfread(sdsinfo_night38ZD(49));
landwatermask38ZD=hdfread(sdsinfo_night38ZD(4));

ParSurface_saturationflag38ZD=hdfread(sdsinfo_night38ZD(13));
PerpSurface_saturationflag38ZD=hdfread(sdsinfo_night38ZD(16));
ParNegative_flag38ZD=hdfread(sdsinfo_night38ZD(15));
PerpNegative_flag38ZD=hdfread(sdsinfo_night38ZD(18));


%%read another night file
fileinfo_night30ZN=hdfinfo('CAL_LID_L1-Standard-V4-10.2015-01-01T20-47-30ZN.hdf');
sdsinfo_night30ZN=fileinfo_night30ZN.SDS;

total_backscatternight30ZN=hdfread(sdsinfo_night30ZN(31));
perp_backscatternight30ZN=hdfread(sdsinfo_night30ZN(32));
depolarization_gainrationight30ZN=hdfread(sdsinfo_night30ZN(27));
time_night30ZN=hdfread(sdsinfo_night30ZN(1));
time_utcnight30ZN=hdfread(sdsinfo_night30ZN(2));
latitude_night30ZN=hdfread(sdsinfo_night30ZN(58));
longitude_night30ZN=hdfread(sdsinfo_night30ZN(59));
day_night30ZN=hdfread(sdsinfo_night30ZN(7));
QCflag_night30ZN=hdfread(sdsinfo_night30ZN(56));
QCflag2_night30ZN=hdfread(sdsinfo_night30ZN(57));
noise_night30ZN=hdfread(sdsinfo_night30ZN(49));
landwatermask30ZN=hdfread(sdsinfo_night30ZN(4));

ParSurface_saturationflag30ZN=hdfread(sdsinfo_night30ZN(13));
PerpSurface_saturationflag30ZN=hdfread(sdsinfo_night30ZN(16));
ParNegative_flag30ZN=hdfread(sdsinfo_night30ZN(15));
PerpNegative_flag30ZN=hdfread(sdsinfo_night30ZN(18));

%% read meta data

metadata38ZD = hdfread('CAL_LID_L1-Standard-V4-10.2015-01-01T10-54-13ZN.hdf', '/metadata', 'Fields', 'Lidar_Data_Altitudes', 'FirstRecord',1 ,'NumRecords',1);
altitudes38ZD=metadata38ZD{1};
%%
figure(888)
plot(depolarization_rationight)
%% read another file

fileinfo2=hdfinfo('CAL_LID_L1-Standard-V4-10.2015-01-01T01-00-52ZN.hdf');

sds_info2=fileinfo2.SDS;

%read in variables

total_backscatter2=hdfread(sds_info2(31));
depolarization_gainratio2=hdfread(sds_info2(27));
time2=hdfread(sds_info2(1));
time_utc2=hdfread(sds_info2(2));
latitude2=hdfread(sds_info2(58));
longitude2=hdfread(sds_info2(59));

%% read L2 data

fileinfo_L2=hdfinfo('CAL_LID_L2_05kmAPro-Standard-V4-20.2015-01-01T00-08-22ZD.hdf');

sds_infoL2=fileinfo_L2.SDS;

%read in variables

backscatter532_L2=hdfread(sds_infoL2(19));
depolarization532=hdfread(sds_infoL2(42));

nightflag=hdfread(sds_infoL2(6));

%read in another file

fileinfo_L22=hdfinfo('CAL_LID_L2_05kmAPro-Standard-V4-20.2015-01-01T05-57-33ZN.hdf');
sds_infoL22=fileinfo_L22.SDS;

backscatter532_L22=hdfread(sds_infoL22(19));
depolarization532_2=hdfread(sds_infoL22(42));

nightflag2=hdfread(sds_infoL22(6));
profiletime=hdfread(sds_infoL22(5));
%% read L2 Aerosol Layer data

fileinfo_AL2=hdfinfo('CAL_LID_L2_05kmALay-Standard-V4-20.2015-01-01T00-08-22ZD.hdf');

sds_infoAL2=fileinfo_AL2.SDS;

%read in variables

backscatter532_AL2=hdfread(sds_infoAL2(18));
volume_depolarization532=hdfread(sds_infoAL2(62));


