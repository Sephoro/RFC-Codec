clc
clear

% Foward Error Correction
% BCH Encoder and Decoder

m = 3;
N = 2^m-1;                % Codeword length
K = 4;                    % Message length
codeRate = K/N;           % Code rate of the FEC code
t = bchnumerr(N,K);       % Get the error correcting capability
G = bchgenpoly(N,K);      % Get the generator Polynomial

encoder = comm.BCHEncoder(N,K,G);	% BCH encoder
decoder = comm.BCHDecoder(N,K,G);   % BCH decoder

% Modulation
% 16 QAM Modulator

M = 16;                     % Size of signal constellation
b = log2(M);                % Number of bits per symbol

% Lets create the message

msgTx = randi([0 1],K*log2(M),1); % Make the message a factor the FEC and Modulation order
disp(msgTx')  

% Lets Encode

encTx = encoder(msgTx);
disp(encTx')
disp(newline)

% Lets Modulate 

modTx = qammod(encTx,M,'UnitAveragePower',true,...
                            'InputType','bit');
disp(modTx)

scatterplot(modTx,1,0,'r*')

%{ 
% Introduce noise

 noisycode = mod(encTx + randerr(1,N*4,1:4)',2);
 disp(noisycode')
 disp(newline)
 disp(isequal(noisycode,encTx));

%}
 
% Decode
%{
msgRx = decoder(noisycode);
disp(msgRx')
disp(newline)

isequal(msgTx,msgRx)
%}