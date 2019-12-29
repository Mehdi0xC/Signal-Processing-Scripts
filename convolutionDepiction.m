% Depiction of Convolution Operation
% Developed by Mehdi0xC (Based on Mike X Cohen Signal Processing Course)

% config
clear;
clc;
% specify signal type
% 1 for square signal
% 2 for triangular signal
% 3 for gaussian signal
signalType = 2;
% specify signal type
% 1 for square signal
% 2 for triangular signal
% 3 for gaussian signal
kernelType = 2;
scale = 10;
convolutionDepictionConfig;

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
f = figure('Renderer', 'painters', 'Position', [100 100 900 600]), clf, hold on
plot(dat4conv,'-','linew',2,'markerface',myBlue,'markersize',8, 'color', myBlue)
alpha(0.5)
hcres = plot(kernel,'-','linew',2,'markerface',myGreen,'markersize',12, 'color', 'g', 'color', myGreen);
hkern = plot(kernel,'-','linew',2,'markerface',myRed,'markersize',8, 'color', myRed);

set(gca,'ylim',[-1 1]*5,'xlim',[0 nConv+1])

plot([1 1]*(half_kern+1),get(gca,'ylim'),'k--')
plot([1 1]*(nConv-2),get(gca,'ylim'),'k--')
legend({'Signal';'Kernel (flip)';'Convolution'})
 
% i = half_kern+1;
% 
% b = uicontrol('Parent',f,'Style','slider','Position',[200,50,500,100],...
%               'value',i, 'min',half_kern+1, 'max',nConv-half_kern);
% bl1 = uicontrol('Parent',f,'Style','text','Position',[200,150,50,50],...
%                  'String','Step','BackgroundColor','w');
% 
% b.Callback = @(es,ed) updateSystem(f,round(es.Value),half_kern,dat4conv, kflip, hkern, hcres);    
%              
% function updateSystem(f,i,half_kern,dat4conv, kflip, hkern, hcres)
% % compute dot product (don't forget to flip the kernel backwards!)
% conv_res(i) = sum( dat4conv(i-half_kern:i+half_kern).*kflip );
% set(hkern,'XData',i-half_kern:i+half_kern,'YData',kflip);
% set(hcres,'XData',half_kern+1:i,'YData',conv_res(half_kern+1:i))
% end


% run convolution
for ti=half_kern+1:nConv-half_kern
     
     % get a chunk of data
     tempdata = dat4conv(ti-half_kern:ti+half_kern);
     
     % compute dot product (don't forget to flip the kernel backwards!)
     conv_res(ti) = sum( tempdata.*kflip )/scale;
     
     % update plot
 
     set(hkern,'XData',ti-half_kern:ti+half_kern,'YData',kflip);
     set(hcres,'XData',half_kern+1:ti,'YData',conv_res(half_kern+1:ti))
     
     pause(.2/scale)
     
 end

% cut off edges
% conv_res = conv_res(half_kern+1:end-half_kern);

