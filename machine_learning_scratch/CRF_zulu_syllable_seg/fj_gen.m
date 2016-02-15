function ftr_vctr=fj_gen(yi_1,yi,x,pos_i)
%pos_i is the tag of interest as found in yi or yi_1

%% Intializations
NumF1=26*26;
NumF2=26*26*26;
NumF3=26*26;
NumF4=26*26;
NumF5=26*26;
NumF6=26*26;
NumF7=26*2;
NumF8=26*26*26*26;

Num_FFs = NumF1+NumF2+NumF3+NumF4+NumF5+NumF6+NumF7+NumF8;


%% Check Which Feature Functions to calculate
% Initiate with no class of feature function is required to be calculated
F1=0;         
F2=0;   
F3=0;
F4=0;
F5=0;
F6=0;
F7=0;
F8=0;

indexF1=[];
indexF2=[];
indexF3=[];
indexF4=[];
indexF5=[];
indexF6=[];
indexF7=[];
indexF8=[];

ftr_vctr=zeros(Num_FFs,1);

if numel(x)>1 && pos_i<numel(x)
    F1=1;
    F3=1;
    F4=1;
    F5=1;
    F6=1;
end

if numel(x)>2 && pos_i<numel(x) && pos_i>1
    F2=1;
end

if pos_i==1
    F7=1;
end

if numel(x)>4 && pos_i<numel(x)-1 && pos_i>1
    F8=1;
end

%% 
if F1==1
    %Find which index of class F1 is requied to be computed
    indexF1=26*(x(pos_i)-'a')+(x(pos_i+1)-'a'+1);
    indexF3=NumF1+NumF2+indexF1;
    indexF4=NumF1+NumF2+NumF3+indexF1;
    indexF5=NumF1+NumF2+NumF3+NumF4+indexF1;
    indexF6=NumF1+NumF2+NumF3+NumF4+NumF5+indexF1;
end

if F2==1
    %Find which index of class F1 is requied to be computed
    indexF2=NumF1+26*26*(x(pos_i-1)-'a')+26*(x(pos_i)-'a')+ (x(pos_i+1)-'a'+1);
end


if F7==1
    %Find which index of class F1 is requied to be compute
    indexF7=NumF1+NumF2+NumF3+NumF4+NumF5+NumF6+yi*26+(x(pos_i)-'a'+1);
end

if F8==1
    %Find which index of class F1 is requied to be computed
    indexF8=NumF1+NumF2+NumF3+NumF4+NumF5+NumF6+NumF7+26*26*26*(x(pos_i-1)-'a')+26*26*(x(pos_i)-'a')+26*(x(pos_i+1)-'a')+ (x(pos_i+2)-'a'+1);
end

ftr_vctr([indexF1],1)=1;
ftr_vctr([indexF2],1)=1;
ftr_vctr([indexF3],1)=(yi_1==0&&yi==0);
ftr_vctr([indexF4],1)=(yi_1==0&&yi==1);
ftr_vctr([indexF5],1)=(yi_1==1&&yi==0);
ftr_vctr([indexF6],1)=(yi_1==1&&yi==1);
ftr_vctr([indexF7],1)=1;
ftr_vctr([indexF8],1)=1;

ftr_vctr = ftr_vctr';