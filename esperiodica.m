function [aa,num_periodos,umbral,auto_corr]=esperiodica(signal)
vec_error=signal>1;

if sum(vec_error)>0
    auto_corr=xcorr(signal-mean(signal),'unbiased');
    auto_corr_norm=auto_corr/max(auto_corr);
    % plot(auto_corr_norm);hold on;
    for i=1:6
        line([(i-1)*48+1 (i-1)*48+1],[0 max(signal)],'Color','black','LineStyle','--');
    end
    auto_corr=0.4;
    mat_48_filas=reshape([0;auto_corr_norm],48,[]);
    [val,pos]=max(mat_48_filas,[],1);
    num_periodos=sum(val>auto_corr);
    umbral=4;
    if num_periodos>umbral
        aa='es periodica';
    else
        aa='no es periodica';
    end
else
    auto_corr=xcorr(signal-mean(signal),'unbiased');
    auto_corr_norm=auto_corr/max(auto_corr);
    for i=1:6
        line([(i-1)*48+1 (i-1)*48+1],[0 max(signal)],'Color','black','LineStyle','--');end;
    auto_corr=0.4;
    mat_48_filas=reshape([0;auto_corr_norm],48,[]);
    [val,pos]=max(mat_48_filas,[],1);
    num_periodos=sum(val>auto_corr);
    umbral=4;
    aa='sin problema';
end