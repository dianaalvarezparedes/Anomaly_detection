clc
clear
tic
% a=readtable('table_mov.csv');
a=readtable('dat_mov_001_backup.csv');
toc
close all
num_max     =   9*48*1000*10;
b           =   a(1:num_max,:);

A1=b.IPPATH;
B1=replace(A1,"Adjacent Node ID=","");
C1=replace(B1," IP path ID=","");
D1=string(C1);
E1=split(D1,',');
F1=double(E1);
b.IPPATH=F1(:,1);
b.Sector=F1(:,2);
MeanLoss    = b.VS_IPPATH_PING_MeanLOST___;
ind_b_inl=strcmp(MeanLoss,'NIL');
b(ind_b_inl,:) = [];
DataTable=b;
writetable(DataTable, 'clean_data.txt','QuoteStrings',true);