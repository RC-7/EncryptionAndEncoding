function IC = multIC(stripText)
    IC = zeros(2, 5);
    
    key = '';
    
    for i=1:5
        newKey = char(randi([2, 26], 1) + 96);
        key = strcat(key, newKey);
        IC(1, i) = i;
        IC(2, i) = calculateIC(lower(enpoly(stripText, key)));
    end
end