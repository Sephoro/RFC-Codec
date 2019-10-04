function [encoder,decoder,r] = bchFEC(m,K)

    % Make the BCH encoder and decoder based on m and the message length K
     ... Also return the code rate "r"
    
   
    % Codeword length
    
        N = 2^m-1;               
  
    % Code rate of the FEC code
    
        r = K/N;
        
    % Get the generator Polynomial
        
        G = bchgenpoly(N,K); 
        
    % Now make the BCH encoder
        
        encoder = comm.BCHEncoder(N,K,G);
        
    % And then the BCH decoder 
        
        decoder = comm.BCHDecoder(N,K,G); 
  
end