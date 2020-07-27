function [z,t] =freqmatch(y,f)
%
%  function [z,t] =freqmatch(y,f)
%
%  Takes the incoming text in y and does a frequency analysis.
%  Then compares this with the normal language's frequency distribution
%  contained in f and translates the alphabet according to the frequency
%  distribution to return deciphered text in z (assuming that the
%  translation was due to a monoalphabetic substitution). If f is not specified,
%  the normal values for the English language (see inside the program)
%  are used. The discovered translation table is returned in t.
%
%    By   G.D.Agnew  (c) 24/2/2001
%    


alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

if (nargin<2)
  

%  f = [ 0.0544    0.0106    0.0290    0.0267    0.0916    0.0176    0.0219 ... %  abcdefg
%        0.0280    0.0577    0.0005    0.0046    0.0328    0.0166    0.0411 ... %  hijklmn
%        0.0570    0.0335    0.0002    0.0421    0.0525    0.0608    0.0303 ... %  opqrstu
%        0.0073    0.0091    0.0046    0.0194    0.0015 ];                      %  vwxyz


   f = [ 0.0749    0.0129    0.0354    0.0362    0.1400    0.0218    0.0174 ... %  abcdefg
         0.0422    0.0665    0.0027    0.0047    0.0357    0.0339    0.0674 ... %  hijklmn
         0.0737    0.0243    0.0026    0.0614    0.0695    0.0985    0.0300 ... %  opqrstu
         0.0116    0.0169    0.0028    0.0164    0.0004 ];                      %  vwxyz


end


x = freqget(y);   %  Find the frequency distribution of the supplied text sample.

f2 = f;   %  Makes copies of the two distributions
x2 = x;


%  This (below) is the simplest algorithm for matching
%  two frequency tables - going from highest to lowest values in each
%  table, matching them one by one. However, a better method would
%  be to match the two tables in the least squares error sense.
%
for i=1:26         
   [y1,i1] = max(f2);
   [y2,i2] = max(x2);
   f2(i1) = 0.0;       % eliminate these from further consideration
   x2(i2) = 0.0;
   ttable(i2) = alphabet(i1);      

end

t = ttable;
z = demono(y,t);   %  Use the discovered translation table to decrypt the message.


