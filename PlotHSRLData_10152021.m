%% plots
%
%
%% Get data from structure

lat=ans.lat;
lon=ans.lon;
wind=ans.wind_speed;
backscat=ans.bsc;
bbp=ans.bbp;
dep=ans.dep;
%% Plot the locations 

figure(1)
geoscatter(lat,lon)

%% Plot Backscatter vs Depolarization
dep9=dep(9,:); %select date from the 9th row from depolarization matrix 
backscat9=backscat(9,:); 

figure(3)
plot(backscat9,dep9);
xlabel('Backscatter')
ylabel('Depolarization')
savefig('Backscatter vs Depolarization (2015)')

figure(4)
myh3dlog(backscat9,dep9)
xlabel('Backscatter')
ylabel('Depolarization')
title('Backscatter vs Depolarization (2015)')
savefig('Backscatter vs Dep 2015')
%% Plot Wind speed vs Depolarization

figure(4)
plot(wind,dep9);
xlabel('Wind Speed (m/s)')
ylabel('Depolarization')
savefig('Wind Speed vs Depolarization (9th row)')

figure(4)
myh3dlog(wind,dep9)
xlabel('Wind Speed (m/s)')
ylabel('Depolarization')
title('Wind Speed vs Depolarization (2015)')
savefig('Wind vs Dep 2015')

%% Plot backscatter

figure(5)
plot(backscat9);
title('Backscatter')
savefig('Backscatter 532 nm')

%% Plot Depolarization
figure(6)
plot(dep9)
title('Depolarization')
savefig('Depolarization')

%% Plot using myh3dlog function

figure(8)
myh3dlog(wind,dep9)

%% Plot time

figure(9)
plot(ans.altitude,'-b'); hold on
ylabel('Altitude')
title('Time Series of Altitude')

figure(111)
plot(ans.gps_alt,'-b'); 
xlabel('Time (UTC)')
ylabel('Altitude (m)')
title('Altitude Timeseries')
