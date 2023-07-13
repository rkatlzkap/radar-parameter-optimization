%% make a complex array
num = zeros(122,1);
i=1;
for a=-5:1:5
    for b=0:1:10
        complex_number = complex(a,b);
        num(i) = complex_number;
        i=i+1;
    end
end

%% make a mag and phase array
mag = sqrt(real(num).^2 + imag(num).^2)*100;
phase = atan(real(num)./imag(num)) + (pi/2);
figure(1); polarscatter(phase,mag,'filled','SizeData',150); hold on

%% make a prediction array
array = readtable('threshold_50_meanstd.csv');
mag_pred = array(:,"mean_distance");
mag_pred = table2array(mag_pred);

phase_pred = array(:,"mean_phase");
phase_pred = table2array(phase_pred).*pi./180 + (pi/2);
polarscatter(phase_pred, mag_pred,'filled','red','SizeData',150);

%% distance vs db
a = array(:,"db");
b = array(:,"distance");
a = table2array(a);
b = table2array(b);
figure(2); scatter(b, a,'filled')
grid
