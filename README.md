# photon-countingLidarProcessing
HDF5 data batch process and height control points extraction

先从H5中读出位于陆地表面、且位于强激光束的激光点A：
Step 1. 把需要处理的h5文件放在同一个文件夹中。程序没有对结构不完整的数据进行过滤，建议在运行前对h5按文件大小进行排序，把大小低于2M的H5手动删除，否则碰到结构不完整的数据会卡住；
Step 2. 把batch.m和readdata_1.m复制到该文件夹里。把matlab的当前文件夹路径设置为该文件夹。运行batch.m


再从陆地激光点中读出LCP：
将所有txt放在同一个文件夹中。将LCPfilter.m放在同一目录中。运行LCPfilter.m
