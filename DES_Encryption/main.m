function x = main()
    %Question 1
    testKey = logical('0001001100110100010101110111100110011011101111001101111111110001'-'0');
    subkey1 = DESSubkey(testKey, 1);
    checkKey = logical('000110110000001011101111111111000111000001110010'-'0');
    check = true;
    
    sCheckKey = '';
    sSubkey1 = '';
    
    for i=1:48
        sCheckKey = strcat(sCheckKey, string(checkKey(i) + 0));
        sSubkey1 = strcat(sSubkey1, string(subkey1(i) + 0));
        if subkey1(i) ~= checkKey(i)
            check = false;
        end
    end
    
    if check
        disp('Question 1'); 
        disp(strcat('The test subkey is', {' '}, sCheckKey));
        disp(strcat('The generated subkey is', {' '}, sSubkey1));
        disp('The generated subkey and the test subkey are the same.');
    end

    %Question 2
    disp('-----------'); 
    disp('Question 2'); 
    key1 = '1F1F1F1F0E0E0E0E';
    key2 = '1FFE1FFE0EFE0EFE';
    key3 = '1FFEFE1F0EFEFE0E';
    
    num1 = calculateUniqueSubkeys(key1);
    disp(strcat('The number of unique subkeys for', {' '}, string(key1), {' '}, 'is', {' '}, string(num1)));
    
    num2 = calculateUniqueSubkeys(key2);
    disp(strcat('The number of unique subkeys for', {' '}, string(key2), {' '}, 'is', {' '}, string(num2)));
    
    num3 = calculateUniqueSubkeys(key3);
    disp(strcat('The number of unique subkeys for', {' '}, string(key3), {' '}, 'is', {' '}, string(num3)));
    
    %Question 3
    disp('-----------'); 
    disp('Question 3');
    testText = '1100110000000000110011001111111111110000101010101111000010101010';
    testKey = logical('0001001100110100010101110111100110011011101111001101111111110001'-'0');
    checkText = '1111000010101010111100001010101000111111011101011101000101001011';
   
    subkeys = DESSubkey(testKey, 1);
    
    [leftCipher, rightCipher] = DESRound(testText, 1, subkeys(:,1));
    
    sRCipher = '';
    sLCipher = '';
    for j=1:32
       sRCipher = strcat(sRCipher, char(rightCipher(j)+'0'));
       sLCipher = strcat(sLCipher, leftCipher(j));
    end
    disp(strcat('The ciphertext is', {' '}, sLCipher, sRCipher));
    disp(strcat('The check ciphertext is', {' '}, checkText));
    
    check = true;
    for k=1:64
        if k < 33
            if sLCipher(k) ~= checkText(k)
               check = false; 
            end
        else
            if sRCipher(k-32) ~= checkText(k)
               check = false; 
            end
        end
    end
    
    if check
        disp('The generated and check ciphertexts match.');
    else
        disp('The generated and check ciphertexts do not match.');
    end
    
    %Question 4
    disp('-----------'); 
    disp('Question 4');
    testText = hexToBinaryVector('8787878787878787',64);
    testKey = hexToBinaryVector('0E329232EA6D0D73',64);

    binText = [];
    binKey = [];

    for i=1:64
        binText(i) = testText(i);
        binKey(i) = testKey(i);
    end

    [~, decipher, confirm] = DEA(binText,binKey);  
    
    
    sBinText = '';
    sDecipher = '';
    
    for j=1:64
        sBinText = strcat(sBinText, string(binText(j)));
        sDecipher = strcat(sDecipher, string(decipher(j)));
    end
    
    disp(strcat('The plaintext is', {' '}, sBinText));
    disp(strcat('The deciphered text is', {' '}, sDecipher));
    if confirm == zeros(64,1)
        disp('The ciphered and deciphered text match.');
    else
        disp('The ciphered and deciphered text do not match.');
    end
end

