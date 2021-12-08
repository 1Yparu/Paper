function [ net ] = gabptrain( gaP,bpP,P,T )
[W1, B1, W2, B2] = getWBbyga(gaP);
net = initnet(W1, B1, W2, B2,bpP);
net = train(net,P,T);