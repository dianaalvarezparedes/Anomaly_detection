function    a = ban_leg(n,c)
% n
if exist('c','var');else;c='k';end
if          n==1
    a=['--' num2str(c)];
elseif      n==2
    a=['-.' num2str(c)];
elseif      n==3
    a=['-*' num2str(c)];
elseif      n==4    
    a=['-o' num2str(c)];
elseif      n==5
    a=['-s' num2str(c)];
elseif      n==6
    a=['-d' num2str(c)];
elseif      n==7
    a=['--o' num2str(c)];
elseif      n==8
    a=['--s' num2str(c)];
elseif      n==9
    a=['--d' num2str(c)];
elseif      n==10
    a=['-^' num2str(c)];
elseif      n==11
    a=['->' num2str(c)];
elseif      n==12
    a=['-V' num2str(c)];
elseif      n==13
    a=['-<' num2str(c)];
elseif      n==14
    a=['--^' num2str(c)];
elseif      n==15
    a=['-->' num2str(c)];
elseif      n==16
    a=['--V' num2str(c)];
elseif      n==17
    a=['--<' num2str(c)];
elseif      n==18
    a=[':o' num2str(c)];
elseif      n==19
    a=[':s' num2str(c)];
elseif      n==20
    a=[':d' num2str(c)];
else
    a=[':d' num2str(c)];
% elseif      n==21
%     a='-o';
% elseif      n==22
%     a='-o';
% elseif      n==23
%     a='-o';
% elseif      n==24
%     a='-o';
% elseif      n==25
%     a='-o';
% elseif      n==26
%     a='-o';
% elseif      n==27
%     a='-o';
% elseif      n==28
%     a='-o';
% elseif      n==29
%     a='-o';
% elseif      n==30
%     a='-o';
% elseif      n==31
%     a='-o';
% elseif      n==32
%     a='-o';
% elseif      n==33
%     a='-o';
% elseif      n==34
%     a='-o';
% elseif      n==35
%     a='-o';
% elseif      n==36
%     a='-o';
% elseif      n==37
%     a='-o';
% elseif      n==38
%     a='-o';
% elseif      n==39
%     a='-o';
% elseif      n==40
%     a='-o';
end
end
