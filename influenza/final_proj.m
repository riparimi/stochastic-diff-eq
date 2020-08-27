%% Load Influenza Data
flu = readtable("real.csv");

%% Put into Week / Data
flu = fillmissing(flu, 'constant', 0, 'DataVariables',@isnumeric);
% start = 396; 2012 season
start = 291; % 2011 season
ending = 813;


weeks = table2array(flu(start:end,3));
fluA = table2array(flu(start:end,6)) + table2array(flu(start:end,8)) + table2array(flu(start:end,10)) ...
            + table2array(flu(start:end,12));

%% Break into Months
lenWeeks = ceil((ending-start+1)/4);
fluByMonth = zeros(1, lenWeeks);
for i=1:length(fluA)
    ind = floor((i-1)/4) + 1;
    fluByMonth(ind) = fluByMonth(ind) + fluA(i);
end
fluByMonth = fluByMonth';
%% Plot Influenza A Data
y = fcast(fluByMonth, [(lenWeeks-26) lenWeeks]);
f = figure;
plot(fluByMonth);
hold on;
plot(y);
xlabel("'Months' Beginning at 'Month' 7 of 2010");
ylabel("Positive Influenza A Cases");
title("Influenza A over Time");
legend(["2018-2020 Flu Seasons" "2010-2018 Flu Seasons"]);

%% Use arspec to find Harmonics
f = figure;
arspec(fluByMonth);

%% Use dhropt to actually do stuff

% We will use a trend component and 3 harmonics.
P=[(13)./(1:3)];

% All of the parameters will be modelled with
% an Integrated Random Walk (IRW).
% TVP=[1 0];
TVP = 1;
 
% The order of the AR spectrum is specified below.
nar=12;

% ESTIMATING HYPER-PARAMETERS : PLEASE WAIT
 
%nvr=dhropt(y, P, TVP, nar, -2,  -2);
nvr=dhropt(y, P, TVP, nar);

%% Actually use DHR

% The DHR function utilises the optimsed NVR values.
[fit, fitse, trend, trendse, comp]=dhr(y, P, TVP, nvr);
 
% The trend identifies the business cycle.
f = figure;
plot([trend(:, 1) fluByMonth])
set(gca, 'xlim', [0 length(fluByMonth)])
xlabel("Months");
ylabel("Positive Influenza A Cases");
title('Data and trend')

%% Seasonal Comp?
% The seasonal component increases over time.
 
f = figure;
plot(sum(comp'))
set(gca, 'xlim', [0 length(fluByMonth)])
xlabel("Months");
ylabel("Seasonal Component");
title('Total seasonal component')

%% Predict
% The functions successfully interpolate over the 10 months
% of missing data starting at sample 85. Similarly, they predict
% the output for the final year, i.e. sample 132 until the end
% of the series. Note that since missing data were introduced at
% the start of the analysis, the latter is a 'true' forecast.
 
f = figure;
plot(fit, 'b')
hold on
plot(fluByMonth, 'r')
plot([fit-fluByMonth zeros(lenWeeks, 1)], 'g')
plot([lenWeeks-26, lenWeeks-26], [-50 50], 'p')  % forecasting horizon
set(gca, 'xlim', [0 length(fluByMonth)])
xlabel("Months");
ylabel("Positive Influenza A Cases");
title('Data, Fit and Residuals')
legend(["DHR fit" "Data" "Error"])

%% Confidence Bands
f=figure;
tf = (105 : 131)';
bands = [fit(tf)+2*fitse(tf) fit(tf)-2*fitse(tf)]; % Confidence bands
plot(1:lenWeeks, [fluByMonth fit trend(:, 1)], tf, bands, ':'); 

%% Irregularity
f=figure;
plot([fluByMonth(1:104)-fit(1:104)]);
title("Irregularity");
xlabel("Months")



%%
% A zoomed in view of the final two years are shown, with
% the standard errors and forecasting horizon also indicated.
 
f = figure;
plot(fit, 'b')
hold on
plot(fluByMonth, 'ro')
plot([fit+2*fitse fit-2*fitse], ':b')
plot([lenWeeks-26, lenWeeks-26], [200 700], 'r')  % forecasting horizon
axis([lenWeeks-26 length(fit) 250 700])
title('Data (o), fit and standard errors')




