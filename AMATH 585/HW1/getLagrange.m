function y = getLagrange(xvals,yvals,x)
    n = length(xvals);
	m = length(x);
    basis = ones(m,n);
	y = zeros(m,1);
	
    for i=1:n
        for j=1:n
            if i~=j
                basis(:,i) = basis(:,i).*(x-xvals(j))./(xvals(i) - xvals(j));
            end
        end 
	end
	
    for i=1:n
		y = y+yvals(i)*basis(:,i);
    end
end