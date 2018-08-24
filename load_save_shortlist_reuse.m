%input: output_dir, shortlist_basename
%output: shortlist_str

shortlist_matname = fullfile(output_dir, 'shortlists', [shortlist_basename, '.mat']);
shortlist_txtname = fullfile('inputs', shortlist_basename);

if exist(shortlist_matname, 'file') == 2
    load(shortlist_matname);
else
    [ shortlist_str ] = load_shortlist_txt( shortlist_txtname );
    if exist(fullfile(output_dir, 'shortlists'), 'dir') ~= 7
        mkdir(fullfile(output_dir, 'shortlists'));
    end
    save('-v6', shortlist_matname, 'shortlist_str');
end