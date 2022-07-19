
function net = DnCNN_init(num_layers)
%%% Initialize the model with num_layers layers

b_min = 0.025;
lr11  = [1 1];
lr10  = [1 0];
weightDecay = [1 0];
meanvar  =  [zeros(64,1,'single'), 0.01*ones(64,1,'single')];

% Define network
net.layers = {} ;

net.layers{end+1} = struct('type', 'conv', ...
    'weights', {{sqrt(2/(9*64))*randn(3,3,1,64,'single'), zeros(64,1,'single')}}, ...
    'stride', 1, ...
    'pad', 1, ...
    'dilate',1, ...
    'learningRate',lr11, ...
    'weightDecay',weightDecay, ...
    'opts',{{}}) ;
net.layers{end+1} = struct('type', 'relu','leak',0) ;

for i = 1:1:num_layers-2
    
    net.layers{end+1} = struct('type', 'conv', ...
        'weights', {{sqrt(2/(9*64))*randn(3,3,64,64,'single'), zeros(64,1,'single')}}, ...
        'stride', 1, ...
        'learningRate',lr10, ...
        'dilate',1, ...
        'weightDecay',weightDecay, ...
        'pad', 1, 'opts', {{}}) ;
    
    net.layers{end+1} = struct('type', 'bnorm', ...
        'weights', {{clipping(sqrt(2/(9*64))*randn(64,1,'single'),b_min), zeros(64,1,'single'),meanvar}}, ...
        'learningRate', [1 1 1], ...
        'weightDecay', [0 0], ...
        'opts', {{}}) ;
    net.layers{end+1} = struct('type', 'relu','leak',0) ;
    
end

net.layers{end+1} = struct('type', 'conv', ...
    'weights', {{sqrt(2/(9*64))*randn(3,3,64,1,'single'), zeros(1,1,'single')}}, ...
    'stride', 1, ...
    'learningRate',lr11, ...
    'dilate',1, ...
    'weightDecay',weightDecay, ...
    'pad', 1, 'opts', {{}}) ;

net.layers{end+1} = struct('type', 'loss') ; % make sure the new 'vl_nnloss.m' is in the same folder.

% Fill in default values
net = vl_simplenn_tidy(net);



function A = clipping(A,b)
A(A>=0&A<b) = b;
A(A<0&A>-b) = -b;




