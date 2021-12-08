function [] = generatesample( path )
p = [0:1:255] ;
t = zeros(1,256);
t(82:256) = 1 ;
save(path,'p','t');