function prime = SolovayStrasse(  )


% p=randi(9999);




p=13;
a=randi([2,p-2])


if mod(a,2)==0
   a=a+1; 
end
a


r=mod((a^((p-1)/2)),p)

if r~=1 && r~=p-1
   disp('composite') 
   return
end

primefact=factor(p);
s=1;

% s=(-1)^(((a-1)/2)*((p-1)/2))


s=JacobiSymbol(a,p)


for i=1:size(primefact)
    
% s=(a/primefact(i))*s;
% r

end



if r~=s
    
    disp('composite')
    
else
    
    disp('prime')
end





end

