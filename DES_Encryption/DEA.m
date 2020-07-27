function [fpText, OG, confirm] = DEA(text, key)
        subkeys = DESSubkey(key,16);

        %initial permutation
        initialPTable = [58 50 42 34 26 18 10 2 60 52 44 36 28 20 12 4 ...
            62 54 46 38 30 22 14 6 64 56 48 40 32 24 16 8 ...
            57 49 41 33 25 17 9 1 59 51 43 35 27 19 11 3 ...
            61 53 45 37 29 21 13 5 63 55 47 39 31 23 15 7];
        sizeIpt = size(initialPTable, 2);
        ipText = char(zeros(1,64));


        for i=1:sizeIpt
            ipText(i) = char(text(initialPTable(i)));
        end

        text2=text(initialPTable);

        %do DES rounds
        for j=1:16
           subkey = subkeys(:,j);
           [left,right] = DESRound(text2, j, subkey);
           text2 = [left right];
        end
        
        text2=[right left];

        %final permutation
        finalPTable = [];

        for i=1:sizeIpt
           finalPTable(initialPTable(i)) = i; 
           %strcat(fpText,text(finalPTable(i)));
        end

        for i=1:sizeIpt
            fpText(i) = text2(finalPTable(i));
        end

        decipher = fpText(initialPTable);
        for j=1:16

           subkey = subkeys(:,17-j);
           [left,right] = DESRound(decipher, j, subkey);
           decipher = [left,right];
        end
        
    decipher=[right left];


    OG=decipher(finalPTable);

    confirm=xor(OG,text);


end

