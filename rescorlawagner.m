 function [V_t,PE] = rescorlawagner (R,a_zero,a_lambda,init)
%function rescorlawagner	computes rescorla-wagner for alpha a
%				and initial V(t) init
%				mm, 03/11
%
%Synopsis:
%       [V,PE] = rescorlawagner(R,a)
%       [V,PE] = rescorlawagner(R,a_zero,a_lambda,init)
%
%
%Input:
%       
%       R         = reward (e.g. shock/no shock), required
%       a_zero    = alpha (learning rate), required
%       a_lambda  = exponential decay rate for alpha_zero. Use Inf for no
%       decay.
%       init      = initial values for V(trial), optional (default 0)
%
%Output:
%       V  = VT array
%       PE  = prediction error array
viz = 0;
%%% vars
% R  = a(2).*R;
V  = nan(1,numel(R)); %initial values 
V(1)=init;
PE = zeros(1,numel(R)); %initial values 
a  = a_zero*2.^(-[1:numel(R)]./a_lambda);
if viz 
figure(1001);plot(a);drawnow;ylabel('alpha');
end
if a_zero > 1
    cprintf([1 0 0 ],'a_zero > 1\n');
end

%% run over trials
for trial=1:numel(R)
	%PE
	PE(trial)  = R(trial) - V(trial); % calculate prediction error	
	%Vt
	V(trial+1) = V(trial) + a(trial) * PE(trial); % update value
end;
V_t=V(1:numel(R));
