function [Confmat]=confusion(classereel,classeatribue)
    Confmat=zeros(31);
    for ii=1:length(classereel)
        Confmat(classereel(ii)+1,classeatribue(ii)+1)=Confmat(classereel(ii)+1,classeatribue(ii)+1)+1;
    end
    for kk=1:31
        if(sum(Confmat(kk,:))~=0)
        Confmat(kk,:)=Confmat(kk,:)/sum(Confmat(kk,:));
        end
    end
end