function [corrected, message] = remSynd(received)
    n = 7;
    k = 4;
    gx = [1 1 0 1 0 0 0];
    
    [~, check] = gfdeconv(received, gx, 2);
    
    H = [1, 0, 0, 1, 0, 1, 1; ...
        0, 1, 0, 1, 1, 1, 0; ...
        0, 0, 1, 0, 1, 1, 1];
    
    if any(check)
        pos = -1;
        i = 1;
        while pos == -1
            check2 = true;
            
            for j=1:length(check)
                if check(j) ~= H(j,i)
                    check2 = false;
                end
            end
            
            if check2
                pos = i;
            end
            i = i+1;
        end
%         pos = pos-1;
        received(pos) = xor(received(pos), 1);
    end
%     check
     message = logical(received(n-k+1:end));
    corrected = received;
end

