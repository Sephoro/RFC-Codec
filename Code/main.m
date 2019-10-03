clc
clear
% Foward Error Correction
% BCH Encoder and Decoder

M = 3;
n = 2^M-1;   % Codeword length
k = 4;       % Message length
nwords = 1;  % Number of words to encode


% Lets create the message

% msgTx = gf(randi([0 1],nwords,k));
msgTx = gf([1 0 1 1]);
disp(msgTx);

% Error correcting capability

t = bchnumerr(n,k);

disp(strcat('Error correcting capability ---> ', num2str(t)))

% Encode

enc = bchenc(msgTx,n,k,'beginning');
disp(enc)

% Introduce noise

noisycode = enc + randerr(nwords,n,1:t);
disp(noisycode)

% Decode

msgRx = bchdec(noisycode,n,k,'beginning');
disp(msgRx)

isequal(msgTx,msgRx)