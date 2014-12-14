power_counter = 0;
im = zeros(1500,1500,60,'single');
for power = linspace(1,4,60);
f = @(x,c,power) x^power+c; 
power_counter = power_counter + 1;
y_counter = 0;
x0=0; 
tic;
for y = linspace(-1,1,1500);
    y_counter = y_counter + 1;
    x_counter = 0;
    for x = linspace(-2.5,1,1500);
        iteration = 0;
        x0=0;
        while iteration < 1000 & abs(x0) < 10^20;
            x0 = f(x0,complex(x,y),power);
            iteration = iteration + 1;
        end;
        x_counter = x_counter + 1;
		im(y_counter,x_counter,power_counter)=log(abs(x0));
    end;
    [power y_counter iteration]
end
EmailText(mfilename,['Power: ' mat2str(power) ' finished in ' mat2str(toc/60,2) ' minutes.'])
end
save('~/fractal.mat','im')
imagesc(im)
SaveFigureWithDate('~/Desktop/MyFirstFractal.png');
