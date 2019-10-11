function [BER,S,NS] = computeBER(m,MessageLength,ModulationOrder,EbNo,NumBits)

     %This function computes the BER of any combination of BCH FEC and QAM
     ...modulation configuration given EbNo. The functions returns the BER.
     
 
    % Get the variables in a more familiar format
    
        k = MessageLength;
        M = ModulationOrder;
        BER = zeros(1, length(EbNo));

    % Get the BCH encoder and decoder

        [encoder,decoder,codeRate] = bchFEC(m,k);

    % Error Collecor

        errorRate = comm.ErrorRate;
        
    % Collecting stats 
        tt = 2^m -1;
        S  = zeros(NumBits*tt*length(EbNo),1);
        NS = S;
        count = 0;
    
    
    for i = 1:length(EbNo)

        % Signal to Noise Ratio dB
        
        SNR = EbNo(i) + 10*log10(codeRate)+10*log10(log2(M)); 

        errorStats = zeros(3,1); %Reset the errorStats variable


        while errorStats(3) < NumBits
            
            % For plotting the constellations, don't mind
            
                count = count + 1; 
            
            % Lets generate the message
            
                msgTx = randi([0 1],k*log2(M),1);
            
            % Lets encode the message
            
                encTx = encoder(msgTx);
             
            % Lets now modulate the encoded message 

                modTx = qammod(encTx,M,'UnitAveragePower',true,...
                               'InputType','bit');
                           
                % For plotting the constellations, again don't mind it           
                    
                    S(tt*count:(tt-1) + tt*count,1) = modTx;
                    
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%THE CHANNEL%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                % Add AWG Noise
                    
                    noisyRx = awgn(modTx,SNR); 
                
                    % For plotting the constellations, again don't mind it 

                        NS(tt*count:(tt-1) + tt*count,1) = noisyRx;


            %%%%%%%%%%%%%%%%%%%%%%%%% END OF THE CHANNEL %%%%%%%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         
            
            %                      THE OTHER SIDE...
     
         

            % Lets Demodulate

                demodRx = qamdemod(noisyRx,M,'UnitAveragePower',true,...
                                   'OutputType','bit');
            
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