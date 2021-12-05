function hac=correct(reg,res,prewhit)

% main procedures which activates the computation of robust standard errors

[nt,d]= size(reg);
b     = zeros(d,1);
bmat  = zeros(d,d);
vstar = zeros(nt-1,d);
vmat  = zeros(nt,d);

% First construct the matrix z_t*u_t.

for i=1:d
    vmat(:,i)=reg(:,i).*res;
end

% Procedure that applies prewhitenning to the matrix vmat by filtering with
% a VAR(1). If prewhit=0, it is skipped.

if prewhit==1;
    
    for i=1:d
        b = olsqr(vmat(2:nt,i),vmat(1:nt-1,:));
        bmat(i,:)=b';
        vstar(:,i)=vmat(2:nt,i)-vmat(1:nt-1,:)*b;
    end
    
    % Call the kernel on the residuals
    
    jh = jhatpr(vstar);
    
    % recolor
    
    hac = inv(eye(d)-bmat)*jh*(inv(eye(d)-bmat))';
    
else
    hac = jhatpr(vmat);     
end
    