initialWord = [1, 0, 1, 0, 0, 0, 1];

initialWord
DecodeHam(initialWord)
for i=1:length(initialWord)
    initialWord(i) = mod(xor(initialWord(i), 1), 2);
    initialWord
    initialWord = DecodeHam(initialWord)
end