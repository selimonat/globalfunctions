function [V_t,PE] = rescorlawagner (R,a,init)
%function rescorlawagner	computes rescorla-wagner for alpha a
%				and initial V(t) init
%				mm, 03/11
%
%Synopsis:
%       [V,PE] = rescorlawagner(D,R,a)
%       [V,PE] = rescorlawagner(D,R,a,init)
%
%
%Input:
%	  D  = data
%       R  = reward (e.g. shock/no shock), required
%       a  = alpha (learning rate), required
%	init = initial values for V(trial), optional (default 0)
%
%Output:
%       V  = VT array
%       PE  = prediction error array

%%% vars
a
% R  = a(2).*R;
V  = nan(1,numel(R)); %initial values 
V(1)=init;
PE = zeros(1,numel(R)); %initial values 

%% run over trials
for trial=1:numel(R)
	%PE
	PE(trial)  = R(trial) - V(trial); % calculate prediction error	
	%Vt
	V(trial+1) = V(trial) + a(1) * PE(trial); % update value
end;
V_t=V(1:numel(R));
