function remainder = GCD( a,b )

divident=b;
quotient=a;
nextQuotient=a;

keepGoing=1;

while keepGoing==1
    quotient=nextQuotient;
    nextQuotient=divident;
    divident=(-1)*(quotient-floor(quotient/divident)*divident);
    
    if divident==0
        remainder=abs(nextQuotient);
        keepGoing=0;
        return
    end
    
end




end

