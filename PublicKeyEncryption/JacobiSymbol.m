function j = JacobiSymbol( a,b )

if b<0 || mod(b,2)==0
    
    j=0;
    return
end

j=1;

if a<0
    a=-a;
    if mod(b,4)==3
        j=-j;
    end
end




while a~=0
    
    while mod(a,2)==0
        
        a=a/2;
        if mod(b,8)==3 || mod(b,8)==5
            
            j=-j;
        end
    end
    temp=a;
    a=b;
    b=temp;
    
    if mod(a,4)==3 && mod(b,4)==3
        j=-j;
    end
    
    a=mod(a,b);
end
if b==1
    return
else
    j=0;
    return
end




end

