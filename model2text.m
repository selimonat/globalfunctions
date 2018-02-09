function model2text(model,folder)

    a     = evalc('disp(model)');
    fid   = fopen(sprintf('%s%s%s.txt',folder,filesep,model.Formula),'w');
    fwrite(fid,a);
    fclose(fid);