function thr = Donoho(x)
n = prod( size(x) );      
[C, S] = wavedec2(x, 1, 'db1');                            
d = C( prod( S(1,:) ) + 2 * prod( S(2,:) ) + 1 : end);     
delta = median( abs(d) ) / 0.6745;
thr = delta * sqrt(2*log(n));