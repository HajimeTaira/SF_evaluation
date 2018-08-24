
fn = 'list_query_sf_with_intrinsics.csv';
fid = fopen(fn);
data_all = textscan(fid, '%s', 'Delimiter', '\n');
fclose(fid);
data_all = data_all{1};

QList = struct('name', {}, 'K', {});
for i = 1:1:length(data_all)
    data_split = strsplit(data_all{i}, ',');
    QList(i).name = data_split{1};
    fl = str2double(data_split{2});
    cx = str2double(data_split{3});
    cy = str2double(data_split{4});
    QList(i).K = [fl, 0, cx; ...
                  0, fl, cy; ...
                  0, 0, 1];
end