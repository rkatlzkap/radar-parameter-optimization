%% load a file
clear
file_name = dir('*.csv');
file = zeros(85,1);
meanstd = zeros(86,11);
for k = 1:85
    file_2 = file_name(k).name;
    yuzin = readtable(file_2); %불러오기 
    len = height(yuzin);

    %distance
    distance = yuzin(6:len,{'distance1_2d'}); %2d테이블과 값이있는 테이블가져오기
    distance = table2array(distance); % 배열로 변경 
    
    %angle
    angle = yuzin(6:len,{'angle1_2d'});
    angle = table2array(angle);
    
    %db
    db = yuzin(6:len,{'level1_2d'});
    db = table2array(db);
    %% setting parameter
    new = split(file_2,'.csv');
    new = cell2mat(new(1));
    new = split(new, '.');

    % load coordinate
    x_cord = str2double(cell2mat(new(1)))*100;
    y_cord = str2double(cell2mat(new(2)))*100;

    % load magnitude (ground_truth)
    magnitude = sqrt(x_cord^2+y_cord^2);
    % load phase (ground_truth)
    if x_cord < 0
        phase = -180+atand(abs(y_cord/x_cord))+90;
    else
        phase = -atand(y_cord/x_cord)+90;
    end

    % setting threshold
    threshold = 100;
    
    %% array after thresholding
    [index_distance] = find(distance>=(magnitude-threshold) & distance<=(magnitude+threshold));
    [index_angle] = find(angle>=-90 & angle<=90);
    [index] = intersect(index_angle,index_distance);
    [array_distance] = distance(index);
    [array_angle] = angle(index);
    [array_db] = db(index);

    new_data = length(array_distance);
    ori_data = length(distance);
    data = new_data / ori_data * 100;

    %% mean, std
    % distance
    mean_distance = mean(array_distance);
    std_distance = std(array_distance);
    % angle
    mean_angle = mean(array_angle);
    std_angle = std(array_angle);
    % db
    mean_db = mean(array_db);
    %% save file
    % save file of meanstd
    meanstd_header = ["threshold","x","y","magnitude","mean_distance","std_distance","phase","mean_angle",'mean_db',"std_angle","accuracy"];
    meanstd_first = [threshold,x_cord,y_cord,magnitude,mean_distance,std_distance,phase,mean_angle,std_angle,mean_db,data];
    meanstd(1,:) = meanstd_header;
    meanstd(k+1,:) = meanstd_first;
    
    % save file of new array
    file_root = strcat('new_',num2str(x_cord),',',num2str(y_cord),'.csv');
    save_array = [array_distance,array_angle];
    writematrix(save_array,file_root);
    
    %% plot gaussian
    sigma_dis = std_distance;
    u_dis = mean_distance;
    x_dis = u_dis-90:1:u_dis+90;
    g_dis = 1./(sqrt(2.*pi*sigma_dis.^2)).*exp(-1.*((x_dis-u_dis).^2./(2.*sigma_dis.^2))); 
    
    sigma_ang = std_angle;
    u_ang = mean_angle;
    x_ang = u_ang-40:0.1:u_ang+40;
    g_ang = 1./(sqrt(2.*pi*sigma_ang.^2)).*exp(-1.*((x_ang-u_ang).^2./(2.*sigma_ang.^2))); 

    %% figure
    %figure(1); title('distan2d'); plot(distance); %Theshold전 plot
    %figure(2); title('distan2d'); plot(angle); %Theshold전 plot
    %figure(3); title('distan2d'); plot(array_distance); %Theshold전 plot
    %figure(4); title('distan2d'); plot(array_angle); %Theshold전 plot
    figure(5); histogram(array_distance); 
    yyaxis left
    plot(x_dis,g_dis); 
    yyaxis right

    figure(6); histogram(array_angle); 
    yyaxis left
    plot(x_ang,g_ang); 
    yyaxis right
    
    %disp(length(array_distance)==length(array_angle));
end
file_meanstd = strcat('threshold_',num2str(threshold),'_meanstd.csv');
writematrix(meanstd,file_meanstd);

