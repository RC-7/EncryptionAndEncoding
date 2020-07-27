function IC = calculateIC(text)
    IC = 0;
    %fileName = 'sampleText.txt';
   
%     fId = fopen(fileName, 'r');
%     fFormat = '%s';
%     fSize = [1 Inf];
%     text = fscanf(fId, fFormat, fSize);

    freq = count(text);
    sizeF = sum(freq);
    

    for i=2:26
        IC = IC + (freq(i) * (freq(i)-1))/(sizeF * (sizeF-1));
    end

end

