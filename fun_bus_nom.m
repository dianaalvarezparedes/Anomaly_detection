function y=fun_bus_nom(vec_ID_real,tab_nom)
legcell=[];
    val=vec_ID_real;
    pos_row=(tab_nom.NodeB==val);
    if sum(pos_row)==0
        pos_row=(tab_nom.NodeB==str2num(['4' num2str(((val)))]));
        if sum(pos_row)==0
            pos_row=(tab_nom.NodeB==str2num(['3' num2str(((val)))]));
            val_str=tab_nom.Name(pos_row);
            
            if sum(pos_row)==0
                legcell=num2str(((val)));
            else
                legcell=val_str{:};
            end
        else
            val_str=tab_nom.Name(pos_row);
            legcell=val_str{:};
        end
    else
        val_str=tab_nom.Name(pos_row);
        legcell=val_str{:};
    end
	y=legcell;
