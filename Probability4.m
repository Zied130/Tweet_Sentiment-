

function P4 = Probability4(gamma_0,gamma_1,POS,coeff_0,coeff_1,data_neg)


T = table();

k = 1;
for i = 1 : size(data_neg,1)-1
    if  data_neg.tag_two(i)== gamma_0    && data_neg.PartOfSpeech(i+1)==POS &&  data_neg.coeff(i+1) < coeff_1 &&  data_neg.coeff(i+1) >= coeff_0
        T.gamma_zero(k) = data_neg.tag_two(i);
        T.gamma_one(k) = data_neg.tag_two(i+1);
        T.PartOfSpeech(k) = data_neg.PartOfSpeech(i+1);
        T.coeff(k) = data_neg.coeff(i+1);
        T.Token_lemma(k) = data_neg.Token_lemma(i+1);
        T.DocumentNumber(k) = data_neg.DocumentNumber(i);
        k=k+1;
    end
    i ;
end
if size(T,1) ~= 0
    P4 = sum(T.gamma_one == gamma_1)/size(T,1) ;
else
    P4 = 0 ;
end

end