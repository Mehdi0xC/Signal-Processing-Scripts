% Signal Generator
% Developed by Mehdi0xC
MU = [1 2;-3 -5];
SIGMA = cat(3,[2 0;0 .5],[1 0;0 1]);
p = ones(1,2)/2;
obj = gmdistribution(MU,SIGMA,p);

for i=1:10
    n=64*2.^(i-1);
    t = 1:1:n;
    y = random(obj,n);
    fid=fopen('/Users/mehdi/Desktop/X/signals/signal'+ string(i)+".txt",'w');
        for k=1:n
        fprintf( fid , string(y(k,1)) );
        fprintf( fid ,'\n');
        end
    fclose(fid);
end