function num = calculateUniqueSubkeys(key)
    num = 1;
    subkeys = {};
    binKey = hexToBinaryVector(key,64);
    newKey = DESSubkey(binKey, 16);
    for i=1:16
        %sKey = [];
        sKey = char(newKey(:,i) + '0');
        keyStr = '';
        
        for j=1:48
            keyStr = strcat(keyStr,sKey(j));
        end
        check = false;      
        
        if i ~= 1
            [~,sizeC] = size(subkeys);
            for j=1:sizeC
                if string(subkeys(j)) == keyStr
                   check = true; 
                end
            end
            
            if ~check
                subkeys(num) = cellstr(keyStr);
                num = num + 1;            
            end
            
        else
            subkeys(num) = cellstr(keyStr);
            num = num+1;
        end
    end
    num = num-1;
    subkeys
end

