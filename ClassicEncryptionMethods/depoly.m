function x = depoly(y,key)
%
%  function x = depoly(y,key)
%
%  Poly - polyalphabetic Vigenere substitution
% 
%
%    By   G.D.Agnew  (c) 24/2/2001
%    


% a=char;
% b=char;


for i=1:26,
  for j=1:26,
    P(i,j) = 65 + mod(+i-j,26);	% Generate Vigenere translation table
%    P(i,j) = 65 + mod(+i+j-2,26);	% Generate Vigenere translation table
  end
end

P = char(P);

% key = 'dickens';                     %  Partial Vigenere (polyalphabetic with key).

if (nargin<2)
   key = 'abcdefghijklmnopqrstuvwxyz';  %  Full Vigenere key (uses all alphabets).
end


kl = size(key);                      %  Calculate key size
key = (double(key) - 96);            %  Get key to be a numerical index


%P = 'XYZABCDEFGHIJKLMNOPQRSTUVW';
%P(27:32) = '[\]^_`';			%  Allow some special chars
%P(33:58)='xyzabcdefghijklmnopqrstuvw'; % Allow lower case as well


%fid = fopen('cipher.txt','r');		%  Read the Plaintext
%C = fread(fid);
%fclose(fid); 
%C = char(C);
%C = C';

C = y;
sizC = size(C);

C2 = double(C) - 64;			%  Translate so that index to t table is correct.

keyindex = 0;
for i=1:sizC(2) 

   t = C2(i);

   if (t < 1)
      M(i) = C(i);		        % Allows cr, lf, spaces, punctuation etc. through.
   else
      if (t > 32)
         t = t - 32;
      end
      M(i) = P(t, key(1+mod(keyindex,kl(2))));	
      % This is the translation proper.
      keyindex = keyindex + 1;          % Don't count punctuation etc. as encipherable chars

   end

   if ((C2(i)<32)&(C2(i)>0))
      M(i)=char(double(M(i))+32);          % The char is upper case. Make translation lower
   end

end

x = M;

%fid=fopen('plain.txt','w');
%printf(fid,'%s',M);
%close(fid);

