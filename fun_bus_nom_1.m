function y=fun_bus_nom_1(vec_ID_real,tab_nom)
legcell=[];
    val=vec_ID_real;
    pos_row=(tab_nom.Var4==((val-1)/10));
    if sum(pos_row)==0
        pos_row=(tab_nom.Var4==str2num(['4' num2str(((val-1)/10))]));
        if sum(pos_row)==0
            pos_row=(tab_nom.Var4==str2num(['3' num2str(((val-1)/10))]));
            val_str=tab_nom.Var1(pos_row);
            
            if sum(pos_row)==0
                legcell=num2str(((val-1)/10));
            else
                legcell=val_str{:};
            end
        else
            val_str=tab_nom.Var1(pos_row);
            legcell=val_str{:};
        end
    else
        val_str=tab_nom.Var1(pos_row);
        legcell=val_str{:};
    end
	y=legcell;
