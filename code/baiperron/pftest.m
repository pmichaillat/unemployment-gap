function ftest=pftest(y,z,i,q,bigt,datevec,prewhit,robust,x,p,hetdat,hetvar)

% procedure that computes the supF test for i breaks.

% construct the R matrix.

rsub=zeros(i,i+1);
j=1;
while j <= i
    rsub(j,j)=-1;
    rsub(j,j+1)=1;
    j=j+1;
end
rmat=kron(rsub,eye(q));
zbar=pzbar(z,i,datevec(1:i,i));
if p==0
    delta=olsqr(y,zbar);
else
    dbdel=olsqr(y,[zbar x]);
    delta=dbdel(1:(i+1)*q,1);
end

vdel=pvdel(y,z,i,q,bigt,datevec(1:i,i),prewhit,robust,x,p,0,hetdat,hetvar);

fstar=delta'*rmat'*inv(rmat*vdel*rmat')*rmat*delta;
ftest=(bigt-(i+1)*q-p)*fstar/(bigt*i);

