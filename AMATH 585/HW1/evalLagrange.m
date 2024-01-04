function y = evalLagrange(basis,yvals)
    y = 0;
    for i=1:length(yvals)
		y = y+yvals(i)*basis(i);
    end
end