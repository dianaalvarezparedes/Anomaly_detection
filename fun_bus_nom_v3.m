function y=fun_bus_nom_v3(vec_ID_real,tab_nom)
legcell=[];
val=vec_ID_real;
 pos_row=(tab_nom.bts_rnc_adj==val);
 if sum(pos_row)==0
             legcell=val_str{:};
 else
     val_str=tab_nom.bts_rnc_adj(pos_row);
     legcell=val_str{:};
 end
y=legcell;
