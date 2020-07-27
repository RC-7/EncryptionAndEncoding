function K_i =DESSubkey(key,index)
%add parity if key ==56 bits, add check

oneShift=[1,2,9,16];
oneShiftCount=1;

permuteKey=zeros(1,64);
keyWithPArity=zeros(1,64);
keySize = length(key);

permutationTable=[57 49 41 33 25 17 9 1 58 50 42 34 26 18 ...
10 2 59 51 43 35 27 19 11 3 60 52 44 36 ...
63 55 47 39 31 23 15 7 62 54 46 38 30 22 ...
14 6 61 53 45 37 29 21 13 5 28 20 12 4];



compressionTable=[14    17   11    24     1    5 ...
 3    28   15     6    21   10 ...
23    19   12     4    26    8 ...
16     7   27    20    13    2 ... 
41    52   31    37    47   55 ...
30    40   51    45    33   48 ...
44    49   39    56    34   53 ...
46    42   50    36    29   32];
% 

%getting parity bits back
    if keySize < 64
        lastPos=8;
        numParityAdded=2;
        parityBit=1;
        xOR=key(1);

        for j=2:7

            xOR=xor(xOR,key(j));
        %     key(j)
        end
        keyWithPArity(1:1*7+1)=[key(1:7) xOR];

        for i=2:8

        %     lastPos+1
        %     i*7+numParityAdded

        xOR=key(((i-1)*7)+1);

        for j=((i-1)*7)+2:i*7

            xOR=xor(xOR,key(j));
            key(j);
        end



           keyWithPArity(lastPos+1:i*7+numParityAdded)=[key(((i-1)*7)+1:i*7) xOR];
           lastPos=i*7+numParityAdded;  
        numParityAdded=numParityAdded+1;

        end

    else
        keyWithPArity=key;
    end


   
    permuteKey=keyWithPArity(permutationTable);
    


% permuteKey=keyWithPArity(permutationTable);


keyLeft=permuteKey(1:28);
keyRight=permuteKey(29:56);

for i=1:index
    
    tempLeft=keyLeft;
    tempRight=keyRight;
    if i==oneShift(oneShiftCount)
        %shift by one
        oneShiftCount=oneShiftCount+1;
       
        keyLeft(1:27)=tempLeft(2:28);
        keyLeft(28)=tempLeft(1);
        keyRight(1:27)=tempRight(2:28);
        keyRight(28)=tempRight(1);
        
    else
         %shift by two
        keyLeft(1:26)=tempLeft(3:28);
        keyLeft(27:28)=tempLeft(1:2);
        keyRight(1:26)=tempRight(3:28);
        keyRight(27:28)=tempRight(1:2);
       
    end
    

    
    onePermutation=[keyLeft keyRight];
    
    finalSubkey=onePermutation(compressionTable);
    
    
    
K_i(:,i)=finalSubkey;

end


end

