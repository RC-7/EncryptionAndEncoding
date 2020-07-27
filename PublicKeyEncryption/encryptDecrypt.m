function [nums, crypt, decrypt, x, check, encryptTime, decryptTime] = encryptDecrypt(k, n, d)
    %[k,d, n] = keyGen();
    nums = randperm(10000, 1000);
    crypt = zeros(1, 1000);
    decrypt = zeros(1, 1000);
    
    tic
    for i=1:1000
        %crypt(i) = mod(nums(i)^k, n);
        x=1;
        y=nums(i);
        test = k;
        
        %    mod=p;


        %fixing rounding error
        while test>0
            %       mod(test,2)
            if mod(test,2)==1
                x=mod((x*y),n);
            end

            y=mod((y*y),n);
            test=fix(test/2);

        end
        
        crypt(i) = mod(x, n);
    end
    
    encryptTime = toc;
    
    check = true;
    tic
    for j=1:1000
        x=1;
        y=crypt(j);
        test = d;

        %fixing rounding error
        while test>0
            %       mod(test,2)
            if mod(test,2)==1
                x=mod((x*y),n);
            end

            y=mod((y*y),n);
            test=fix(test/2);

        end
        
        decrypt(j) = mod(x, n);
        
        if nums(j) ~= decrypt(j)
            check = false;
        end
    end
    
    decryptTime = toc;
    
end

