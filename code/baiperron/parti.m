function [ssrmin, dx]=parti(start,b1,b2,last,bigvec,bigt)

% procedure to obtain an optimal one break partitions for a segment that
% starts at date start and ends at date last. It returns the optimal break
% and the associated SSR.

% start: beginning of the segment considered
% b1: first possible break date
% b2: last possible break date
% last: end of segment considered

dvec=zeros(bigt,1);
ini=(start-1)*bigt-(start-2)*(start-1)/2+1;
j=b1;
while j <= b2
    jj=j-start;
    k=j*bigt-(j-1)*j/2+last-j;
    dvec(j,1)=bigvec(ini+jj,1)+bigvec(k,1);
    j=j+1;
end

ssrmin=min(dvec(b1:b2,1))';
[dummy, minindcdvec]=min(dvec(b1:b2,1));
dx=(b1-1)+minindcdvec';

    
    