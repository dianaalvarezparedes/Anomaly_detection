legend(leg);
tex_esperiodica={};
tex_nombre={};
for i_mea_los=1:size(mat_mea_los,2)
   fig=figure;
   plot(mat_mea_los(:,i_mea_los),'-');
   tex_esperiodica=[esperiodica(mat_mea_los(:,i_mea_los)); tex_esperiodica];
   title(tex_esperiodica);
   xlabel('$Lag$ $30$ $min.$','interpreter','latex')
   ylabel('$Packet$ $loss$','interpreter','latex')
   leg_fil=fun_bus_nom(num_leg(i_mea_los),tab_nom);
   tex_nombre=[leg_fil;tex_nombre];
%    legend(leg_fil)
%    saveas(fig,['C:\Users\juan\Dropbox\Proyecto TFM\' 'graficosTFM\' leg_fil '.png']);
   close all
end
toc
num_ref=(1:i_mea_los)';
tabla_rbs=table(num_ref,tex_nombre,tex_esperiodica);