function X = zhishu(x, wname, n, thr, thr1)
a = (thr + 1) ^ (1/(thr-thr1));
b = thr1;
[C, S] = wavedec2(x, n, wname);                   
dcoef = C( prod(S(1, :)) + 1 : end);               

ind = find( abs(dcoef) < thr1) + prod(S(1, :));     
C(ind) = 0;                                         

ind = find( abs(dcoef) >= thr1 & abs(dcoef) < thr )...
     + prod(S(1, :));                               
C(ind) = sign(C(ind)) .* ...
    (a .^( abs(C(ind)) - b) - 1);                  

X = waverec2(C, S, wname);