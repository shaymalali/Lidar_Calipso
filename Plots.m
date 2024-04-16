%Plot depolarization
%load('CalipsoData.mat');

figure(111)
subplot(2,2,1)
myh3dlog(surf_2018.tbsc,dep_cal2018)
xlabel('Total Backscatter')
ylabel('Depolarization')
caxis([0 8])
title('Total Backscatter vs Depolarization (2018)')

subplot(2,2,2)
myh3dlog(surf_2018.pbsc,dep_cal2018)
xlabel('Parallel Backscatter')
ylabel('Depolarization')
caxis([0 8])
title('Parallel Backscatter vs Depolarization (2018)')


subplot(2,2,3)
myh3dlog(surf_2018.prpbsc,dep_cal2018)
xlabel('Perpendicular Backscatter')
ylabel('Depolarization')
caxis([0 8])
xlim([0 0.09])
title('Perpendicular Backscatter vs Depolarization (2018)')
savefig('bsc v dep 2018')

figure(112)
scatter(surf_2018.pbsc,dep_cal2018,[],j.wspd,'filled');
h=colorbar;
ylabel(h,'CCMP Wind Speeds')
ylabel('Depolarization')
xlabel('Surface Backscatter')
ylim([0 0.02])
title('Backscatter vs Depolarization as a function of windspeed (November 2015)')
colormap jet

%%
%plot using the bins below and above the surface? 
p562=cr.pbsc(562,:); prp562=cr.prpbsc(562,:); t562=cr.tbsc(562,:); 

figure(112)
subplot(2,2,1)
myh3dlog(dep_cal2012,surf.tbsc)
xlabel('Total Backscatter')
ylabel('Depolarization')
caxis([0 4])
title('Total Backscatter vs Depolarization (bin 563) ')

subplot(2,2,3)
myh3dlog(t562,dep)
xlabel('Total Backscatter')
ylabel('Depolarization')
caxis([0 4])
xlim([0 0.09])
title('Total Backscatter vs Depolarization (bin 562) ')

subplot(2,2,2)
myh3dlog(surf.pbsc,dep)
xlabel('Parallel Backscatter')
ylabel('Depolarization')
caxis([0 4])
title('Parallel Backscatter vs Depolarization (bin 563) ')

subplot(2,2,4)
myh3dlog(p562,dep)
xlabel('Parallel Backscatter')
ylabel('Depolarization')
caxis([0 4])
xlim([0 0.09])
title('Parallel Backscatter vs Depolarization (bin 562)')
savefig('562 v 563 dep bsc')

%%
%plot the backscatter vs altitude 

figure(113)
subplot(3,3,1)
plot(c.pbscf((430:end),1),c.alt(430:end),'-b');
xlabel('Backscatter')
ylabel('Altitude')
title('Backscatter vs Altitude (1)')
grid on 


subplot(3,3,2)
plot(c.pbscf((430:end),100),c.alt(430:end),'-b');
xlabel('Backscatter')
ylabel('Altitude')
title('Backscatter vs Altitude (100)')
grid on 


subplot(3,3,3)
plot(c.pbscf((430:end),500),c.alt(430:end),'-b');
xlabel('Backscatter')
ylabel('Altitude')
title('Backscatter vs Altitude (500)')
grid on 

subplot(3,3,4)
plot(c.pbscf((430:end),750),c.alt(430:end),'-b');
xlabel('Backscatter')
ylabel('Altitude')
title('Backscatter vs Altitude (750)')
grid on 

subplot(3,3,5)
plot(c.pbscf((430:end),900),c.alt(430:end),'-b');
xlabel('Backscatter')
ylabel('Altitude')
title('Backscatter vs Altitude (900)')
grid on 

subplot(3,3,6)
plot(c.pbscf((430:end),1000),c.alt(430:end),'-b');
xlabel('Backscatter')
ylabel('Altitude')
title('Backscatter vs Altitude (1000) ')
grid on 



%%
figure(115)
subplot(2,2,1)
myh3dlog(j.wspd,dep_cal2018)
xlabel('CCMP Wind Speed (m/s)')
ylabel('Depolarization')
caxis([0 8])
title('CCMP Wind Speed vs Depolarization')

subplot(2,2,3)
myh3dlog(j.wspd,surf_2018.tbsc)
xlabel('Wind speed (m/s)')
ylabel('Total Backscatter')
caxis([0 8])
title('Total Backscatter vs Wind speed (CCMP)')

subplot(2,2,2)
myh3dlog(surf_2018.tbsc,dep_cal2018)
xlabel('Total Backscatter')
ylabel('Depolarization')
caxis([0 8])
title('Total Backscatter vs Depolarization')
savefig('myh3dlog of dep')

%% Plot 2015 vs 2016 data 

figure(116)

plot(surf_2018.pbsc,'-k')

%% Plot time series of Backscatter and depolarization



%% Plot high wind speeds
figure(119)
subplot(2,1,2)
plot(cr_2018.pbschi,'-k'); hold on 
plot(cr_2018.prpbschi,'-.k'); hold on
plot(dephi,'-r'); hold on
ylim([0 1.5])
xlabel('Satellite Track')
ylabel('Backscatter and Depolarization')
legend('Parallel Backscatter','Perpendicular Backscatter','Depolarization')

subplot(2,2,2)
scatter(surf_2018.pbhi,dephi,[],j.hiwspd,'filled');
h=colorbar;
ylabel(h,'CCMP Wind Speeds')
ylabel('Depolarization')
xlabel('Surface Backscatter')
ylim([0 0.02])
title('Backscatter vs Depolarization as a function of windspeed (Winter 2018)')
colormap jet
caxis([15 20])

subplot(2,2,1)
lrand=rand(1696,1); j.lathi=double(j.lathi); j.lonhi=double(j.lonhi);
worldmap([20 50], [-60 -30])
pcolorm(j.lathi,j.lonhi,j.hiwspd); hold on
scatterm(j.lathi,j.lonhi,lrand,'^w','LineWidth',10);
h=colorbar; 
ylabel(h,'CCMP Wind Speeds')
caxis([15 20])
savefig('High wind speeds map of dep & backscatter')
%look at the peak wind at end 
j.wspd8=j.wspd(1800:end); j.lat8=j.lat(1800:end); j.lon8=j.lon(1800:end);
cr_2018.lat8=cr_2018.latf(1800:end); cr_2018.lon8=cr_2018.lonf(1800:end);
cr_2018.dt8=cr_2018.datetime(1800:end); cr_2018.pb8=cr_2018.pbsc(1800:end);

surf_2018.pb8=surf_2018.pbsc(1800:end); dep8=dep_cal2018(1800:end);
surf_2018.prp8=surf_2018.prpbsc(1800:end);

figure(120)
subplot(2,1,2)
plot(surf_2018.pb8,'-k'); hold on 
plot(surf_2018.prp8,'-.k'); hold on
plot(dep8,'-r'); hold on
xlabel('Satellite Track')
ylabel('Backscatter and Depolarization')
legend('Parallel Backscatter','Perpendicular Backscatter','Depolarization')

subplot(2,2,2)
scatter(surf_2018.pb8,dep8,[],j.wspd8,'filled');
h=colorbar;
ylabel(h,'CCMP Wind Speeds')
ylabel('Depolarization')
xlabel('Surface Backscatter')
ylim([0 0.02])
title('Backscatter vs Depolarization as a function of windspeed (Winter 2018)')
colormap jet
caxis([0 20])

subplot(2,2,1)
lrand=rand(length(dep8),1); j.lat8=double(j.lat8); j.lon8=double(j.lon8);
worldmap([20 50], [-60 -30])
pcolorm(j.lat,j.lon,j.wspd); hold on
scatterm(j.lat8,j.lon8,lrand,'^w','LineWidth',10);
h=colorbar; 
ylabel(h,'CCMP Wind Speeds')
caxis([0 20])

