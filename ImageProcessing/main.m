clc;clear;close all;
n=5;
fpath='';
for i=1:n
I{i}=imread([fpath,'P',num2str(i),'.tif']);
I{i}=im2uint8(I2);
end
% ͼ��ȥ��
for i=1:n
x = im2double(I{i});                                             
f = ones(3);
x =medfilter(x,f);
[C, S]= wavedec2(x, 2, 'sym4');
thr = Donoho(x);                                                                 
alpha = 0.5;
xq = zhishu(x, 'sym4', 2, thr, 0.5*thr);  
end
% ͼ����׼
for i=1:n
   Q{i}=imread([fpath,'QZ',num2str(i),'.tif']); 
end
for i=1:n
[Theta{i},Tx{i},Ty{i},P{i}]=FMelin(Q{3},Q{i});
end
The=cell2mat(Theta);Row=cell2mat(Ty);Col=cell2mat(Tx);
for i=1:n
    se=translate(strel(1),[-Row(i) -Col(i)]);
    P{i}=imdilate(Q{i},se);
end

% ͼ��ָ� GA-BPNN
for i=1:n
   P{i}=imread([fpath,'P',num2str(i),'.tif']); 
end
BW1=double(CBFG(P{1}));BW1=1-(BW1/255);
bw=BW1;
for i=1:n
    M=double(P{i});
    F{i}=immultiply(bw,M);
end
for i=1:n
    F{i}=uint8(F{i});
end
% ͼ��ָ� ����ء�OTSU����С������
[BW1,BW2,BW3]=FGThree(P{1});