function x = enpoly(y,key)
%
%  function x = enpoly(y,key)
%
%  Poly - polyalphabetic Vigenere substitution. Enciphers with
%  the key contained in the text string 'key'. If key is omitted
%  then the default key "abcdefghijklmnopqrstuvwxyz' is used for
%  maximum letter frequency distribution flattening.
%

% a=char;
% b=char;


for i=1:26,
  for j=1:26,
    P(i,j) = 97 + mod(i+j-2,26);	% Generate Vigenere translation table
  end
end

P = char(P);

%key = 'dickens';                     %  Partial Vigenere (polyalphabetic with key).
if (nargin<2)
   key = 'abcdefghijklmnopqrstuvwxyz';  %  Full Vigenere key (uses all alphabets).
end


kl = size(key);                      %  Calculate key size
key = (double(key) - 96);            %  Get key to be a numerical index


%P = 'XYZABCDEFGHIJKLMNOPQRSTUVW';
%P(27:32) = '[\]^_`';			%  Allow some special chars
%P(33:58)='xyzabcdefghijklmnopqrstuvw'; % Allow lower case as well


%fid = fopen('plain.txt','r');		%  Read the Plaintext
%M = fread(fid);
%close(fid); 
%M = char(M);
%M = M';

M = y;
sizM = size(M);

M2 = double(M) - 64;			%  Translate so that index to t table is correct.

keyindex = 0;
for i=1:sizM(2) 

   t = M2(i);

   if (t < 1)
      C(i) = M(i);		        % Allows cr, lf, spaces, punctuation etc. through.
   else
      if (t > 32)
         t = t - 32;
      end
      if (t < 27)                      % Eliminate the junk between the upper & lower case sets
         C(i) = P(key(1+mod(keyindex,kl(2))), t);	
         % This is the translation proper.
         keyindex = keyindex + 1;          % Don't count punctuation etc. as encipherable chars
      end

   end

   if (M2(i)>32)
      C(i)=char(double(C(i))-32);          % The char is lower case. Make translation upper
   end

end

x = C;

%fid=fopen('cipher.txt','w');
%fprintf(fid,'%s',C);
%fclose(fid);

