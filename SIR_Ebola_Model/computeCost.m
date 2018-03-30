function J = computeCost(X, y, theta)
%COMPUTECOST Compute cost for linear regression
%   J = COMPUTECOST(X, y, theta) computes the cost of using theta as the
%   parameter for linear regression to fit the data points in X and y

% Initialize values
m = length(y); % number of training examples
J = 0;



h_theta=X*theta;
sqrErrors=(h_theta-y).^2;
J=(1/(2*m))*sum(sqrErrors);



end
