function dSIR = SIRModel(t,SIR,N,beta,f,alpha,kappa)
%in place of quarantine we lower R0 over time. 
%preventative measures were taken after about 110-120 days

if (t>110 && t < 120)
    R0 = .9;                      % Reproductive number
    beta = R0*alpha; 
elseif (t>120 && t< 140)
    
    R0 = .8;                      % Reproductive number
    beta = R0*alpha; 
elseif (t>140)
    
    R0 = .6;                      % Reproductive number
    beta = R0*alpha; 
end

%% ----- System of ODEs ---------------------------------------------------
dSIR(1) = -beta*SIR(3)*SIR(1)./N;                % S
dSIR(2) = beta*SIR(3)*SIR(1)./N-alpha*SIR(2);    % E
dSIR(3) = alpha*SIR(2)-kappa*SIR(3);             % I
dSIR(4) = (1-f)*kappa*SIR(3);                    % R
dSIR(5) = alpha*SIR(2);                          % C (Cumulative cases)
dSIR(6) = f*kappa*SIR(3);                        % D
dSIR = [dSIR(1) dSIR(2) dSIR(3) dSIR(4) dSIR(5) dSIR(6)]';