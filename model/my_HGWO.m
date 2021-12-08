function [besta]=my_HGWO(para,input,output)
nPop=para(1);MaxIt=para(2);
nVar=1; VarSize=[1,nVar];
beta_min=para(3);beta_max=para(4);
pCR=para(5);lb=0.00001;ub=1; 
parent_Position=init_individual(lb,ub,nVar,nPop);
parent_Val=zeros(nPop,1); 
for i=1:nPop 
    parent_Val(i)=fobj(parent_Position(i,:),input,output);
end
mutant_Position=init_individual(lb,ub,nVar,nPop); 
mutant_Val=zeros(nPop,1);
for i=1:nPop 
    mutant_Val(i)=fobj(mutant_Position(i,:),input,output); 
end
child_Position=init_individual(lb,ub,nVar,nPop); 
child_Val=zeros(nPop,1); 
for i=1:nPop 
    child_Val(i)=fobj(child_Position(i,:),input,output);
end
[~,sort_index]=sort(parent_Val); 
parent_Alpha_Position=parent_Position(sort_index(1),:);
parent_Alpha_Val=parent_Val(sort_index(1));
parent_Beta_Position=parent_Position(sort_index(2),:); 
parent_Delta_Position=parent_Position(sort_index(3),:); 
BestCost=zeros(1,MaxIt);
BestCost(1)=parent_Alpha_Val;
for it=1:MaxIt
    a=2-it*((2)/MaxIt);
    for par=1:nPop
        for var=1:nVar         
            r1=rand(); 
            r2=rand();        
            A1=2*a*r1-a;
            C1=2*r2;
            D_alpha=abs(C1*parent_Alpha_Position(var)-parent_Position(par,var));
            X1=parent_Alpha_Position(var)-A1*D_alpha;
            r1=rand();
            r2=rand();            
            A2=2*a*r1-a; 
            C2=2*r2;
            D_beta=abs(C2*parent_Beta_Position(var)-parent_Position(par,var));
            X2=parent_Beta_Position(var)-A2*D_beta;
            r1=rand();
            r2=rand();
            A3=2*a*r1-a;
            C3=2*r2; 
            D_delta=abs(C3*parent_Delta_Position(var)-parent_Position(par,var));
            X3=parent_Delta_Position(var)-A3*D_delta;
            X=(X1+X2+X3)/3;
            X=max(X,lb(var));
            X=min(X,ub(var));
            parent_Position(par,var)=X;
        end
        parent_Val(par)=fobj(parent_Position(par,:),input,output);
    end
    for mut=1:nPop
        A=randperm(nPop); 
        A(A==i)=[];
        a=A(1);
        b=A(2);
        c=A(3);
        beta=unifrnd(beta_min,beta_max,VarSize);
        y=parent_Position(a)+beta.*(parent_Position(b)-parent_Position(c));
        y=max(y,lb);
		y=min(y,ub);
        mutant_Position(mut,:)=y;
    end
    for child=1:nPop
        x=parent_Position(child,:);
        y=mutant_Position(child,:);
        z=zeros(size(x)); 
        j0=randi([1,numel(x)]);
        for var=1:numel(x) 
            if var==j0 || rand<=pCR
                z(var)=y(var);
            else
                z(var)=x(var);
            end
        end
        child_Position(child,:)=z; 
        child_Val(child)=fobj(z,input,output);
    end
    for par=1:nPop
        if child_Val(par)<parent_Val(par) 
            parent_Val(par)=child_Val(par);
        end
    end
    [~,sort_index]=sort(parent_Val); 
    parent_Alpha_Position=parent_Position(sort_index(1),:); 
    parent_Alpha_Val=parent_Val(sort_index(1)); 
    parent_Beta_Position=parent_Position(sort_index(2),:); 
    parent_Delta_Position=parent_Position(sort_index(3),:);
    BestCost(it)=parent_Alpha_Val;
end
besta=parent_Alpha_Position;
end