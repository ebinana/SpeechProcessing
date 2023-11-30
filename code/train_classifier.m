function [matF] = train_classifier(data,train,w,d,Nfft,N_mfcc,Fs) 
    % This function returns matF, a matrix contaning features
    % for every element of the train set.
    ii=1;
    N=length(train(1,:));
    matF=zeros(11,N);
    while ii<N+1
        index1=train(2,ii);
        index2=train(3,ii);
        X=data(index1:1:index2);
        features=mfcc_features(X,w,d,Nfft,N_mfcc,Fs);
        matF(:,ii)=features(N_mfcc-10:N_mfcc);
        ii=ii+1;
    end 
end
