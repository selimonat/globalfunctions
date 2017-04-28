function contourf_transparency(hContour,alpha_level);
%hContour is the second output of contourf.


try
    hFills = hContour.FacePrims;  % array of TriangleStrip objects
    [hFills.ColorType] = deal('truecoloralpha');  % default = 'truecolor'
    for idx = 1 : numel(hFills)
        hFills(idx).ColorData(4) = 255*alpha_level;   % default=255
    end
catch
    fprintf('failed transparency...\n');
end
