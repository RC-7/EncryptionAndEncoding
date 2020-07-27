function [ decrypt ] = encryptorDecrypt( base,exponent,n)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% TO encrypt or decrypt using %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% RSA %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        x=1;
        y=base;
        newExponent = exponent;

        %fixing rounding error
        while newExponent>0
            %       mod(test,2)
            if mod(newExponent,2)==1
                x=mod((x*y),n);
            end

            y=mod((y*y),n);
            newExponent=fix(newExponent/2);

        end
        
        decrypt = mod(x, n);
       
end

