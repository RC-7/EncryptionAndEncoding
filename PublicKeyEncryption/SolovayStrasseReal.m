function isIt = SolovayStrasseReal( p,it )

%isIt ==1 if prime and 0 otherwise

a=randi([2,p-2]);
count=0;

for i=0:it
    
    a=randi([2,p-2]);
    %    a=84
    jacob=mod(p+(JacobiSymbol(a,p)),p);
    
    
    %does't work because rounds off...
    %    r=mod((a^((p-1)/2)),p)
    
    
    test=(p-1)/2;
    x=1;
    y=a;
    %    mod=p;
    
    
    %fixing rounding error
    while test>0
        %       mod(test,2)
        if mod(test,2)==1
            x=mod((x*y),p);
        end
        
        y=mod((y*y),p);
        test=fix(test/2);
        
    end
    
    r=mod(x,p);
    
    
    
    if (~jacob) || r~=jacob
        
        isIt=0;
        return
        
        
    end
    
    
    
end

isIt=1;
return

end

