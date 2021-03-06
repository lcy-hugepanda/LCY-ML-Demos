%"PRTools5_prmapping_template_test" A test routine for the prmapping template
%
%
% DESCRIPTION
% This is a testing routine for PRTools5_prmapping_template.m
% You could run (and dubug via breakpoints) this script to understand the
% typical useage of prmapping.
%
% SEE ALSO
% PRTools5_prmapping_template.m

% This is a part of LCY-ML-Demos (https://github.com/lcy-hugepanda/LCY-ML-Demos)
% Copyright: LCY-Hugepanda (www.lovecaoying.com)
% Last updated: 2013-11-27 9:21:24

% Based on PRTools5 (www.37steps.com)
% Copyright: Robert P.W. Duin, prtools@rduin.nl

A = gendatb([50, 150]);
A = setprior(A,[]);
scatterd(A);

W = PRTools5_prmapping_template(A, 5); % '5' is a dummy argument for illustration
[E, C] = testc(A, W)