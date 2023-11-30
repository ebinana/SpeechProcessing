function [knn]=real_time_classification()

%% First step : Recording a 2 seconds audio 

rec = audiorecorder(44100,16,1);

disp('The audio start recording in 3');
pause(1);
disp('2');
pause(1);
disp('1');
pause(1);
disp('Go');
recordblocking(rec,2);
disp('The End');
signal = getaudiodata(rec);
soundsc(signal,44100);
figure;
plot(signal);
title('Signal recorded during 2 seconds');
xlabel('Time');
ylabel('Amplitude');

%% 2nd step : find if there are spoken word 

%on doit d'abord échantilloné le signal rec que l'on a récup

energy=sum(signal.^2);
energy_threshold=0.001;
if energy>energy_threshold
    disp('There are spoken word')
else 
    disp('No spoken word ')
end

%% 3rd step : extract words 

% Initialisation 
Fs=16000;    % fréquence arbitraire
N=0.03*Fs;
w=hamming(N);   % N pris pour que ce soit égal a un message de 30 sec 
d=floor(N);
Nfft=1024;
N_mfcc=12;
 

features=mfcc_features(signal,w,d,Nfft,N_mfcc,Fs);

%% 4th step : classify this words 

K=5;
f=features(N_mfcc-10:N_mfcc);

load("own_train.mat");
train=own_train;
[data,Fs] = audioread('own_data_hq.m4a');

[knn]=KNN(data,train,f,w,d,Nfft,N_mfcc,Fs,K);

%% 5th step : Display of the response 

% U=unique(knn);
% n=histcounts(knn,U);
% classet=U(find(n==max(n)));
% classe=classet(1);

comptage=zeros(1,5);

for i=1:length(knn)
    for k=1:5
        if knn(i)==k
            comptage(k)=comptage(k)+1;
        end
    end
end

[~,classe] = max(comptage);

if classe==1
    one=imread('../data/01.jpg');
    imshow(one);
end
if classe==2
    two=imread('../data/02.jpg');
    imshow(two);
end
if classe==3
    three=imread('../data/03.jpg');
    imshow(three);
end
if classe==4
    four=imread('../data/04.jpg');
    imshow(four);
end
if classe==5
    five=imread('../data/05.jpg');
    imshow(five);
end




