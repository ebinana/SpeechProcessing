function [X,f,t]=stft(x,w,d,N_fft,Fs)
  N=length(w);
  L=length(x);
  M=floor(L/d);
  
  X=zeros(N,M);         
  ii=1;
  
  f=(Fs/N_fft).*(1:1:N_fft/2+1)';
  while ii<M+1
    jj=1;
    while jj<N+1
            if ((jj+(ii-1)*d)<L)
            X(jj,ii)=w(jj)*x( jj + (ii-1)*d );
            
        else
        X(jj,ii)=0;
         end
    jj=jj+1;
    end 
     ii=ii+1; 
  end
  
    X=fft(X,N_fft);
    t=linspace(0,850,N_fft);
   
end 