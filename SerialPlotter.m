% Serial Signal Plotter
% Developed by Mehdi0xC, February 2017
%VARIABLE DEFINITIONS PART-------------------------------------------------
clc
portName = '/dev/tty.usbmodem1421';
plotTitle = 'ADC Data';
xLabel = 'Elapsed Time (s)';
yLabel = 'Data';
plotGrid = 'on';
min = 0; %MINUMUM ADC VALUE
max = 1024; %MAXIMUM ADC VALUE
scrollWidth = 5;
delay = 0.0001; %DELAY AFTER EACH LOOPS IS PASSED IN MAINLOOP PART , ALLOWS THE PLOTHANDLER TO UPDATE THE PLOT , CHANGE THE ARDUINO'S DELAY AND THIS DELAY IN RESPECT TO EACH OTHER IN ORDER TO GET THE SMOOTHEST REALTIME RESULT
time = 0;
data = 0;
count = 0;
%PLOT SETTINGS PART--------------------------------------------------------
figure('Color',[0 0 0]);
Graph = plot(time,data,...
'LineWidth',2,...
'Color',[1 0 0]);
set(gca,'Color',[0 0 0]);
set(gca,'XColor',[0.9725 0.9725 0.9725]);
set(gca,'YColor',[0.9725 0.9725 0.9725]);
title(plotTitle,'FontSize',25);
xlabel(xLabel,'FontSize',15);
ylabel(yLabel,'FontSize',15);
axis([0 10 min max]);
grid(plotGrid);
%SERIAL PORT PART----------------------------------------------------------
s = serial(portName , 'baudrate' , 115200);
fopen(s);
%MAIN LOOP PART------------------------------------------------------------
tic
while (ishandle(Graph))
    dat = fscanf(s , '%d');
    if(~isempty(dat))
        count = count + 1;
        time(count) = toc;
        data(count) = dat;
        if(scrollWidth > 0)
        set(Graph,'XData',time(time > time(count)-scrollWidth),'YData',data(time > time(count)-scrollWidth));
        axis([time(count)-scrollWidth time(count) min max]);
        else
        set(Graph,'XData',time,'YData',data(end-10:10));
        axis([0 time(count) min max]);
        end
        pause(delay);
        elapsedTime = toc - tic;
    end
end
%TERMINATION PART----------------------------------------------------------
fclose(s);
