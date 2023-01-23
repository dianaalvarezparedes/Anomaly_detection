% set(groot, 'defaultAxesTickLabelInterpreter','latex'); 
% set(groot, 'defaultLegendInterpreter','latex');
% clc
% clear
% close all
% %------------------------------
% b=readtable('clean_data.txt');
% %------------------------------
% %------------------------------
% col_ippat = b.IPPATH*10+b.Sector;
% b.PING_MeanLOST___=str2num(char(b.VS_IPPATH_PING_MeanLOST___));

vec_ID=[];
vec_ID_real=[];
vec_ID_real_num=[];
i_real=0;
leg={};
inicio_semana=4*48;
tot_pun_per=inicio_semana+5*48;
mat_mea_los=[];
num_leg=[];
% col_ippat=col_ippat*10+1;
vec_index_values=unique(b.IPPATH,'rows');
for id=800:5000                                               %identificadores buscados, reemplazar por los reales, listado
    ID_=id*10+1;                                                %tomamos el sector 1 de cada nodo ya que todos poseen un sector 1
    vec_ID(id)=ID_;
%     col_ippat=col_ippat*10+1;
    vec_mea_los_ID=b.PING_MeanLOST___(col_ippat==ID_);        %col_ippat es el identificador del nodo B
                                                              %descubre si el id es valido        
    if isempty(vec_mea_los_ID)
    else
        i_real=i_real+1;
        leg{i_real}=num2str(id);
        num_leg(i_real)=id;
        vec_ID_real(i_real)=ID_;
        vec_mea_los_part=vec_mea_los_ID(inicio_semana+1:tot_pun_per);
        plot(vec_mea_los_part);hold on;
        mat_mea_los(:,i_real)=vec_mea_los_part;
    end
   xlabel('$Lag$ $30$ $min.$','interpreter','latex')
   ylabel('$Packet$ $loss$','interpreter','latex')
end

tab_nom = readtable('rbs.csv'); 

legend(leg);
tex_esperiodica={};
tex_nombre={};
tex_umbral={};
tex_num_periodos={};
tex_diagnostico={};
tex_auto_corr={};
mat_dat_periodicos=[];
mat_dat_noperiodicos=[];
mat_dat_sinerror=[];
for i_mea_los=1:size(mat_mea_los,2)
   fig=figure;
   plot(mat_mea_los(:,i_mea_los),'-');
   
   [titulo,num_periodos,umbral,auto_corr]=esperiodica(mat_mea_los(:,i_mea_los));
   tex_esperiodica=[titulo tex_esperiodica];
   tex_umbral=[umbral tex_umbral];
   tex_num_periodos=[num_periodos tex_num_periodos];
%    tex_diagnostico=[diagnostico tex_diagnostico];
   tex_auto_corr=[auto_corr tex_auto_corr];
   title(titulo);
   xlabel('$Lag$ $30$ $min.$','interpreter','latex')
   ylabel('$Packet$ $loss$','interpreter','latex')
   leg_fil=fun_bus_nom(num_leg(i_mea_los),tab_nom);
   tex_nombre=[leg_fil;tex_nombre];
   legend(leg_fil)
   if strcmp(titulo,'es periodica')
       saveas(fig,['C:\Users\juan\Dropbox\Proyecto TFM\' 'graficosTFM\intento3\es_periodica\' leg_fil '4' ' .png']);
       mat_dat_periodicos=[mat_dat_periodicos mat_mea_los(:,i_mea_los)];
   elseif strcmp(titulo, 'no es periodica')
       saveas(fig,['C:\Users\juan\Dropbox\Proyecto TFM\' 'graficosTFM\intento3\no_periodica\' leg_fil '4' ' .png']);
       mat_dat_noperiodicos=[mat_dat_noperiodicos mat_mea_los(:,i_mea_los)];
   elseif strcmp(titulo, 'sin problema')
        saveas(fig,['C:\Users\juan\Dropbox\Proyecto TFM\' 'graficosTFM\intento3\sin_problema\' leg_fil '4' ' .png']);
        mat_dat_sinerror=[mat_dat_sinerror mat_mea_los(:,i_mea_los)];
   end
   close all
end

num_ref=(i_mea_los:-1:1)';
tabla_rbs=table(num_ref,tex_nombre,tex_esperiodica(:),tex_umbral(:),tex_num_periodos(:),tex_auto_corr(:));
table_rbs_sorted= sortrows(tabla_rbs,1);
Table_esperiodica=table(tex_nombre,tex_esperiodica(:));

Tab_res.Periodicidad=tex_esperiodica;
Tab_res.Nombre=tex_nombre;

[mat1] =    corrcoef(mat_mea_los);

mat2=mat1-diag(diag(mat1));
vec_leg_cell=[];
vec_val_cell=[];
las_len=0;
for ind_cor=1:length(mat1)
    trigger=.7;
    [row, col]=find((mat2(ind_cor,:))>trigger);
    vec_rep_plo=sort(unique([col],'first'));
%%%
    if isempty(row)
    else
        
        for i_au2=1:length(vec_rep_plo)
            vec_mat_mea_loss=mat_mea_los(:,vec_rep_plo(i_au2));
            figure(2);
            fig2=plot(vec_mat_mea_loss,ban_leg(i_au2));hold on;
        end
        xlabel('$Lag$ $30$ $min.$','interpreter','latex')
        ylabel('$Packet$ $loss$','interpreter','latex')
        vec_ID_real_corr=vec_ID_real(vec_rep_plo);
        
        vec_sig_corr=num2str(vec_ID_real_corr(:));
    legcell=[];
    for i_au1=1:length(vec_ID_real(vec_rep_plo))
        val=vec_ID_real(vec_rep_plo);
        pos_row=(tab_nom.NodeB==((val(i_au1)-1)/10));
        if sum(pos_row)==0
            pos_row=(tab_nom.NodeB==str2num(['4' num2str(((val(i_au1)-1)/10))]));
            if sum(pos_row)==0
                pos_row=(tab_nom.NodeB==str2num(['3' num2str(((val(i_au1)-1)/10))]));
                val_str=tab_nom.Name(pos_row);

                if sum(pos_row)==0
                    legcell{i_au1}=num2str(((val(i_au1)-1)/10));
                else
                    legcell{i_au1}=val_str{:};
                end
            else
                val_str=tab_nom.Name(pos_row);
                legcell{i_au1}=val_str{:};
            end
        else
            val_str=tab_nom.Name(pos_row);
            legcell{i_au1}=val_str{:};
        end
    end
    vec_val_cell = [vec_val_cell(:);val(:)];
    i_cell=0;
    for i_leg_cell=1+las_len:length(legcell)+las_len
        i_cell=i_cell+1;
        vec_leg_cell{i_leg_cell}=legcell{i_cell};
    end
    las_len=las_len+length(legcell);
% 
%     figure(2);legend(legcell);
%     saveas(fig2,['C:\Users\juan\Dropbox\Proyecto TFM\' 'graficosTFM\intento3\' 'corr3_' num2str(ind_cor)  '.png']);

    close all

    end
end
writetable(tabla_rbs, '.\graficosTFM\intento3\tab_res_nom_per.csv','QuoteStrings',true);
datawir=array2table(mat_mea_los);writetable(datawir, '.\graficosTFM\intento3\tab_mat_mea_los.csv');

datawir=array2table(mat_dat_periodicos);writetable(datawir, '.\graficosTFM\intento3\tab_mat_periodicos.txt');
datawir=array2table(mat_dat_noperiodicos);writetable(datawir, '.\graficosTFM\intento3\tab_mat_noperiodicos.txt');
datawir=array2table(mat_dat_sinerror);writetable(datawir, '.\graficosTFM\intento3\tab_mat_sinerror.txt');