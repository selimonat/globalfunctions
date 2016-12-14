function fixmat = getfixmat(edfdata, edfmeta)
            % fixmat = fixations(edfdata, edfmeta)
            %   where [edfdata, edfmeta] = edfread('file.edf')
            %   returns a flat fixation matrix
            %   returns user defined meta data per trial and per experiment
            %   removes pre-stimulus-onset fixations
            
            % parameter with_pupil: return pupil data
            with_pupil = 0;
            % number of trials
            trials = length(edfdata);
            
            % get field names of custom per-trial meta data
            function my_fields = trial_metadata()
                fields = fieldnames(edfdata);
                my_fields = setdiff(fields, {'left', 'right', 'button'});
            
            end
            
            % get field names of custom per-experiment meta data
            function my_fields = experiment_metadata()
                fields = fieldnames(edfmeta);
                my_fields = setdiff(fields, {'calib', 'header'});
            end
            
            % get empty trials for each eye
            function empty = empty_trials()
                empty = zeros(2, trials);
                for i=(1:trials)
                    empty(1, i) = isstruct(edfdata(i).left);
                    empty(2, i) = isstruct(edfdata(i).right);
                end
            end
            
            % get eye with best calibration
            function better = eye_calib()
                % init result:
                better = zeros(2, trials);
                % number of calibrations realized
                ncalib = size(edfmeta.calib, 1);
                % running from the back, in which trial we calibrated the last time
                lastc  = size(edfdata, 2) + 1;
                % run over calibrations, from the last one to the first one
                for c=(ncalib:-1:1)
                    % get current calibration
                    cal = edfmeta.calib(c);
                    % is the calibration more recent than the last one?
                    if cal.trial ~= lastc
                        % we have a fresh calibration
                        if isstruct(cal.left) && ((~isstruct(cal.right) || cal.left.err_avg <  cal.right.err_avg) || isnan(cal.right.err_avg)) && ( ~ isnan(cal.left.err_avg) )
                            % left eye has better calibration
                            better(1, max(1, cal.trial):lastc-1) = 0.5;
                            lastc = cal.trial;
                        elseif ~ isnan(cal.right.err_avg)
                            % right eye rocks
                            better(2, max(1, cal.trial):lastc-1) = 0.5;
                            lastc = cal.trial;
                        end % no suitable calibration. we will skip this
                    end
                end
                if lastc~=0
                    display(['Error: no calibration before trial ', int2str(lastc), ' - using left eye']);
                end
            end
            
            % initialize the output structure
            function fixmat = init_struct(fields)
                fixmat.start = zeros(0, 0, 'int32');
                fixmat.stop  = zeros(0, 0, 'int32');
                fixmat.x     = zeros(0, 0, 'single');
                fixmat.y     = zeros(0, 0, 'single');
                fixmat.fix   = zeros(0, 0, 'int32');
                fixmat.triali= zeros(0,0,'int32');
                if with_pupil
                    fixmat.pupil = zeros(0, 0, 'single');
                end
                fixmat.eye   = zeros(0, 0, 'uint8');
                for i=(1:length(fields))
                    fixmat.(fields{i}) = zeros(0, 0, 'int32');
                end
            end
            
            % determine which eye to use
            eye = eye_calib() + empty_trials();
            want_eye = 1+(eye(1,:)<eye(2,:));
            eyes = {'left'; 'right'};
            
            % read user defined meta data
            trial_fields = trial_metadata();
            trial_fields_length = length(trial_fields);
            exp_fields = experiment_metadata();
            exp_fields_length = length(exp_fields);
            
            % prepare output structure
            fixmat = init_struct(union(trial_fields, exp_fields));
            
            % main loop: iterate over single trials
            for trial=(1:trials)
                % get fixations of 'better' eye
                fix = edfdata(trial).(eyes{want_eye(trial)}).fixation;
                tstart = fix.start;
                % skip pre-stimulus fixations
                idx = find(tstart>0);
                fix_in_trial = length(idx);
                % output: eye (1 - left, 2 - right)
                fixmat.eye = [fixmat.eye, ones(1, fix_in_trial) * want_eye(trial)];
                % add user defined meta data
                for f=(1:trial_fields_length)
                    % check for empty fields, mark them with -maxint
                    if isempty(edfdata(trial).(trial_fields{f}))
%                         keyboard                        
                        trial
                        edfdata(trial).(trial_fields{f}).msg = '-2147483648';
                    end
                    field_val = str2double(edfdata(trial).(trial_fields{f}).msg);
                    fixmat.(trial_fields{f}) = [fixmat.(trial_fields{f}), ones(1, fix_in_trial) * field_val];
                    
                end
                % add default data fields
                fixmat.start = [fixmat.start, tstart(idx)];
                fixmat.stop  = [fixmat.stop, fix.end(idx)];
                fixmat.x     = [fixmat.x, fix.x(idx)];
                fixmat.y     = [fixmat.y, fix.y(idx)];
                fixmat.fix   = [fixmat.fix,1:fix_in_trial];
                fixmat.triali= [fixmat.triali,repmat(trial,1,fix_in_trial)];
                if with_pupil
                    fixmat.pupil = [fixmat.pupil, fix.pupil(idx)];
                end
                
            end;
            % add user defined meta data
            for f=(1:exp_fields_length)
                fixmat.(exp_fields{f}) = ones(1, length(fixmat.start), 'int32') * str2double(edfmeta.(exp_fields{f}));
            end
            
        end                