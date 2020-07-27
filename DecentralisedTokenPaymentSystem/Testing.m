delete('errorLog.txt')
aNode=Node;
aNode.readDataBase();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% See errorLog.txt once the code has been run to view the different errors %
%%%% and attacks that were simulated on the system and the fact that the %%%
%%%%%%%%%%%%% system was immune to them and identified them. %%%%%%%%%%%%%%%%
%%% Repitition of error messages is due to each node recording the error %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% initialises the member/users objects


aMember=Member;
aMember.setMemberID(1);
aMember.setPublicKey(aNode.getKeyDatabase(1,3));
aMember.setPrivateKey(aNode.getKeyDatabase(1,2));
aMember.setn(aNode.getKeyDatabase(1,1));


aMember2=Member;
aMember2.setMemberID(2);
aMember2.setPublicKey(aNode.getKeyDatabase(2,3));
aMember2.setPrivateKey(aNode.getKeyDatabase(2,2));
aMember2.setn(aNode.getKeyDatabase(2,1));

%% performing handshake between users

aMember2.setSenderKeyAtReciever(aMember.sendKey());

aMember.recieveTransactionPacket(aMember2.transactionPacketToSender());

%set member wallets from ledger.txt
ledgerFile = csvread('Ledger.txt');
aMember.setWallet(ledgerFile(1,:));
aMember2.setWallet(ledgerFile(2,:));

for i=1:2
   
    aMember.encryptSession();
    aMember.setSession();
    
end


%% initialise an array of node objects
for i=1:4
   
    nodeArray(i)=Node;  %#ok<SAGROW>
    nodeArray(i).readLedger;
    nodeArray(i).readDataBase()
     nodeArray(i).setNumberTransactions();
end

%% Iterate for four blocks being added to the block-chain/ledger


for blocks=1:4
    ledgerFile = nodeArray(1).getLedger();
aMember.setWallet(ledgerFile(1,:));
aMember2.setWallet(ledgerFile(2,:));
    if blocks==1
       
        message=['Ledger at block ', num2str(blocks), ' before transactions processed'];
        disp(message);
        disp(nodeArray(1).getLedger)
        
    end

numberTransactions=[];

for i=1:4  
   
    
    
    if blocks==1
recHash = aMember2.hashLedger();   
[transaction, sendHash]=aMember.requestTransaction(2,7);
nodeArray(i).validateParticipants(transaction, recHash, sendHash);
[transaction, sendHash]=aMember.requestTransaction(2,9); %will simulate an identity attack with an invalid sesion key, see node
nodeArray(i).validateParticipants(transaction, recHash, sendHash);
[transaction, sendHash]=aMember.requestTransaction(2,7); %double spending
nodeArray(i).validateParticipants(transaction, recHash, sendHash);

[transaction, sendHash]=aMember.requestTransaction(2,4545);
nodeArray(i).validateParticipants(transaction, recHash, sendHash);
    
 nodeArray(i).addToTransactionQueue([6 2 1 3455]); %adds transaction straight to transaction queue without handshake
    end
    
    
    
    if blocks==2
        recHash = aMember2.hashLedger(); 
          nodeArray(i).setNumberTransactions();
  
[transaction, sendHash]=aMember.requestTransaction(2,4545506);
nodeArray(i).validateParticipants(transaction, recHash, sendHash);

 nodeArray(i).addToTransactionQueue([8 2 1 41534]);
    end
    
    
    
    
    if blocks==3
        recHash = aMember2.hashLedger(); 
          nodeArray(i).setNumberTransactions();
[transaction, sendHash]=aMember.requestTransaction(2,7);
nodeArray(i).validateParticipants(transaction, recHash, sendHash);
[transaction, sendHash]=aMember.requestTransaction(2,6568568); %coin doesnt exist
nodeArray(i).validateParticipants(transaction, recHash, sendHash);
[transaction, sendHash]=aMember.requestTransaction(2,3455); %will simulate an identity attack with an invalid reciever hash, see node
nodeArray(i).validateParticipants(transaction, recHash, sendHash);
 nodeArray(i).addToTransactionQueue([13 2 1 453]);
    end
    
    
    
    if blocks==4
        recHash = aMember2.hashLedger(); 
      nodeArray(i).setNumberTransactions();

[transaction, sendHash]=aMember.requestTransaction(2,453);%will simulate an identity attack with an invalid sender hash, see node
nodeArray(i).validateParticipants(transaction, recHash, sendHash);
nodeArray(i).addToTransactionQueue([13 2 1 2]);
nodeArray(i).addToTransactionQueue([13 2 1 22222]);  %does not exist
[transaction, sendHash]=aMember.requestTransaction(2,453);
nodeArray(i).validateParticipants(transaction, recHash, sendHash);
    end
    
nodeArray(i).getLedger();
   


 
 
 
if i==blocks
    
    
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%% simulating a byzentine node %%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  
  nodeArray(i).addToTransactionQueue([3453507 2 1 7]);
end
 
    nodeArray(i).sortTransaction();





nodeArray(i).getTransactionQueue; % to visualise the transaction queue

nodeArray(i).validateTransaction(); % validates & processes queue 

nodeArray(i).getLedger;  % to visualise ledger


numberTransactions(i)=nodeArray(i).getNumberTransactions()-1;%#ok<*NASGU>
end

transactions=mode(numberTransactions);

goodNode=0;

for j=1:4
if transactions==nodeArray(j).getNumberTransactions()-1
    
BzCheckArray=[]; %#ok<*NASGU>
BzCheckArray=nodeArray(j).getTransactionQueue; % don't assume transaction queue is immune to faults
BzCheckArray(:,5)=0;
for i=1:size (nodeArray,2) 
   if transactions==nodeArray(i).getNumberTransactions()-1
    buffTransaction=nodeArray(i).getTransactionQueue;
    BzCheckArray(:,5)=BzCheckArray(:,5)+buffTransaction(:,5); % if any of this == 0.5 nodes... just quit
   end
    
end

nodeArray(j).BFT(BzCheckArray) %performs bazentine fault check on nodes

if nodeArray(j).getCompromisedStatus==0
   goodNode=j; 
end


else 
    
    nodeArray(j).setCompromised(1);
    
end



end


if goodNode==0 %if entire  system is compromised
   
    fileID = fopen('errorLog.txt','a');    
               
               
                     fmt = 'All nodes/half of the nodes are compromised, %2d nodes\n';
                 fprintf(fileID,fmt,4);
%                  obj.saveError();
               fclose(fileID);  


else

    % attempts to fix bayzentine nodes

for i=1:4
    

   
    if nodeArray(i).getCompromisedStatus==1
        fileID = fopen('errorLog.txt','a');
         fmt = 'Byzantine error occured from node %2d\n';  
                 fprintf(fileID,fmt,i);
%                  obj.saveError();
               fclose(fileID);  
    
       nodeArray(i).setLedger(nodeArray(goodNode).getLedger);
       nodeArray(i).setKeyDatabase(nodeArray(goodNode).getWholeKeyDatabase());
        

       nodeArray(i).setCompromised(0);

        nodeArray(i).clearTransactionQueue();
    end
    
    
    nodeArray(i).clearTransactionQueue();
    
end

end



% end

message=['Ledger at block ', num2str(blocks), ' after transactions processed'];
        disp(message);
disp(nodeArray(1).getLedger());


disp('-------------------------------------------------------------------------')
fileID = fopen('errorLog.txt','a');
       
         fmt = '---------------------------Block %2d---------------------------\n'; 
                 fprintf(fileID,fmt,blocks);
%                  obj.saveError();
               fclose(fileID);  
end





% nodeArray(1).saveLedger(); % will save ledger to txt file, not
% implimented as it would change the simulation in the next run



