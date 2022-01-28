clear all
clearvars
clearvars -GLOBAL
% close all

% set(0,'DefaultFigureWindowStyle','docked')
% set(0,'defaultaxesfontsize',20)
% set(0,'defaultaxesfontname','Times New Roman')
% set(0,'DefaultLineLineWidth', 2);

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

% initialize electron position and velocity
% elecXPos = 0;
% elecVel = 1;

% initialize variables used to calculate the change in velocity and time
% prevVel = 0;
% currVel = 0;
% prevTime = 0;

% initialize variables used to calculate electron position
% prevPos = 0;
NumPart = 5;
currPos = zeros(NumPart,1);
currVel = linspace(1,NumPart,NumPart).';
accel = 1;

dt = 1;
Nt = 50;

% simulate 1 second
for n = 1:Nt %1:0:0.001:1
        currTime = n*dt;
        saveTime(n) = currTime;
    
%     F = 0.003; %N of force
    
%     currVel = elecVel; % store velocity before time step
    
    randVal = rand(NumPart,1);
    currVel = currVel + accel*dt; % calculate new velocity
    scatter = randVal<=0.5;
    currVel(scatter) = 0;
    
    saveVel(:,n) = currVel;
% prevVel = currVel; % update previous velocity
    
%     currPos = elecXPos; % store current position
    currPos = currPos + currVel*dt; % calculate new position
    savePos(:,n) = currPos;
%     prevPos = currPos; % update previous position
    
    % Create plots for position and velocity
    subplot(2,1,1)
    sLeg = {};
    for i=1:NumPart
        plot(saveTime,savePos(i,:),'-'); hold on
    end
    hold off
%     plot(currPos,'o')
    xlabel('time')
    ylabel('X Position')
    title('Electron Position over time')
%     axis([0,20,-inf,inf])
    
    subplot(2,1,2)
    for i = 1:NumPart
        plot(saveTime,saveVel(i,:), '-'); hold on
    end
    hold off
    xlabel('time')
    ylabel('Velocity')
    title('Electron Velocity over time')
%     axis([0,20,-inf,inf])
    
    sgtitle('Drift Velocity: ')
    
%     hold on
    pause(0.01)
    
end