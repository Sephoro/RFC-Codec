function [] = plots(EbNo, BER, ModS, NoisyS,m,k,M)

    % To help with plotting results
   
    
     % Plot the BER vs EbNo graph
   
     
        semilogy(EbNo, BER,'g')
        title('BCH with M-QAM')
        xlabel('Eb/No')
        ylabel('BER')
     
     % Plot the constellations
     
        figure
        s = scatterplot(NoisyS,1,0,'k.');  % Noisy Signal
        title_ = strcat('Constellation of BCH(', num2str(2^m-1) ...
                         ,',', num2str(k), ') with ', num2str(M), '-QAM');
                     
        title(title_);
        hold on
        
        scatterplot(ModS,1,0,'g*',s)       % Original Signal
        grid on
        legend('Noisy Constellation', 'Original Constellation')
        
        hold off
   
   
end