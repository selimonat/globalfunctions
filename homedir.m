function userDir = homedir
%homedir return the user home directory.
%   USERDIR = homedir returns the user home directory using the registry
%   on windows systems and using Java on non windows systems as a string
%
%   Example:
%      homedir() returns on windows
%           C:\Documents and Settings\MyName\Eigene Dateien

if ispc
    userDir = winqueryreg('HKEY_CURRENT_USER',...
        ['Software\Microsoft\Windows\CurrentVersion\' ...
         'Explorer\Shell Folders'],'Personal');
     regexprep(userDir,'Documents','');
else
    userDir = char(java.lang.System.getProperty('user.home'));
end