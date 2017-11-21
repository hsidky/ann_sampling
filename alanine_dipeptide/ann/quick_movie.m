close all
set(0,'defaulttextInterpreter','latex');
set(groot, 'defaultAxesTickLabelInterpreter','latex'); 
set(groot, 'defaultLegendInterpreter','latex');

%n = 10000*5000*0.002;
n = 20000*10000*0.002;
%file = 'ANN/longforget3/ann.out10000';
files = dir('ann_20000.dat*'); 
nf = length(files);

clear FRAMES
nmax = 400;
FRAMES(nmax) = struct('cdata',[],'colormap',[]);

for i=1:nf
    file = files(i).name; 
    [tokens,~] = regexp(file, '^ann_20000.dat([0-9.]+)', 'tokens', 'match');
    cframe = str2double(tokens{1}{1});
    if cframe > nmax
        continue;
    end

    A = dlmread(sprintf('%s',file), '');
    nn = 31;
    x1 = reshape(A(:,1), nn, nn); 
    x2 = reshape(A(:,2), nn, nn);
    %y = reshape(-log(A(:,3)), nn, nn);
    y = reshape(-A(:,4), nn, nn);

    contourf(x1, x2, (y-max(y(:))), 15);
    %{
    plt = Plot();
    %c = colorbar;
    %c.Label.String = 'kJ/mol';
    plt.Colors = {[0.2,0.2,0.2]};
    plt.LineWidth = 0.6;
    plt.AxisLineWidth = 1.0;
    plt.BoxDim = [4, 4];
    plt.FontName = 'Serif'; 
    plt.XMinorGrid = 'off'; 
    plt.YMinorGrid = 'off'; 
    plt.XTick = [-3,-2,-1,0,1,2,3];
    plt.YTick = [-3,-2,-1,0,1,2,3];
    plt.FontSize = 14;
    plt.XLabel = '$\phi$';
    plt.YLabel = '$\psi$';
    plt.Title = sprintf('t = %.0f ps', cframe*5000*0.002);
    %}
    title(sprintf('t = %.0f ps', cframe*20000*0.002));
    drawnow; 
    FRAMES(cframe) = getframe(gcf);
    close(gcf);
end