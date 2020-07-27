function x = demono(y,table)
%
%  function x = demono(y,table)
%
%  demono - monoalphabetic substitution decipherment. IF table
%  is not supplied, a Caesar cipher is assumed. The deciphered
%  text is returned in x.
%
%    By   G.D.Agnew  (c) 24/2/2001
%    

if (nargin<2)
   P = 'XYZABCDEFGHIJKLMNOPQRSTUVW';	%  The translation table
else
   P = table;
end


%P = 'defghijklmnopqrstuvwxyzabc';	%  The translation table
%p(27:32) = '[\]^_`';			%  Allow some special chars
%P(33:58)='DEFGHIJKLMNOPQRSTUVWXYZABC'; % Allow lower case as well


%fid = fopen('cipher.txt','r');		%  Read the Plaintext
%C = fread(fid);
%fclose(fid); 
%C = char(C);
%C = C';

C = y;

sizC = size(C);

C2 = double(C) - 64;			%  Translate so that index to t table is correct.

for i=1:sizC(2) 

   t = C2(i);
   if (t < 1)
      M(i) = C(i);		% Allows cr, lf, spaces etc through.
   else
      if (t>32)                 % Its lower case
         t = t-32;
         if (t<27)              % its a - z
            M(i) = P(t);	% This is the translation proper.
         else
            M(i) = C(i);        % its not a -z: leave it as-is.
         end
      else
         if (t<27)              %  Its upper-case
            M(i) = char(double(P(t))+32);    %  Translate to lower case
         else
            M(i) = C(i);        %  Its one of those chars between upper & lower. Leave as-is.
         end
      
      end
   end

end

x = M;

%fid=fopen('plain.txt','w');
%fprintf(fid,'%s',M);
%fclose(fid);

