%% Part6
% creation de notre propre database

[signal,Fs] = audioread('own_data_hq.m4a');     %Fichier présent dans le zip
li1=[1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5];
li2=[0.5 1.75 2.50 3.60 4.5 5.50 6.70 7.70 8.75 9.75 10.80 12 12.90 13.90 15 16.06 17.2 18.2 19.3 20.35 21.4 22.5 23.3 24.5 25.4];
li3=[1.15 1.95 2.95 4 5 6.20 7.10 8.25 9.20 10.30 11.30 12.40 13.30 14.40 15.40 16.6 17.6 18.6 19.7 20.8 21.9 22.85 23.9 25 26.10] ;

own_train=zeros(3,25);
own_train(1,:)=li1;
own_train(2,:)=li2.*Fs;
own_train(3,:)=li3.*Fs;
save("own_train.mat","own_train");

knn=real_time_classification();