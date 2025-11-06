function MS = mean_n_se(matrx,dim)
if dim == 2
    MS = [mean(matrx,dim),std(matrx,1,dim)/sqrt(size(matrx,dim))];
else
    MS = [mean(matrx,dim);std(matrx,1,dim)/sqrt(size(matrx,dim))];
end

