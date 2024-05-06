clear all

    tmp=load('./freya_nors23_tbdGRIDDED.mat')
    Pi = tmp.freya(1).prsHALFMETER
    NT = length(tmp.freya);
 
    for ii = 1:NT
        freya_hr.dnum0(ii)  = nanmean(tmp.freya(ii).tim);
        freya_hr.lon0(ii)   = nanmean(tmp.freya(ii).lonHALFMETER);
        freya_hr.lat0(ii)   = nanmean(tmp.freya(ii).latHALFMETER);
        freya_hr.T    (:,ii) = tmp.freya(ii).temHALFMETER;
        freya_hr.S    (:,ii) = tmp.freya(ii).salHALFMETER;
    end
whos Pi dnum T;skip=10;
t0 = min(tmp.tim);t0 = max(tmp.tim);
freya_hr.Pi = Pi;clear Pi tmp tdx* t0* t1* ii skip dnum* lon0 lat0 NT D* S T P
whos
