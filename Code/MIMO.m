function [demodRx,RX] = MIMO(modTx,Nt,Nr,Ns,SNR,M,H,receiver)


    % This function performs MIMO under RFC
    
     demodRx = []; % To store received symbols
     RX = [];

    for j = 1:Nt:Ns

        % Send Nt Symbols at a time

        Tx = modTx(j:j+1);

        % Apply Raleigh Fading Coeffecients

        YTx = H*Tx;

            %HH = [HH;YTx];      % Constellation collector

        % Add AWG Noise

        noisyRx = awgn(YTx,SNR);

            % NS = [NS;noisyRx];  % Constellation collector

       
         % Choose receiver....
         ... ................
         
            if receiver == "ZF"
                
                % Zero Forcing reciever
                W = inv(H'*H)*H';
                
            elseif receiver == "MMSE"
                
                
                % MMSE reciver
                
                W = inv(H'*H + (1/(10^(0.1*SNR)))*eye(Nr,Nt))*H';
            end

       

        % Reverse the effect of Raleigh Fading

        RxHat = W*noisyRx;

            RX = [RX; RxHat];  % Constellation collector

        % Lets Demodulate

        Rx = qamdemod(RxHat,M,'UnitAveragePower',true,...
            'OutputType','bit');

        % Store the demodulated symbols for decoding later

        demodRx = [demodRx;Rx];


        % Count the number of symbols sent

        % symCount = symCount + Nt;

        % Change H for every 1 ms (Calculation above!)

        %   if ~mod(symCount, Symbols) || ~mod(symCount-1, Symbols)
            
        %       H = 1/sqrt(2)*(randn(Nr,Nt)+1i*(randn(Nr,Nt)));

        %   end
    end


end
