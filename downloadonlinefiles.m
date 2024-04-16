%download files from online 

URL = 'https://xfr139.larc.nasa.gov/7e10ba36-eed9-494d-b3d1-3b69dc2752e8/';
% Local path on your machine
localPath = 'F:\LIDAR\2018';

% Read html contents and parse file names with ending *.hdf
urlContents = urlread(URL);
 %ret = regexp(urlContents, '\S+\.hdf\.xml', 'match');
 ret = regexp(urlContents, '"\S+\.hdf"', 'match');

% Loop over all files and download them
for k=1:length(ret)
    filename = ret{k}(2:end-1);
    filepathOnline = strcat(URL, filename);
    filepathLocal = fullfile(localPath, filename);
    urlwrite(filepathOnline, filepathLocal);
    end