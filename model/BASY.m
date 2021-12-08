function [besta] = BASY(X,Y)
lb=0.000001;ub=0.999999; 
d0=0.6;c=2;step=2;
popmax=1;popmin=-1;
eta=0.995;
nvars=1;iterations=150;
x=popmin+(popmax-popmin)*rand(1,nvars);
xbest=x;
xbest=max(xbest,lb);
xbest=min(xbest,ub);
fbest=fobj(xbest,X,Y);
fbest_store=fbest;
fail=0;
for i=1:iterations
    step=eta*step;
    d0=step/c;
dire=rands(1,nvars);
dire=dire/norm(dire);
xL=x-d0*dire/2;
xR=x+d0*dire/2;
xL=xL/(xL+xR);
xR=xR/(xL+xR);
xL=max(xL,lb);
xL=min(xL,ub);
xR=max(xR,lb);
xR=min(xR,ub);
funxL=fobj(xL,X,Y);
funxR=fobj(xR,X,Y);
if funxL<funxR
    x=x+rand*step*((xL-xR)/norm(xL-xR));
else
    x=x-rand*step*((xL-xR)/norm(xL-xR));
end

for j=1:nvars
    if x(j)>popmax
        x(j)=popmin+(popmax-popmin)*rand;
    elseif x(j)<popmin
        x(j)=popmin+(popmax-popmin)*rand;
    end
end
x=max(x,lb);
x=min(x,ub);
f=fobj(x,X,Y);
if f<fbest
    xbest=x;
    fbest=f;
else
    fail=fail+1;
end
if fail==200
    x=xbest;
    step=popmax*rand;
    fail=0;
end
fbest_store=[fbest_store,fbest];
end
besta=xbest(1);
end

