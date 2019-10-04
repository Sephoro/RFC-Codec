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

EbNo = 5;  

% Lets create the message

msgTx = randi([0 1],K*log2(M),1); % Make the message a factor the FEC and Modulation order
% print(msgTx)  

% Lets Encode

encTx = encoder(msgTx);
print(encTx')
% Lets Modulate 

modTx = qammod(encTx,M,'UnitAveragePower',true,...
                            'InputType','bit');


s = scatterplot(modTx,1,0,'r*');
hold on


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%  THE CHANNEL  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

SNR = EbNo + 10*log10(codeRate)+10*log10(log2(M));

noisyRx = awgn(modTx,SNR);

%%%%%%%%%%%%%%%%%%%%%%%%% END OF THE CHANNEL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% THE OTHER SIDE...
hold on
scatterplot(noisyRx,1,0,'go',s)
grid on

% Lets Demodulate

demodRx = qamdemod(noisyRx,M,'UnitAveragePower',true,...
                               'OutputType','bit');
print(demodRx')
             
% Lets Decode

msgRx = decoder(demodRx);
print(msgRx')

%isequal(msgTx,msgRx)
