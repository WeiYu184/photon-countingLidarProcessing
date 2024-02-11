# photon-countingLidarProcessing
HDF5 data batch process and height control points extraction


First extract the laser points located on the land surface and from the strong laser beam:
Step 1. Put the h5 files to be processed in the same folder. (it is recommended to sort the files by file size before running and look at the files with sizes lower than 2M to search for imcomplete file structure

Step 2. Copy batch.m and readdata_1.m to the folder. Set the current folder path of Matlab to that folder. Run batch.m


Then read the LCP from the land laser point:
Put all txt into the same folder. Put LCPfilter.m in the same directory. Run LCPfilter.m
