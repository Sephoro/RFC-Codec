clc
clear

% Foward Error Correction
% BCH Encoder and Decoder

m = 3;
K = 4;                    % Message length

[encoder,decoder,codeRate] = bchFEC(m,K);


% Modulation
% 16 QAM Modulator

M = 16;                     % Size of signal constellation
b = log2(M);                % Number of bits per symbol

% Lets create the message

msgTx = randi([0 1],K*log2(M),1); % Make the message a factor the FEC and Modulation order
print(msgTx')  

% Lets Encode

encTx = encoder(msgTx);
print(encTx')

% Lets Modulate 

modTx = qammod(encTx,M,'UnitAveragePower',true,...
                            'InputType','bit');
print(modTx)

scatterplot(modTx,1,0,'r*')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% THE REVERSE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Lets Demodulate

demodRx = qamdemod(modTx,M,'UnitAveragePower',true,...
                               'OutputType','bit');

             
% Lets Decode

msgRx = decoder(demodRx);
print(msgRx')

isequal(msgTx,msgRx)
