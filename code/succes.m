function [Nbsucces,classe]=succes(classeteste,knn)
U=unique(knn);
n=histcounts(knn,U);
classet=U(find(n==max(n)));
classe=classet(1);
if (classe==classeteste)
    Nbsucces=1;
else
    Nbsucces=0;
end
end