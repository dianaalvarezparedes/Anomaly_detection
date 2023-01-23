vec_ID=[];
vec_ID_real=[];
vec_ID_real_num=[];
% id1=
close all
i_real=0;
leg={};
vec_mea_los_ID=[];
% for id=3000:1:4957
for id=4500:4510
    ID_=id*10+1;
    vec_ID(id)=ID_;
    vec_mea_los_ID=vec_ip_pat_mea_los((b.col_ippat==ID_));
    if isempty(vec_mea_los_ID)
    else
        i_real=i_real+1;
%         size(vec_mea_los_ID)
        vec_len(i_real)=length(vec_mea_los_ID);
        %         leg{i_real}=num2str(ID_);
        leg{i_real}=num2str(id);
        vec_ID_real_num(i_real) = ID_;
        vec_ID_real(i_real)=ID_;
        figure(1)
        plot(vec_mea_los_ID);hold on;
    end
end
legend(leg);
mat_mea_los_ID=[];
for i_r=1:i_real
    ID_=vec_ID_real(i_r);
    vec_mea_los_ID=vec_ip_pat_mea_los((b.col_ippat==ID_))
    mat_mea_los_ID(:,i_r)=vec_mea_los_ID(1:min(vec_len));
end
[mat1] =    corrcoef(mat_mea_los_ID);
trigger=0.5;
[row, col]=find(triu(mat1-diag(diag(mat1)))>trigger);
vec_rep_plo=sort(unique([row; col],'first'));
figure(2);
plot(mat_mea_los_ID(:,vec_rep_plo))
vec_ID_real_corr=vec_ID_real(vec_rep_plo);
vec_sig_corr=num2str(vec_ID_real_corr(:));
legend(vec_sig_corr)
% end