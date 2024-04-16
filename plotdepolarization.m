%% plots

%% plot 1
%
% plot parallel backscatter & depolarization ratio on same plot

figure(555)
y2=parallel_backscatternight;
y1=depolarization_rationight;

yyaxis left
plot(y1,'-k')
ylabel('Depolarization Ratio')

yyaxis right
plot(y2,'-r')
ylabel('Parallel Backscatter')
title('Parallel Backscatter and Depolarization Ratio Entire Dataset')

%% plot 2
%
% plot parallel backscatter & depolarization ratio against each other

figure(666)
plot(parallel_backscatternight,depolarization_rationight,'.k')
xlabel('Parallel Backscatter');
ylabel('Depolarization ratio');
grid on 
axis square
title('Parallel Backscatter vs Depolarization Ratio Entire Dataset')
%% plot 3 
%
% plot location 
lat_ocean=latitude_night(Flags);
lon_ocean=longitude_night(Flags);

figure(9494)
geoscatter(lat_ocean,lon_ocean,'^')

%% plot 4
%
% plot location of 39ZD file 
lat_ocean38ZD=latitude_night38ZD(Flags38ZD);
lon_ocean38ZD=longitude_night38ZD(Flags38ZD);

figure(4949)
geoscatter(lat_ocean38ZD,lon_ocean38ZD,'^')

%
figure(555)
y2=parallel_backscatternight38ZD;
y1=depolarization_rationight38ZD;

yyaxis left
plot(y1,'-k')
ylabel('Depolarization Ratio')

yyaxis right
plot(y2,'-r')
ylabel('Parallel Backscatter')
title('Parallel Backscatter and Depolarization Ratio')

% plot parallel backscatter & depolarization ratio against each other
figure(666)
plot(parallel_backscatternight38ZD,depolarization_rationight38ZD,'.k')
xlabel('Parallel Backscatter');
ylabel('Depolarization ratio');
grid on 
axis square

%% Plot for another night file

%% plot 4
%
% plot location of 39ZD file 
lat_ocean30ZN=latitude_night30ZN(Flags30ZN);
lon_ocean30ZN=longitude_night30ZN(Flags30ZN);

figure(8484)
geoscatter(lat_ocean30ZN,lon_ocean30ZN,'^')
title('Geo Plot 30ZN')

%
figure(9898)
y2=parallel_backscatternight30ZN;
y1=depolarization_rationight30ZN;

yyaxis left
plot(y1,'-k')
ylabel('Depolarization Ratio 30ZN')

yyaxis right
plot(y2,'-r')
ylabel('Parallel Backscatter')
title('Parallel Backscatter and Depolarization Ratio 30ZN')

% plot parallel backscatter & depolarization ratio against each other
figure(2424)
plot(parallel_backscatternight30ZN,depolarization_rationight30ZN,'.k')
xlabel('Parallel Backscatter');
ylabel('Depolarization ratio');
title('Parallel Backscatter vs Depolarization Ratio 30ZN');
grid on 
axis square
%% Plot 5
%
% Plot depolarization ratio over pacific ocean 

figure(8800)
y2=parbackscat_pacific;
y1=depolarization_pacific;


yyaxis left
plot(y1,'-k')
ylabel('Depolarization Ratio')

yyaxis right
plot(y2,'-r')
ylabel('Parallel Backscatter')
title('Parallel Backscatter and Depolarization Ratio Northern Pacific Ocean')

% plot parallel backscatter & depolarization ratio against each other
figure(3090)
plot(parbackscat_pacific,depolarization_pacific,'.k')
xlabel('Parallel Backscatter');
ylabel('Depolarization ratio');
grid on 
axis square
title('Parallel Backscatter vs. Depolarization Northern Pacific Ocean')

%% plots 6
%
%plot over southern pacific ocean 

figure(1200)
y2=parbackscat_lp;
y1=depolarization_lp;


yyaxis left
plot(y1,'-k')
ylabel('Depolarization Ratio')

yyaxis right
plot(y2,'-r')
ylabel('Parallel Backscatter')
title('Parallel Backscatter and Depolarization Ratio Southern Pacific Ocean')

% plot parallel backscatter & depolarization ratio against each other
figure(1400)
plot(parbackscat_lp,depolarization_lp,'.k')
xlabel('Parallel Backscatter');
ylabel('Depolarization ratio');
grid on 
axis square
title('Parallel Backscatter and DepolarizationRatio Southern Pacific Ocean')
