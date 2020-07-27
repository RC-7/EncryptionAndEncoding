function [comparrisonTranslationTable1, comparrisonTranslationTable2] = recoverTable(stripText)
    alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    forwardTranslationTable= 'DEFGHIJKLMNOPQRSTUVWXYZABC';	%  The translation table
    backwardsTranslationTable = 'XYZABCDEFGHIJKLMNOPQRSTUVW';
    encrypted=enmono(stripText,forwardTranslationTable);
    freqStripped=freqget(stripText);
    %decrypted=demono(encrypted,backwardsTranslationTable);    

    [z,x]=freqmatch(encrypted);
    
    for i=1:length(x)
        comparrisonTranslationTable1(i,1)=alphabet(i);
        comparrisonTranslationTable1(i,2)=',';
        comparrisonTranslationTable1(i,3)=backwardsTranslationTable(i);
        comparrisonTranslationTable1(i,4)=',';
        comparrisonTranslationTable1(i,5)=x(i);
    end
    
    [z,y]=freqmatch(encrypted,freqStripped);
    
    for i=1:length(x)
        comparrisonTranslationTable2(i,1)=alphabet(i);
        comparrisonTranslationTable2(i,2)=',';
        comparrisonTranslationTable2(i,3)=backwardsTranslationTable(i);
        comparrisonTranslationTable2(i,4)=',';
        comparrisonTranslationTable2(i,5)=y(i);
    end
end

