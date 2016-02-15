function best_topic = getbesttopic(prob_vec)
[prob_sort,sortidx]=sort(prob_vec,2,'descend');
num = rand(1);
if (num>0 && num<=prob_sort(1))
    best_topic = sortidx(1);
elseif (num>prob_vec(1) && num<=(prob_vec(1)+prob_vec(2)))
    best_topic = sortidx(2);
else
    best_topic = sortidx(3);
end