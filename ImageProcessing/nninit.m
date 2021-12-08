function [P,T,R,S1,S2,Q,S]=nninit
P = [0:3:255] ;
T = zeros(1,86);
T(29:86) = 1 ;
[R,Q]=size(P);
[S2,Q]=size(T);
S1=6;             
S=R*S1+S2+S1+S2;