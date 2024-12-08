

dt = 0.1; 
total_time = 20; 
num_steps = total_time / dt;


x_true = [0; 0; 0]; 
x_est = [0; 0; 0]; 

%(enkel robotmodell)
A = [1 0 0; 0 1 0; 0 0 1]; 
B = [dt 0; 0 dt; 0 0]; 
u = [0.5; 0.2]; 

%Kalman filter parametere
P = eye(3); 
Q = 0.01 * eye(3); %støy
R = 0.1 * eye(2); %Måleusikkerhet

% Målematrise
H = [1 0 0; 0 1 0]; % Måling kun av x og y posisjon

% Lagre data for plott
x_true_data = zeros(3, num_steps);
x_est_data = zeros(3, num_steps);

% Simulering
for k = 1:num_steps
    
    x_true = A * x_true + B * u + sqrt(Q) * randn(3,1); 

    z = H * x_true + sqrt(R) * randn(2,1); 

    x_pred = A * x_est + B * u; 
    P = A * P * A' + Q;

    
    K = P * H' / (H * P * H' + R);
    x_est = x_pred + K * (z - H * x_pred); 
    P = (eye(3) - K * H) * P; 

    % Lagre data for plott
    x_true_data(:, k) = x_true;
    x_est_data(:, k) = x_est;
end

% Plot resultatene
figure;
plot(x_true_data(1,:), x_true_data(2,:), 'g-', 'DisplayName', 'Sann bane');
hold on;
plot(x_est_data(1,:), x_est_data(2,:), 'r--', 'DisplayName', 'Estimert bane');
legend;
xlabel('X posisjon');
ylabel('Y posisjon');
title('Kalman Filter Simulering av Robotbane');
grid on;
