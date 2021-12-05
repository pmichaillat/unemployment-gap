function ssrn=ssrnul(y,zz)

% Computes the SSR under the null of no break

delta=olsqr(y,zz);
ssrn=(y-zz*delta)'*(y-zz*delta);

