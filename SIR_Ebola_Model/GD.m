function est = GD(inputData)

days = [1:1:length(inputData)]';
%feature scale on days
daysNorm = (days-mean(days))/(std(days));
%plot (days, inputData, 'rx');
iterations = 1500;
alpha = 0.01;
m = length(inputData);
X = [ones(m,1), daysNorm];

theta = zeros(2,1);
computeCost(X,inputData, theta);

% run gradient descent
theta = gradientDescent(X, inputData, theta, alpha, iterations);

% print theta to screen
fprintf('Theta found by gradient descent: ');
fprintf('%f %f \n', theta(1), theta(2));

% Plot the linear fit
hold on; % keep previous plot visible
%plot(days, X*theta, '-') %don't plot scaled features
legend('Training data', 'Linear regression')

estData = [days,X*theta];
est = (estData(2,2) - estData(1,2));
%R_0 = est;
%N = 5500;
%alpha = 0.005;
%beta = R_0*alpha/N;
%estData = [days,X*theta];
%est = (estData(2,2) - estData(1,2));
return;