clear all
clearvars
clearvars -GLOBAL
close all

%% Questions to ask TA
% Plots are created after position and velocities have been updated so they
% don't show t = 0
% Do velocity and position numbers look reasonable?

% set(0,'DefaultFigureWindowStyle','docked')
% set(0,'defaultaxesfontsize',20)
% set(0,'defaultaxesfontname','Times New Roman')
% set(0,'DefaultLineLineWidth', 2);

%% Global Constants

global C

C.q_0 = 1.60217653e-19;             % electron charge
C.hb = 1.054571596e-34;             % Dirac constant
C.h = C.hb * 2 * pi;                % Planck constant
C.m_0 = 9.10938215e-31;             % electron mass
C.kb = 1.3806504e-23;               % Boltzmann constant
C.eps_0 = 8.854187817e-12;          % vacuum permittivity
C.mu_0 = 1.2566370614e-6;           % vacuum permeability
C.c = 299792458;                    % speed of light
C.g = 9.80665;                      % metres (32.1740 ft) per s²

%% initialize variables used to calculate electron position
NumPart = 5;
currPos = zeros(NumPart,1);
currVel = zeros(1,NumPart).';

% Assume electric field of 0.01F
F = 0.01*C.q_0; % force of E-field
accel = F/C.m_0; % from Newton's law: a = F/m

dt = 1; % time step
Nt = 101; % number of time steps

%% simulate 0.01 second
for n = 1:Nt
    
    %% Update time
    currTime = n*dt;
    saveTime(n) = currTime;
    
    %% Velocity
    randVal = rand(NumPart,1); % assign scatter probability
    currVel = currVel + accel*dt; % calculate new velocity
    scatter = randVal<=0.05; % scatter if rand <= 0.05 (probability of scatter)
    
    % scattering rules
    currVel(scatter) = 0;
%     currVel(scatter) = currVel(scatter)*-0.25;
%     currVel(scatter) = -currVel(scatter);
%     currVel(scatter) = 2*currVel(scatter);

    saveVel(:,n) = currVel;
    
    % Drift velocity calc
    velSum = sum(saveVel);
    driftVel = velSum(n)/NumPart;
    
    %% Position
    currPos = currPos + currVel*dt; % calculate new position
    savePos(:,n) = currPos;
    
    %% Create plots for position and velocity
    subplot(2,1,1)
    sLeg = {};
    for i=1:NumPart
        plot(saveTime,savePos(i,:),'-'); hold on
    end
    hold off
    xlabel('Time (ms)')
    ylabel('X Position (m)')
    title('Electron Position over time (for 0.1s)')
    
    subplot(2,1,2)
    for i = 1:NumPart
        plot(saveTime,saveVel(i,:), '-'); hold on
    end
    hold off
    xlabel('Time (ms)')
    ylabel('Velocity (m/s)')
    title('Electron Velocity over time (for 0.1s), drift velocity (m/s): ', driftVel)
    
    pause(0.01)
    
end