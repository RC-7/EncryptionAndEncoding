function x = main()
    %first read in and strip text of spaces and puncutation
    fileName = 'sampleText.txt';
    text = readfile(fileName);
    stripText = strip(text, 0);

    %1a) and 1b)
    q1a = calcDist(stripText)

    %1d) and 1e)
    [q1d, q1e] = recoverTable(stripText)
    
    %2
    q2 = multIC(stripText)
    
    %3a
    transpose22()
    
    %3b
    [q3b1, q3b2] = transpose91();
    q3b1
    q3b2
    
    %3c
    [q3c1, q3c2] = transpose20();
    q3c1
    q3c2
end

