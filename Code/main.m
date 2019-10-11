clc
clear
close all


EbNo = 8:0.5:25;              % Signal to Noise Ratio
NumBits = 64*64;            % Number of bits to proces
C = 4;                    % Number of comparisons


BER = zeros(C, length(EbNo));
m = zeros(C);
K = m;
M = m;
Q = 64;

%% BCH(7,4) -- 16 QAM
    
    m(1) = 3;                  % Galois field power
    K(1) = 4;                  % Message length
    M(1) = Q;                 % 16 QAM Modulator
   
    [BER(1,:),ModS1,NoisyS1] = computeBER(m(1),K(1),M(1),EbNo,NumBits);
    
%% BCH(127,85) -- 64 QAM
    
    m(2) = 7;                  % Galois field power
    K(2) = 85;                  % Message length
    M(2) = Q;                 % 16 QAM Modulator
   
    [BER(2,:),ModS2,NoisyS2] = computeBER(m(2),K(2),M(2),EbNo,NumBits);
    
 
%% BCH(127,85) -- 64 QAM
    
    m(3) = 6;                  % Galois field power
    K(3) = 45;                  % Message length
    M(3) = Q;                 % 16 QAM Modulator
   
    [BER(3,:),ModS3,NoisyS3] = computeBER(m(3),K(3),M(3),EbNo,NumBits);
    
 %% BCH(127,85) -- 64 QAM
    
    m(4) = 6;                  % Galois field power
    K(4) = 30;                  % Message length
    M(4) = Q;                 % 16 QAM Modulator
   
    [BER(4,:),ModS,NoisyS] = computeBER(m(4),K(4),M(4),EbNo,NumBits);
    
    
    
    
 BERCurve(EbNo,BER,m,K,M);
 Constellation(ModS,NoisyS,m,K,M);
 
 
    
