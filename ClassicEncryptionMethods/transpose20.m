function [x3, x4] = transpose20()

  twenty=readfile('20.txt');
  i=0;
 back=1;
  temp=twenty;
  
  while back==1
      iterate=temp;
  temp=encolumn(iterate,4);
  i=i+1;
 if temp==twenty
     back=0;
     x3 = i;
     temp;
 end
  end
  
  back=1;
  temp=twenty;
  i=0;
  while back==1
      iterate=temp;
  temp=encolumn(iterate,5);
  i=i+1;
 if temp==twenty
     back=0;
     x4 = i;
     temp;
 end
  end
end

