function [bw] = CBFG(img)
generatesample('sample.mat');  
gaP = [100 0.00001];
bpP = [500 0.00001];
load('sample.mat');
gabptrain( gaP,bpP,p,t )
load('net.mat');
img=double(img);
img(img==0)=255;
bw = segment( net,img ) ;
epochs = 200;
goal = 0.0001 ;
net = newcf([0 255],[7 1],{'tansig' 'purelin'});
net.trainParam.epochs = epochs;
net.trainParam.goal = goal ;
load('sample.mat');
net = train(net,p,t);
gaP = [100 0.00001];
bpP = [500 0.00001];
gabptrain( gaP,bpP,p,t );
img=double(img);
img(img==0)=255;
bw = segment( net,img ) ;
end

