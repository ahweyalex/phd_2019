clear all; close all; clc;
tic;
f = 125e3;
r = 0.02;
w = 0.2546e-3;
N = 15;
S = 0.2546e-3;
hx = dipoleHelix('Radius',r,'Width',w,'Turns',N,'Spacing',S);
x = linspace(-30e-3,30e3,11);
%y = linspace(-30e-3,30e3,11);
z = linspace(-1,2,50);
%[X,Y,Z] = meshgrid(x,y,z);
%[X,Y] = meshgrid(x,y);
[X,Z] = meshgrid(x,z);
%p =  [X(:)';Z(:)';Y(:)';.01*ones(1,prod(size(X)))];
% p = [X(:)';Y(:)';.01*ones(1,prod(size(X)))];
p = [X(:)';Z(:)';.01*ones(1,prod(size(X)))];
% EHfields (hx,f)
% [e,h] = EHfields (hx,f,p);
EHfields(hx,f,p);
toc;
% [e,h] = EHfields (hx,f,p);
%{
% limitation
% from dipoleHelix code
%validateattributes(W,{'numeric'}, ...
%    {'scalar','<',r/5,'>',r/250},'dipoleHelix/set.Width', ...
%    'Width of helix');
%}
%%
show(hx)
