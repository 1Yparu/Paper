clc;clear;close all;
M=load('zm.txt');
Y=M(:,45);
X1=M(:,1:24);%��������
X2=M(:,25:44);%��������
X3=M(:,1:44);%�ۺ�����
%HGWO
besta1=my_HGWO(para,X1,Y);
besta11=my_HGWO(para,X2,Y);
besta111=my_HGWO(para,X3,Y);
%BAS
besta2=BASY(X1,Y);
besta22=BASY(X2,Y);
besta222=BASY(X3,Y);
%ABC 
besta3=ABCY(X1,Y);
besta33=ABCY(X2,Y);
besta333=ABCY(X3,Y);
% X=X3;
% [b,fitinfo]=lasso(X,Y,'CV',n,'Alpha',besta); %n������֤
% lam=fitinfo.IndexMinMSE;
% yc=X*(b(:,lam))+fitinfo.Intercept(lam);
% [PJ,OP]=err(Y,yc);
