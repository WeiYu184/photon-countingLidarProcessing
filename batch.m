FileList = dir('*.h5');
N = size(FileList,1);

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
   readdata_1
end

saveas(f,'plots.png');
fprintf('Success!');