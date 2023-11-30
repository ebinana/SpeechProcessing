clear all;
close all;
clc;
%%% 5.1 

%   parameters
NUMDATABASE=2;
if (NUMDATABASE==1)
load("../data/train_1.mat")
load("../data/data_1.mat")
load("../data/test_1.mat")
train=train_1;
data=data_1;
test=test_1;
end

if (NUMDATABASE==2)
load("../data/train_2.mat")
load("../data/data_2.mat")
load("../data/test_2.mat")
train=train_2;
data=data_2;
test=test_2;
end


T=1/Fs;
P=20;
N=0.03*Fs;
d=N/2;
w=hamming(N);
Nfft=1024;
                   % FrÃ©quence des voix humaine
N_mfcc=12;   



    kk=1;
    L=length(train(1,:));
    Zsucces=0;
    K=7;
    classe1=zeros(1,L); %ici c'est les vraies classes 
    classe2=zeros(1,L);%ici les classe que l'on va trouvé
                       %ces deux listes servent pour la matrice de confusion 
f=zeros(1,11);    

while kk<L+1

     
     index1=test(2,kk);                             %cette partie du code 
     index2=test(3,kk);                             % donnes les indices et les features
     X=data(index1:1:index2);
     features=mfcc_features(X,w,d,Nfft,N_mfcc,Fs);
     f=features(N_mfcc-10:N_mfcc);                    

[kres]= KNN(data, train,f,w,d,Nfft,N_mfcc,Fs,K); %la on cherches k classe les plus proche selon la distance des features

[succe]=succes(test(1,kk),kres) ; %ici on recupere le succes et la classe
Zsucces=succe+Zsucces; 

classe1(kk)=test(1,kk); % on donne la vrai classe
classe2(kk)=kres;% on donne la classe recu a l'aide du KNN
kk=kk+1;
end 
zProbas=Zsucces/L;
 
%soundsc(data(index1:1:index2),Fs)% alerte sonore
%matrice de confusion
[Confmat]=confusion(classe1,classe2);
%figure(1)
%histogram2(classe2,classe1,'DisplayStyle','tile','ShowEmptyBins','off')

figure(2)
imagesc(Confmat)
colorbar
%% Question 14 

function [matF] = train_classifier(data,train,w,d,Nfft,N_mfcc,Fs) 
    % This function returns matF, a matrix contaning features
    % for every element of the train set.
    
    N=length(train(1,:));
    matF=zeros(11,N);
    ii=1;
    while ii<N+1
        index1=train(2,ii);
        index2=train(3,ii);
        X=data(index1:1:index2);
        features=mfcc_features(X,w,d,Nfft,N_mfcc,Fs);

        matF(:,ii)=features(N_mfcc-10:N_mfcc); % we take the eleven last features 
        ii=ii+1;
    end 
end

%% Question 15
% KNN implementation 
function [classe]= KNN(data, train ,f,w,d,Nfft,N_mfcc,Fs,K)
% this function return the classe the most represented in KNN

    N=length(train(1,:));   
    Vd=zeros(1,N);
    ii=1;
    [matF] = train_classifier(data,train,w,d,Nfft,N_mfcc,Fs); % on recupere les features de la bdd entrainee
    while ii<N+1 % ici on calcule la distance entre f (moyenne des mfcc) et tout les f de data 
        Vd(ii)=sqrt(sum((abs(f-matF(:,ii))).^2)); %vd est le tableau des distance 
        ii=ii+1; 
    end
    
    % trouvesles k plus petite distance
    jj=1;
    KNN=zeros(1,K);
    S=zeros(1,K);
    while jj<K+1
        
        ii=1;
       while (ii<N+1)
        if(Vd(ii)==min(Vd))
 
            Vd(ii)=max(Vd)+100;
            KNN(jj)=train(1,ii); %Knn est le tableau comportant les k plus petites distance entre les differents f
            S(jj)=ii;
            ii=N;
        end
        ii=ii+1;
       end
       jj=jj+1;
    end
    U=unique(KNN);              %|
    n=histc(KNN,U);             %|---- find the class with the most representation 
    classet=U(find(n==max(n))); %|
    classe=classet(1); % here we chose the first class in case of there more than two class 
    if (length(classet)>1)
        if (classet(1)==0)
            classe=classet(2);
        else
            classe=classet(1);
        end
    end
end

function [Nbsucces]=succes(classetest,knn) %renvois le succes par 1 ou 0 et la classe la plus representé dans KNN

if (knn==classetest)
    Nbsucces=1;  %la je compare la vrai classe du test avec la classe trouvé.
else
    Nbsucces=0;
end
end


