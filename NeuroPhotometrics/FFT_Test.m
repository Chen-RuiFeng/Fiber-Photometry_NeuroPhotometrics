close all
Fs = 25;

Duration = 80;
L = Duration*Fs;
init= 2000;
figure
set(gcf, 'Position', get(0, 'Screensize'));
zscore_sample = [];
for i = 1:4
    nexttile
    zscore_sample = [zscore_sample,zscore(FP.Ftd470(init:init+L,i))];
    plot(zscore(FP.Ftd470(init:init+L,i)),'g')
    xlim([0,1000])
end

saveas(gca,[Para.path,'\Sample trace.jpg'])
figure
set(gcf, 'Position', get(0, 'Screensize'));

fft_d_abs=[];
for i = 1:4
    nexttile
    fft_d = fft(zscore(FP.Ftd470(init:init+Duration*25,i)));
    fft_d = fftshift(fft_d);
    fft_d_abs =[fft_d_abs,real(fft_d)];
    plot(abs(fft_d),'g')
    ylim([0,600])
   %xlim([0,1000])
end
saveas(gca,[Para.path,'\FFT.jpg'])
save([Para.path,'\zscore_sample.mat'],'zscore_sample')
save([Para.path,'\fft_d_abs.mat'],'fft_d_abs')