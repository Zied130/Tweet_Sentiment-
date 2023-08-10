load dataset.mat
N=unique(data_neg.DocumentNumber);
warning('off','all');
Total_cv_score_2=[];
Total_jaccard_2=[];
cv_score_end_2 = [];

for l = 1:size(unique(data_neg.DocumentNumber),1)


T1=data_neg(data_neg.DocumentNumber==N(l),:);

Delta=dictionary();
PHI=dictionary();
cm=dictionary();



if T1.PartOfSpeech(2)=='adposition' || T1.PartOfSpeech(2)=='punctuation' || T1.PartOfSpeech(2)=='coord-conjunction' || T1.PartOfSpeech(2)=='pronoun' || T1.PartOfSpeech(2)=='particle' || T1.PartOfSpeech(2)=='subord-conjunction'
delta = zeros(2,2);
[x,y]=interval_min_max(T1.coeff(1));
delta(1,1) = Probability1(0,x,y,data_neg) * Probability2(T1.Token_lemma(1),0,T1.PartOfSpeech(1),data_neg,token_dict) * Probability3(T1.Token_lemma(1),0,0,T1.PartOfSpeech(1),data_neg,token_dict) ;
delta(1,2) = Probability1(0,x,y,data_neg) * Probability2(T1.Token_lemma(1),0,T1.PartOfSpeech(1),data_neg,token_dict) * Probability3(T1.Token_lemma(1),0,1,T1.PartOfSpeech(1),data_neg,token_dict) ;
delta(2,1) = Probability1(1,x,y,data_neg) * Probability2(T1.Token_lemma(1),1,T1.PartOfSpeech(1),data_neg,token_dict) * Probability3(T1.Token_lemma(1),1,0,T1.PartOfSpeech(1),data_neg,token_dict) ;
delta(2,2) = Probability1(1,x,y,data_neg) * Probability2(T1.Token_lemma(1),1,T1.PartOfSpeech(1),data_neg,token_dict) * Probability3(T1.Token_lemma(1),1,1,T1.PartOfSpeech(1),data_neg,token_dict) ;
delta = reshape(normalize(reshape(delta , 1,size(delta,1)*size(delta,2)),"norm",1),size(delta,1),size(delta,2));
Delta{1}=delta;
Delta{1}(isnan(Delta{1}))=0;
else
delta = zeros(2,3);
[x,y]=interval_min_max(T1.coeff(1));
delta(1,1) = Probability1(0,x,y,data_neg) * Probability2(T1.Token_lemma(1),0,T1.PartOfSpeech(1),data_neg,token_dict) * Probability3(T1.Token_lemma(1),0,0,T1.PartOfSpeech(1),data_neg,token_dict) ;
delta(1,2) = Probability1(0,x,y,data_neg) * Probability2(T1.Token_lemma(1),0,T1.PartOfSpeech(1),data_neg,token_dict) * Probability3(T1.Token_lemma(1),0,1,T1.PartOfSpeech(1),data_neg,token_dict) ;
delta(1,3) = Probability1(0,x,y,data_neg) * Probability2(T1.Token_lemma(1),0,T1.PartOfSpeech(1),data_neg,token_dict) * Probability3(T1.Token_lemma(1),0,2,T1.PartOfSpeech(1),data_neg,token_dict) ;
delta(2,1) = Probability1(1,x,y,data_neg) * Probability2(T1.Token_lemma(1),1,T1.PartOfSpeech(1),data_neg,token_dict) * Probability3(T1.Token_lemma(1),1,0,T1.PartOfSpeech(1),data_neg,token_dict) ;
delta(2,2) = Probability1(1,x,y,data_neg) * Probability2(T1.Token_lemma(1),1,T1.PartOfSpeech(1),data_neg,token_dict) * Probability3(T1.Token_lemma(1),1,1,T1.PartOfSpeech(1),data_neg,token_dict) ;
delta(2,3) = Probability1(1,x,y,data_neg) * Probability2(T1.Token_lemma(1),1,T1.PartOfSpeech(1),data_neg,token_dict) * Probability3(T1.Token_lemma(1),1,2,T1.PartOfSpeech(1),data_neg,token_dict) ;
delta = reshape(normalize(reshape(delta , 1,size(delta,1)*size(delta,2)),"norm",1),size(delta,1),size(delta,2));
Delta{1}=delta;
Delta{1}(isnan(Delta{1}))=0;
end


for l = 2 : size(T1,1)-1
l;

if T1.PartOfSpeech(l+1)=='adposition' || T1.PartOfSpeech(l+1)=='punctuation' || T1.PartOfSpeech(l+1)=='coord-conjunction' || T1.PartOfSpeech(l+1)=='pronoun' || T1.PartOfSpeech(l+1)=='particle' || T1.PartOfSpeech(l+1)=='subord-conjunction'

delta = zeros(size(Delta{l-1},2),2);
phi = zeros(size(Delta{l-1},2),2);
CM = zeros(size(Delta{l-1},2),2);  

else

delta = zeros(size(Delta{l-1},2),size(Delta{l-1},2)+1);
phi = zeros(size(Delta{l-1},2),size(Delta{l-1},2)+1);
CM = zeros(size(Delta{l-1},2),size(Delta{l-1},2)+1);

end


[x,y]=interval_min_max(T1.coeff(l));


for k = 1 : size(delta,1)

v=zeros(1,size(Delta{l-1},1));

for i=1:size(Delta{l-1},1)
    v(i)= Probability4(i-1,k-1,T1.PartOfSpeech(l),x,y,data_neg);
end

for j =1:size(delta,2)

delta(k,j) = max(Delta{l-1}(:,k).*v') * Probability5(T1.Token_lemma(l),k-1,j-1,T1.PartOfSpeech(l+1),data_neg,token_dict) * Probability6(T1.Token_lemma(l+1),k-1,j-1,T1.PartOfSpeech(l+1),data_neg,token_dict) ;
[~,phi(k,j)] = max(Delta{l-1}(:,k).*v');
CM(k,j) = max(Delta{l-1}(:,k).*v') / sum(Delta{l-1}(:,k).*v');

end

end

phi = phi-1 ;
delta = reshape(normalize(reshape(delta , 1,size(delta,1)*size(delta,2)),"norm",1),size(delta,1),size(delta,2));
Delta{l}=delta;
Delta{l}(isnan(Delta{l}))=0;
CM(isnan(CM))=1;
PHI{l-1}=phi;
cm{l-1}=CM;


end

output = zeros(1,size(T1,1));
[a,b]=find(Delta{size(T1,1)-1}==max(max(Delta{size(T1,1)-1})));

output(size(T1,1)) = b-1;
output(size(T1,1)-1) = a-1;
output(size(T1,1)-2) = PHI{size(T1,1)-2}(a,b);

for i = size(T1,1)-3 : -1 : 1
    output(i) = PHI{i}(output(i+1)+1,output(i+2)+1);
end


cv = zeros(1,size(T1,1));

[row,col]=find(Delta{size(T1,1)-1}==max(max(Delta{size(T1,1)-1}))) ;

cv(size(T1,1)) = Delta{size(T1,1)-1}(row,col) / sum(Delta{size(T1,1)-1}(row,:)) ;

cv(size(T1,1)-1) = Delta{size(T1,1)-1}(row,col) / sum(Delta{size(T1,1)-1}(:,col)) ;

cv(size(T1,1)-2) = cm{size(T1,1)-2}(a,b);

for i = size(T1,1)-3 : -1 : 1
    cv(i)=cm{i}(output(i+1)+1,output(i+2)+1);
end

output
cv

cvv=[];
a=[];
b=[];
for i = 1 : size(output,2)
    if output(i)>0  
        a=[a T1.Token(i)];
        cvv = [cvv cv(i)] ;
    end
    if T1.selected_text(i)>0
        b=[b T1.Token(i)];
    end
end
a
b
c=intersect(unique(a),unique(b));
formatSpec = 'jaccard score is %4.2f \n';
jaccard=size(c,2)/(size(unique(a),2)+size(unique(b),2)-size(c,2));
fprintf(formatSpec,jaccard)

% cvv=[];
% 
% for i = 1 : size(cv,2)
%     if output(i)>0 
%         cvv = [cvv cv(i)] ;
%     end
% end

cv_score=sum(cvv)/size(cvv,2);
formatSpec = 'confidence score is %4.2f \n';
fprintf(formatSpec,cv_score);

Total_cv_score_2 = [Total_cv_score_2 cv_score];
Total_jaccard_2 = [Total_jaccard_2 jaccard];
cv_score_end_2 = [cv_score_end_2 cv(size(cv,2))];


end




