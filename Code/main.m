clc
clear
close all


EbNo = 0:30;            % Signal to Noise Ratio
NumBits = 240;        % Number of bits to proces


% BCH(7,4) -- 16 QAM
    
    m = 3;                  % Galois field power
    K = 4;                  % Message length
    M = 16;                 % 16 QAM Modulator
   
    [BER,ModS,NoisyS] = computeBER(m,K,M,EbNo,NumBits);
    %plots(EbNo,BER,ModS,NoisyS,m,K,M);
    
% BCH(7,4) -- 64 QAM
    
    m1 = 3;                  % Galois field power
    K1 = 4;                  % Message length
    M1 = 64;                 % 64 QAM Modulator
   
   [BER1,ModS1,NoisyS1] = computeBER(m1,K1,M1,EbNo,NumBits);
 
 % BCH(7,4) -- 64 QAM
    
    m_ = 3;                  % Galois field power
    K_ = 4;                  % Message length
    M_ = 256;                 % 64 QAM Modulator
   
  [BER_,ModS_,NoisyS_] = computeBER(m_,K_,M_,EbNo,NumBits);
   
  BER2 = [BER;BER1;BER_];
  ModS2 = [ModS ModS1 ModS_];
  NoisyS2 = [NoisyS NoisyS1 NoisyS_];
  m2 = [m m1 m_];
  K2 = [K K1 K_];
  M2 = [M M1 M_];
  
  plots(EbNo,BER2,ModS2,NoisyS2,m2,K2,M2);
  
    