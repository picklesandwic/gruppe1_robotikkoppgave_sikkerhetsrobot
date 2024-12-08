
xg = [5 5 pi/2];  % mål pose 
x0 = [9 4.5 0];   % start pose 

r = sim('sl_drivepose');  

q = r.find('y');          

figure;
plot(xg(1), xg(2), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
hold on;
title('move to pose');
xlabel('X Position');
ylabel('Y Position');
grid on;
axis equal;
xlim([min(q(:,1))-1, max(q(:,1))+1]);
ylim([min(q(:,2))-1, max(q(:,2))+1]);

robot_width = 0.6;  
robot_length = 0.6;  

for k = 1:length(q)
    if k > 1
        delete(robot_body);
    end
    
    theta = q(k,3);  
    
  
    back_left_x = q(k,1) - (robot_width/2) * sin(theta) - (robot_length/2) * cos(theta);
    back_left_y = q(k,2) + (robot_width/2) * cos(theta) - (robot_length/2) * sin(theta);
    
    back_right_x = q(k,1) + (robot_width/2) * sin(theta) - (robot_length/2) * cos(theta);
    back_right_y = q(k,2) - (robot_width/2) * cos(theta) - (robot_length/2) * sin(theta);
    
 
    front_left_x = q(k,1) - (robot_width/2) * sin(theta) + (robot_length/2) * cos(theta);
    front_left_y = q(k,2) + (robot_width/2) * cos(theta) + (robot_length/2) * sin(theta);
    
    front_right_x = q(k,1) + (robot_width/2) * sin(theta) + (robot_length/2) * cos(theta);
    front_right_y = q(k,2) - (robot_width/2) * cos(theta) + (robot_length/2) * sin(theta);
    
    %hjulene
    robot_body(1) = plot(back_left_x, back_left_y, 'bo', ...
                         'MarkerFaceColor', 'b', 'MarkerSize', 8);  % Bak venstre
    robot_body(2) = plot(back_right_x, back_right_y, 'bo', ...
                         'MarkerFaceColor', 'b', 'MarkerSize', 8);  % Bak høyre
    robot_body(3) = plot(front_left_x, front_left_y, 'bo', ...
                         'MarkerFaceColor', 'b', 'MarkerSize', 8);  % Foran venstre
    robot_body(4) = plot(front_right_x, front_right_y, 'bo', ...
                         'MarkerFaceColor', 'b', 'MarkerSize', 8);  % Foran høyre
    
    pause(0.05); 
end


