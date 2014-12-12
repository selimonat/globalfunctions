function [cmat,mask] = CorrelationMatrix( mat, ts,alpha,method)


if strcmp(method,'bootci')
    corrfun = @(X) 1-pdist(X', 'correlation' );
    data    = mat;
    dummy   = bootci(ts,{corrfun ,  data},'alpha',alpha);
    cmat    = squareform(corrfun(data));
    mask    = squareform( (sum(dummy < 0) == 2)+(sum(dummy > 0) == 2) == 1);    
else    
    for x = 1:size(mat,2);
        for y = 1:size(mat,2);
            sprintf('Current comparison: %d vs. %d\n',x,y)
            if x > y
                %%
                %%
                %%
                r(x,y,1) = dummy(1);
                r(x,y,2) = dummy(2);
                %get the samples
                % % % %             samples = bootstrp(ts,@corr2,mat(:,y),mat(:,x));
                % % % %             %get the confidence intervals for different alpha values
                % % % %             ci = [];
                % % % %             A  = logspace(log10(eps),log10(5),1000);
                % % % %             for a = A
                % % % %                 ci= [ci prctile(samples,[a 100-a])'];
                % % % %             end
                % % % %             M = mean(samples);
                % % % %             if M > 0
                % % % %                 %get the alpha values for the first non-negative ci
                % % % %                 %interval
                % % % %                 i = find(ci(1,:)>=0,1);
                % % % %             else
                % % % %                 %do the same if the mean is negative but use the upper CI
                % % % %                 i = find(ci(1,:)>=0,1);
                % % % %             end
                % % % %             % set it to NaN if it is less than 0.05
                % % % %             if ~isempty(i)
                % % % %                 alpha = A(i);
                % % % %             else
                % % % %                 alpha = NaN;
                % % % %             end
                % % % %             r(y,x)  = M;
                % % % %             rp(y,x) = alpha;
                % % % %             r(x,y)  = M;
                % % % %             rp(x,y) = alpha;
                % % % %             %
                % % % % %             if ~isempty(i)
                % % % % %                   plot(A,ci);
                % % % % %                   drawnow;
                % % % % %                 hold on
                % % % % %                 plot([rp(y,x) rp(y,x)],ci(:,i),'ro-')
                % % % % %                 hold off
                % % % % %                 pause;
                % % % % %             end
            else
                r(x,x) = NaN;
            end
            figure(1);imagesc(r);colorbar;
            figure(2);imagesc(rp);drawnow
            %
        end
    end
end
