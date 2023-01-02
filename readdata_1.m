h5 = filename;
sc_orient =  h5read(h5,'/orbit_info/sc_orient');
% Flag Values: ['0', '1', '2']
% Flag Meanings: ['backward', 'forward', 'transition'] 
% %  sc_orient==0 - l为强激光 sc_orient==1 - r为强激光 sc_orient==2 - 无效数据

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%gt1l
if sc_orient==0 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    latitude = h5read(h5,'/gt1l/land_segments/latitude');
    longitude = h5read(h5,'/gt1l/land_segments/longitude');
    dem_removal_flag = h5read(h5,'/gt1l/land_segments/dem_removal_flag');
    h_te_interp = h5read(h5,'/gt1l/land_segments/terrain/h_te_interp');
    h_te_max = h5read(h5,'/gt1l/land_segments/terrain/h_te_max');
    h_te_min = h5read(h5,'/gt1l/land_segments/terrain/h_te_min');
    h_te_mean = h5read(h5,'/gt1l/land_segments/terrain/h_te_mean');
    h_te_median = h5read(h5,'/gt1l/land_segments/terrain/h_te_median');
  
    ph_removal_flag =  h5read(h5,'/gt1l/land_segments/ph_removal_flag');

    terrain_slope = h5read(h5,'/gt1l/land_segments/terrain/terrain_slope');
    dem_h = h5read(h5,'/gt1l/land_segments/dem_h');
    dem_flg = h5read(h5,'/gt1l/land_segments/dem_flag');
    accuracy = h_te_interp - dem_h;
    terrain_flg = h5read(h5,'/gt1l/land_segments/terrain_flg');
    urban_flag = h5read(h5,'/gt1l/land_segments/urban_flag');
    night_flag = h5read(h5,'/gt1l/land_segments/night_flag');
    cloud_flag_atm = h5read(h5,'/gt1l/land_segments/cloud_flag_atm');

    
 
    gtx=[filename,'gt1l.txt'];
    fid = fopen(gtx,'w');
    len = length(latitude(:));
    fprintf(fid,'n\tlon\tlat\th_interp\th_max\th_min\th_mean\th_median\tdem_h\tdem_flg\taccur\tac_level\tte_slope\tte_flg\turban_flg\tcloud_flg\tnight_flg\t\n');
    ac_level = zeros(len,1);
    j=1;
    for i=1:len
         if abs(accuracy(i))<0.1
            ac_level(i) = 1;
        elseif abs(accuracy(i))<0.2
            ac_level(i) = 2;
        elseif abs(accuracy(i))<0.5
            ac_level(i) = 3;
        elseif abs(accuracy(i))<1
            ac_level(i) = 4;
        elseif abs(accuracy(i))<3
            ac_level(i) = 5;
         else
            ac_level(i) = 6;
        end
          if ph_removal_flag(i)==0 && dem_removal_flag(i)==0 && isnan(h_te_interp(i))==0 && abs(h_te_max(i))<10000 && abs(h_te_mean(i)-dem_h(i))<10 && cloud_flag_atm(i) <3 && abs(terrain_slope(i))<0.03492
               fprintf(fid,'%d\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%d\t%f\t%d\t%f\t%d\t%d\t%d\t%d\n',j,longitude(i) ,latitude(i) ,h_te_interp(i),h_te_max(i),h_te_min(i),h_te_mean(i),h_te_median(i),dem_h(i),dem_flg(i),accuracy(i),ac_level(i),terrain_slope(i),terrain_flg(i),urban_flag(i),cloud_flag_atm(i),night_flag(i));
               j=j+1;
          end
    end
    fclose(fid);
    %scatterm(latitude, longitude, 1, h_te_interp);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%gt1r
if sc_orient==1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    latitude = h5read(h5,'/gt1r/land_segments/latitude');
    longitude = h5read(h5,'/gt1r/land_segments/longitude');
    dem_removal_flag = h5read(h5,'/gt1r/land_segments/dem_removal_flag');
    h_te_interp = h5read(h5,'/gt1r/land_segments/terrain/h_te_interp');
    h_te_max = h5read(h5,'/gt1r/land_segments/terrain/h_te_max');
    h_te_min = h5read(h5,'/gt1r/land_segments/terrain/h_te_min');
    h_te_mean = h5read(h5,'/gt1r/land_segments/terrain/h_te_mean');
    h_te_median = h5read(h5,'/gt1r/land_segments/terrain/h_te_median');
    ph_removal_flag =  h5read(h5,'/gt1r/land_segments/ph_removal_flag');

    terrain_slope = h5read(h5,'/gt1r/land_segments/terrain/terrain_slope');
    dem_h = h5read(h5,'/gt1r/land_segments/dem_h');
    dem_flg = h5read(h5,'/gt1r/land_segments/dem_flag');
    accuracy = h_te_interp - dem_h;
    terrain_flg = h5read(h5,'/gt1r/land_segments/terrain_flg');
    urban_flag = h5read(h5,'/gt1r/land_segments/urban_flag');
    night_flag = h5read(h5,'/gt1r/land_segments/night_flag');
    cloud_flag_atm = h5read(h5,'/gt1r/land_segments/cloud_flag_atm');

    gtx=[filename,'gt1r.txt'];
    fid = fopen(gtx,'w');
    len = length(latitude(:));

   fprintf(fid,'n\tlon\tlat\th_interp\th_max\th_min\th_mean\th_median\tdem_h\tdem_flg\taccur\tac_level\tte_slope\tte_flg\turban_flg\tcloud_flg\tnight_flg\t\n');
    ac_level = zeros(len,1);
    j=1;
    for i=1:len
         if abs(accuracy(i))<0.1
            ac_level(i) = 1;
        elseif abs(accuracy(i))<0.2
            ac_level(i) = 2;
        elseif abs(accuracy(i))<0.5
            ac_level(i) = 3;
        elseif abs(accuracy(i))<1
            ac_level(i) = 4;
        elseif abs(accuracy(i))<3
            ac_level(i) = 5;
        else
            ac_level(i) = 6;
        end
          if ph_removal_flag(i)==0 && dem_removal_flag(i)==0 && isnan(h_te_interp(i))==0 && abs(h_te_max(i))<10000 && abs(h_te_mean(i)-dem_h(i))<10 && cloud_flag_atm(i) <3 && abs(terrain_slope(i))<0.03492
               fprintf(fid,'%d\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%d\t%f\t%d\t%f\t%d\t%d\t%d\t%d\n',j,longitude(i) ,latitude(i) ,h_te_interp(i),h_te_max(i),h_te_min(i),h_te_mean(i),h_te_median(i),dem_h(i),dem_flg(i),accuracy(i),ac_level(i),terrain_slope(i),terrain_flg(i),urban_flag(i),cloud_flag_atm(i),night_flag(i));
               j=j+1;
          end
    end
    fclose(fid);
    %scatterm(latitude, longitude, 1, h_te_interp);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%gt2l
if sc_orient==0 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    latitude = h5read(h5,'/gt2l/land_segments/latitude');
    longitude = h5read(h5,'/gt2l/land_segments/longitude');
    dem_removal_flag = h5read(h5,'/gt2l/land_segments/dem_removal_flag');
    h_te_interp = h5read(h5,'/gt2l/land_segments/terrain/h_te_interp');
    ph_removal_flag =  h5read(h5,'/gt2l/land_segments/ph_removal_flag');
    h_te_max = h5read(h5,'/gt2l/land_segments/terrain/h_te_max');
    h_te_min = h5read(h5,'/gt2l/land_segments/terrain/h_te_min');
    h_te_mean = h5read(h5,'/gt2l/land_segments/terrain/h_te_mean');
    h_te_median = h5read(h5,'/gt2l/land_segments/terrain/h_te_median');
    
    terrain_slope = h5read(h5,'/gt2l/land_segments/terrain/terrain_slope');
    dem_h = h5read(h5,'/gt2l/land_segments/dem_h');
    dem_flg = h5read(h5,'/gt2l/land_segments/dem_flag');
    accuracy = h_te_interp - dem_h;
    terrain_flg = h5read(h5,'/gt2l/land_segments/terrain_flg');
    urban_flag = h5read(h5,'/gt2l/land_segments/urban_flag');
    night_flag = h5read(h5,'/gt2l/land_segments/night_flag');
    cloud_flag_atm = h5read(h5,'/gt2l/land_segments/cloud_flag_atm');

    gtx=[filename,'gt2l.txt'];
    fid = fopen(gtx,'w');
    len = length(latitude(:));

    fprintf(fid,'n\tlon\tlat\th_interp\th_max\th_min\th_mean\th_median\tdem_h\tdem_flg\taccur\tac_level\tte_slope\tte_flg\turban_flg\tcloud_flg\tnight_flg\t\n');
    ac_level = zeros(len,1);
    j=1;
    for i=1:len
         if abs(accuracy(i))<0.1
            ac_level(i) = 1;
        elseif abs(accuracy(i))<0.2
            ac_level(i) = 2;
        elseif abs(accuracy(i))<0.5
            ac_level(i) = 3;
        elseif abs(accuracy(i))<1
            ac_level(i) = 4;
        elseif abs(accuracy(i))<3
            ac_level(i) = 5;
         else
            ac_level(i) = 6;
        end
          if ph_removal_flag(i)==0 && dem_removal_flag(i)==0 && isnan(h_te_interp(i))==0 && abs(h_te_max(i))<10000 && abs(h_te_mean(i)-dem_h(i))<10 && cloud_flag_atm(i) <3 && abs(terrain_slope(i))<0.03492
               fprintf(fid,'%d\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%d\t%f\t%d\t%f\t%d\t%d\t%d\t%d\n',j,longitude(i) ,latitude(i) ,h_te_interp(i),h_te_max(i),h_te_min(i),h_te_mean(i),h_te_median(i),dem_h(i),dem_flg(i),accuracy(i),ac_level(i),terrain_slope(i),terrain_flg(i),urban_flag(i),cloud_flag_atm(i),night_flag(i));
               j=j+1;
          end
    end
    fclose(fid);
    %scatterm(latitude, longitude, 1, h_te_interp);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%gt2r
if sc_orient==1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    latitude = h5read(h5,'/gt2r/land_segments/latitude');
    longitude = h5read(h5,'/gt2r/land_segments/longitude');
    dem_removal_flag = h5read(h5,'/gt2r/land_segments/dem_removal_flag');
    h_te_interp = h5read(h5,'/gt2r/land_segments/terrain/h_te_interp');
    ph_removal_flag =  h5read(h5,'/gt2r/land_segments/ph_removal_flag');
    h_te_max = h5read(h5,'/gt2r/land_segments/terrain/h_te_max');
    h_te_min = h5read(h5,'/gt2r/land_segments/terrain/h_te_min');
    h_te_mean = h5read(h5,'/gt2r/land_segments/terrain/h_te_mean');
    h_te_median = h5read(h5,'/gt2r/land_segments/terrain/h_te_median');
    
    terrain_slope = h5read(h5,'/gt2r/land_segments/terrain/terrain_slope');
    dem_h = h5read(h5,'/gt2r/land_segments/dem_h');
    dem_flg = h5read(h5,'/gt2r/land_segments/dem_flag');
    accuracy = h_te_interp - dem_h;
    terrain_flg = h5read(h5,'/gt2r/land_segments/terrain_flg');
    urban_flag = h5read(h5,'/gt2r/land_segments/urban_flag');
    night_flag = h5read(h5,'/gt2r/land_segments/night_flag');
    cloud_flag_atm = h5read(h5,'/gt2r/land_segments/cloud_flag_atm');

    gtx=[filename,'gt2r.txt'];
    fid = fopen(gtx,'w');
    len = length(latitude(:));

    fprintf(fid,'n\tlon\tlat\th_interp\th_max\th_min\th_mean\th_median\tdem_h\tdem_flg\taccur\tac_level\tte_slope\tte_flg\turban_flg\tcloud_flg\tnight_flg\t\n');
    ac_level = zeros(len,1);
    j=1;
    for i=1:len
         if abs(accuracy(i))<0.1
            ac_level(i) = 1;
        elseif abs(accuracy(i))<0.2
            ac_level(i) = 2;
        elseif abs(accuracy(i))<0.5
            ac_level(i) = 3;
        elseif abs(accuracy(i))<1
            ac_level(i) = 4;
        elseif abs(accuracy(i))<3
            ac_level(i) = 5;
        else
            ac_level(i) = 6;
        end
          if ph_removal_flag(i)==0 && dem_removal_flag(i)==0 && isnan(h_te_interp(i))==0 && abs(h_te_max(i))<10000 && abs(h_te_mean(i)-dem_h(i))<10 && cloud_flag_atm(i) <3 && abs(terrain_slope(i))<0.03492
               fprintf(fid,'%d\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%d\t%f\t%d\t%f\t%d\t%d\t%d\t%d\n',j,longitude(i) ,latitude(i) ,h_te_interp(i),h_te_max(i),h_te_min(i),h_te_mean(i),h_te_median(i),dem_h(i),dem_flg(i),accuracy(i),ac_level(i),terrain_slope(i),terrain_flg(i),urban_flag(i),cloud_flag_atm(i),night_flag(i));
               j=j+1;
          end
    end
    fclose(fid);
    %scatterm(latitude, longitude, 1, h_te_interp);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%gt3l
if sc_orient==0 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    latitude = h5read(h5,'/gt3l/land_segments/latitude');
    longitude = h5read(h5,'/gt3l/land_segments/longitude');
    dem_removal_flag = h5read(h5,'/gt3l/land_segments/dem_removal_flag');
    h_te_interp = h5read(h5,'/gt3l/land_segments/terrain/h_te_interp');
    ph_removal_flag =  h5read(h5,'/gt3l/land_segments/ph_removal_flag');
    h_te_max = h5read(h5,'/gt3l/land_segments/terrain/h_te_max');
    h_te_min = h5read(h5,'/gt3l/land_segments/terrain/h_te_min');
    h_te_mean = h5read(h5,'/gt3l/land_segments/terrain/h_te_mean');
    h_te_median = h5read(h5,'/gt3l/land_segments/terrain/h_te_median');
    
    terrain_slope = h5read(h5,'/gt3l/land_segments/terrain/terrain_slope');
    dem_h = h5read(h5,'/gt3l/land_segments/dem_h');
    dem_flg = h5read(h5,'/gt3l/land_segments/dem_flag');
    accuracy = h_te_interp - dem_h;
    terrain_flg = h5read(h5,'/gt3l/land_segments/terrain_flg');
    urban_flag = h5read(h5,'/gt3l/land_segments/urban_flag');
    night_flag = h5read(h5,'/gt3l/land_segments/night_flag');
    cloud_flag_atm = h5read(h5,'/gt3l/land_segments/cloud_flag_atm');

    gtx=[filename,'gt3l.txt'];
    fid = fopen(gtx,'w');
    len = length(latitude(:));

    fprintf(fid,'n\tlon\tlat\th_interp\th_max\th_min\th_mean\th_median\tdem_h\tdem_flg\taccur\tac_level\tte_slope\tte_flg\turban_flg\tcloud_flg\tnight_flg\t\n');
    ac_level = zeros(len,1);
    j=1;
    for i=1:len
         if abs(accuracy(i))<0.1
            ac_level(i) = 1;
        elseif abs(accuracy(i))<0.2
            ac_level(i) = 2;
        elseif abs(accuracy(i))<0.5
            ac_level(i) = 3;
        elseif abs(accuracy(i))<1
            ac_level(i) = 4;
        elseif abs(accuracy(i))<3
            ac_level(i) = 5;
        else
            ac_level(i) = 6;
        end
          if ph_removal_flag(i)==0 && dem_removal_flag(i)==0 && isnan(h_te_interp(i))==0 && abs(h_te_max(i))<10000 && abs(h_te_mean(i)-dem_h(i))<10 && cloud_flag_atm(i) <3 && abs(terrain_slope(i))<0.03492
               fprintf(fid,'%d\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%d\t%f\t%d\t%f\t%d\t%d\t%d\t%d\n',j,longitude(i) ,latitude(i) ,h_te_interp(i),h_te_max(i),h_te_min(i),h_te_mean(i),h_te_median(i),dem_h(i),dem_flg(i),accuracy(i),ac_level(i),terrain_slope(i),terrain_flg(i),urban_flag(i),cloud_flag_atm(i),night_flag(i));
               j=j+1;
          end
    end
    fclose(fid);
   % scatterm(latitude, longitude, 1, h_te_interp);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%gt3r
if sc_orient==1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    latitude = h5read(h5,'/gt3r/land_segments/latitude');
    longitude = h5read(h5,'/gt3r/land_segments/longitude');
    dem_removal_flag = h5read(h5,'/gt3r/land_segments/dem_removal_flag');
    h_te_interp = h5read(h5,'/gt3r/land_segments/terrain/h_te_interp');
    ph_removal_flag =  h5read(h5,'/gt3r/land_segments/ph_removal_flag');
    h_te_max = h5read(h5,'/gt3r/land_segments/terrain/h_te_max');
    h_te_min = h5read(h5,'/gt3r/land_segments/terrain/h_te_min');
    h_te_mean = h5read(h5,'/gt3r/land_segments/terrain/h_te_mean');
    h_te_median = h5read(h5,'/gt3r/land_segments/terrain/h_te_median');
    
    terrain_slope = h5read(h5,'/gt3r/land_segments/terrain/terrain_slope');
    dem_h = h5read(h5,'/gt3r/land_segments/dem_h');
    dem_flg = h5read(h5,'/gt3r/land_segments/dem_flag');
    accuracy = h_te_interp - dem_h;
    terrain_flg = h5read(h5,'/gt3r/land_segments/terrain_flg');
    urban_flag = h5read(h5,'/gt3r/land_segments/urban_flag');
    night_flag = h5read(h5,'/gt3r/land_segments/night_flag');
    cloud_flag_atm = h5read(h5,'/gt3r/land_segments/cloud_flag_atm');

    gtx=[filename,'gt3r.txt'];
    fid = fopen(gtx,'w');
    len = length(latitude(:));

    fprintf(fid,'n\tlon\tlat\th_interp\th_max\th_min\th_mean\th_median\tdem_h\tdem_flg\taccur\tac_level\tte_slope\tte_flg\turban_flg\tcloud_flg\tnight_flg\t\n');
    ac_level = zeros(len,1);
    j=1;
    for i=1:len
         if abs(accuracy(i))<0.1
            ac_level(i) = 1;
        elseif abs(accuracy(i))<0.2
            ac_level(i) = 2;
        elseif abs(accuracy(i))<0.5
            ac_level(i) = 3;
        elseif abs(accuracy(i))<1
            ac_level(i) = 4;
        elseif abs(accuracy(i))<3
            ac_level(i) = 5;
         else
            ac_level(i) = 6;
        end
          if ph_removal_flag(i)==0 && dem_removal_flag(i)==0 && isnan(h_te_interp(i))==0 && abs(h_te_max(i))<10000 && abs(h_te_mean(i)-dem_h(i))<10 && cloud_flag_atm(i) <3 && abs(terrain_slope(i))<0.03492
               fprintf(fid,'%d\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%d\t%f\t%d\t%f\t%d\t%d\t%d\t%d\n',j,longitude(i) ,latitude(i) ,h_te_interp(i),h_te_max(i),h_te_min(i),h_te_mean(i),h_te_median(i),dem_h(i),dem_flg(i),accuracy(i),ac_level(i),terrain_slope(i),terrain_flg(i),urban_flag(i),cloud_flag_atm(i),night_flag(i));
               j=j+1;
          end
    end
    fclose(fid);
    scatterm(latitude, longitude, 1, h_te_interp);
end