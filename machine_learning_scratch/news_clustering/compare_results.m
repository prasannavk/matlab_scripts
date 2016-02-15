function [F_measure]=compare_results(derived_labels, truelabels)
truelabels1 = truelabels;
for i = 1:size(truelabels,2)
    if truelabels(i)==1
        truelabels1(i)=3;
    elseif truelabels(i) ==2
        truelabels1(i) =2;
    elseif truelabels(i)==3
        truelabels1(i)=1;
    end
end
F_measure = confusionmat(truelabels1',derived_labels);