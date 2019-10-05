clc
clear
close all

% Foward Error Correction
% BCH Encoder and Decoder

m = 3;
K = 4;                    % Message length

[encoder,decoder,codeRate] = bchFEC(m,K);


% Modulation
% 16 QAM Modulator

M = 16;                     % Size of signal constellation
b = log2(M);                % Number of bits per symbol

% The noise?

EbNo = 0:30;

% Error Collecor

errorRate = comm.ErrorRate;

% Lets create the message

% msgTx = randi([0 1],K*log2(M),1); % Make the message a factor the FEC and Modulation order
% print(msgTx)  

% Lets Encode

%encTx = encoder(msgTx);
%print(encTx')
% Lets Modulate 

% modTx = qammod(encTx,M,'UnitAveragePower',true,...
%                             'InputType','bit');


%s = scatterplot(modTx,1,0,'r*');
%%hold on
[~, q] = size(EbNo);
BER = zeros(1,q);

noBits = 12000;

a = zeros(noBits*7*q,1);
b = a;

yes = true;

for i = 1:q
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%  THE CHANNEL  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    SNR = EbNo(i) + 10*log10(codeRate)+10*log10(log2(M)); % Signal to Noise Ratio dB
    
    errorStats = zeros(3,1); % Error Collector
    
    count = 0;
    
    while errorStats(3) < noBits
        count = count + 1;
        msgTx = randi([0 1],K*log2(M),1);
        
        encTx = encoder(msgTx);
        
        modTx = qammod(encTx,M,'UnitAveragePower',true,...
            'InputType','bit');
        a(7*count:6 + 7*count,1) = modTx;
        
        noisyRx = awgn(modTx,SNR); % Add AWG Noise
        
         b(7*count:6 + 7*count,1) = noisyRx;
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%% END OF THE CHANNEL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % %         s = scatterplot(modTx,1,0,'b');
        % %         THE OTHER SIDE...
        % %         hold on
        % %         scatterplot(noisyRx,1,0,'r',s)
        % %         grid on
        
        % Lets Demodulate
        
        demodRx = qamdemod(noisyRx,M,'UnitAveragePower',true,...
            'OutputType','bit');
        %print(demodRx')
        
        % Lets Decode
        
        msgRx = decoder(demodRx);
        %print(msgRx')
        errorStats = errorRate(msgTx,msgRx);
        %errorStats = errorRate(msgTx,msgRx)
    end
   
    BER(i) = errorStats(1);
    reset(errorRate)
    
end

s = scatterplot(b,1,0,'r.');
        % THE OTHER SIDE...
hold on
scatterplot(a,1,0,'g*',s)
grid on
figure
hold off
semilogy(EbNo, BER,'go-')
