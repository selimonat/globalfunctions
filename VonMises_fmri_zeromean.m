function [out] = VonMises_fmri_zeromean(X,amp,kappa)
%[out] = VonMises_fmri_zeromean(X,amp,kappa)
%
%   Same as VonMises_fmri however with mean correction. See the note in
%   make_gaussian_fmri_zeromean about why we need a specific function for
%   this.
%

[out]  = VonMises(X,amp,kappa,0,0);

X      = deg2rad(linspace(-135,180,8));
offset = mean(VonMises(X,amp,kappa,0,0));

out    = out - offset;
