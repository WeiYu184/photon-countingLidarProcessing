% 1. �ο�ICESat2_2020_V2�ļ�����ĸ�ʽ���½�һ��ICESat2_2021_V3�ļ���

% 2. ��.m���Ƶ�֮ǰ��ȡǿ������ÿ�������txt���ļ��������У�������ͬһ��Ŀ¼�������µ�һ��txt�ļ����ļ���ǰ׺ΪV3_


% �����������ֶ���������ķ�Χ����Ҳ����ֱ�ӸĴ��룬�磺min_LON = input('�����뾭����Сֵ��\n')ֱ�Ӹĳ� min_LON = 59.999999 
% (!ע�⣺��С������60��ʱ�����õ�ֵ��59.999999����������ֵ�����60.000001����֮��Ҫ������)
% (!ע�⣺��������γ�Ǹ��ģ�����
% (!ע�⣺�������н���ǰ����Ҫ��figure���ڽ����κβ���
% (!ע�⣺�����ͼ������������һֱ�жϣ����԰�scatterm(latitude, longitude, 1,h_te_interp)ע�͵�


% 3. ������ɵ�V3_xxxxxxxx.txt��ʽ�Ƿ���ȷ���ο�ICESat2_2020_V2���txt��ʽ��
% 4. �ο�ICESat2_2020_V2�������ɵ�txt��range.jpg������ICESat2_2021_V3��


FileList = dir('*.txt');
N = size(FileList,1);
min_LON = input('�����뾭����Сֵ��\n');
max_LON = input('�����뾭�����ֵ��\n');
min_LAT = input('������γ����Сֵ��\n');
max_LAT = input('������γ�����ֵ��\n');

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
disp('���ڻ�ͼ�У���������κβ���...');
saveas(f,'range.jpg');
disp('��ͼ�ɹ������Զ�figure���ڽ��в���');