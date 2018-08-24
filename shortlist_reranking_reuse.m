%input: this_shortlist_str (length = 1)
%output: this_shortlist_str

[~, idx] = sort([this_shortlist_str.topN_score], 'descend');
this_shortlist_str.topN_name = this_shortlist_str.topN_name(idx);
this_shortlist_str.topN_score = this_shortlist_str.topN_score(idx);
if ~isempty(this_shortlist_str.topN_P) 
    this_shortlist_str.topN_P = this_shortlist_str.topN_P(idx);
    this_shortlist_str.topN_C = this_shortlist_str.topN_C(idx);
end