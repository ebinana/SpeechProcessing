clear all ;
close all ;
clc;

%%---Parametre----
[x,Fs]=audioread('../data/HelloWorld.wav');
Mi=length(x);
tempsx=linspace(0,(Mi/Fs),Mi);
T=1/Fs;

%%x1
Nb=0.04*Fs;
Nbmin=0.01*Fs;
N=Nb-Nbmin;

temps=linspace(0.01,0.04,N);
x1=zeros(Nb,1);
x1=x(Nbmin:Nb-1);
X1fft=fft(x1,Fs);
k=-Fs/2:Fs/2-1;
%x2
Nbmax2=0.23*Fs;
Nbmin2=0.2*Fs;
N2=Nbmax2-Nbmin2;
temps2=linspace(0.2,0.23,N2);
x2=zeros(N2,1);
x2=x(Nbmin2:Nbmax2-1);
X2fft=fft(x2,Fs);
k2=-Fs/2:Fs/2-1;
%xH
nbminh=0.04*Fs;
nbmaxh=0.4*Fs;
Nh=nbmaxh-nbminh;
tempsh=linspace(0.04,0.4,Nh);
xh=zeros(Nh,1);
xh=x(nbminh:nbmaxh-1);
%%---Signal-Processing-----

%figure-x1
figure(1)
subplot 211
plot(temps,x1)
xlabel('temps (en s)')
ylabel('signal x1')
subplot 212
plot(k,(X1fft).^2)


%figure-x2
figure(2)
subplot 211
plot(temps2,x2)
xlabel('temps (en s)')
ylabel('signal x2')
subplot 212
plot(k2,(X2fft).^2)
%figure-xH
figure(3)
plot(tempsh,xh)

N=882; 
d=441;
N_fft=1024; 
w=hamming(N);
N_mfcc=20;
M=floor(Mi/d);


[Sx,f,t]=spectro(x,w,d,N_fft,Fs);

figure()
imagesc(log(spectro(x,w,d,N_fft,Fs)))
colorbar


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
    t=linspace(0,M,1);
   
end 

function [Sx, f, t] = spectro(x,w,d,N_fft,Fs)

% This function computes the spectrogram for m = [0, d, 2d, 3d...]
% This function outputs are:
% -> Sx, which is a matrix of n_fft lines and
% M (number of elements of m) columns
% Sx(i,j) is the value of the spectrogram for time t(i) and frequency f(j)
% -> f, is a column vector of the frequencies (in Hz)
% -> t, is a row vector containing the times of the beginning of the windows

    [X,f,t] = stft(x,w,d,N_fft,Fs);
    
    X=X(1:(N_fft/2)+1,:);
    Sx = (1/((N_fft/2)+1))*(abs(X)).^2;
    Sx=Sx(end:-1:1,:);

end


