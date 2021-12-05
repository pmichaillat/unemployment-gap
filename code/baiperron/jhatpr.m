function jhat=jhatpr(vmat)

% procedure to compute the long-run covariance matrix of vmat.

[nt,d]=size(vmat);
jhat=zeros(d,d);

% calling the automatic bandwidth selection

st=bandw(vmat);

% lag 0 covariance

jhat=vmat'*vmat;

% forward sum
for j=1:nt-1
    jhat=jhat+kern(j/st)*vmat(j+1:nt,:)'*vmat(1:nt-j,:);
end

% backward sum
for j=1:nt-1
    jhat=jhat+kern(j/st)*vmat(1:nt-j,:)'*vmat(j+1:nt,:);
end

% small sample correction
jhat=jhat/(nt-d);

