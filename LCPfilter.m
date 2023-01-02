% 1. 参考ICESat2_2020_V2文件夹里的格式，新建一个ICESat2_2021_V3文件夹

% 2. 将.m复制到之前提取强激光后的每个区域的txt子文件夹下运行，就能在同一个目录下生成新的一批txt文件，文件名前缀为V3_


% 程序设置了手动输入区域的范围，但也可以直接改代码，如：min_LON = input('请输入经度最小值：\n')直接改成 min_LON = 59.999999 
% (!注意：最小经度是60度时，设置的值是59.999999，如果是最大值就设成60.000001，总之不要用整数)
% (!注意：西经，南纬是负的，别反了
% (!注意：程序运行结束前，不要对figure窗口进行任何操作
% (!注意：如果绘图崩溃导致运行一直中断，可以把scatterm(latitude, longitude, 1,h_te_interp)注释掉


% 3. 检查生成的V3_xxxxxxxx.txt格式是否正确（参考ICESat2_2020_V2里的txt格式）
% 4. 参考ICESat2_2020_V2，将生成的txt和range.jpg整理在ICESat2_2021_V3里


FileList = dir('*.txt');
N = size(FileList,1);
min_LON = input('请输入经度最小值：\n');
max_LON = input('请输入经度最大值：\n');
min_LAT = input('请输入纬度最小值：\n');
max_LAT = input('请输入纬度最大值：\n');

% Create the graphics figure.
f = figure('Renderer', 'zbuffer', ...
            'Position', [0,0,800,600], ...
            'visible','on');
axesm('MapProjection','eqdcylin','Frame','on','Grid','on', ...
      'MeridianLabel','on','ParallelLabel','on','MLabelParallel','south','MLineVisible' ,'on');
 
coast = load('coast.mat');
plotm(coast.lat, coast.long, 'k');
tightmap;

for k = 1:N
   % get the file name:
   filename = FileList(k).name;
   disp(filename);
   
   data1=importdata(filename);
   data2=data1.data; 
   longitude=data2(:,2);
   latitude=data2(:,3);
   h_te_interp=data2(:,4);
   ac_level=data2(:,12);
   terrain_slope = data2(:,13);
   scatterm(latitude, longitude, 1, h_te_interp);
   
   [len_ori,n] = size(latitude);
   lat_start=1;

   gtx=['V3_',filename];
   fid = fopen(gtx,'w');
   j=0;
   %len = length(lat(:));
   fprintf(fid,'n\tlon\tlat\th_interp\tac_level\tterrain_slope\n');
   for i=1:len_ori
           if longitude(i)>min_LON && longitude(i)<max_LON && latitude(i)>min_LAT && latitude(i)<max_LAT
                    j=j+1;
                    fprintf(fid,'%d\t%f\t%f\t%f\t%d\t%f\n',j,longitude(i),latitude(i),h_te_interp(i),ac_level(i),terrain_slope(i));
           end
   end
   fclose(fid);
end

% 
disp('正在绘图中，请勿进行任何操作...');
saveas(f,'range.jpg');
disp('绘图成功！可以对figure窗口进行操作');