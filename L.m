clc 
clear all
















































C = [2 10 4 5; 6 12 8 11; 3 9 5 7];
S = [12 25 20];  
D = [25 10 15 5];
if sum(S)==sum(D)
    fprintf('P is balanced');
elseif sum(S)>sum(D)
    diff= sum(S)-sum(D);
    D= [D diff]
    C(:, end+1)= 0
else 
    diff = sum(D) - sum(S);
    S = [S diff]
    C(end+1, :) = 0
end
icost= C;
X= zeros(size(icost))
[m,n]= size(icost)
BFS= m+n-1
for i= 1: m
    for j= 1:n
        min_c= min(C(:));
        [r_i, c_i]= find (min_c==C);
        qty= min(S(r_i),D(c_i));
        [Value,index]=max(qty);
        ii=r_i(index);      
        jj=c_i(index);       
        y11=min(S(ii),D(jj)) ;     
        X(ii,jj)=y11 ;
        S(ii)=S(ii)-y11 ;
        D(jj)=D(jj)-y11 ;
        C(ii,jj)=inf ;
    end
end
X
InitialCost=sum(sum(icost.*X))
fprintf('Initial BFS Cost is = %d \n',InitialCost)



   

