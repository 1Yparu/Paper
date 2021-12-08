function [ net ] = initnet(W1, B1, W2, B2,paraments)
epochs = 500;
goal = 0.01 ;
if(nargin > 4)
    epochs = paraments(1) ;
    goal   = paraments(2) ;
end
net = newcf([0 255],[6 1],{'tansig' 'purelin'});
net.trainParam.epochs = epochs;
net.trainParam.goal = goal ;
net.iw{1} = W1 ;
net.iw{2} = W2 ;
net.b{1}  = B1 ;
net.b{2}  = B2 ;