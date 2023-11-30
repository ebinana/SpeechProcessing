function [mfcc_feat] = mfcc_features(x,w,d,Nfft,N_mfcc,Fs)
% This function returns a vector of the averaged P mfcc features

mfcc_value=mfcc(x,w,d,Nfft,N_mfcc,Fs);
mfcc_feat=mean(mfcc_value,2);

end