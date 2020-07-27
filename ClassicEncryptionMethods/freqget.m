function x =freqget(y)
%
%  function x =freqget(y)
%
%  Returns a letter frequency distribution for the
%  text sample contained in y.
%
%    By   G.D.Agnew  (c) 24/2/2001
%    


%if (nargin<2)
%end


sizy=size(y);
TOT = sizy(2);
y2 = double(y)-64;


for i=1:26
	x(i) = 0;                %  First zero the frequency array
end

j=0;
for i=1:TOT

   if (y2(i)>0)
     j = j + 1;	                 %  count the valid characters found
     if (y2(i)>32) 
        y2(i) = y2(i) - 32;      %  Remove offset for lower case chars
     end
     if (y2(i)<27)               %  Eliminates junk between upper & lower case set.
        x(y2(i)) = x(y2(i)) + 1; 
     end
   end
end

if (TOT>0) 
   x = x/TOT;		%  Normalise the frequency array
end

