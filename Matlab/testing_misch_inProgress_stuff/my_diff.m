function out = my_diff(v)
    out = diff(v,1,2);
    out = cat(2,out,out(:,length(out)));
end