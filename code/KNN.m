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