function y_hat = Argmax(x,wt,tags)
%%% given current set of weights wt and the x example in hand, as well as
%%% feature functions, we need to find the argmax over possible set of
%%% labels. This can be done using the Viterbi for the given weights at
%%% that iteration.
gis = gi(x,tags,wt);
[y_hat,xx] = Viterbi_mine(x,gis,tags);
return