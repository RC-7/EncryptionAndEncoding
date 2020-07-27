function hash = SHA(text)
    %note addition is modulo 2^32

    h0 = hexToBinaryVector('6a09e667', 32);
    h1 = hexToBinaryVector('bb67ae85', 32);
    h2 = hexToBinaryVector('3c6ef372', 32);
    h3 = hexToBinaryVector('a54ff53a', 32);
    h4 = hexToBinaryVector('510e527f', 32);
    h5 = hexToBinaryVector('9b05688c', 32);
    h6 = hexToBinaryVector('1f83d9ab', 32);
    h7 = hexToBinaryVector('5be0cd19', 32);
    
   const = {'428a2f98', '71374491', 'b5c0fbcf', 'e9b5dba5', '3956c25b', '59f111f1', '923f82a4', 'ab1c5ed5',...
   'd807aa98', '12835b01', '243185be', '550c7dc3', '72be5d74', '80deb1fe', '9bdc06a7', 'c19bf174',...
   'e49b69c1', 'efbe4786', '0fc19dc6', '240ca1cc', '2de92c6f', '4a7484aa', '5cb0a9dc', '76f988da',...
   '983e5152', 'a831c66d', 'b00327c8', 'bf597fc7', 'c6e00bf3', 'd5a79147', '06ca6351', '14292967',...
   '27b70a85', '2e1b2138', '4d2c6dfc', '53380d13', '650a7354', '766a0abb', '81c2c92e', '92722c85',...
   'a2bfe8a1', 'a81a664b', 'c24b8b70', 'c76c51a3', 'd192e819', 'd6990624', 'f40e3585', '106aa070',...
   '19a4c116', '1e376c08', '2748774c', '34b0bcb5', '391c0cb3', '4ed8aa4a', '5b9cca4f', '682e6ff3',...
   '748f82ee', '78a5636f', '84c87814', '8cc70208', '90befffa', 'a4506ceb', 'bef9a3f7', 'c67178f2'};

%     x = hexToBinaryVector(const(1), 32)

    binText = hexToBinaryVector(text);
    if mod(length(binText), 2) ~= 0
        binText = horzcat(0, binText);
    end
    lengthB = length(binText);
    hexSize = dec2hex(lengthB);
    binSize = hexToBinaryVector(hexSize, 64);
    
    binText(lengthB+1) = 1;
    currLength = length(binText);
    num = 0;
    while mod((lengthB + 1 + num + 64), 512) ~= 0
        binText(currLength+1) = 0;
        num = num+1;
        currLength = currLength+1;
    end
    
    binText = horzcat(binText, binSize);
    
    messageLength = length(binText);
    pos = 0;
    
    while messageLength > 0
        words = {[]};
        
        count = 1;
        for j=1:16
            words{j}(1:32) = binText(pos+count:pos+count+31);
            count=count+32;
        end
        
%         words{16}
%          binaryVectorToHex(words{2})
        
        for k=17:64
            n = 3;
            tmp = words{k-15};
            tmp = circshift(tmp, [1, n]);
            tmp(1:n) = 0;
            s0 = xor(xor(circshift(words{k-15}, [1, 7]), circshift(words{k-15}, [1, 18])), tmp);
            
            n = 10;
            tmp = words{k-2};
            tmp = circshift(tmp, [1, n]);
            tmp(1:n) = 0;
            s1 = xor(xor(circshift(words{k-2}, [1, 17]), circshift(words{k-2}, [1, 19])), tmp);
            
            decw1 = bin2dec(char(words{k-16} + '0'));
            decs0 = bin2dec(char(s0 + '0'));
            decw2 = bin2dec(char(words{k-7} + '0'));
            decs1 = bin2dec(char(s1 + '0'));
            tot = mod(mod(mod(decw1+decs0, 2e32) + decw2, 2e32) + decs1, 2e32);
            sBin = dec2bin(tot, 32);
            
            for j=1:32
                words{k}(j) = str2double(sBin(j));
            end
        end
        
        a = h0;
        b = h1;
        c = h2;
        d = h3;
        e = h4;
        f = h5;
        g = h6;
        h = h7;
        
        for l=1:64
            S1 = xor(xor(circshift(e, [1, 6]), circshift(e, [1, 11])), circshift(e, [1, 25]));
            ch = xor(bitand(e, f), bitand(~e, g));
            
            dech = bin2dec(char(h + '0'));
            decS1 = bin2dec(char(S1 + '0'));
            decch = bin2dec(char(ch + '0'));
            decconst = bin2dec(char(hexToBinaryVector(const(l), 32) + '0'));
            decwords = bin2dec(char(words{l} + '0'));
            tot = mod(mod(mod(mod(dech+decS1, 2e32)+decch, 2e32)+decconst, 2e32)+decwords, 2e32);
            sBin = dec2bin(tot, 32);
            
            for j=1:32
                temp1(j) = str2double(sBin(j));
            end
%             temp1 = h+S1+ch+hexToBinaryVector(const(l), 32)+words{l};
            
            S0 = xor(xor(circshift(a, [1, 2]), circshift(a, [1, 13])), circshift(a, [1, 22]));
            maj = xor(xor(bitand(a, b), bitand(a, c)), bitand(b, c));
            
            decS0 = bin2dec(char(S0 + '0'));
            decmaj = bin2dec(char(maj + '0'));
            tot = mod(decS0+decmaj, 2e32);
            sBin = dec2bin(tot, 32);
            
            for j=1:32
                temp2(j) = str2double(sBin(j));
            end
%             temp2 = S0+maj;
            
            h = g;
            g = f;
            f = e;
            
            decd = bin2dec(char(d + '0'));
            dectemp1 = bin2dec(char(temp1 + '0'));
            tot = mod(decd+dectemp1, 2e32);
            sBin = dec2bin(tot, 32);
            
            for j=1:32
                e(j) = str2double(sBin(j));
            end
%             e = d + temp1;
            
            d = c;
            c = b;
            b = a;
            
            dectemp1 = bin2dec(char(temp1 + '0'));
            dectemp2 = bin2dec(char(temp2 + '0'));
            tot = mod(dectemp1+dectemp2, 2e32);
            sBin = dec2bin(tot, 32);
            
            for j=1:32
                a(j) = str2double(sBin(j));
            end
%             a = temp1 + temp2;
            
        end
        
        dech0 = bin2dec(char(h0 + '0'));
        deca = bin2dec(char(a + '0'));
        tot = mod(dech0+deca, 2e32);
        sBin = dec2bin(tot, 32);

        for j=1:32
            h0(j) = str2double(sBin(j));
        end
%         h0 = h0 + a;
        
        dech1 = bin2dec(char(h1 + '0'));
        decb = bin2dec(char(b + '0'));
        tot = mod(dech1+decb, 2e32);
        sBin = dec2bin(tot, 32);

        for j=1:32
            h1(j) = str2double(sBin(j));
        end
%         h1 = h1 + b;
        
        dech2 = bin2dec(char(h2 + '0'));
        decc = bin2dec(char(c + '0'));
        tot = mod(dech2+decc, 2e32);
        sBin = dec2bin(tot, 32);

        for j=1:32
            h2(j) = str2double(sBin(j));
        end
%         h2 = h2 + c;
        
        dech3 = bin2dec(char(h3+ '0'));
        decd = bin2dec(char(d + '0'));
        tot = mod(dech3+decd, 2e32);
        sBin = dec2bin(tot, 32);

        for j=1:32
            h3(j) = str2double(sBin(j));
        end
%         h3 = h3 + d;
        
        dech4 = bin2dec(char(h4 + '0'));
        dece = bin2dec(char(e + '0'));
        tot = mod(dech4+dece, 2e32);
        sBin = dec2bin(tot, 32);

        for j=1:32
            h4(j) = str2double(sBin(j));
        end
%         h4 = h4 + e
        
        dech5 = bin2dec(char(h5 + '0'));
        decf = bin2dec(char(f + '0'));
        tot = mod(dech5+decf, 2e32);
        sBin = dec2bin(tot, 32);

        for j=1:32
            h5(j) = str2double(sBin(j));
        end
%         h5 = h5 + f;
        
        dech6 = bin2dec(char(h6 + '0'));
        decg = bin2dec(char(g + '0'));
        tot = mod(dech6+decg, 2e32);
        sBin = dec2bin(tot, 32);

        for j=1:32
            h6(j) = str2double(sBin(j));
        end
%         h6 = h6 + g;
        
        dech7 = bin2dec(char(h7 + '0'));
        dech = bin2dec(char(h + '0'));
        tot = mod(dech7+dech, 2e32);
        sBin = dec2bin(tot, 32);

        for j=1:32
            h7(j) = str2double(sBin(j));
        end
%         h7 = h7 + h;
        
        messageLength = messageLength - 512;
        pos = pos+512;
    end
    %append to get final hash
     hash = horzcat(h0, h1, h2, h3, h4, h5, h6, h7);
     hash = binaryVectorToHex(hash);
end

