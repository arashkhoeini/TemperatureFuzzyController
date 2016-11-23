function result =  t_norm(x , y)
for c=1:length(x)
    result(c) = min( x(c), y(c) );
end
end

