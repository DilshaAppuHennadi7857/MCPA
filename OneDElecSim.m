clear all
clearvars
clearvars -GLOBAL
close all

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
Nt = 100; % number of time steps

%% simulate 0.1 second
for n = 0:Nt
    
    %% Update time
    currTime = n*dt;
    saveTime(n+1) = currTime;
    
    %% Velocity
    if n > 0 % update velocity after time = 0
        
        randVal = rand(NumPart,1); % assign scatter probability
        currVel = currVel + accel*(dt/1000); % calculate new velocity
        scatter = randVal<=0.05; % scatter if rand <= 0.05 (probability of scatter)

        % scattering rules
        currVel(scatter) = 0;
    %     currVel(scatter) = currVel(scatter)*-0.25;
    %     currVel(scatter) = -currVel(scatter);
    %     currVel(scatter) = 2*currVel(scatter);

    end

    saveVel(:,n+1) = currVel;
    
    % Drift velocity calc
    velSum = sum(saveVel);
    driftVel = velSum(n+1)/NumPart;
    
    %% Position
    
    if n > 0 % update position after time = 0
        
        currPos = currPos + currVel*(dt/1000); % calculate new position
        
    end
    savePos(:,n+1) = currPos;
    
    %% Create plots for position and velocity
    subplot(2,1,1)
    sLeg = {};
    for i=1:NumPart
        plot(saveTime,savePos(i,:),'-'); hold on
    end
    hold off
    xlabel('Time (ms)')
    ylabel('X Position (m)')
    title('Electron Position')
    
    subplot(2,1,2)
    for i = 1:NumPart
        plot(saveTime,saveVel(i,:), '-'); hold on
    end
    hold off
    xlabel('Time (ms)')
    ylabel('Velocity (m/s)')
    title('Electron Velocity, drift velocity (m/s): ', driftVel)
    
    sgtitle('Electron Movement Over 0.1s')
    
    pause(0.01)
    
end