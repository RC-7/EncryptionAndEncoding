function c = count(str)

for x=1:26
	c(x) = 0;                %  First zero the frequency array
end

str = strip(str);
[l,len] = size(str);

for x=1:len
    if str(x) == 'a'
        c(1) = c(1)+1;
    elseif str(x) == 'b'
        c(2) = c(2)+1;
    elseif str(x) == 'c'
        c(3) = c(3)+1;
    elseif str(x) == 'd'
        c(4) = c(4)+1;
    elseif str(x) == 'e'
        c(5) = c(5)+1;
    elseif str(x) == 'f'
        c(6) = c(6)+1;
    elseif str(x) == 'g'
        c(7) = c(7)+1;
    elseif str(x) == 'h'
        c(8) = c(8)+1;
    elseif str(x) == 'i'
        c(9) = c(9)+1;
    elseif str(x) == 'j'
        c(10) = c(10)+1;
    elseif str(x) == 'k'
        c(11) = c(11)+1;
    elseif str(x) == 'l'
        c(12) = c(12)+1;
    elseif str(x) == 'm'
        c(13) = c(13)+1;
    elseif str(x) == 'n'
        c(14) = c(14)+1;
    elseif str(x) == 'o'
        c(15) = c(15) +1 ;
    elseif str(x) == 'p'
        c(16) = c(16)+1;
    elseif str(x) == 'q'
        c(17) = c(17)+1;
    elseif str(x) == 'r'
        c(18) = c(18)+1;
    elseif str(x) == 's'
        c(19) = c(19)+1;
    elseif str(x) == 't'
        c(20) = c(20)+1;
    elseif str(x) == 'u'
        c(21) = c(21)+1;
    elseif str(x) == 'v'
        c(22) = c(22)+1;
    elseif str(x) == 'w'
        c(23) = c(23)+1;
    elseif str(x) == 'x'
        c(24) = c(24)+1;
    elseif str(x) == 'y'
        c(25) = c(25)+1;
    elseif str(x) == 'z'
        c(26) = c(26)+1;
    end;
end;