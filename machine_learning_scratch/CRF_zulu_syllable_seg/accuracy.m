%% ACCURACY 
function [letterAccuracy wordAccuracy] = accuracy(y_hat,y_given)
if numel(y_hat)~=numel(y_given)
    letterAccuracy=-1;
    wordAccuracy=-1;
    return;
end
wordAccuracy=0;
letterAccuracy=0;
totalLength=0;
for i=1:numel(y_hat)
   b=y_given{i,1};
   b = b(2:numel(b)-1);
   p=num2str(y_hat{i,1});
   s = '';
   for k = 1:size(p,2)
    if ~isspace(p(1,k))
        s = strcat(s,p(1,k));
    end
   end
   a = (s==num2str(b)); 
   numOfLetterMisMatch=size(find(a(:)==0),1);
   lenOfWord=size(y_hat{i,1},2);
   if(numOfLetterMisMatch==0)
       wordAccuracy=wordAccuracy+1;
   end
   letterAccuracy=letterAccuracy+(lenOfWord-numOfLetterMisMatch);
   totalLength=totalLength+lenOfWord;
end
letterAccuracy=letterAccuracy/totalLength;
wordAccuracy=wordAccuracy/numel(y_hat);
end