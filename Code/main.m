clc
clear

% Foward Error Correction
% BCH Encoder and Decoder

M = 3;
N = 2^M-1;                % Codeword length
K = 4;                    % Message length
codeRate = K/N;           % Code rate of the FEC code
t = bchnumerr(N,K);       % Get the error correcting capability
G = bchgenpoly(N,K);      % Get the generator Polynomial

encoder = comm.BCHEncoder(N,K,G);	% BCH encoder
decoder = comm.BCHDecoder(N,K,G);   % BCH decoder

% Lets create the message

nwords = 1;
msgTx = [1;0;0;0];


% Lets Encode

encTx = encoder(msgTx)';
disp(encTx)
disp(newline)

% Introduce noise

noisycode = mod(encTx + randerr(nwords,N,1:t),2)';
disp(noisycode')
disp(newline)


% Decode

msgRx = decoder(noisycode);
disp(msgRx')
disp(newline)

isequal(msgTx,msgRx)