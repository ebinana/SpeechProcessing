clear all ;
close all ;
clc;

%%---Parametres----
[x,Fs]=audioread('../data/HelloWorld.wav');
Mi=length(x);
tempsx=linspace(0,(Mi/Fs),Mi);
T=1/Fs;


%figure-
N=882; 
d=441;
N_fft=1024; 
w=hamming(N);

%% Partie --- stft ---

[Sx,f,t]=spectro(x,w,d,N_fft,Fs);

%% Partie MFCC
N_mfcc=20;
mfcc=mfcc(x,w,d,N_fft,N_mfcc,Fs);

mfcc;

mfcc_features=mfcc_features(x,w,d,N_fft,N_mfcc,Fs);

%% Test MFCC 

clear all ;
close all ;
clc;

load("../data/one1.mat");
load("../data/one2.mat");
load("../data/two1.mat");
load("../data/two2.mat");   % Nous chargeons les fichiers de test 

Fs_one=16000;
Fs_two=16000;
d=Fs_one*0.03/2;
fen=hamming(Fs_one*0.03);
N_fft=1024;
N_mfcc=20;

mfcc_features_one1=mfcc_features(one1,fen,d,N_fft,N_mfcc,Fs_one);
mfcc_features_one2=mfcc_features(one2,fen,d,N_fft,N_mfcc,Fs_one);
mfcc_features_two1=mfcc_features(two1,fen,d,N_fft,N_mfcc,Fs_two);
mfcc_features_two2=mfcc_features(two2,fen,d,N_fft,N_mfcc,Fs_two);


figure;
plot(mfcc_features_one1);
hold on
plot(mfcc_features_one2);

figure;
plot(mfcc_features_two1);
hold on
plot(mfcc_features_two2);