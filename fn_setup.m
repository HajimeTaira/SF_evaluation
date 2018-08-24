function [ fnames ] = fn_setup
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%dataset
fnames.dataset.dir = '/datagrid5new';
fnames.dataset.name = 'SanFrancisco';
fnames.dataset.PCIdir = 'PCIs';
fnames.dataset.PCInameformat = 'PCI_sp_*.jpg';
fnames.dataset.Qdir = 'Query/BuildingQueryImagesCartoIDCorrected-Upright';
fnames.dataset.Qnameformat = '*.jpg';


%groundtruth (reference poses)
fnames.gt.dir = 'reference_poses';
fnames.gt.matname = 'reference_poses_addTM_all_598.mat';

%inputs (shortlist must be here)
fnames.inputs.dir = 'inputs';

%outputs
fnames.outputs.dir = 'outputs';
fnames.outputs.locresults.name = 'localization_results';
fnames.outputs.locresults.top1matname = 'top1locposes.mat';
fnames.outputs.shortlists.name = 'shortlists';
fnames.outputs.qualitative.name = 'qualitatives';
fnames.outputs.verification.name = 'verification';




end

