%"PRTools5_prmapping_template" A template prmapping file
%
%   [Here list some typical invoking format]
%   W = PRTools5_prmapping_template(A,N)
%   W = PRTools5_prmapping_template([],N)
%
% INPUT [Here list all possible input arguments]
%   A       Dateset used for training
%   N      An optional parameter in integar (default 1)
%
% OUTPUT [Here list output arguments]
%   W       Resulting, trained PRTools5_prmapping_template classifier
%
% DESCRIPTION
% PRTools5_prmapping_template is a template for further implemeting of classifiers based on PRTools5.
% To illustrating the structure of prmappings, this
% PRTools5_prmapping_template is a simplest ZeroR classifier.
%
% REFERENCES
% [Here list some reference articles related to this prmapping]
%
% SEE ALSO
% [Here append some related source files]

% This is a part of LCY-ML-Demos (https://github.com/lcy-hugepanda/LCY-ML-Demos)
% Copyright: LCY-Hugepanda (www.lovecaoying.com)
% Last updated: 2013-11-27 9:04:19

% Based on PRTools5 (www.37steps.com)
% Copyright: Robert P.W. Duin, prtools@rduin.nl

function out = PRTools5_prmapping_template(varargin)

% Set default parameters
argin = setdefaults(varargin,[],1);

% Execution Path A: definition (construct an untrained prmapping)
if mapping_task(argin,'definition')
    % prepare the untrained prmapping, you should modify the name
	out = define_mapping(argin,'untrained',['PRTools5_prmapping_template_' int2str(argin{2})]);

% Execution Path B: training
elseif mapping_task(argin,'training')
    % unpack all arguments, the name of parameters could be modified.
    % but the prdataset here always has a name of 'a' / 'A'
    [a, para] = deal(argin{:});
    
    %
    % [TO DO: You code here. Implement the training of this prmapping.]
	%
	% Some frequently used code phases:
	%  [numInstances,numAttributes,numClasses] = getsize(A);
	%
    % the following code block is a dummy example (simplist ZeroR), just
    % delete it when use this template file for your own purpose
    num_classes = size(a, 2);
    list_lab = getnlab(a);
    max_class = 1;
    num_max_class = 0;
    for i = 1 : 1 : num_classes
        if (num_max_class < length(find(list_lab == i)))
            max_class = i;
            num_max_class = length(find(list_lab == i));
        end
    end
    
    %
    % [TO DO: You code here. Prepare all arguments which will be used in the further testing phase.]
    % all arguments must be stored in 'data' which is always a 'struct'
    %
    % the following code block is a dummy example (simplist ZeroR), just
    % delete it when use this template file for your own purpose
    data.input_argument = para; 
    data.max_class = max_class; 
    
    % pack arguments of trained classifier
    out = trained_classifier(a, data);

% Execution Path C: Testing
elseif mapping_task(argin,'execution')
    % unpack arguments for testing
    % commonly there are two arguments
    %  1) the prdataset for testing
    %  2) the trained prmapping
	[a,w] = deal(argin{1:2}); 
    
    % retrieve the arguments of trained classifier (the 'data' in the training phase)
	v = getdata(w);

    %
    % [TO DO: You code here. Using the arguments of the trained classifier to decide labels of given prdataset]
    %
    label = v.max_class;
    
    %
    % [TO DO: You code here. Prepare the output of testing phase]
    %
	% the following code block is a dummy example (simplist ZeroR), just
    % delete it when use this template file for your own purpose
    single_row = zeros(1, size(a,2));
    single_row(label) = 1;
    out = repmat(single_row, size(a,1), 1);

    % pack arguments of the testing results
	out = setdat(a,out,w);

% Error invoking handling (commonly leave it unmodified)
else
  error('Illegal call')
  
end
return % END main prmapping function

% after the main prmapping function, there could be some 