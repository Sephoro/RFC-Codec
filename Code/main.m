clc
clear
close all


EbNo = 0:2:25;              % Signal to Noise Ratio
NumBits = 56*56*10;         % Number of bits to proces
C = 4;                      % Number of comparisons



BER = zeros(C, length(EbNo));
m = zeros(1,C);
K = m;
M = m;
Q = 64;

%% BCH(7,4) -- 16 QAM
    
    m(1) = 7;                  % Galois field power
    K(1) = 85;                  % Message length
    M(1) = Q;                 % 16 QAM Modulator
    Nr(1) = 2;                     % Number of Transmit antennas
    Nt(1) = 2;                     % Number of Receive antennas


   [BER(1,:),BER2,ModS,NoisyS,~,RX] = computeBER(m(1),K(1),M(1),Nt(1),Nr(1),EbNo,NumBits);
%%   
    m(2) = 7;                  % Galois field power
    K(2) = 85;                  % Message length
    M(2) = Q;                 % 16 QAM Modulator
    Nr(2) = 4;                     % Number of Transmit antennas
    Nt(2) = 2;                     % Number of Receive antennas

   
   [BER(2,:),BER3,~,NoisyS2,~,RX2] = computeBER(m(2),K(2),M(2),Nt(2),Nr(2),EbNo,NumBits);
    
  
%% BCH(127,106) -- 64 QAM
    
    m(3) = 7;                   % Galois field power
    K(3) = 85;                  % Message length
    M(3) = Q;                   % 16 QAM Modulator
    Nr(3) = 4;                     % Number of Transmit antennas
    Nt(3) = 4;                     % Number of Receive antennas

   
   [BER(3,:),~,~,NoisyS3,~,RX3] = computeBER(m(3),K(3),M(3),Nt(2),Nr(2),EbNo,NumBits);
   
  %% BCH(127,106) -- 64 QAM
    
    m(4) = 7;                   % Galois field power
    K(4) = 85;                  % Message length
    M(4) = Q;                   % 16 QAM Modulator
    Nr(4) = 8;                     % Number of Transmit antennas
    Nt(4) = 2;                     % Number of Receive antennas

   
   [BER(4,:),~,~,NoisyS4,~,RX4] = computeBER(m(4),K(4),M(4),Nt(4),Nr(4),EbNo,NumBits);
    
    
 BERCurve(EbNo,[BER;BER2],[m 0],[K 0],[M 0]); 
 %Constellation(ModS,HH,m,K,M);
% Constellation(ModS,NoisyS,m,K,M);
 Constellation(ModS,RX,m(1),K(1),M(1));
 Constellation(ModS,RX2,m(1),K(1),M(1));
 Constellation(ModS,RX3,m(1),K(1),M(1));
 
 
    
