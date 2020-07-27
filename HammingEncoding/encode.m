message = zeros(16,4);
codeword1=zeros(16,7);
% Generate the plaintext matrix



for i=0:15
    message(i+1,:)=de2bi(i,4); %little endian
    
end


% dec2bin(i,4)-'0';  big endian



g=[1 1 0; 0 1 1; 1 1 1; 1 0 1];
Id=eye(4);

GenMatrix=[g Id]



C1=mod(message*GenMatrix, 2);




IdH=eye(3);

H=[IdH g.'];
sevenBit=zeros(1,7);
poly=[1 1 0 1 0 0 0];
% for non-systematic
G_nonSystematic=poly;

for i=2:4
    
    G_nonSystematic=[G_nonSystematic; circshift(poly,[1, i-1])];
end
   
    
G_nonSystematic  % use gauss...



C2=mod(message*G_nonSystematic, 2);


% for systematic
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

for i=1:16
m=gfconv(message(i,:),[0 0 0 1]);

m=[m, zeros(1,7-length(m))];

[~,remd] = gfdeconv(m,poly,2);

CsystematicByDef(i,:)=gfsub(m, remd,2);
end
% min distance

minDistance=sum(xor(C1(1,:),C1(2,:)));

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


%min weight


minWeight=(sum(C1(2,:))); %row 1 is all zeros
for i=3:16

    newWeight=(sum(C1(i,:)));
    
    if newWeight<minWeight
        minWeight=newWeight;
    end
    
end


StudentNumber=[2 9 7]; %little endian....
% set_param('TargetEndianess', 'LittleEndian')

BinaryStudent=de2bi(StudentNumber,4);


Cstudent=mod(BinaryStudent*GenMatrix,2)




% systematic encoding




