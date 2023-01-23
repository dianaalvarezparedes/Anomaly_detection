close all;
clear;
tab_sig=readtable('.\descomposicion\tab_mat_periodicos.txt');
mat_sig=tab_sig{:,:};
mat_trend_mea = zeros(size(mat_sig,1),1);
de_trend = zeros(size(mat_sig,1),1);
seasonal = zeros(size(mat_sig,1),1);
for i=1:1
    mat_trend_mea(:,i) = movmean(mat_sig(:,i),48);
    de_trend(:,i)=mat_sig(:,i)./mat_trend_mea(:,i);
    mat_mean=mean(reshape(de_trend,48,[]),2);
    vec_mean=repmat(mat_mean(:),5,1);
    seasonal(:,i)=vec_mean;
end
% de_trend=mat_sig./mat_trend_mea;
%de_means=de_trend-mat_means_col;
% de_noise=mat_sig-de_means;
noise_signal=mat_sig./(mat_trend_mea.*seasonal);
for i=1:1
   subplot(5,1,1)
   plot(mat_sig(:,i));
   subplot(5,1,2);
   plot(mat_trend_mea(:,i));
   subplot(5,1,3)
   plot(de_trend(:,i)); 
   subplot(5,1,4)
   plot(seasonal(:,i));
   subplot(5,1,5)
   plot(noise_signal(:,i));
end