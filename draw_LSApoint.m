% 绘图代码
% 程序运行结束前，不要对figure窗口进行任何操作
% 将生成的所有txt整理到一个文件夹里
% 将.m复制到txt文件夹下运行

FileList = dir('*.txt');
N = size(FileList,1);

% Create the graphics figure.
 f = figure('Renderer', 'zbuffer', ...
           'Position', [0,0,800,600], ...
            'visible','on');
 axesm('MapProjection','eqdcylin','Frame','on','Grid','on', ...
       'MeridianLabel','on','ParallelLabel','on','MLabelParallel','south','MLineVisible' ,'on');% 
 coast = load('coast.mat');
 plotm(coast.lat, coast.long, 'k');
 tightmap;

for k = 1:N
   % get the file name:
   filename = FileList(k).name;
   disp(filename);
   try 
        d=textread(filename, '' , 'headerlines', 1);
        longitude=d(:,2);
        latitude=d(:,3);
        h_te_interp=d(:,4);
        scatterm(latitude, longitude, 1, h_te_interp);
   catch
       fprintf("Read txt error!!!!!%s\n",filename);
   end
end

% 
 disp('正在绘图中，请勿进行任何操作...');
 saveas(f,'plots_sub3.3km.png');
 disp('绘图成功！可以对figure窗口进行操作');