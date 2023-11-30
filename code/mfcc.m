function mfcc = mfcc(x,w,d,Nfft,N_mfcc,Fs)
% This function returns the mfcc features

% Apres consultation on prendra que Nfft=P
P=20;
L=length(x);
M=floor(L/d);
[X,~,~]=stft(x,w,d,Nfft,Fs);
absX=abs(X).^2;
%E=zeros(1,P);
R=[100 3700];                     % Fréquence des voix humaines
[H,~]=compute_filter_bank(P,(Nfft/2)+1,R,Fs);

X_f_positive=absX(1:(Nfft/2)+1,:);
E=H*X_f_positive;

mfcc=zeros(M,N_mfcc);
E=sum(E,2);

for k=1:M 
    for i=1:N_mfcc
        for j=1:P
            mfcc(k,i)=sqrt(2/P).*log(E(j)).*cos((pi/P).*k.*(j-0.5))+mfcc(k,i);
        end
    end
end 
end








