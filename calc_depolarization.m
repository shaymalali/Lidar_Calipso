%% calculate depolarization values

t_backscatter=total_backscatter(:,562);
p_backscatter=perp_backscatter(:,562);
parallel_backscatter=(t_backscatter)-(p_backscatter);

% depolarization = perp backscatter/parallel backscatter

depolarization_ratio=p_backscatter./parallel_backscatter;

depolarizationstats_day.max=max(depolarization_ratio);
depolarizationstats_day.min=min(depolarization_ratio);
depolarizationstats_day.mean=mean(depolarization_ratio);

%% calculate depolarization values for nightime measurements

%find data in ocean 

water_data=find(landwatermask==7 | landwatermask==0);
Perp_saturationdata=find(PerpSurface_saturationflag==0);
Par_saturationdata=find(ParSurface_saturationflag==0);
Perp_negativedata=find(PerpNegative_flag==-1);
Par_negativedata=find(ParNegative_flag==-1);

t_backscatternight=total_backscatternight(:,562);
p_backscatternight=perp_backscatternight(:,562);


Saturation_flags=intersect(Perp_saturationdata,Par_saturationdata);
Negative_flags=intersect(Perp_negativedata,Par_negativedata);
Pre_flags=intersect(Saturation_flags,water_data);
Flags=intersect(Pre_flags,Negative_flags);

t_backscatternight=t_backscatternight(Flags);
p_backscatternight=p_backscatternight(Flags);

%find data at specific latitudes
lat_ocean=latitude_night(Flags);
lon_ocean=longitude_night(Flags);

lat_flags=find(lat_ocean < 30 & lat_ocean >23);
lat_pacific=lat_ocean(lat_flags);
lon_pacific=lon_ocean(lat_flags);

parallel_backscatternight=(t_backscatternight)-(p_backscatternight);

% depolarization = perp backscatter/parallel backscatter

depolarization_rationight=p_backscatternight./parallel_backscatternight;

depolarizationstats_night.max=max(depolarization_rationight);
depolarizationstats_night.min=min(depolarization_rationight);
depolarizationstats_night.mean=mean(depolarization_rationight);

%%
%get stats for Yong's data
dpstats.max=max(dp);
dpstats.min=min(dp);
dpstats.mean=mean(dp);
dpstats.std=std(dp);
figure(444)
plot(dp)
title('Yongs Data');
%get time data
time_data=time_night(Flags);
datetime_night=datetime(1993,1,1)+seconds(time_data);


%look at depolarization ratios at pacific ocean 
depolarization_pacific=depolarization_rationight(lat_flags);
parbackscat_pacific=parallel_backscatternight(lat_flags);



depolarizationstats_pacific.max=max(depolarization_pacific);
depolarizationstats_pacific.min=min(depolarization_pacific);
depolarizationstats_pacific.mean=mean(depolarization_pacific);



%look at lower pacific
lp_flags=find(lat_ocean <-24 & lat_ocean > -60);
lat_lp=lat_ocean(lp_flags);
lon_lp=lon_ocean(lp_flags);
depolarization_lp=depolarization_rationight(lp_flags);
parbackscat_lp=parallel_backscatternight(lp_flags);

figure(1)
subplot(3,1,1)
plot(depolarization_rationight)
title('Depolarization Ratio')

subplot(3,1,2)
plot(depolarization_pacific)
title('Depolarization Ratio Northern Pacific')

subplot(3,1,3)
figure(888)
plot(depolarization_lp)
title('Depolarization Ratio Southern Ocean')
%% Calculate depolarization values for another night file 
%find data in ocean 

water_data38ZD=find(landwatermask38ZD==7 | landwatermask38ZD==0);
Perp_saturationdata38ZD=find(PerpSurface_saturationflag38ZD==0);
Par_saturationdata38ZD=find(ParSurface_saturationflag38ZD==0);
Perp_negativedata38ZD=find(PerpNegative_flag38ZD==-1);
Par_negativedata38ZD=find(ParNegative_flag38ZD==-1);

t_backscatternight38ZD=total_backscatternight38ZD(:,562);
p_backscatternight38ZD=perp_backscatternight38ZD(:,562);


Saturation_flags38ZD=intersect(Perp_saturationdata38ZD,Par_saturationdata38ZD);
Negative_flags38ZD=intersect(Perp_negativedata38ZD,Par_negativedata38ZD);
Pre_flags38ZD=intersect(Saturation_flags38ZD,water_data38ZD);
Flags38ZD=intersect(Pre_flags38ZD,Negative_flags38ZD);

t_backscatternight38ZD=t_backscatternight38ZD(Flags38ZD);
p_backscatternight38ZD=p_backscatternight38ZD(Flags38ZD);

parallel_backscatternight38ZD=(t_backscatternight38ZD)-(p_backscatternight38ZD);
figure(555)
plot(parallel_backscatternight)
hold on
plot(depolarization_rationight,'-r')
% depolarization = perp backscatter/parallel backscatter

depolarization_rationight38ZD=p_backscatternight38ZD./parallel_backscatternight38ZD;

depolarizationstats_night38ZD.max=max(depolarization_rationight38ZD);
depolarizationstats_night38ZD.min=min(depolarization_rationight38ZD);
depolarizationstats_night38ZD.mean=mean(depolarization_rationight38ZD);

%frequency distribution 
h38ZD=histogram(depolarization_rationight38ZD);

%plot data
 figure(999)
 plot(depolarization_rationight38ZD)
 
 %% Calculate depolarization values for another night file 
%find data in ocean 

water_data30ZN=find(landwatermask30ZN==7 | landwatermask30ZN==0);
Perp_saturationdata30ZN=find(PerpSurface_saturationflag30ZN==0);
Par_saturationdata30ZN=find(ParSurface_saturationflag30ZN==0);
Perp_negativedata30ZN=find(PerpNegative_flag30ZN==-1);
Par_negativedata30ZN=find(ParNegative_flag30ZN==-1);

t_backscatternight30ZN=total_backscatternight30ZN(:,562);
p_backscatternight30ZN=perp_backscatternight30ZN(:,562);


Saturation_flags30ZN=intersect(Perp_saturationdata30ZN,Par_saturationdata30ZN);
Negative_flags30ZN=intersect(Perp_negativedata30ZN,Par_negativedata30ZN);
Pre_flags30ZN=intersect(Saturation_flags30ZN,water_data30ZN);
Flags30ZN=intersect(Pre_flags30ZN,Negative_flags30ZN);

t_backscatternight30ZN=t_backscatternight30ZN(Flags30ZN);
p_backscatternight30ZN=p_backscatternight30ZN(Flags30ZN);

parallel_backscatternight30ZN=(t_backscatternight30ZN)-(p_backscatternight30ZN);

% depolarization = perp backscatter/parallel backscatter

depolarization_rationight30ZN=p_backscatternight30ZN./parallel_backscatternight30ZN;

depolarizationstats_night30ZN.max=max(depolarization_rationight30ZN);
depolarizationstats_night30ZN.min=min(depolarization_rationight30ZN);
depolarizationstats_night30ZN.mean=mean(depolarization_rationight30ZN);

%frequency distribution 
h38ZD=histogram(depolarization_rationight30ZN);

%plot data
 figure(9292)
 plot(depolarization_rationight30ZN)

%% integrate depolarization values over layers 
total_backscatternight(total_backscatternight==-9999)=NaN;
perp_backscatternight(perp_backscatternight==-9999)=NaN;


