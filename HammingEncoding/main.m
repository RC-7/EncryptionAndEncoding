%% Assignment 1
disp('Assignment 1');

%Question 1
message = zeros(16,4);
codeword1=zeros(16,7);

for i=0:15
    message(i+1,:)=de2bi(i,4); %little endian
    
end

g=[1 1 0; 0 1 1; 1 1 1; 1 0 1];
Id=eye(4);

GenMatrix=[g Id];

C1=mod(message*GenMatrix, 2)

%Question 2
IdH=eye(3);

H=[IdH g.'];
sevenBit=zeros(1,7);
poly=[1 1 0 1 0 0 0];
% for non-systematic
G_nonSystematic=poly;

for i=2:4
    
    G_nonSystematic=[G_nonSystematic; circshift(poly,[1, i-1])];
end
   
    
G_nonSystematic;  % non-systematic form of the Generator matrix using the polynomial

C2=mod(message*G_nonSystematic, 2)



%Question 4
% for systematic, creates a systeamtic form of the generator matrix using the polynomial
%i->H(x,4)
count =1;
for i=1:4
ex=de2bi(2^(i+2), 7)   ;
gfc = gfconv(ex,poly,2);
[~,remd] = gfdeconv(ex,poly,2);

temp=zeros(1,7-length(remd));
remd=[remd, temp];

polyAdd= gfconv(de2bi(2^(i-1), 7),poly,2);

temp=zeros(1,7-length(polyAdd));
polyAdd=[polyAdd, temp];

Gadd=ex+remd;

% Gadd=xor(message,remd)

% if length(gfc)<7
%    temp=zeros(1,7-length(gfc));
%    gfc=[gfc,temp];
   
   if count ==1
       G=Gadd;
       count=count+1;
   else
%        gfc=circshift(gfc,[i,0]);
       G=[G;Gadd];
   end
% end
    
end

G
Csys=mod(message*G, 2);

% systematically encodes the messages using the non-systemaic form of the generator matrix
% this results in the same codewords generated as Csys

for i=1:16
m=gfconv(message(i,:),[0 0 0 1]);

m=[m, zeros(1,7-length(m))];

[~,remd] = gfdeconv(m,poly,2);

CsystematicByDef(i,:)=gfsub(m, remd,2);
end

%Question 5
% min distance

minDistance=sum(xor(C1(1,:),C1(2,:)))

for i=1:16
    
    for j=1:16
        
        if j~=i
           newMin=sum(xor(C1(i,:),C1(j,:)));
           
           if newMin<minDistance
           minDistance=newMin;

           end
            
        end
        
    end 
end

%Question 6
%min weight

minWeight=(sum(C1(2,:))); %row 1 is all zeros
for i=3:16

    newWeight=(sum(C1(i,:)));
    
    if newWeight<minWeight
        minWeight=newWeight;
    end
    
end
minWeight

%Question 8

%make sure to change to our specific student number
StudentNumber=[2 9 7]; %little endian....
% set_param('TargetEndianess', 'LittleEndian')

BinaryStudent=de2bi(StudentNumber,4);


Cstudent=mod(BinaryStudent*GenMatrix,2)


%% Assignment 2
disp('Assignment 2');

%Question 1
initialWord = [1, 0, 1, 0, 0, 0, 1];

disp('Initial known codeword');
initialWord

[c, m] = DecodeHam(initialWord);
disp('Codeword after correction (none in this case)');
c
disp('Message after decoding');
m

codeword = initialWord;
testWords(1,:) = initialWord;
correctedWords(1,:) = initialWord;
for i=1:length(initialWord)
    codeword(i) = mod(xor(codeword(i), 1), 2);
    fprintf('Codeword with corrupted bit at position %i', i);
    codeword
    testWords(i+1,:) = codeword; 
    [codeword, m] = DecodeHam(codeword);
    disp('Codeword after correction');
    codeword
    disp('Message after decoding');
    m
    correctedWords(i+1,:) = codeword;
end

dlmwrite('matrixTestWords.txt', testWords);
dlmwrite('matrixCorrectedWords.txt', correctedWords);

%Question 2
initialWord = [1, 0, 1, 0, 0, 0, 1];

disp('Initial known codeword');
initialWord

[c, m] = remSynd(initialWord);
disp('Codeword after correction (none in this case)');
c
disp('Message after decoding');
m

codeword = initialWord;
testWords(1,:) = initialWord;
correctedWords(1,:) = initialWord;

for i=1:length(initialWord)
    codeword(i) = mod(xor(codeword(i), 1), 2);
    fprintf('Codeword with corrupted bit at position %i', i);
    codeword
    testWords(i+1,:) = codeword; 
    [codeword, m] = remSynd(codeword);
    disp('Codeword after correction');
    codeword
    disp('Message after decoding');
    m
    correctedWords(i+1,:) = codeword;
end

dlmwrite('polynomialTestWords.txt', testWords);
dlmwrite('polynomialCorrectedWords.txt', correctedWords);