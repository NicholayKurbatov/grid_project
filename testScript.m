clear all, clc


% Load paramters '*.mat' file
load('testing_parameters.mat');
% Assign input properties
% loads' props
load_1 = param.sigma1;
load_2 = param.sigma2;
length_1 = 2;
length_2 = 1;
length_3 = 4;
length_4 = 1;
% lines' props
line_Z = param.Z;
line_Y = param.Y;
line_W = [ zeros(3), line_Z; line_Y, zeros(3) ];
% source props
src_ID = 'srcNode';
src_EMF = 1e4;
src_Z0 = 1+0.14i;
src_Zn = 1e6;
% Describe net structure and element props
nGrid = Grid();
nGrid.addNode('srcNode'); % source node
nGrid.addNode('intN_1'); % internal node
nGrid.addNode('Load_1',load_1); % load node
nGrid.addNode('intN_2'); % internal node
nGrid.addNode('Load_2',load_2); % load node
nGrid.addLine('Line_1', 'srcNode', 'intN_1', length_1, line_W);
nGrid.addLine('Line_2',  'intN_1', 'Load_1', length_2, line_W);
nGrid.addLine('Line_3',  'intN_1', 'intN_2', length_3, line_W);
nGrid.addLine('Line_4',  'intN_2', 'Load_2', length_4, line_W);
% Set source parameters
nGrid.setSource( src_ID, src_EMF, src_Z0, src_Zn );
% Call phasors calculations
nGrid.calcPhasors();
% Collect nodes phasors
resPhasors = [];
for k = 1:numel(nGrid.nodes)
    resPhasors(k).nodeID = nGrid.nodes{k}.id;
    resPhasors(k).U = nGrid.nodes{k}.U;
    resPhasors(k).I = nGrid.nodes{k}.I;
end
% Save coolected phasors
save('testResults.mat', 'resPhasors', '-v7');
