clear;

% I have gamed the NORSELBE grids so that they are perfectly rectilinear in
% x and y, which means I can do the telescoping as vectors in x and y
% without worrying about accounting for some tilt angle.

% The IC/BC source data is coming from CMEMS and at ~75N I'm seeing:
%   delta_lat = 1/12 deg ~ 9.25 km
%   delta_lon = 1/12 deg ~ (9.25 km) * cos (75 deg) ~ 2.4 km

%% Size the core area
% Take the x/y corners from the NORSELBE_6km grid and pull them in 50 km.
xPsiMin =   62558.1094 + 50000; 
xPsiMax =  560558.1094 - 50000;	
yPsiMin = -2522805.25  + 50000;  
yPsiMax = -2078805.25  - 50000; 

% 2 km interior grid

gridInterval = 1000;

Lm = (xPsiMax - xPsiMin)/gridInterval;
Mm = (yPsiMax - yPsiMin)/gridInterval;

% Double check
(yPsiMax - yPsiMin)/Mm;
(xPsiMax - xPsiMin)/Lm;

xCore = [xPsiMin:gridInterval:xPsiMax];
yCore = [yPsiMin:gridInterval:yPsiMax];

aaa=5;

%% Diffs

% The longitude source data interval is about 2.4 km, which was close enough 
% to the 2km inner grid to ignore but not close enough to the 1km that this 
% new grid has. The latitude source data interval is
% 9.25 degree so will get some telescoping. I have calculated the best
% number of telescoping points and the constant, C, using MMA

[1000:916.667:9250];
myDiffsY = ans(2:end);

[1000:48.0716:2400];
myDiffsX = ans(2:end);


% x direction is easy in this particular case
fullX =[ xPsiMin - fliplr(cumsum(myDiffsX))    xCore    xPsiMax+cumsum(myDiffsX)   ]
fig(1);clf;plot(diff(fullX));title('diff(x)')
fig(2);clf;plot(fullX);title('x values')


% y direction only
fullY =[ yPsiMin - fliplr(cumsum(myDiffsY))    yCore    yPsiMax+cumsum(myDiffsY)   ]
fig(3);clf;plot(diff(fullY));title('diff(y)')
fig(4);clf;plot(fullY);title('y values')



%% Create the sqgrid.in file

% the data write begins in the upper left corner, runs counterclockwise
% until you get back (almost) to the starting point.


nx=length(fullX); ny=length(fullY);

%
dumWest = zeros(ny,2);
for jj=1:ny
    dumWest(jj,2) = fullY(ny-jj+1);
    dumWest(jj,1) = fullX(1);
end


dumSouth = zeros(nx,2);
for ii=1:nx
    dumSouth(ii,2) = fullY(1);
    dumSouth(ii,1) = fullX(ii);
end

dumEast = zeros(ny,2);
for jj=1:ny
    dumEast(jj,2) = fullY(jj);
    dumEast(jj,1) = fullX(end);
end

dumNorth = zeros(nx,2);
for ii=1:nx
    dumNorth(ii,2) = fullY(end);
    dumNorth(ii,1) = fullX(nx-ii+1);
end


%%
coast = vertcat(dumWest,dumSouth,dumEast,dumNorth);

['Include/gridparam.h:  Lm=',num2str(nx-1),'   Mm=',num2str(ny-1)]

['The numbers that go in the coast.in file are ',num2str(nx),' and ',num2str(ny)]

save('west.in','dumWest','-ascii')
save('east.in','dumEast','-ascii')
save('north.in','dumNorth','-ascii')
save('south.in','dumSouth','-ascii')



%% Plot perimeter


fig(10);clf;

plot(dumWest(:,2),dumWest(:,1),'r' );hold on
plot(dumSouth(:,2),dumSouth(:,1),'g' );
plot(dumEast(:,2),dumEast(:,1),'b' );
plot(dumNorth(:,2),dumNorth(:,1),'k' );


