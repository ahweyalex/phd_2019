function lampSize
% Create figure and components

fig = uifigure('Position',[100 100 300 275]);

lmp = uilamp(fig,...
    'Position',[100 30 20 20]);

dd = uidropdown(fig,...
    'Editable','on',...
    'Position',[84 204 100 20],...
    'Items',{'Size x 1','Size x 2','Size x 3','Size x 4'},...
    'ItemsData',[1 2 3 4],...
    'Value',1,...
    'ValueChangedFcn',@(dd,event) optionSelected(dd,lmp));
end

% Create ValueChangedFcn callback
function optionSelected(dd,lmp)
val = dd.Value;
s = [20 20];
switch val
    case {1, 2, 3, 4}  % User selected a defined option
        size = val * s;
        lmp.Position(3:4) = size;
    otherwise % User typed a value
        m = str2num(val);
        size = m * s;
        lmp.Position(3:4) = size;
end
end