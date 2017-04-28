function contourf_transparency(hContour,alpha_level);
%hContour is the second output of contourf.



hFills = hContour.FacePrims;  % array of TriangleStrip objects
[hFills.ColorType] = deal('truecoloralpha');  % default = 'truecolor'
if length(alpha_level) == 1
    alpha_level = repmat(alpha_level(:)',1,numel(hFills));
end
for idx = 1 : numel(hFills)
   hFills(idx).ColorData(4) = 255*alpha_level(idx);   % default=255
end