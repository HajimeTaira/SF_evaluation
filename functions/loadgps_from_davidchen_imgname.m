function [ gpsinfos ] = loadgps_from_davidchen_imgname( davidstr )
%LOADGPS_FROM_DAVIDCHEN_IMGNAME この関数の概要をここに記述
%davidstr: '***.jpg' ('.jpg' must be included, fullpath is OK.)

%output
gpsinfos = struct();

%Extract information
[~, basestr, ~] = fileparts(davidstr);
infopart = strsplit(basestr, 'sp_');
infopart = infopart{2};

%Load information
infos = str2double(strsplit(infopart, '_'));
gpsinfos.panoid = infos(1);
gpsinfos.lat = infos(2);
gpsinfos.lng = infos(3);
gpsinfos.bldg_id = infos(4);
gpsinfos.tile = infos(5);
gpsinfos.carto_id = infos(6);
gpsinfos.yaw = infos(7);
gpsinfos.pitch = infos(8);




end

