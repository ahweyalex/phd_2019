function testGUI_dropList
    v0 = 0;
    global gData;
    gData = struct('h',v0,'W',v0,'L',v0,'wT',v0,'N',v0,'O',v0,'Nxy',v0,'phi',v0); 
    
    fig = uifigure;
    ax  = uiaxes('Parent',fig,'Position',[10 10 400 400]);
    
    % create a plot
    plotW = linspace(-2*pi,2*pi);
    y = sin(plotW);
    p = plot(ax,plotW,y);
    p.Color = 'Blue';
            % save where (in fig), call name, what (plot)
    setappdata(fig,'plot1',p);
    
    % drop list
    typeVal = 'Elliptical';
    % uf = uifigure('units','pixels','position', [300, 300, 300, 300]);
    dd = uidropdown(fig,...
        'Editable','on',...
        'InnerPosition',[100,100,10,10],...
        'Position',[430 210 100 22],...
        'Items',{'Elliptical','Circular','Rectangular','Custom'},...
        'ValueChangedFcn',@(dd,event) optionSelected(dd,typeVal));
    setappdata(dd,'ddParent',fig);
    % plot
    
end



function optionSelected(dd,typeVal)
    gData.h = dd.Value
    fig = getappdata(dd,'ddParent');
    
    p = getappdata(fig,'plot1');
    %set(p.y = cos(plotW)); 
end