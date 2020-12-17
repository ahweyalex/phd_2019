r = 0.5e-3;
tag_x = max(max(x))/2;
tag_y = max(max(x))/2;

E = ((x + tag_x) ./r).^2 + ((y+tag_y) ./r).^2 <=1;
figure(2)
imagesc(r,r,E.');
[idx] = find(E);
%BF = BFnorm(idx)';
