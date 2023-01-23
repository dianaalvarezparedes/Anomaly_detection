close all
clear
clc
tab_sig=readtable('.\descomposicion\tab_mat_noperiodicos.txt');
mat_sig=tab_sig{:,:};

max_vec = size(mat_sig,2);
vec_per = {};
for i=1:max_vec
    signal = mat_sig(:,i);
    [evit,mat_trend_mea,de_trend,noise_signal]=descomposicion(signal);
    [aa,num_periodos,umbral,auto_corr]=esperiodica(de_trend);
    vec_per=[aa; vec_per];
end