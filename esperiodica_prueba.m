function [aa,num_periodos,umbral,auto_corr]=esperiodica_prueba(signal)
% signal=mat_mea_los(:,1:20);
auto_corr=xcorr(signal-mean(signal),'unbiased');
auto_corr_norm=auto_corr/max(auto_corr);
plot(auto_corr_norm);hold on;
% for i=1:7;line([(i-1)*48+1 (i-1)*48+1],[0 100],'Color','black','LineStyle','--');end;
auto_corr=0.4;
% num_periodos=(sum(auto_corr_norm>auto_corr)-1)/2;
% mat_48_filas=reshape([0;auto_corr_norm],48,[]);[val,pos]=max(mat_48_filas,[],1);plot(1:48:2*7*48,val)
mat_48_filas=reshape([0;auto_corr_norm],48,[]);
[val,pos]=max(mat_48_filas,[],1);
num_periodos=sum(val>auto_corr);
umbral=12;
if num_periodos>umbral
    aa='es periodica';
else
    aa='no es periodica';
end
line([0 700],[0.4 0.4])
% num_periodos