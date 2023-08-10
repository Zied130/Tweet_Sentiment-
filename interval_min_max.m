function [min,max] = interval_min_max(a)
if round(a) <= a
min = round(a) ; 
max = min + 0.5 ; 
else
max = round(a) ;
min = max - 0.5 ;
end
end