function output = inference(i,j,temp_input,d_temp_input,rhs , memberships)
    h = min( max(t_norm(temp_input,memberships(i,:)))  ,  max(t_norm(d_temp_input, memberships(j,:))));
    output = rhs;
    for c=1:size(output,2)
        if output(c) > h
            output(c) = h;
        end
    end
end

