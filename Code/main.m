clc
clear
close all


EbNo = 0:30;            % Signal to Noise Ratio
NumBits = 12000;        % Number of bits to proces


% BCH(7,4) -- 16 QAM
    
    m = 3;                  % Galois field power
    K = 4;                  % Message length
    M = 16;                 % 16 QAM Modulator
   
   [BER,ModS,NoisyS] = computeBER(m,K,M,EbNo,NumBits);

   % Plot the constellation
   
   s = scatterplot(NoisyS,1,0,'r.');
   hold on
   scatterplot(ModS,1,0,'g*',s)
   grid on
   
   % Plot the BER vs EbNo graph
   
   figure
   hold off
   semilogy(EbNo, BER,'g')
