% ��ͼ����
% �������н���ǰ����Ҫ��figure���ڽ����κβ���
% �����ɵ�����txt����һ���ļ�����
% ��.m���Ƶ�txt�ļ���������

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
 disp('���ڻ�ͼ�У���������κβ���...');
 saveas(f,'plots_sub3.3km.png');
 disp('��ͼ�ɹ������Զ�figure���ڽ��в���');