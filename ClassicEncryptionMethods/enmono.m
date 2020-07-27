function x = enmono(y,table);
%
%  function x = enmono(y,table);
%
%  Mono - monoalphabetic substitution encipherment.
%  The text in y is enciphered with the translation table
%  given in table. If table is omitted, a Caesar cipher
%  is assumed. The translation table MUST be all upper
%  case and must contain 26 characters.
%
%    By   G.D.Agnew  (c) 24/2/2001
%    


if (nargin<2)
   P = 'DEFGHIJKLMNOPQRSTUVWXYZABC';	%  The translation table
else
   P = table;
end

%P = 'defghijklmnopqrstuvwxyzabc';	%  The translation table
%p(27:32) = '[\]^_`';			%  Allow some special chars
%P(33:58)='DEFGHIJKLMNOPQRSTUVWXYZABC'; % Allow lower case as well


%fid = fopen('plain.txt','r');		%  Read the Plaintext
%M = fread(fid);
%fclose(fid); 
%M = char(M);
%M = M';

M = y;

sizM = size(M);

M2 = double(M) - 64;			%  Translate so that index to t table is correct.

for i=1:sizM(2) 

   t = M2(i);
   if (t < 1)
      C(i) = M(i);		% Allows cr, lf, spaces etc through.
   else
      if (t>32)                 % Its lower case
         t = t-32;
         if (t<27)              % its a - z
            C(i) = P(t);	% This is the translation proper.
         else
            C(i) = M(i);        % its not a -z: leave it as-is.
         end
      else
         if (t<27)              %  Its upper-case
            C(i) = char(double(P(t))+32);    %  Translate to lower case
         else
            C(i) = M(i);        %  Its one of those chars between upper & lower. Leave as-is.
         end
      
      end
   end

end

x = C;

%fid=fopen('cipher.txt','w');
%fprintf(fid,'%s',C);
%fclose(fid);

