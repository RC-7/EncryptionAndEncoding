classdef Member <handle
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%% Class to simulate members/users on the system %%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    properties (Access = private)
      
       publicKey; 
       privateKey;
       n;
       sessionKey;
       senderKey;
       encryptedSessionKey;
       encryptedSessionKeySender;
       recieversEncryptedKey;

       currentHash;
       MemberID;
       wallet; 
    end
    
    methods
        
        function setMemberID(obj, id)
           
            obj.MemberID=id;
            
        end
        
        function key = sendKey(obj)
           
            key=[obj.publicKey, obj.n];
            
        end
        
        function setSenderKeyAtReciever(obj,key)
            
           obj.senderKey=key;
          
        end
        
        function setPrivateKey(obj,key)
            obj.privateKey=key;
        end
         

        
        function setPublicKey(obj,key)
            obj.publicKey=key;
        end
        
        function setn(obj,nIn)
            obj.n=nIn;
        end
        
        function setWallet(obj, w)
            obj.wallet = w;
        end
        
        %for reciever
         function setSession(obj)
            obj.sessionKey=obj.encryptedSessionKey;
         end
        
          %run twice to recieve and encrypt using private & once for
          %reciever 
        function encryptSession (obj)
            
            obj.encryptedSessionKey=encryptorDecrypt(obj.sessionKey, ...
                obj.privateKey,obj.n);
          
            obj.encryptedSessionKey;
        end
        
        
        %reciever for sender to decrypt--------------------------
        function encryptSessionForSender(obj)
            
               obj.encryptedSessionKeySender=encryptorDecrypt(obj.sessionKey, ...
                obj.senderKey(1),obj.senderKey(2));
            
        end
        
        %sender and encrypt using private
         function recieveSessionKey (obj,S) %,publicKey,n)
            
            obj.sessionKey=encryptorDecrypt(S,obj.publicKey,obj.n);
%              obj.sessionKey=S;
         end
         
         %for reciever
         function generateSessionKey (obj)
            
             obj.sessionKey=77;
             obj.sessionKey;
             
         end
         
         function [toSender]=transactionPacketToSender(obj)
             obj.generateSessionKey();
             obj.encryptSessionForSender;
             obj.encryptSession();
         
             toSender=[obj.encryptedSessionKeySender, obj.encryptedSessionKey];
             
         end
         
         function recHash = hashLedger(obj)
            obj.createHash();
            recHash = obj.currentHash;
         end
         
         function recieveTransactionPacket(obj, transactionPacket)
            
             obj.recieversEncryptedKey=transactionPacket(2);
             obj.sessionKey=transactionPacket(1);
         end
         
         
         
         %sender only, send to nodes
         function [transaction, sendHash]=requestTransaction(obj,to,coin)
             obj.createHash();
             transaction =[obj.encryptedSessionKey, obj.recieversEncryptedKey,  ...
                 obj.MemberID, to, coin];             
             sendHash = obj.currentHash;
         end
         
         function createHash(obj) 
            obj.currentHash = num2str(obj.MemberID);
             for i=1:length(obj.wallet)
                obj.currentHash = strcat(obj.currentHash, num2str(obj.wallet(i)));
             end
%              check1 = obj.currentHash
             obj.currentHash = SHA(obj.currentHash);
             obj.currentHash;
         end
      
        
    end
    
end

