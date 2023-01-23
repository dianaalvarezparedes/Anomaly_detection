% load(fullfile(matlabroot,'examples','econ','Data_Accidental.mat'))
y = d_fr;
T = length(y);

figure
plot(y/1000)
% h1 = gca;
% h1.XLim = [0,T];
% h1.XTick = 1:12:T;
% h1.XTickLabel = datestr(dates(1:12:T),10);
title 'Monthly Accidental Deaths';
ylabel 'Number of deaths (thousands)';
hold on



sW13 = [1/24;repmat(1/12,11,1);1/24];
yS = conv(y,sW13,'same');
yS(1:6) = yS(7); yS(T-5:T) = yS(T-6);

xt = y-yS;

h = plot(yS/1000,'r','LineWidth',2);hold on;

legend(h,'13-Term Moving Average')
hold off



s = 12;
sidx = cell(s,1);
for i = 1:s
 sidx{i,1} = i:s:T;
end

sidx{1:2}


figure(10)
plot(xt,'-');hold on;
plot(y,'--');hold on;
plot(yS,'-s');hold on;
legend('tendencia','serie temporal','sin tendencia');

smooth_y=smoothdata(y);
figure(11)
plot(y-smooth_y,'-b');hold on;
plot(y,'-r');hold on;
plot(y-yS,'-g');hold on;
legend('suavizado','datos originales','ajuste cuadratico')

%---------------
close all;
window=5;
medianspeed = movmedian(y,window);
figure(12)
plot(medianspeed,'k');hold on;
plot(y-medianspeed,'b');hold on;
plot(y,'r');
legend('media movil','datos menos media','serie temporal')
% plot(y-smooth_y,'-b');hold on;
% plot(y,'-r');hold on;
% plot(y-yS,'-g');hold on;
% legend('media movil','suavizado','datos originales','ajuste cuadratico')

%--------------------
close all
Anoise=y;
[Asgolay,window] = smoothdata(Anoise,'sgolay');
figure(11)
plot(Asgolay);hold on;
plot(y-Asgolay)


%---------------------busqueda de outliers-------------------
close all
Anoise=y; 
Arlowess = smoothdata(Anoise,'rlowess',5); 
figure(12)
plot(Arlowess);hold on;
plot(y);
% axis tight legend('Noisy Data','Robust Lowess')
%---------------------
close all
Anoise=y;
t=0:length(Anoise)-1;
Amedian = smoothdata(Anoise,'movmedian'); 

plot(t,Anoise,t,Amedian);
TF = isoutlier(Anoise); ind = find(TF);
Afill = filloutliers(Anoise,'next'); 
plot(t,Anoise,t,Afill)
legend('Anoise','Afill')
% axis tight legend('Noisy Data with Outlier','Noisy Data with Filled Outlier')
%---------------------
close all
Anoise=y;
d_trend=detrend(Anoise);
d_trend_5=detrend(Anoise,'linear',1);
plot(d_trend,'-b');hold on;
plot(Anoise,'r-');hold on;
plot(d_trend_5,'-g');hold on;
legend('sin tendencia','Anoise','sin tendencia 5');
grid
%---------------------
close all;
y_log=log10(y+1);
y_diff_log=zeros(1,length(y_log));
y_diff=zeros(1,length(y_log));
for i=1:length(y_log)-1
   y_diff_log(i)=y_log(i+1)-y_log(i); 
   y_diff(i)=y(i+1)-y(i);
end
plot(y_diff_log,'-b');hold on;
plot(y,'-r');hold on;
plot(y_log,'g'),hold on;
plot(y_diff,'k');hold on;
% plot(y_diff,)
legend('y diff log - eliminacion media y varianza const','y','y log varianza constante','y diff');
%------------------------------
%ejercicio con periodicidad
% close all;auto_corr=xcorr(y_diff_log,'unbiased');auto_corr_norm=auto_corr/max(auto_corr);plot(auto_corr_norm);
% num_periodos=(sum(auto_corr_norm>0.5)-1)/2;
% if num_periodos>4
%     'es periodica'
% else
%     'no es periodica'
% end


%ejercicio sin periodicidad
close all;auto_corr=xcorr(mat_mea_los(:,11)-mean(mat_mea_los(:,11)),'unbiased');auto_corr_norm=auto_corr/max(auto_corr);plot(auto_corr_norm);
