function [BER,S,NS] = computeBER(m,MessageLength,ModulationOrder,TxAntennas,RxAntennas,EbNo,NumBits)

     %This function computes the BER of any combination of BCH FEC and QAM
     ...modulation configuration given EbNo. The functions returns the BER.
     
 
    % Get the variables in a more familiar format
    
        k = MessageLength;
        M = ModulationOrder;
        Nt = TxAntennas;
        Nr = RxAntennas;
        Ns = (2^m - 1)*Nt;  % Number of symbols per frame
        BER = zeros(1, length(EbNo));

    % Get the BCH encoder and decoder

        [encoder,decoder,codeRate] = bchFEC(m,k);

    % Error Collecor

        errorRate = comm.ErrorRate;
        
    % Collecting stats
    
        S  = [];
        NS = [];
        
     H = 1/sqrt(2)*(randn(Nr,Nt)+1i*(randn(Nr,Nt)))
        
    for i = 1:length(EbNo)

        % Signal to Noise Ratio dB
        
        SNR = EbNo(i) + 10*log10(codeRate) + 10*log10(log2(M)); 

        errorStats = zeros(3,1); %Reset the errorStats variable


        while errorStats(3) < NumBits
           
            % Lets generate the message, the message is a factor of the FEC
            ..., Modulation Scheme & Number of transmit antennas.
            
                msgTx = randi([0 1],k*log2(M)*Nt,1);
            
            % Lets encode the message
            
                encTx = encoder(msgTx);
             
            % Lets now modulate the encoded message 

                modTx = qammod(encTx,M,'UnitAveragePower',true,...
                               'InputType','bit');
                           
                % For plotting the constellations, again don't mind it           
                    
                    S = [ S; modTx];
                    
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%THE CHANNEL%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            demodRx = [];
            
            for j = 1:Nt:Ns
               
                % Send Nt Symbols at a time
              
                Tx = modTx(j:j+1)
                
                % Apply Raleigh Fading Coeffecients
                
                YTx = H*Tx
                
                % Add AWG Noise
                noisyRx = awgn(YTx,SNR)
                
                % For plotting the constellations, again don't mind it
                
                NS = [NS;noisyRx];
                
                
                %%%%%%%%%%%%%%%%%%%%%%%%% END OF THE CHANNEL %%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                
                %                      THE OTHER SIDE...
                
                
                
                % Lets Demodulate
                
                Rx = qamdemod(noisyRx,M,'UnitAveragePower',true,...
                    'OutputType','bit')
                
                demodRx = [demodRx;Rx];
            end
            
            % Now lets Decode the demodulated signal

                msgRx = decoder(demodRx);
                
                
            % Compute the errors due to the channel
          
               errorStats = errorRate(msgTx,msgRx);
            
        end
        
        % Get the BER for this point of Eb/No
            
            BER(i) = errorStats(1);
        
        % House Keeping
            
            reset(errorRate)

    end



end