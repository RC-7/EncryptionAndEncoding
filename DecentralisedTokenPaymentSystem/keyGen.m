function [primeNumber, publicKey, privateKey, n, phi, chosingE, congruent] = keyGen( )


    primeNumber=zeros(1,2);

    for i=1:2

        isPrime=0;

        while ~isPrime
            possiblePrime=randi(9999); %mac can use is 10000^2
            isPrime=SolovayStrasseReal(possiblePrime,50);


        end
        primeNumber(i)=possiblePrime;

    end

    %
    % primeNumber(1)=53;
    % primeNumber(2)=59;

    n=primeNumber(1)*primeNumber(2);

    phi=(primeNumber(1)-1)*(primeNumber(2)-1); %% e and phi relative prime

    chosingE=0;
    while chosingE==0

        e=randi([1,n]);
        % e=3

        if GCD(e,phi)==1

            chosingE=1;
        end



    end

    [~, d,~]=extendedEuclid(e,phi);

    %publicKey=[e,n];
    %privateKey=[d,n];

    publicKey=e;
    privateKey=d;

    congruent = 0;
    
    for i=1:d
        congruent = congruent + e;
        
        if congruent > phi
            congruent = mod(congruent, phi);
        end
    end 
    congruent = mod(congruent, phi);
end

