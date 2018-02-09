function model2text(model,filename)

    a     = evalc('disp(model)');
    fid   = fopen(sprintf('%s.txt',filename,model.Formula),'w');
    fwrite(fid,a);
    fclose(fid);