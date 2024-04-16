%% Compare Calipso 2012 data with SOAP data
%SOAP data is flagged and we know which dates have whitecaps in them 
%therefore we can see what kind of signal we can expect from LIDAR 


%%convert CALIPSO UTC date to datetime

cr_2018.datenum=[];
for i=1:length(cr_2018.timeutc)
    x=cr_2018.timeutc(i);
    
    d=datetime(string(floor(x)),'InputFormat','yyMMdd');
    t=days(x-floor(x));
    
    dt=d+t;
    k=datenum(dt);
    cr_2018.datenum=[cr_2018.datenum;k];
end

cr_2018.datetime=datetime(cr_2018.datenum,'ConvertFrom','datenum');

%% Get the WC fractions from SOAP 

%interpolate the averaged WC data from SOAP so its the same size as CALIPSO
x=dep_cal2012; y=wc_average;
ix = linspace(1, numel(x), numel(y));
WC_interp = interp1(ix, y, 1:numel(x)); WC_cap=WC_interp';

%% Plots

%plot WC when we know there are whitecaps in SOAP data
figure(333)
subplot(2,2,1)
semilogy(new_u10wcav,wc_average,'.m','MarkerSize',10);
xlabel('Wind Speed (m/s)')
ylabel('WC')
grid on
title('WC vs Wind Speed (SOAP 2012)')

subplot(2,2,2)
semilogy(wcdate_av,wc_average,'.m','MarkerSize',10);
xlabel('Datetime')
ylabel('WC')
grid on
title('Time series of WC (SOAP 2012)')

subplot(2,2,3)
semilogy(wspd_CCMP2012,dep_cal2012,'.m','MarkerSize',10);
xlabel('Wind Speed (m/s)')
ylabel('Depolarization')
ylim([0 0.15])
xlim([0 22])
grid on
title('Depolarization vs Wind Speed (Calipso/CCMP)')

subplot(2,2,4)
plot(cr_2018.datetime,dep_cal2012,'.m');
xlabel('Datetime')
ylabel('Depolarization')
ylim([0 0.15])
grid on
title('Time Series of Depolarization')
%Plot ALL the WC data
%plotting all will give us an idea what a signal for whitecaps look like


