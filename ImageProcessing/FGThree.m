function [BW1,BW2,BW3]=FGThree(I)
gray=I;
h=imhist(gray);   
h1=h;
len=length(h);    
[m,n]=size(gray);    
h1=(h1+eps)/(m*n); 

%------------------------最小交叉熵--------------------------

for i=1:(len-1)
        P1(i)=sum(h(1:i))/(m*n);  
        P2(i)=sum(h((i+1):len))/(m*n);
        Q1(i)=sum((1:i)*h(1:i))/(m*n);
        Q2(i)=sum((i+1:len)*h((i+1):len))/(m*n); 
        u1(i)=Q1(i)*(1/P1(i));
        u2(i)=Q2(i)*(1/P2(i));
        W(i)=sum((1:len)*h1(1:len)*log10(1:len))-Q1(i)*log10(u1(i))-Q2(i)*log10(u2(i));
end
m1=min(W);
n1=find(W==m1);
%-----------------------------最大熵-----------------------
for i=1:(len-1)
        P11(i)=sum(h(1:i))/(m*n);      
        P22(i)=sum(h((i+1):len))/(m*n);
        H1(i)=-(sum(h1(1:i).*log10(h1(1:i))));
        H2(i)=-(sum(h1((i+1):len).*log10(h1((i+1):len))));
        H(i)=(1/P11(i))*H1(i)+H2(i)*(1/P22(i))+log10(P11(i)*P22(i));
end
m2=max(H);
n2=find(H==m2);
%-----------------------------otsu---------------------
[v,r]=size(I);
k=zeros(1,len);
for i=1:len
    if h(i)~=0
    k(i)=h(i)/(v*r);
    else 
        continue;
    end
end
for i=1:(len-1)
        P3=sum(h(1:i))/(v*r);   
        P4=sum(h((i+1):len))/(v*r);   
        H3=sum((1:i).*k(1:i));
        H4=sum(((i+1):len).*k((i+1):len));
        m3=(1/P3)*H3;
        m4=H4*(1/P4);
        m=P3*m3+P4*m4;
        S(i)=P3*((m3-m).^2)+P4*((m4-m).^2);
end
m0=max(S);
n0=find(S==m0);
BW1=im2bw(I,n1/255);   
BW2=im2bw(I,n2/255);  
BW3=im2bw(I,n0/255);  
end

