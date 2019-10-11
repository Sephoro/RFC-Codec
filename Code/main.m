clc
clear
close all


EbNo = 0:30;              % Signal to Noise Ratio
NumBits = 240;            % Number of bits to proces
C = 2;                    % Number of comparisons


BER = zeros(C, length(EbNo));
m = zeros(C);
K = m;
M = m;


%% BCH(7,4) -- 16 QAM
    
    m(1) = 3;                  % Galois field power
    K(1) = 4;                  % Message length
    M(1) = 16;                 % 16 QAM Modulator
   
    [BER(1,:),ModS1,NoisyS1] = computeBER(m(1),K(1),M(1),EbNo,NumBits);
    
%% BCH(127,85) -- 64 QAM
    
    m(2) = 7;                  % Galois field power
    K(2) = 85;                  % Message length
    M(2) = 64;                 % 16 QAM Modulator
   
    [BER(2,:),ModS,NoisyS] = computeBER(m(2),K(2),M(2),EbNo,NumBits);
    
    
    
 BERCurve(EbNo,BER,m,K,M);
 Constellation(ModS,NoisyS,m,K,M);
 
 
    
