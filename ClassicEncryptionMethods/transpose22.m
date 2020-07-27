function [x3, x4] = transpose22()
  twentyTwoBuff=readfile('22.txt');
  twentyTwo=lower(twentyTwoBuff);
  transpose=encolumn(twentyTwo);
  OG=decolumn(transpose);
  x=count(twentyTwo);
  x2=count(transpose);
  
  %one is scalled due to fregget implimentation
  figure, 
  hold on
  stem(freqget(twentyTwo)),stem(freqget(transpose))
  legend('input data','frequency distribution of cypher-text using transposition')
  hold off;
  title('Q3a) Scaled frequency distribution Comparison') 
  %non-scalled version
  figure, 
  hold on
  stem(count(twentyTwo)),
  stem(count(transpose),'--','+')
  legend('input data','character count of cypher-text using transposition')
  hold off;
  title('Q3a) Unscaled frequency distribution Comparsion') 
  x3 = x;
  x4 = x2;
end

