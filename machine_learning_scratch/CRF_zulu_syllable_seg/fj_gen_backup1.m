function fnpointer_vector=fj_gen()
%% Intializations
numOfFeatures=1;
a_z = ['a':'z'];  %List of charaters from a to z
len = 13; %Maximum length of avialable Zulu word

%% Generating Specific Low Level Feature Functions from makeFni definitions
for i=1:26
    ch=a_z(i);
    fnpointer_vector{numOfFeatures}=makeFn2(ch);
    numOfFeatures=numOfFeatures+1;
end

for i=1:26
    ch=a_z(i);
    fnpointer_vector{numOfFeatures}=makeFn3(ch);
    numOfFeatures=numOfFeatures+1;
end

for i=1:len
    fnpointer_vector{numOfFeatures}=makeFn4(i);
    numOfFeatures=numOfFeatures+1;
end

for i=1:26
    ch=a_z(i);
    fnpointer_vector{numOfFeatures}=makeFn5(ch);
    numOfFeatures=numOfFeatures+1;
end

for y1=0:3
    for y2=0:3
        fnpointer_vector{numOfFeatures}=makeFn6(y1,y2);
        numOfFeatures=numOfFeatures+1;
    end
end

fnpointer_vector{numOfFeatures}=@look_vol_const_1;
numOfFeatures=numOfFeatures+1;

fnpointer_vector{numOfFeatures}=@look_vol_const_2;
numOfFeatures=numOfFeatures+1;

fnpointer_vector{numOfFeatures}=@look_vol_const_3;
numOfFeatures=numOfFeatures+1;

fnpointer_vector{numOfFeatures}=@look_vol_const_4;
numOfFeatures=numOfFeatures+1;

fnpointer_vector{numOfFeatures}=@look_const_vol_1;
numOfFeatures=numOfFeatures+1;

fnpointer_vector{numOfFeatures}=@look_const_vol_2;
numOfFeatures=numOfFeatures+1;

fnpointer_vector{numOfFeatures}=@look_const_vol_3;
numOfFeatures=numOfFeatures+1;

fnpointer_vector{numOfFeatures}=@look_const_vol_4;
numOfFeatures=numOfFeatures+1;

end


function ret_ptr=makeFn1(a, b, alpha, beta)
%this is the evaluation of the lower level feature function
ret_ptr =@(yi_1,yi,x,i)((x(a)==alpha)&& x(b)==beta && yi_1==2 && yi==1);
end

function ret_ptr=makeFn2(ch)
%% Return 1 if x_i==ch and yi == 0
    function val=temp(yi_1,yi,x,i)
       if i<=numel(x)
           val=(x(i)==ch && yi==0);
       else
           val=0;
       end
    end
ret_ptr = @temp;
       %ret_ptr =@(yi_1,yi,x,i)(x(i)==ch && yi==0);
end

function ret_ptr=makeFn3(ch)
%% Return 1 if x_i==ch and yi == 1
    function val=temp(yi_1,yi,x,i)
        if i<=numel(x)
            val=(x(i)==ch && yi==1);
        else
            val=0;
        end
    end
ret_ptr = @temp;
%ret_ptr =@(yi_1,yi,x,i)(x(i)==ch && yi==1);
end

function ret_ptr=makeFn4(len)
%% Return 1 if Length of x == len
ret_ptr =@(yi_1,yi,x,i)(numel(x)==len);
end

function ret_ptr=makeFn5(ch)
%% Return 1 if Start of the word is x_1==ch
ret_ptr =@(yi_1,yi,x,i)(x(1)==ch);
end

function ret_ptr=makeFn6(y1,y2)
%% Return 1 if yi_1==y1 and yi==y2
ret_ptr =@(yi_1,yi,x,i)(yi_1==y1 && yi==y2);
end


%% VOL-->CONST 
function val=look_vol_const_1(yi_1,yi,x,i)
%% Checks the seq as VOL-->CONST and Label as 1 --> 0
a_z = ['a':'z'];
if(numel(x)>2&&i>2&&i<=numel(x))
    val=(sum(x(i-1)==['a','e','i','o','u']) && sum(x(i)==setdiff(a_z,['a','e','i','o','u']))&&yi_1==1&&yi==0);
else
    val=0;
end
end

function val=look_vol_const_2(yi_1,yi,x,i)
%% Checks the seq as VOL-->CONST and Label as 0 --> 1
a_z = ['a':'z'];
if(numel(x)>2&&i>2&&i<=numel(x))
    val=(sum(x(i-1)==['a','e','i','o','u']) && sum(x(i)==setdiff(a_z,['a','e','i','o','u']))&&yi_1==0&&yi==1);
else
    val=0;
end
end
function val=look_vol_const_3(yi_1,yi,x,i)
%% Checks the seq as VOL-->CONST and Label as 0 --> 0
a_z = ['a':'z'];
if(numel(x)>2&&i>2&&i<=numel(x))
    val=(sum(x(i-1)==['a','e','i','o','u']) && sum(x(i)==setdiff(a_z,['a','e','i','o','u']))&&yi_1==0&&yi==0);
else
    val=0;
end
end

function val=look_vol_const_4(yi_1,yi,x,i)
%% Checks the seq as VOL-->CONST and Label as 1 --> 1
a_z = ['a':'z'];
if(numel(x)>2&&i>2&&i<=numel(x))
    val=(sum(x(i-1)==['a','e','i','o','u']) && sum(x(i)==setdiff(a_z,['a','e','i','o','u']))&&yi_1==1&&yi==1);
else
    val=0;
end
end

%% CONST --> VOL
function val=look_const_vol_1(yi_1,yi,x,i)
%% Checks the seq as CONST --> VOL and Label as 1 --> 0
a_z = ['a':'z'];
if(numel(x)>2&&i>2&&i<=numel(x))
    val=(sum(x(i)==setdiff(a_z,['a','e','i','o','u'])) && sum(x(i-1)==['a','e','i','o','u']) && yi_1==1 && yi==0);
else
    val=0;
end
end

function val=look_const_vol_2(yi_1,yi,x,i)
%% Checks the seq as CONST --> VOL and Label as 0 --> 1
a_z = ['a':'z'];
if(numel(x)>2&&i>2&&i<=numel(x))
    val=(sum(x(i)==setdiff(a_z,['a','e','i','o','u'])) && sum(x(i-1)==['a','e','i','o','u']) && yi_1==0 && yi==1);
else
    val=0;
end
end
function val=look_const_vol_3(yi_1,yi,x,i)
%% Checks the seq as CONST --> VOL and Label as 0 --> 0
a_z = ['a':'z'];
if(numel(x)>2&&i>2&&i<=numel(x))
    val=(sum(x(i)==setdiff(a_z,['a','e','i','o','u'])) && sum(x(i-1)==['a','e','i','o','u']) && yi_1==0 && yi==0);
else
    val=0;
end
end

function val=look_const_vol_4(yi_1,yi,x,i)
%% Checks the seq as CONST --> VOL and Label as 1 --> 1
a_z = ['a':'z'];
if(numel(x)>2&&i>2 && i<=numel(x))
    val=(sum(x(i)==setdiff(a_z,['a','e','i','o','u'])) && sum(x(i-1)==['a','e','i','o','u']) && yi_1==1 && yi==1);
else
    val=0;
end
end
