function SaveFigure(WritePath,varargin)
%To save eps, expand ~ yourself for homedir reference.

%delete if there is mat suffix
if strcmp(WritePath(end-3:end),'.mat')
	WritePath(end-3:end)=[];
end

[p,fname,ext]=fileparts(WritePath);

%if no extension
if isempty(ext)%default extension.
    ext = '.png';
    WritePath = [WritePath ext];
end

%in order to not save the white background, I turn it off momentarily
col = get(gcf,'color');
set(gcf, 'Color', 'w');
% all = findall(gcf,'type','axes')
% set(all,'color','none');

ext(1) = '-';
% % % %decide on drawer
% % % if strcmp(ext,'.png')
set(gcf,'renderer','opengl')
% % % elseif strcmp(ext,'.jpg') | strcmp(ext,'jpeg')
% % %     set(gcf,'renderer','painters')    
% % % elseif strcmp(ext,'.eps')
% % %     set(gcf,'renderer','painters')    
% % % elseif strcmp(ext,'.ps')
% % %     %set(gcf,'renderer','painters')    
% % % end
% % % 
% % % %export
% exportfig(gcf,WritePath,'format',ext(2:end),'FontSizeMin',8,'Bounds','loose','color','rgb',varargin{:});

%you need to install Ghostscript
export_fig(WritePath,'-png','-r120',varargin{:});%,'-transparent'
% export_fig(WritePath,'-png',varargin{:})


%set it back
% set(all,'color','k');
set(gcf, 'Color', col)