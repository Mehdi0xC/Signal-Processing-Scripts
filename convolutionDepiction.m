% Gaussian Denoising
% Developed by Mehdi0xC (Based on Mike X Cohen Signal Processing Course)

% Signal definition
signal = zeros(1,20);
signal(8:15) = 1;

% convolution kernel
% kernel = [1 .8 .6 .4 .2];

% convolution sizes
nSign = length(signal);
nKern = length(kernel);
nConv = nSign + nKern - 1;

half_kern = floor(nKern/2);

% flipped version of kernel
kflip = kernel(end:-1:1);%-mean(kernel);

% zero-padded data for convolution
dat4conv = [ zeros(1,half_kern) signal zeros(1,half_kern) ];

% initialize convolution output
conv_res = zeros(1,nConv);

%%% initialize plot
figure(3), clf, hold on
subplot(311)
plot(dat4conv,'o-','linew',2,'markerface','g','markersize',9)
hkern = plot(kernel,'o-','linew',2,'markerface','r','markersize',9);
hcres = plot(kernel,'s-','linew',2,'markerface','k','markersize',15);
set(gca,'ylim',[-1 1]*3,'xlim',[0 nConv+1])
subplot(312)

plot([1 1]*(half_kern+1),get(gca,'ylim'),'k--')
subplot(313)

plot([1 1]*(nConv-2),get(gca,'ylim'),'k--')
legend({'Signal';'Kernel (flip)';'Convolution'})

% run convolution
for ti=half_kern+1:nConv-half_kern
    
    % get a chunk of data
    tempdata = dat4conv(ti-half_kern:ti+half_kern);
    
    % compute dot product (don't forget to flip the kernel backwards!)
    conv_res(ti) = sum( tempdata.*kflip );
    
    % update plot
    subplot(312)

    set(hkern,'XData',ti-half_kern:ti+half_kern,'YData',kflip);
    subplot(313)
    set(hcres,'XData',half_kern+1:ti,'YData',conv_res(half_kern+1:ti))
    
    pause(.25)
    
end

% cut off edges
conv_res = conv_res(half_kern+1:end-half_kern);
