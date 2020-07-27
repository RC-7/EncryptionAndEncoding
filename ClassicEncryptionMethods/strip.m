function x=strip(y,uppercase)
%  Strips all punctuation including spaces from
%  the input string. If uppercase is 1, also converts
%  all text to upper. Otherwise case is maintained.
%
%    By   G.D.Agnew  (c) 24/2/2001
%    


if (nargin<2)
   uppercase = 0;
end



sizy=size(y);
TOT = sizy(2);
y2 = double(y);

j=0;
for i=1:TOT

   if (y2(i)>64)
      j = j + 1;
      x(j) = y2(i);
      if (uppercase==1)
         if (x(j)>96)	
            x(j) = x(j)-32;
         end
      end
   end
end

x = char(x);


