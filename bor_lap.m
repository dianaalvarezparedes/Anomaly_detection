vec_ind_cor=1:172;
sum_vec_ind_cor=zeros(length(vec_ind_cor),1);
mat2=mat1-diag(diag(mat1));
for ind_cor=vec_ind_cor
    sum_vec_ind_cor(ind_cor)=sum((mat2(ind_cor,:))>trigger);
end
sum(sum_vec_ind_cor)

