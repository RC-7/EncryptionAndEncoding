function x = main()
    [primes, publicKey, privateKey, n, phi, chosingE, congruent] = keyGen();
    disp('Question 1');
    
    if isprime(primes(1)) && isprime(primes(2))
        prime = strcat('The two generated numbers,', {' '}, string(primes(1)) ...
            , ' and', {' '}, string(primes(2)), {' '}, 'are prime.');
        disp(prime);
    end
    
    pqphi = strcat('The product, m, of p and q is', {' '}, string(n), ' and the totient function of m is ', {' '}, ...
        string(phi));
    disp(pqphi);
    
    pubKey = strcat('The public key is', {' '}, string(publicKey));
    disp(pubKey);
    
    if chosingE 
        pubKey = strcat('The public key is co-prime to the totient function of m.');
        disp(pubKey);
    end
    
    privKey = strcat('The private key is', {' '}, string(privateKey));
    disp(privKey);
    
    if congruent
        con = strcat('The product of the public and private key is congruent to 1 modulus the totient function of m.');
        disp(con);
    end

    disp('-------------------');

    [nums, crypt, decrypt, x, check, encryptTime, decryptTime] = encryptDecrypt(publicKey, n, privateKey);
    disp('Question 2');
    
    disp('Numbers:');
    nums
    
    disp('Encrypted Numbers:');
    crypt
    
    disp('Decrypted Numbers:');
    decrypt
    
    x = '';    
    
    if check
        x = strcat(x, 'The plaintext and decrypted text match. The encryption time was' ...
            , {' '}, string(encryptTime), '. The decryption time was' ...
            , {' '}, string(decryptTime));
    end
    
    
end