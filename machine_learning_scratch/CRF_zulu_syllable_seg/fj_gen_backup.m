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

for y1=1:4
    for y2=1:4
        fnpointer_vector{numOfFeatures}=makeFn6(y1,y2);
        numOfFeatures=numOfFeatures+1;
    end
end
end


function ret_ptr=makeFn1(a, b, alpha, beta)
%this is the evaluation of the lower level feature function
ret_ptr =@(yi_1,yi,x,i)((x(a)==alpha)&& x(b)==beta && yi_1==2 && yi==1);
end

function ret_ptr=makeFn2(ch)
%% Return 1 if x_i==ch and yi == 0
ret_ptr =@(yi_1,yi,x,i)(x(i)==ch && yi==0);
end

function ret_ptr=makeFn3(ch)
%% Return 1 if x_i==ch and yi == 1
ret_ptr =@(yi_1,yi,x,i)(x(i)==ch && yi==1);
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


