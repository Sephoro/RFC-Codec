function [] = plots(EbNo, BER, ModS, NoisyS,m,k,M)

    % To help with plotting results
   
    
     % Plot the BER vs EbNo graph
     
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
       
     
     hold off
     % Plot the constellations
     
        figure
        s = scatterplot(NoisyS(1,:),1,0,'k.');  % Noisy Signal
        title_ = strcat('Constellation of BCH(', num2str(2^m(1)-1) ...
                         ,',', num2str(k), ') with ', num2str(M(1)), '-QAM');
                     
        title(title_);
        hold on
        
        scatterplot(ModS(1,:),1,0,'g*',s)       % Original Signal
        grid on
        legend('Noisy Constellation', 'Original Constellation')
        
        hold off
       
        
   
   
end