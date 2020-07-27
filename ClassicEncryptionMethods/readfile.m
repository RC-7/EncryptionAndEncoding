function x=readfile(y)
%  Puts the contents of a text file with path and name
%  specified in string y, into char array x.
%      Example:  mystring = readfile('c:\workdir\readme.txt');
%
%    By   G.D.Agnew  (c) 24/2/2001
%    



fid = fopen(y,'r');		%  Read the Plaintext
M = fread(fid);
fclose(fid); 
x = char(M');


