function SetTickNumber(handle,N,varargin)
%SetTickNumber(gca,N,varargin)
%
%Sets the number of the ticks of an axis to N without chaning its span. N
%is a vector specifying the number of ticks for x- and y-axis. VARARGIN can
%be used for restricting to X or Y axis. VARARGIN can be 'x' or 'y'.
%
%Selim, 20-Dec-2007 09:36:23

if isempty(varargin)

    x = get(handle,'xlim');
    set(gca,'xtick',linspace(min(x),max(x),N(1))) ;
    
    y = get(handle,'ylim');
    set(handle,'ytick',linspace(min(y),max(y),N(2))) ;
    
else

    if strcmp(varargin{1},'x')

        x = get(handle,'xlim');
        set(handle,'xtick',(linspace(min(x),max(x),N(1)))) ;
    elseif strcmp(varargin{1},'y')        
        y = get(handle,'ylim');
        set(handle,'ytick',(linspace(min(y),max(y),N(1)))) ;        
    else

        x = get(handle,'xlim');
        set(handle,'xtick',(linspace(min(x),max(x),N(1)))) ;
        
        y = get(handle,'ylim');
        set(handle,'ytick',(linspace(min(y),max(y),N(2)))) ;        
    end    
end