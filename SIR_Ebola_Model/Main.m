% SEIR Model for Ebola Outbreak in Sierra Leone

%% ----- Load Learning Data -----------------------------------------------
load('nat_short_data.mat');
load('nat_long_data.mat');
nat_short_data(:,4) = nat_short_data(:,2) + nat_short_data(:,3);


%% ----- Gradient Descent -------------------------------------------------
estDeaths = GD(nat_short_data(:,3));    % GD on deaths
estInfects = GD(nat_short_data(:,2));   % GD on cumulative cases


%% ----- Parameters -------------------------------------------------------
N = 6000000;        % Initial Population
%C0 = 16;            % Cumulative Cases (from WHO) - works well
%D0 = 5;             % Cumulative Deaths (from WHO) - works well
C0 = 147;          % Cumulative Cases (from our data) - doesn't work well
D0 = 34;           % Cumulative Deaths (from our data) - doesn't work well
E0 = 0;             % Initial Exposed 
Rec0 = 0;           % Initial Recovered 
I0 = C0-D0;         % Initial Infectives
S0 = N-I0-D0;    % Initial Suceptibles

f = estDeaths / estInfects;     % Fatality rate
avg_incub = 6;                  % Average number of days incubated
avg_infect = 6;                 % Average number of days infective
alpha = 1/avg_incub;            % Average duration of incubation
kappa = 1/avg_infect;           % Average duration of infectiousness
R0 = 1.5;                       % Reproductive number
beta = R0*alpha;                % Transmission rate
% beta = estInfects / I0;       % Transmission rate - good when I0 = 40ish
% R0 = beta/alpha;              % Reproductive number


%% ----- Solve the ODE ----------------------------------------------------
t0 = 50;                         % Starting day
tf = 360;                       % Final day
SIR0 = [S0 E0 I0 Rec0 C0 D0];   % Initial Conditions

[t,SIR] = ode45(@(t,SIR) SIRModel(t,SIR,N,beta,f,alpha,kappa), [t0, tf], SIR0);


%% ----- Plot -------------------------------------------------------------
% Clear previous plots
cla;

% Plot model 
plot(t,SIR(:,5),'g', t,SIR(:,6),'b')
hold on;

% Plot data
scatter(nat_long_data(:,1), nat_long_data(:,2), 'g');
hold on;
scatter(nat_long_data(:,1), nat_long_data(:,3), 'b');
hold on;
scatter(nat_short_data(:,1), nat_short_data(:,2), 'g');
hold on;
scatter(nat_short_data(:,1), nat_short_data(:,3), 'b');
hold on;

legend('Cases - SEIR', 'Deaths - SEIR', 'Cases - Data', 'Deaths - Data')
str = sprintf('R_0 = %d',R0);
title(str);