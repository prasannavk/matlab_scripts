function q = getqs(zvec,wvec,n,K)
for i = 1:n % over all words in the vocabulary
    word_idxs=find(wvec==i);
    for k=1:K % over all topics
        topic_idxs=find(zvec(word_idxs)==k);
        q(i,k)=length(topic_idxs);
    end
end
