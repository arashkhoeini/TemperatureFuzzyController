function output = main(temp_input , d_temp_input)
%Defining Membership functions
l = ones(1,100);
r = [0.99:-0.01:0];
very_low = [l r zeros(1,300)];
l = [0.01:0.01:1];
r = [0.99:-0.01:0];
low = [zeros(1,100) l r zeros(1,200)];
high = [zeros(1,300) l r ];
medium = [zeros(1,200) l r zeros(1,100)];
very_high = [zeros(1,400) l];

l = ones(1,200);
r = [0.995:-0.005:0];
fan_very_low = [l r zeros(1,600)];
l = [0.005:0.005:1];
r = [0.995:-0.005:0];
fan_low = [zeros(1,200) l r zeros(1,400)];
fan_high = [zeros(1,600) l r ];
fan_medium = [zeros(1,400) l r zeros(1,200)];
fan_very_high = [zeros(1,800) l];

%Defining Rules
rules = [very_low very_low medium medium medium ;
   very_low very_low medium medium medium ; 
   medium medium medium medium medium; 
   very_high very_high high high high ;
   very_high very_high high high high];

%Fuzzification temp_input
temp_input(1) = temp_input(1) * 10;
temp_input(2) = temp_input(2) * 10;
zeros(1,(temp_input(1) - temp_input(2)/2 ));
l = [0+(1/temp_input(2)/2):1/temp_input(2)/2:1];
r = [1-(1/temp_input(2)/2):-1/temp_input(2)/2:0];
temp_input = [zeros(1,(temp_input(1) - temp_input(2)/2 )) l r ];
temp_input = [temp_input zeros(1,500 - size(temp_input,2))];

%Fuzzification d_temp_input
d_temp_input(1) = d_temp_input(1) * 10;
d_temp_input(2) = d_temp_input(2) * 10;
zeros(1,(d_temp_input(1) - d_temp_input(2)/2 ));
l = [ 0+(1/d_temp_input(2)/2) : 1/d_temp_input(2)/2 :1];
r = [1-(1/d_temp_input(2)/2):-1/d_temp_input(2)/2:0];
d_temp_input = [zeros(1,(d_temp_input(1) - d_temp_input(2)/2 )) l r ];
d_temp_input = [d_temp_input zeros(1,500 - size(d_temp_input,2))];

temp_active = [ all(t_norm(very_low, temp_input) == 0)==0 all(t_norm(low, temp_input)==0)==0 ...
    all(t_norm(medium, temp_input)==0)==0 all(t_norm(high, temp_input)==0)==0 all(t_norm(very_high, temp_input)==0)==0 ];

d_temp_active = [ all(t_norm(very_low, d_temp_input) == 0)==0 all(t_norm(low, d_temp_input)==0)==0 ...
    all(t_norm(medium, d_temp_input)==0)==0 all(t_norm(high, d_temp_input)==0)==0 all(t_norm(very_high, d_temp_input)==0)==0 ];
memberships = [very_low , low , medium , high , very_high];
for i=1:5
    for j=1:5
        if(temp_active(i) && d_temp_active(j))
            output = inference(i,j,temp_input , d_temp_input , rules(i,j) , memberships );
            plot(output)
        end
    end
end


end

