function [besta] = ABCY(input,output)
NP=20; FoodNumber=NP/2; 
limit=100; maxCycle=60; 
D=1; nn=1;
ub1=0.99; lb1=0.000001;
BestGlobalMins=ones(1,nn);
BestGlobalParams=zeros(nn,D);
for r=1:nn
    Range1 = repmat((ub1-lb1),[FoodNumber 1]);
    Lower1 = repmat(lb1, [FoodNumber 1]);
    M=rand(FoodNumber) .* Range1 + Lower1;
    Foods(:,1) = rand(FoodNumber,1) .* Range1 + Lower1;
    ObjVal=ones(1,FoodNumber); 
    for k = 1:FoodNumber
        ObjVal(k) = fobj(Foods(k,:),input,output);
    end
    Fitness=calculateFitness(ObjVal);
    trial=zeros(1,FoodNumber);
    BestInd=find(ObjVal==min(ObjVal)); 
    BestInd=BestInd(end);
    GlobalMin=ObjVal(BestInd); 
    GlobalParams=Foods(BestInd,:); 
    iter=1; 
    while ((iter <= maxCycle))
        for i=1:(FoodNumber)
            Param2Change=fix(rand*D)+1;
            neighbour=fix(rand*(FoodNumber))+1;
            while(neighbour==i)
                neighbour=fix(rand*(FoodNumber))+1;
            end
            sol=Foods(i,:); 
            sol(Param2Change)=Foods(i,Param2Change)+(Foods(i,Param2Change)-Foods(neighbour,Param2Change))*(rand-0.5)*2;
            c=sol(1);
            ind=find(c<lb1);
            c(ind)=lb1(ind);
            ind=find(c>ub1);
            c(ind)=ub1(ind);
            sol=c;
            ObjValSol=fobj(sol,input,output);
            FitnessSol=calculateFitness(ObjValSol);
            if (FitnessSol>Fitness(i))
                Foods(i,:)=sol;
                Fitness(i)=FitnessSol;
                ObjVal(i)=ObjValSol;
                trial(i)=0; 
            else
                trial(i)=trial(i)+1;
            end
        end
        prob=(0.9.*Fitness./max(Fitness))+0.1;
        i=1;
        t=0;
        while(t<FoodNumber) 
            if(rand<prob(i))
                t=t+1; 

                Param2Change=fix(rand*D)+1; 
                neighbour=fix(rand*(FoodNumber))+1;
                while(neighbour==i)
                    neighbour=fix(rand*(FoodNumber))+1;
                end
                sol=Foods(i,:);
                sol(Param2Change)=Foods(i,Param2Change)+(Foods(i,Param2Change)-Foods(neighbour,Param2Change))*(rand-0.5)*2;
                c=sol(1);
            ind=find(c<lb1);
            c(ind)=lb1(ind);
            ind=find(c>ub1);
            c(ind)=ub1(ind);
            sol=c;
                ObjValSol=fobj(sol,input,output);
                FitnessSol=calculateFitness(ObjValSol);
                if (FitnessSol>Fitness(i))
                    Foods(i,:)=sol;
                    Fitness(i)=FitnessSol;
                    ObjVal(i)=ObjValSol;
                    trial(i)=0; 
                else
                    trial(i)=trial(i)+1; 
                end
            end
            i=i+1; 
            if (i==(FoodNumber)+1) 
                i=1;
            end   
        end 
         ind=find(ObjVal==min(ObjVal));
         ind=ind(end);
         if (ObjVal(ind)<GlobalMin)
            GlobalMin=ObjVal(ind);
            GlobalParams=Foods(ind,:);
         end
        ind=find(trial==max(trial)); 
        ind=ind(end);
        if (trial(ind)>limit) 
            Bas(ind)=0;
            sol=(ub1-lb1).*rand(1,D)+lb1;
            ObjValSol=fobj(sol,input,output);
            FitnessSol=calculateFitness(ObjValSol);
            Foods(ind,:)=sol;
            Fitness(ind)=FitnessSol;
            ObjVal(ind)=ObjValSol;
        end
        iter=iter+1;
    end 
    BestGlobalMins(r)=GlobalMin; 
    BestGlobalParams(r,:)=GlobalParams; 
end % end of runs
besta=GlobalParams(1);
end

