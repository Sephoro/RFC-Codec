function [BER] = awgnBER(MsgTx,modTx,SNR,decoder, errorStats,M)
    
        
        % This function computes the BER for a channel with AWGN noise only
        % this used to compare with a channel having Raleigh Fading and
        % MIMO

        
        % Introduce noise to the signal
        
        noisyRx = awgn(modTx,SNR);
                 
        % Demodulate the noisy signal
        
        demodRx = qamdemod(noisyRx,M,'UnitAveragePower',true,...
                    'OutputType','bit');
                
        % Decode the the demodulated signal
        
        MsgRx = decoder(demodRx);
        
        % Get the error stats 
        
        BER = errorStats(MsgRx,MsgTx);
        
        %! FIN

end