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
% Last updated: 2013-12-26 17:39:40

% Based on PRTools5 (www.37steps.com)
% Copyright: Robert P.W. Duin, prtools@rduin.nl

function out = DemoPercaptron(varargin)

% Set default parameters
argin = setdefaults(varargin,[],[],'Naive',1,50);

% Execution Path A: definition (construct an untrained prmapping)
if mapping_task(argin,'definition')
    % prepare the untrained prmapping, you should modify the name
	out = define_mapping(argin,'untrained',['PLA_', argin{3}]);

% Execution Path B: training
elseif mapping_task(argin,'training')
    % unpack all arguments, the name of parameters could be modified.
    % but the prdataset here always has a name of 'a' / 'A'
    [A, cycle, pla_type, learningRate, sizePocket] = deal(argin{:});
    
    % Prepare
    [numInstances,numAttributes,numClasses] = getsize(A);  
    if isempty(cycle)
        cycle = 1: 1 : numInstances;
    end
    w = zeros(1, numAttributes+1); 
    
    % Training Loop
    trainingDataset = A;
    x = [A.data ones(numInstances, 1)];
    y = getnlab(A);
    y(y==1) = -1;
    y(y==2) = 1;
    numUpdate = 0;
    best_error = numInstances;
    best_w = w;
    while(true)
        isNoError = true;
        for i = 1 : 1 : numInstances
            idx = cycle(i);
            if (pla_sign(w*x(idx,:)') * y(idx) == -1)
                w = w + learningRate * (y(idx)*x(idx,:)')';
                numUpdate = numUpdate + 1;
                isNoError = false;
                % Just for Pocket-PLA
                if strcmp(pla_type, 'pocket')
                    now_error = test_w(x,y,w);
                    if (best_error > test_w(x,y,w))
                        best_error = now_error;
                        best_w = w;
                    end
                    if numUpdate >= sizePocket
                        w = best_w;
                        break;
                    end
                end
                % END
            end
        end
        if isNoError
            break;
        end
        if strcmp(pla_type, 'pocket') && numUpdate >= sizePocket
            w = best_w;
            break;
        end
    end
                                    
    % Construct output
    data.w = w;
    data.numUpdate = numUpdate;
    out = trained_classifier(trainingDataset, data);

% Execution Path C: Testing
elseif mapping_task(argin,'execution')
    % unpack arguments for testing
    % commonly there are two arguments
    %  1) the prdataset for testing
    %  2) the trained prmapping
	[A,W] = deal(argin{1:2}); 
    
    % retrieve the arguments of trained classifier (the 'data' in the training phase)
	v = getdata(W);
    A = prdataset(A);
    [numInstances,numAttributes,numClasses] = getsize(A);  
    x = [A.data ones(numInstances, 1)];

    % Evaluate the testing dataset
    out = zeros(numInstances,2);
    
    for i = 1 : 1 : numInstances
        if (1 == pla_sign(v.w * x(i,:)'))
            out(i,2) = 1;
        else
            out(i,2) = -1;
        end
    end
    
    
    % Construct output
	out = setdat(A,out,W);

% Error invoking handling (commonly leave it unmodified)
else
  error('Illegal call')
  
end
return % END main prmapping function


function out = pla_sign(a)
    out = sign(a);
    if 0 == out
        out = -1;
        return;
    end
return

function errorCount = test_w(x,y,w)
    errorCount = 0;
    for i = 1 : 1 : size(x,1)
            if (pla_sign(w*x(i,:)') * y(i) == -1)
                errorCount = errorCount  + 1;
            end
    end

