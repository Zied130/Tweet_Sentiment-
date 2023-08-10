

function P6 = Probability6(V_0,gamma_0,gamma_1,POS,data_neg,token_dict)

T = table();

k = 1;
for i = 1 : size(data_neg,1)-1
    if  data_neg.tag_two(i)== gamma_0 && data_neg.tag_two(i+1)== gamma_1 && data_neg.PartOfSpeech(i+1)==POS 
        T.gamma_zero(k) = data_neg.tag_two(i);
        T.gamma_one(k) = data_neg.tag_two(i+1);
        T.PartOfSpeech(k) = data_neg.PartOfSpeech(i+1);
        T.coeff(k) = data_neg.coeff(i);
        T.Token_lemma(k) = data_neg.Token_lemma(i+1);
        T.DocumentNumber(k) = data_neg.DocumentNumber(i);
        k=k+1;
    end
    i;
end

k=0;

for i = 0 : size(T)
    try
    if sum(strcmp(token_dict{V_0},T.Token_lemma(i)))>0
        k=k+1;
    end
    catch ME
    end
    i;
end

P6 = k/i ;


end