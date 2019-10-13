clc
clear
close all


EbNo = 0:2:25;              % Signal to Noise Ratio
NumBits = 56*56;         % Number of bits to proces
C = 1;                      % Number of comparisons
Nr = 2;                     % Number of Transmit antennas
Nt = 2;                     % Number of Receive antennas



BER = zeros(C, length(EbNo));
m = zeros(C);
K = m;
M = m;
Q = 16;

%% BCH(7,4) -- 16 QAM
    
    m(1) = 3;                  % Galois field power
    K(1) = 4;                  % Message length
    M(1) = Q;                 % 16 QAM Modulator
   
    [BER(1,:),ModS,NoisyS] = computeBER(m(1),K(1),M(1),Nt,Nr,EbNo,NumBits);
    
% %% BCH(127,113) -- 64 QAM
%     
%     m(2) = 7;                  % Galois field power
%     K(2) = 85;                  % Message length
%     M(2) = Q;                 % 16 QAM Modulator
%    
%     [BER(2,:),ModS2,NoisyS2] = computeBER(m(2),K(2),M(2),EbNo,NumBits);
%     
%  
% %% BCH(127,106) -- 64 QAM
%     
%     m(3) = 7;                   % Galois field power
%     K(3) = 50;                  % Message length
%     M(3) = Q;                   % 16 QAM Modulator
%    
%     [BER(3,:),ModS3,NoisyS3] = computeBER(m(3),K(3),M(3),EbNo,NumBits);
    
    
 BERCurve(EbNo,BER,m,K,M);
 Constellation(ModS,NoisyS,m,K,M);
 
 
    
