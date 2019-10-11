function [] = Constellation(ModS, NoisyS,m,k,M)

     % Plot the constellations of the different schemes
     
              
         s = scatterplot(NoisyS,1,0,'k.');  % Noisy Signal
         title_ = strcat("Constellation of BCH(", num2str(2^m-1) ...
             ,",", num2str(k), ") with ", num2str(M), "-QAM");
         
         title(title_);
         hold on
         
         scatterplot(ModS,1,0,'g*',s)       % Original Signal
         grid on
         legend('Noisy Constellation', 'Original Constellation')
         
         hold off
               
end