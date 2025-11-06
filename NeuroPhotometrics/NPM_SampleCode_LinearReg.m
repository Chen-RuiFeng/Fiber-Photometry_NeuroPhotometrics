%this script fits the 470 and 415 traces to themselves to detrend data,
%then uses linear regression to motion correct signals

%it is formatted for a slightly older data file format, so if you are
%looking at data recorded with Neurophotometrics 0.6.1 packages, instead of
%adding in the FP.comptime file, you can use the computer timestamp column
%that is already in the data file

clear FP 

FP.raw = readmatrix('D:\Neurophotometrics\Ruifeng\02202024RC\M373R_Ketamine\FPData2024-02-20T14_31_56.csv'); %imports raw data
% FP.comptime= readmatrix('computertimestamp.csv'); %imports computer timestamps
% FP.raw=[FP.raw FP.comptime(:,1)]; %add computer timestamp for each frame to same matrix


TS1=FP.raw(1,2); %save first timestamp so we can accurately calculate elapsed time after cropping data

fr=1/mean(diff(FP.raw(:,2))); %calculate frame rate

FP.raw = FP.raw(600:end,:); %optional step: removes initialization frame and first 600 frames to improve curvefitting
FP.n_channels = length(unique(FP.raw(:,3))); %extracts number of channels (ie 415, 470, 560)

%ensure equal number of frames for each channel
while mod(length(FP.raw),FP.n_channels) ~= 0
    FP.raw(end,:) = [];
end

%plot deinterleaved data to evaluate the raw signal
%note: tilelayout allows us to link the x axes of the two graphs so you can
%zoom in on putative motion artifacts

%filter data by flag (column 3) to deinterleave
%plot raw data for both mice and both channels

tiledlayout(4,2)
ax1 = nexttile;
plot(FP.raw(FP.raw(:,3)==2,2),FP.raw(FP.raw(:,3)==2,5))
title('G0 470-signal raw ')
xlabel('Time (seconds)')
ylabel('F (norm mean pixel value)')

ax2 = nexttile;
plot(FP.raw(FP.raw(:,3)==1,2),FP.raw(FP.raw(:,3)==1,5))
title('G0 415-signal raw')
xlabel('Time (seconds)')
ylabel('F (norm mean pixel value)')

ax3 = nexttile;
plot(FP.raw(FP.raw(:,3)==2,2),FP.raw(FP.raw(:,3)==2,6))
title('G1 470-signal raw ')
xlabel('Time (seconds)')
ylabel('F (norm mean pixel value)')

ax4 = nexttile;
plot(FP.raw(FP.raw(:,3)==1,2),FP.raw(FP.raw(:,3)==1,6))
title('G1 415-signal raw')
xlabel('Time (seconds)')
ylabel('F (norm mean pixel value)')

ax5 = nexttile;
plot(FP.raw(FP.raw(:,3)==2,2),FP.raw(FP.raw(:,3)==2,7))
title('G2 470-signal raw ')
xlabel('Time (seconds)')
ylabel('F (norm mean pixel value)')

ax6 = nexttile;
plot(FP.raw(FP.raw(:,3)==1,2),FP.raw(FP.raw(:,3)==1,7))
title('G2 415-signal raw')
xlabel('Time (seconds)')
ylabel('F (norm mean pixel value)')
linkaxes([ax1 ax2 ax3 ax4],'x')

ax7 = nexttile;
plot(FP.raw(FP.raw(:,3)==2,2),FP.raw(FP.raw(:,3)==2,8))
title('G3 470-signal raw ')
xlabel('Time (seconds)')
ylabel('F (norm mean pixel value)')

ax8 = nexttile;
plot(FP.raw(FP.raw(:,3)==1,2),FP.raw(FP.raw(:,3)==1,8))
title('G3 415-signal raw')
xlabel('Time (seconds)')
ylabel('F (norm mean pixel value)')

linkaxes([ax1 ax2 ax3 ax4 ax5 ax6 ax7 ax8],'x')

%change col number for computer timestamp when changing # of mice (line 81)
%create new array with deinterleaved data
FP.data(:,1) = FP.raw(FP.raw(:,3)==2,2); %system time when 470 LED is on
FP.data(:,2) = FP.raw(FP.raw(:,3)==2,4); %computer TS when 470 is on
FP.data(:,3) = FP.raw(FP.raw(:,3)==2,5); %G0 photometry data when 470 LED is on
FP.data(:,4) = FP.raw(FP.raw(:,3)==1,5); %G0 415
FP.data(:,5) = FP.raw(FP.raw(:,3)==2,6); %G1 470
FP.data(:,6) = FP.raw(FP.raw(:,3)==1,6); %G1 415
FP.data(:,7) = FP.raw(FP.raw(:,3)==2,7); %G2 470 
FP.data(:,8) = FP.raw(FP.raw(:,3)==1,7); %G2 415
FP.data(:,9) = FP.raw(FP.raw(:,3)==2,8); %G3 470
FP.data(:,10) = FP.raw(FP.raw(:,3)==1,8); %G3 415




%% correcting for photobleaching

%order of operations:
%1) deinterleave data by flag (LED) and save into a matrix (above)
%2) fit 470 signal with a biexponential decay -- the shape of this
%decay is a good approximation of the CONCENTRATION of GCaMP molecules
%underneath your fiber. it decreases as the autofluorescence photobleaches.
%3) divide the raw 470 data by this scale fit to get a corrected signal
%4) note: this isn't dF/F but it is INTERNALLY reliable -- that is, you can
%compare the beginning of the recording to the end of the recording. dF/F
%requires a good approximation of baseline

%first calculate the number of data column  s by counting the number of columns in
%FP.raw and then subtracting 9
ndatacol=(size(FP.raw,2))-5;

%we will create a new matrix for fitted and normalized data
FP.dff(:,1) = (FP.data(:,1)-TS1)./60 %calculate time in elapsed minutes
FP.dff(:,2) = FP.data(:,2) %computer ts in second col


for i=1:ndatacol-3

figure
tiledlayout(2,2)
temp_x = FP.data(:,1); %x axis= system time

%fit 470 data first
ax1 = nexttile;

FP.fit1 = fit(temp_x(:,1),FP.data(:,(2*i)+1),'exp2','Normalize', 'on'); %fit G0 raw 470 with biexponential.
plot(FP.data(:,(2*i)+1)) %plot raw 470
hold on
plot(FP.fit1(temp_x),'LineWidth',1) %overlay fit
xlabel('frame number')
ylabel('F (mean pixel value')
label1=sprintf('%d 470 data fit with biexponential',i);
title(label1)

%normalize 470
ax2 = nexttile;
FP.dff(:,(2*i)+1) = 100*(FP.data(:,(2*i)+1)-(FP.fit1(temp_x)))./(FP.fit1(temp_x)); %divide 470 data by fitted "baseline"
plot(FP.dff(:,(2*i)+1))
xlabel('frame number')
ylabel('normalized F (dF/F%)')
label2=sprintf('%d 470 normalized',i);
title(label2)

%then fit 415 data to itself
ax3 = nexttile;

FP.fit2 = fit(temp_x(:,1),FP.data(:,(2*i)+2),'exp2','Normalize', 'on'); %fit G0 raw 415 with biexponential.
plot(FP.data(:,(2*i)+2)) %plot raw 415
hold on
plot(FP.fit2(temp_x),'LineWidth',1) %overlay fit
xlabel('frame number')
ylabel('F (mean pixel value')
label3=sprintf('%d 415 data fit with biexponential',i);
title(label3)

%normalize 415
ax4 = nexttile;
FP.dff(:,(2*i)+2) = 100*(FP.data(:,(2*i)+2)-(FP.fit2(temp_x)))./(FP.fit2(temp_x)); %divide 470 data by fitted "baseline"
plot(FP.dff(:,(2*i)+2))
xlabel('frame number')
ylabel('normalized F (dF/F%)')
label4=sprintf('%d 415 normalized',i);
title(label4)
linkaxes([ax1 ax2 ],'x')

clear FP.fit1 FP.fit2 %clear variables between mice

end

clear label1 label2 label3 label4

%% regress out 415 using non-negative robust linear regression

%plot normalized 415 against normalized 470 for each mouse and fit a line.
%we can conceptualize this line as where the signal in the 415 and 470
%overlap. points that stray from the line are where the signals differ. the
%more divergence from the line, the better the signal.
fitdata1 = fit(FP.dff(:,4),FP.dff(:,3),fittype('poly1'),'Robust','on'); %mouse 1
fitdata2 = fit(FP.dff(:,6),FP.dff(:,5),fittype('poly1'),'Robust','on');
fitdata3 = fit(FP.dff(:,8),FP.dff(:,7),fittype('poly1'),'Robust','on');
fitdata4= fit(FP.dff(:,10),FP.dff(:,9),fittype('poly1'),'Robust','on');


tiledlayout(2,2)
ax1=nexttile
plot(FP.dff(:,4),FP.dff(:,3),'k.')
hold on
plot(fitdata1,'b')
title('Mouse 1')

ax2=nexttile
plot(FP.dff(:,6),FP.dff(:,5),'k.')
hold on
plot(fitdata2,'b')
title('Mouse 2')


ax3=nexttile
plot(FP.dff(:,8),FP.dff(:,7),'k.')
hold on
plot(fitdata3,'b')
title('Mouse 3')

ax3=nexttile
plot(FP.dff(:,10),FP.dff(:,9),'k.')
hold on
plot(fitdata4,'b')
title('Mouse 4')

 %fit isosbestic to ca signal
isosfitted(:,1)=fitdata1(FP.dff(:,4));%fit mouse 1 isosbestic
isosfitted(:,2)=fitdata2(FP.dff(:,6));
isosfitted(:,3)=fitdata3(FP.dff(:,8));
isosfitted(:,4)=fitdata4(FP.dff(:,10));

%subtract fitted isosbestic signal from normalizedd 470 data and store data in a new array
FP.corrected(:,1)=FP.dff(:,1); %carryover elapsed time
FP.corrected(:,2)=FP.dff(:,2);%carry over computer time
FP.corrected(:,3)=(FP.dff(:,3)-isosfitted(:,1)); %mouse 1
FP.corrected(:,4)=(FP.dff(:,5)-isosfitted(:,2)); %mouse 2
FP.corrected(:,5)=(FP.dff(:,7)-isosfitted(:,3));
FP.corrected(:,6)=(FP.dff(:,9)-isosfitted(:,4));

%plot fitted isosbestic and normalized 470, then on separate axes- corrected 470 data
tiledlayout(2,4)

ax1=nexttile
plot(FP.dff(:,1),FP.dff(:,3),'b')
hold on
plot(FP.dff(:,1),isosfitted(:,1),'m')
title('fitted isos and signal mouse 1')
legend('fitted isos', '470')
hold off

ax2=nexttile
plot(FP.dff(:,1),FP.dff(:,5),'b')
hold on
plot(FP.dff(:,1),isosfitted(:,2),'m')
title('fitted isos and signal mouse 2')
legend('fitted isos', '470')
hold off

ax3=nexttile
plot(FP.dff(:,1),FP.dff(:,7),'b')
hold on
plot(FP.dff(:,1),isosfitted(:,3),'m')
title('fitted isos and signal mouse 3')
legend('fitted isos', '470')
hold off

ax4=nexttile
plot(FP.dff(:,1),FP.dff(:,9),'b')
hold on
plot(FP.dff(:,1),isosfitted(:,4),'m')
title('fitted isos and signal mouse 3')
legend('fitted isos', '470')
hold off

ax5=nexttile
plot(FP.corrected(:,1),FP.corrected(:,3),'k')
title('Motion Corrected mouse 1')
xlabel('Time')
ylabel('dF/F%')

ax6=nexttile
plot(FP.corrected(:,1),FP.corrected(:,4),'k')
title('Motion Corrected mouse 2')
xlabel('Time')
ylabel('dF/F%')

ax7=nexttile
plot(FP.corrected(:,1),FP.corrected(:,5),'k')
title('Motion Corrected mouse 3')
xlabel('Time')
ylabel('dF/F%')

ax8=nexttile
plot(FP.corrected(:,1),FP.corrected(:,6),'k')
title('Motion Corrected mouse 4')
xlabel('Time')
ylabel('dF/F%')
linkaxes([ax1 ax2 ax3 ax4 ax5 ax6 ax7 ax8 ],'x')

%% plot processed traces around timestamps of interest


% FP.timestamp=readmatrix('timestamps.csv'); 
% 
% %find corresponding index numbers for each TS
% %starting with saline
% clear temp
% for i=1:length(FP.timestamp)
%    temp=find(FP.corrected(:,2)>= FP.timestamp(i,1));
%     FP.timestamp(i,3)=temp(1) %store index in col 3
%  FP.timestamp(i,4)=FP.corrected(temp(1),1); %corresponding ts in minutes in col 4
%  clear temp
% end
% 
% %repeat for drug
% for i=1:length(FP.timestamp)
%    temp=find(FP.corrected(:,2)>= FP.timestamp(i,2));
%    FP.timestamp(i,5)=temp(1)
%  FP.timestamp(i,6)=FP.corrected(temp(1),1);
%  clear temp
% end
% 
% %plot corrected data with markers for saline/drug admin
% figure
% tiledlayout(4,1)
% 
% ax1=nexttile
% plot(FP.corrected(:,1), FP.corrected(:,3))
% title("ROI G0")
% xlabel('Time (m)')
% ylabel('normalized F (dF/F%)')
% xline(FP.timestamp(1,4)) %saline ts
% xline(FP.timestamp(1,6))%drug ts
% 
% ax2=nexttile
% plot(FP.corrected(:,1), FP.corrected(:,4))
% title("ROI G1")
% xlabel('Time (m)')
% ylabel('normalized F (dF/F%)')
% xline(FP.timestamp(2,4))
% xline(FP.timestamp(2,6))
% 
% ax3=nexttile
% plot(FP.corrected(:,1), FP.corrected(:,5))
% title("ROI G2")
% xlabel('Time (m)')
% ylabel('normalized F (dF/F%)')
% xline(FP.timestamp(3,4))
% xline(FP.timestamp(3,6))
% 
% ax4=nexttile
% plot(FP.corrected(:,1), FP.corrected(:,6))
% title("ROI G3")
% xlabel('Time (m)')
% ylabel('normalized F (dF/F%)')
% xline(FP.timestamp(4,4))
% xline(FP.timestamp(4,6))

