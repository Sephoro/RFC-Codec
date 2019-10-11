function [] = BERCurve(EbNo, BER,m,k,M)

     % This function plots the BER vs EbNo graph
     
     C = ['g','r','y','c','k', 'b']; % color schemes
     legend__ = [];                  % For the legends
   
     [size_,~] = size(BER);
     
     for i = 1:size_
        
         semilogy(EbNo, BER(i,:),C(i))
         title('BCH with M-QAM')
         xlabel('Eb/No')
         ylabel('BER')
         legend_ = strcat("BCH(", num2str(2^m(i) - 1 ),",", num2str(k(i)),...
                           ") with ", num2str(M(i)), "-QAM");
         legend__ = [legend__ legend_]; % Pad the legend
         legend(legend__);
         
         hold on
     
     end
       
end