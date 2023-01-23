clc
clear
tic
a=readtable('dat_mov_001.csv');
toc
close all

% num_max     =   7*48*1000*10;

set(groot, 'defaultAxesTickLabelInterpreter','latex'); 
set(groot, 'defaultLegendInterpreter','latex');


num_max     =   7*48*1000*10;
b           =   a(1:num_max,:);
Day   =     b.StartTime.Day;
Format=     b.StartTime.Format;
Hour  =     b.StartTime.Hour;
Minute=     b.StartTime.Minute;
Month =     b.StartTime.Month;
Second=         b.StartTime.Second;
SystemTimeZone=     b.StartTime.SystemTimeZone;
TimeZone =  b.StartTime.TimeZone;
Year   =    b.StartTime.Year;

NEName      = b.NEName;
IPPATH      = b.IPPATH;
MeanLoss    = b.PING_MeanLOST___;
% col_ippat   = zeros(num_max,1);

% for i_1=1:num_max
%     char_ip_pat     =   char(b.IPPATH(i_1));
%     char_ip_pat     =   b.IPPATH;
%     vec             =   strfind(char_ip_pat,'ID');
%     vec_2           =   strfind(char_ip_pat,',');
%     col_ippat(i_1,1) = str2num([char_ip_pat(vec(1)+3:vec_2-1) char_ip_pat(vec(2)+3)]);
%     col_ippat(i_1,1) = str2num([char_ip_pat(vec(1)+3:vec_2-1) char_ip_pat(vec(2)+3)]);
% col_ippat = b.IPPATH*10+b.VS_IPPATH;
% end

% tab_col_ippat = table(col_ippat);
% b=[b tab_col_ippat];

ind_b_inl=strcmp(MeanLoss,'NIL');
b(ind_b_inl,:) = [];
col_ippat = b.IPPATH*10+b.VS_IPPATH;
% b=table(b);
b.PING_MeanLOST___=str2num(char(b.PING_MeanLOST___));
% vec_ip_pat_mea_los = cellfun(@str2num,b.PING_MeanLOST___);

vec_ID=[];
vec_ID_real=[];
vec_ID_real_num=[];
% id1=
close all
i_real=0;
leg={};
tot_pun_per=7*48;
% load('dat_mov.mat','vec_ID_real');
% for id=vec_ID_real
% i_id=0;
% mat_mea_los
mat_mea_los=[];
num_leg=[];
for id=800:1:5000                                               %identificadores buscados, reemplazar por los reales, listado
%     i_id=i_id+1;
    ID_=id*10+1;                                                %tomamos el sector 1 de cada nodo ya que todos poseen un sector 1
    vec_ID(id)=ID_;
    vec_mea_los_ID=b.PING_MeanLOST___(col_ippat==ID_);        %col_ippat es el identificador del nodo B
                                                              %descubre si el id es valido        
    id_vec_mea_los=0;
    if isempty(vec_mea_los_ID)
        id_vec_mea_los=id_vec_mea_los+1;
    else
        i_real=i_real+1;
        leg{i_real}=num2str(id);
        num_leg(i_real)=id;
%         vec_ID_real_num(i_real) = ID_;
        vec_ID_real(i_real)=ID_;
        vec_mea_los_part=vec_mea_los_ID(1:tot_pun_per);
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
tex_auto_corr={};
for i_mea_los=1:size(mat_mea_los,2)
   fig=figure;
   plot(mat_mea_los(:,i_mea_los),'-');
   
   [titulo,num_periodos,umbral,auto_corr]=esperiodica(mat_mea_los(:,i_mea_los));
   tex_esperiodica=[titulo tex_esperiodica];
   tex_umbral=[umbral tex_umbral];
   tex_num_periodos=[num_periodos tex_num_periodos];
   tex_auto_corr=[auto_corr tex_auto_corr];
   title(titulo);
   xlabel('$Lag$ $30$ $min.$','interpreter','latex')
   ylabel('$Packet$ $loss$','interpreter','latex')
   leg_fil=fun_bus_nom(num_leg(i_mea_los),tab_nom);
   tex_nombre=[leg_fil;tex_nombre];
   legend(leg_fil)
   saveas(fig,['C:\Users\juan\Dropbox\Proyecto TFM\' 'graficosTFM\' leg_fil '.png']);
   close all
end
toc
num_ref=(i_mea_los:-1:1)';
tabla_rbs=table(num_ref,tex_nombre,tex_esperiodica(:),tex_umbral(:),tex_num_periodos(:),tex_auto_corr(:));
table_rbs_sorted= sortrows(tabla_rbs,1);
% table_rbs_sorted(find(strcmp('SMALL UIO CHICHE1',table_rbs_sorted.tex_nombre)),:)

Table_esperiodica=table(tex_nombre(:),tex_esperiodica(:));

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
%             [Pxx,Fxx] = periodogram(vec_mat_mea_loss,[],length(vec_mat_mea_loss),1);
%             F = cumsum(Pxx)./sum(Pxx);
%             figure(3)
%             fig3=plot(F,ban_leg(i_au2));hold on;
        end
       xlabel('$Lag$ $30$ $min.$','interpreter','latex')
       ylabel('$Packet$ $loss$','interpreter','latex')
        vec_ID_real_corr=vec_ID_real(vec_rep_plo);
        
        vec_sig_corr=num2str(vec_ID_real_corr(:));
%         legend(vec_sig_corr)
legcell=[];
for i_au1=1:length(vec_ID_real(vec_rep_plo))
    val=vec_ID_real(vec_rep_plo);
    pos_row=(tab_nom.Var4==((val(i_au1)-1)/10));
    if sum(pos_row)==0
%         legcell{i_au1}='not found';
        pos_row=(tab_nom.Var4==str2num(['4' num2str(((val(i_au1)-1)/10))]));
        if sum(pos_row)==0
            pos_row=(tab_nom.Var4==str2num(['3' num2str(((val(i_au1)-1)/10))]));
            val_str=tab_nom.Var1(pos_row);
            
            if sum(pos_row)==0
                legcell{i_au1}=num2str(((val(i_au1)-1)/10));
            else
                legcell{i_au1}=val_str{:};
            end
        else
            val_str=tab_nom.Var1(pos_row);
            legcell{i_au1}=val_str{:};
        end
    else
        val_str=tab_nom.Var1(pos_row);
        legcell{i_au1}=val_str{:};
    end
end
% vec_leg_cell{} = [vec_leg_cell';legcell];
vec_val_cell = [vec_val_cell(:);val(:)];
i_cell=0;
for i_leg_cell=1+las_len:length(legcell)+las_len
    i_cell=i_cell+1;
    vec_leg_cell{i_leg_cell}=legcell{i_cell};
end
las_len=las_len+length(legcell);
% figure

figure(2);legend(legcell);
saveas(fig2,['C:\Users\juan\Dropbox\Proyecto TFM\' 'graficosTFM\' 'corr2_' num2str(ind_cor)  '.png']);

close all

    end
end