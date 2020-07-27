classdef Node <handle
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%% Class to simulate nodes on the system, which validate %%%%%%%%%
    %%%%%%% Transactions and identify attacks and error occuring %%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    properties (Access = private)
        
        CurrentHash;
        validTransaction=0;       %== 1 when participants session key checks out
        transactionQueue=[0 0 0 0]; %first column is date, will sort in decending order
        % [time (s) since last block, from, to, Coin identifier]
        Ledger;                  %Ledger, gets populated in function, should probably make a
        errorLog=[0 0 0 0];                          
        isCompromised =0;
        KeyDatabase
        
        numberOfTransactions;
        time=1;
    end
    
    properties (Access=public)  % Don't think we want anything public, keep
        % as inaccessable as we can?
        
    end
    
    properties(Constant)
        
    end
    methods
        
        function transNo = getNumberTransactions (obj)
            transNo=obj.numberOfTransactions;
            
        end
        function setNumberTransactions (obj)
            obj.numberOfTransactions=1;
            
        end
        
        
        function key=getKeyDatabase (obj, row, column)
            key=obj.KeyDatabase(row,column);
            
        end
        
        function key=getWholeKeyDatabase (obj)
            key=obj.KeyDatabase;
            
        end
        
        function setKeyDatabase (obj,database)
            obj.KeyDatabase=database;
            
        end
        
        
        function readLedger(obj)
            obj.Ledger=csvread('Ledger.txt');
            
        end
        

        
        
        function readDataBase(obj)
            obj.KeyDatabase=csvread('publicKeys.txt');
        end
        
        
        
        function setLedger(obj,input)
            obj.Ledger=input;
        end
        
        
        
        function a=getLedger(obj)
            
            a= obj.Ledger;
        end
        
        
        
        function sortTransaction(obj)
            
            obj.transactionQueue=sortrows(obj.transactionQueue);
            
        end
        
        
        
    
        
        
        % Validates Member handshake

        function validateParticipants(obj,transactionPacket, recHash, sendHash)
            
            Actualtransaction=[];
            obj.time=obj.time+1;
            S1=transactionPacket(1);
            S2=transactionPacket(2);
            pub1=obj.getKeyDatabase(transactionPacket(3),3);
            pub2=obj.getKeyDatabase(transactionPacket(4),3);
            n1=obj.getKeyDatabase(transactionPacket(3),1); 
            n2=obj.getKeyDatabase(transactionPacket(4),1);
            to=transactionPacket(4);
            from=transactionPacket(3);
            Actualtransaction(1)=obj.time;
            Actualtransaction(2:4)=transactionPacket(3:5);
            timestep=obj.time;
            
%%%%%%%%%%%%%% simuates different possible identity attacks %%%%%%%%%%%%%%%
            if obj.time==2 
                S1=1;
            end
            
            if obj.time==9
            recHash='a'; 
            end
            if obj.time==10
            sendHash='a';
            end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            toWallet = obj.Ledger(to, :);
            fromWallet = obj.Ledger(from, :);
            toHash = strcat('', num2str(to));
            fromHash = strcat('', num2str(from));
%             fromWallet
            for i=1:length(toWallet)
                toHash = strcat(toHash, num2str(toWallet(i)));
            end
            
            for j=1:length(fromWallet)
                fromHash = strcat(fromHash, num2str(fromWallet(j)));
            end

%             cehck2 = fromHash
            toHash = SHA(toHash);
%             z = recHash
            fromHash = SHA(fromHash);
            
            session1=encryptorDecrypt(S1,pub1,n1);
            session2=encryptorDecrypt(S2,pub2,n2);

            if session1==session2 & recHash == toHash & sendHash == fromHash  %% add hash check here
                obj.validTransaction=1;
                
                addToTransactionQueue(obj, Actualtransaction)% only add to queue when
                %                 it is a valid handshake
                
            else
                
                if session1~=session2

                fileID = fopen('errorLog.txt','a');   % maybe deactivate an account after a few double spending occurances
                
                
                fmt = 'Member authentication error at timestep %2d From account %2d To account %2d, invalid session key pair\n';
                fprintf(fileID,fmt,[timestep, ...
                    from, ...
                    to]);
                %                  obj.saveError();
                fclose(fileID);
                end
                if recHash ~= toHash
                    fileID = fopen('errorLog.txt','a');   % maybe deactivate an account after a few double spending occurances
                
                
                fmt = 'Member authentication error at timestep %2d From account %2d To account %2d, invalid reciever hash\n';
                fprintf(fileID,fmt,[timestep, ...
                    from, ...
                    to]);
                %                  obj.saveError();
                fclose(fileID);
                    
                end
                if sendHash ~= fromHash
                    fileID = fopen('errorLog.txt','a');   % maybe deactivate an account after a few double spending occurances
                
                
                fmt = 'Member authentication error at timestep %2d From account %2d To account %2d, invalid sender hash\n';
                fprintf(fileID,fmt,[timestep, ...
                    from, ...
                    to]);
           
                fclose(fileID);
                    
                end
            end
            
        end
        
        
        
        function isValid=getValidation (obj)
            
            isValid=obj.validTransaction;
            
        end
        
        
        function addToTransactionQueue(obj, newTransaction) % add as comes into queue
            
              
            if obj.getNumberTransactions==1
                obj.transactionQueue=newTransaction;
                obj.numberOfTransactions=obj.numberOfTransactions+1;
            else
                obj.transactionQueue=vertcat(obj.transactionQueue, ...
                    newTransaction);
                obj.numberOfTransactions=obj.numberOfTransactions+1;
            end
        end
        
        
        
        
        function clearTransactionQueue(obj)
            obj.transactionQueue=[];
            obj.transactionQueue=[0 0 0 0];
        end
        
        
        
        
        %Validates if coin exists on the person's ledger and performs
        %exchange
        
        function validateTransaction(obj)
            
            
            
            for i=1:size(obj.transactionQueue,1)
                
                
                [row,column]=find(obj.Ledger == obj.transactionQueue(i,4));
                
                
                if row ==obj.transactionQueue(i,2)
                    obj.transactionQueue(i,5)=1;
                    [~, columnLedger]=size(obj.Ledger);
                    
                    if obj.Ledger(obj.transactionQueue(i,3),columnLedger)==0
                        
                        
                        while obj.Ledger(obj.transactionQueue(i,3),columnLedger)==0
                            columnLedger=columnLedger-1;
                            
                        end
                        obj.Ledger(obj.transactionQueue(i,3),columnLedger+1) ...
                            =obj.transactionQueue(i,4);
                        obj.Ledger(row,column)=0;
                        
                    else
                        
                        obj.Ledger(obj.transactionQueue(i,3), ...
                            size(obj.Ledger,2)+1)=obj.transactionQueue(i,4);
                        
                        obj.Ledger(row,column)=0;
                    end
                    
                else
                    obj.transactionQueue(i,5)=0;
                    fileID = fopen('errorLog.txt','a');   % maybe deactivate an account after a few double spending occurances
                    if isempty(row)
                        fmt = 'Token does not exist error at timestep %2d From account %2d To account %2d Of proposed token identifier %5d\n';
                        fprintf(fileID,fmt,[obj.transactionQueue(i,1), ...
                            obj.transactionQueue(i,2), ...
                            obj.transactionQueue(i,3), ...
                            obj.transactionQueue(i,4)]);
                        %                  obj.saveError();
                        fclose(fileID);
                    else
                        fmt = 'Double spending error at timestep %2d From account %2d To account %2d Of proposed token identifier %5d\n';
                        fprintf(fileID,fmt,[obj.transactionQueue(i,1), ...
                            obj.transactionQueue(i,2), ...
                            obj.transactionQueue(i,3), ...
                            obj.transactionQueue(i,4)]);
                        %                  obj.saveError();
                        fclose(fileID);
                    end
                    
                    
                end
                
                
            end
            obj.reorderledger();
        end
        
        
        function reorderledger(obj)
            
            [row, column]=size(obj.Ledger);
            
            for i=1:row
                
                for j=column:-1:2
                    
                    if obj.Ledger(i,j-1)==0
                        obj.Ledger(i,j-1)=obj.Ledger(i,j);
                        obj.Ledger(i,j)=0;
                        
                    end
                    
                    
                    
                end
                
                
            end
            
            
            
        end
        
        
        function saveLedger(obj)
            
            csvwrite('Ledger.txt',obj.Ledger)
            
        end
        
    
        function saveError(obj)
            csvwrite('errorLog.txt',obj.errorLog)
        end
        
        function queue=getTransactionQueue (obj)
            queue=obj.transactionQueue;
        end
        
        
        
        function BFT(obj,Transactions)
            
            
            for i=1:size(Transactions,1)
                
                if Transactions(i,5)<3
                    
                    if obj.transactionQueue(i,5)==1  
                        
                        obj.setCompromised(1);
                        
                        break
                    end
                    
                end
                
                if Transactions(i,5)>=3
                    
                    if obj.transactionQueue(i,5)==0
                        
                        obj.setCompromised(1);
                        
                        
                        break
                    end
                    
                end
                
            end
            
            
        end
        
        
        function isCompromised=getCompromisedStatus (obj)
            isCompromised=obj.isCompromised;
            
        end
        
        function setCompromised (obj, status)
            
            obj.isCompromised=status;
            
        end
        
    end
end