% I have daily temperatures for one river for about 1 year that isn't the
% one I'm working on. It will have to function as a proxy.

% The problem is that the add_temp.py is hardwired for 2 vectors:
%       vector 1 is the day number
%       vector 2 is the temperature for that day number
% and I don't want to copy paste a line 366 numbers long into the script

% Kate set it up so that you use monthly averages for these day numbers (leap year):

% dayN = [0 46 76 107 137 167 198 228 259 289 320 366]

% I think I like this better:

% dayN   = [1 16 46 76 107 137 167 198 228 259 289 320 351 366];
dayN   = [16 45 76 106 137 167 198 229 259];  % Jun thru Sept 2020 is all I've got
Tmean = 0*dayN;


%% Calculate monthly means

for nn = 1:length(dayN)
    
    ['grep 2020-0',num2str(nn),' Tdata_ORIG/temp_Taunton.TXT | cut -d "," -f5 > TForAMonth.txt'];
    unix(ans)';
    temp = importdata('TForAMonth.txt')';
    [nn length(temp)]
    Tmean(nn) = sum(temp)/length(temp);
    
end;

Tmean



