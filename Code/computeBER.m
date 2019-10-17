function [BER,BERawgn,S,NS,HH,RX] = computeBER(m,MessageLength,ModulationOrder,TxAntennas,RxAntennas,EbNo,NumBits)

     %This function computes the BER of any combination of BCH FEC and QAM
     ...modulation configuration given EbNo. The functions returns the BER.
     
 
    % Get the variables in a more familiar format
    
        k = MessageLength;
        M = ModulationOrder;
        Nt = TxAntennas;
        Nr = RxAntennas;
        Ns = (2^m - 1)*Nt;                  % Number of symbols per frame 
        BER = zeros(1, length(EbNo));       % BER for MIMO with RFC
        BERawgn = zeros(1, length(EbNo));   % BER for AWGN with no RFC and MIMO

    % Get the BCH encoder and decoder

        [encoder,decoder,codeRate] = bchFEC(m,k);
       
    % Error Collecor

        errorRate = comm.ErrorRate;
        awgnErrorStats = comm.ErrorRate;
        
    % Raleigh Fading Channel
    
        H = 1/sqrt(2)*(randn(Nr,Nt)+1i*(randn(Nr,Nt)));     % The main player ;)
    
        Rb = 10e6;                                          % Bit rate = 10 Mb/s
        Rb_prime = Rb/(codeRate*log2(M));                   % Bit rate due to FEC and Modulation
        Symbols = floor(Rb_prime*1e-3);                     % Number of symnols before changing H
        symCount = 0;                                       % Counts the number of symbols to change H

        
    % Collecting stats
    
        S  = []; %  Original Constellation
        NS = []; %  Noisy Constellation
        HH = [];
        RX = [];
        
    for i = 1:length(EbNo)

        % Signal to Noise Ratio dB
        
        SNR = EbNo(i) + 10*log10(codeRate) + 10*log10(log2(M)); 

        errorStats = zeros(3,1); % Reset the errorStats variable
        awgnErrors = zeros(3,1); % Reset the awgnErrors variable


        while errorStats(3) < NumBits
           
            % Lets generate the message, the message is a factor of the FEC
            ..., Modulation Scheme & Number of transmit antennas.
            
                msgTx = randi([0 1],k*log2(M)*Nt,1);
            
            % Lets encode the message
            
                encTx = encoder(msgTx);
             
            % Lets now modulate the encoded message 

                modTx = qammod(encTx,M,'UnitAveragePower',true,...
                               'InputType','bit');
                S = [S; modTx]; % Constellation collector
                  
            % Collect the errors for only AWGN
               
                awgnErrors = awgnBER(msgTx,modTx,SNR,decoder,awgnErrorStats,M);
               
          
            % The MVP: MIMO and Raleigh Fading ahead .....
            
                [demodRx,H,symCount,rRX] = MIMO(modTx,Nt,Nr,Ns,SNR,M,H,symCount,Symbols,"MMSE");
                    RX = [RX;rRX];
            % Now lets Decode the demodulated signal

                msgRx = decoder(demodRx);
                
                
            % Compute the errors due to the channel
          
               errorStats = errorRate(msgTx,msgRx);
            
        end
        
        % Get the BER for this point of Eb/No
            
            BER(i) = errorStats(1);
            BERawgn(i) = awgnErrors(1);
        
        % House Keeping
            
            reset(errorRate)
            reset(awgnErrorStats)

    end



end