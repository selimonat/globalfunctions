function [version_count,version_id]=GetGit(path)
%[version_count,version_id]=GetGit(path)
%
%Get the GIT version count and id numbers for the repository in path.
p = pwd;
cd(path);
[~,version_count] = system(['git rev-list --count --first-parent HEAD']);
[~,version_id]    = system(['git describe  --always']);
cd(p);