%%
clear;
close all;
clc;

%%

[x,F_s] = audioread("../data/HelloWorld.wav");
load("../data/one1.mat"); %Remplacer le texte entre "." par le chemin relatif ou absolu de "one1.mat"
load("../data/one2.mat"); %Remplacer le texte entre "." par le chemin relatif ou absolu de "one2.mat"
load("../data/two1.mat"); %Remplacer le texte entre "." par le chemin relatif ou absolu de "two1.mat"
load("../data/two2.mat"); %Remplacer le texte entre "." par le chemin relatif ou absolu de "two2.mat"

%Segmentation de "x" en "x_2 et "x_3"
x_2 = x(((1:length(x)) > 0.01*F_s) & ((1:length(x)) < 0.04*F_s));
x_3 = x(((1:length(x)) > 0.2*F_s) & ((1:length(x)) < 0.23*F_s));


[gam_x2, p2] = autocorr(x_2,length(x_2));
[gam_x3, p3] = autocorr(x_2,length(x_2));

%Diminutifs pour les longueurs des données
l11 = length(one1);
l12 = length(one2);
l21 = length(two1);
l22 = length(two2);

%Initialisation des vecteurs contenant les pitchs
a11 = zeros(l11);
a12 = zeros(l12);
a21 = zeros(l21); 
a22 = zeros(l22);


for k = 1:(l11 - 1)
    [~,pitch11] = isvoiced(one1(k:(k+1)),F_s);
    a11(k) = pitch11;
end
for k = 1:(l12 - 1)
    [~,pitch12] = isvoiced(one2(k:(k+1)),F_s);
    a12(k) = pitch12;
end
for k = 1:(l21 - 1)
    [~,pitch21] = isvoiced(two1(k:(k+1)),F_s);
    a21(k) = pitch21;
end
for k = 1:(l22 - 1)
    [~,pitch22] = isvoiced(two2(k:(k+1)),F_s);
    a22(k) = pitch22;
end    

%Affichage des autotcorrélations 
figure()
%Affichage de l'autocorréltion de "x_2" 
subplot(2,1,1); 
plot(p2,gam_x2);
xlim([500 2000]);
ylim([-5e-6 5e-6]);

%Affichage de l'autocorréltion de "x_3"
subplot(2,1,2); 
plot(p3,gam_x3);
xlim([500 2000]);
ylim([-5e-6 5e-6]);

%Affichage des pitchs
figure()
%Affichage du pitch de "one1.m"
subplot(4,1,1); 
plot(a11);

%Affichage du pitch de "one1.m"
subplot(4,1,2); 
plot(a12);

%Affichage du pitch de "one1.m"
subplot(4,1,3); 
plot(a21);

%Affichage du pitch de "one1.m"
subplot(4,1,4); %Affichage du pitch de "one1.m"
plot(a22);



function [gam_x, p] = autocorr(xi,maxP)
    gam_x0  = zeros(1,2*maxP-1);
    L = maxP-1;
    for i = 1:(L+1)
        for k = i:L
            gam_x0(i) = (1/(L-i+2)) * (gam_x0(i) + xi(k)*(conj(xi(k-i+1))));
        end
    end
    gam_x1 = fliplr(gam_x0);
    gam_x1(L+2:length(gam_x0)) = gam_x0(2:(L+1));
    gam_x = gam_x1;
    p = (-L):(L);
end


function [voicedFlag, pitch] = isvoiced(x,F_s)
    [gam_x, ~] = autocorr(x,length(x));
    for k = 1:length(gam_x)
        if gam_x(k) >= (0.6)*gam_x(length(x))
            voicedFlag = 1;
        else
            voicedFlag = 0;
        end
    end
    pitch = voicedFlag*F_s/max(gam_x);
end