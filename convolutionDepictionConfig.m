
signalLength = 33*scale;
signal = zeros(1,signalLength);

switch signalType
    case 1
        signal(0.4*signalLength:0.6*signalLength) = 1;
    case 2
        signal(0.4*signalLength:0.5*signalLength) = linspace(0,1,0.1*signalLength+1);
        signal(0.5*signalLength:0.6*signalLength) = linspace(1,0,0.1*signalLength+1);
    case 3
        gauss = @(x,a,b,c) a*exp(-(((x-b).^2)/(2*c.^2)));
        x = ceil(-signalLength/2):1:floor(signalLength/2);   
        amp = 1; 
        cnt = 0; 
        sig = 2; 
        signal = gauss(x, amp, cnt, sig);
end
kernelLength = 6*scale+3;
kernel = zeros(1,kernelLength);

switch kernelType
    case 1
        kernel(ceil(0.33*kernelLength+1):ceil(0.66*kernelLength)) = 1;
    case 2
        kernel(floor(0.25*kernelLength+1):ceil(0.5*kernelLength)) = linspace(0,1,ceil(0.5*kernelLength)-floor(0.25*kernelLength));
        kernel(floor(0.5*kernelLength+1):ceil(0.75*kernelLength)) = linspace(1,0,ceil(0.75*kernelLength)-floor(0.5*kernelLength));
    case 3
        gauss = @(x,a,b,c) a*exp(-(((x-b).^2)/(2*c.^2)));
        x = ceil(-kernelLength/2):1:floor(kernelLength/2);   
        amp = 1; 
        cnt = 0; 
        sig = kernelLength/scale; 
        kernel = gauss(x, amp, cnt, sig);
    case 4
       kernel = linspace(1,0,kernelLength)  ;   
end


myBlueHex = '#0C90C8';
myBlue = sscanf(myBlueHex(2:end),'%2x%2x%2x',[1 3])/255;

myGreenHex = '#00C890';
myGreen = sscanf(myGreenHex(2:end),'%2x%2x%2x',[1 3])/255;

myRedHex = '#C81830';
myRed = sscanf(myRedHex(2:end),'%2x%2x%2x',[1 3])/255;
clear 'myRedHex' 'myGreenHex' 'myBlueHex'