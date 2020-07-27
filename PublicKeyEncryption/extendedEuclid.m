function [gcd x y] = extendedEuclid( a,b )
phi=b;
y=1;
x= 0;
u=1;
v=0;

while a~=0
    
    q=floor(b/a);
    r=mod(b,a);
    m=x-u*q;
    n=y-v*q;
    b=a;
    a=r;
    x=u;
    y=v;
    u=m;
    v=n;
end
gcd=b;

if x<0
    
    x=phi+x;
end



end

