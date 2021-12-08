function [W1, B1, W2, B2, P, T, A1, A2, SE, val]=gadecod(x)
[P,T,R,S1,S2,Q,S]=nninit;
 for i=1:S1,
    W1(i,1)=x(i);
 end
for i=1:S2,
   W2(i,1)=x(i+S1);
end
for i=1:S1,
   B1(i,1)=x(i+S1+S2);
end
for i=1:S2,
   B2(i,1)=x(i+S1+S2+S1);
end
[m n] = size(P) ;
sum=0; 
SE=0; 
for i=1:n 
   x1=W1*P(i)+B1; 
   A1=tansig(x1); 
   x2=W2*A1+B2; 
   A2=purelin(x2); 
    SE=sumsqr(T(i)-A2); 
    sum=sum+SE; 
end 
val=10/sum;