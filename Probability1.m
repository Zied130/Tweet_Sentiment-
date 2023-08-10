function P1 = Probability1(gamma_0,coeff_0,coeff_1,data_neg)
T = table();
k = 1;
for i = 1 : size(data_neg,1)
    if  data_neg.token_number(i)== 1  &&  data_neg.coeff(i) < coeff_1 &&  data_neg.coeff(i) >= coeff_0
        T.gamma_zero(k) = data_neg.tag_two(i);
        %T.gamma_one(k) = data_neg.tag_two(i+1);
        T.PartOfSpeech(k) = data_neg.PartOfSpeech(i);
        T.coeff(k) = data_neg.coeff(i);
        T.Token_lemma(k) = data_neg.Token_lemma(i);
        T.DocumentNumber(k) = data_neg.DocumentNumber(i);
        k=k+1;
    end
    i;
end
P1 = sum(T.gamma_zero == gamma_0)/size(T,1) ;
end