close all
tabwindow;

% This'll take about 6 minutes for 6 day's worth of DOPPIO data


newDir = 'DOPPIO_modified/';

% unix(['\rm ',newDir,'doppio*.nc'])

files = dir([newDir,'doppio*.nc']);

nFiles = length(files);
nIterations = 1 ;

tic
for ff = 1:nFiles

    myFile = files(ff).name
    
    %% zeta
    myVar  = 'zeta';
    myMask = 'mask_rho';
    var  = nc_varget([newDir,myFile],myVar);
    mask = nc_varget([newDir,myFile],myMask);
    %fig(1);clf;pcolor(mask);shading flat;colorbar
    %fig(2);clf;pcolor(sq(var(1,:,:)));shading flat;colorbar;title(myVar);
    [nt,ny,nx] = size(var);   
    for nn=1:nIterations
        for tt=1:nt
            dum1 = var;
            for ii=2:nx-1; for jj=2:ny-1
                if mask(jj,ii) == 0
                    var(tt,jj-1:jj+1,ii-1:ii+1);
                    var(tt,jj,ii) = nanmean(ans(:));
                end;
            end;end;    
%         var = dum1;
        end
    end;
      
    %fig(3);clf;pcolor(sq(var(1,:,:)));shading flat;colorbar;title(myVar);
%     container = zeros(1,ny,nx);
%     container(1,:,:) = var;
    nc_varput([newDir,myFile],myVar,var) 
%     nc_varput([newDir,myFile],myMask,1+0*mask) 
        
    %% ubar
    
    myVar  = 'ubar_eastward';
    myMask = 'mask_rho';  % Fucking weird
    var  = nc_varget([newDir,myFile],myVar);
%     mask = nc_varget([newDir,myFile],myMask);
    %fig(2);clf;pcolor(sq(var(1,:,:)));shading flat;colorbar;title(myVar);
    [nt,ny,nx] = size(var);  
    for tt=1:nt
            for nn=1:nIterations
            dum1 = var;
            for ii=2:nx-1; for jj=2:ny-1
                if mask(jj,ii) == 0
                    var(tt,jj-1:jj+1,ii-1:ii+1);
                    var(tt,jj,ii) = nanmean(ans(:));
                end;
            end;end; 
        end;
    end;
        
    %fig(3);clf;pcolor(sq(var(1,:,:)));shading flat;colorbar;title(myVar);

    nc_varput([newDir,myFile],myVar,var) 
%     nc_varput([newDir,myFile],myMask,1+0*mask)
        
    %% vbar
    myVar  = 'vbar_northward';
    myMask = 'mask_rho';  % Fucking weird
    var  = nc_varget([newDir,myFile],myVar);
%     %fig(1);clf;pcolor(mask);shading flat;colorbar
    %fig(2);clf;pcolor(sq(var(1,:,:)));shading flat;colorbar;title(myVar);
    [nt,ny,nx] = size(var);    
    for tt=1:nt
        for nn=1:nIterations
            dum1 = var;
            for ii=2:nx-1; for jj=2:ny-1
                if mask(jj,ii) == 0
                    var(tt,jj-1:jj+1,ii-1:ii+1);
                    var(tt,jj,ii) = nanmean(ans(:));
                end;
            end;end; 
        end;
    end;
    
    %fig(3);clf;pcolor(sq(var(1,:,:)));shading flat;colorbar;title(myVar);
    nc_varput([newDir,myFile],myVar,var) 
%     nc_varput([newDir,myFile],myMask,1+0*mask)
    
    %% temp
    myVar  = 'temp';
    myMask = 'mask_rho';
    var  = nc_varget([newDir,myFile],myVar);
%     mask = nc_varget([newDir,myFile],myMask);
%     %fig(1);clf;pcolor(mask);shading flat;colorbar
    %fig(2);clf;pcolor(sq(var(1,end,:,:)));shading flat;colorbar;title(myVar);
    [nt,nz,ny,nx] = size(var);  
    for tt=1:nt
        for nn=1:nIterations
            dum1 = var;
            for ii=2:nx-1; for jj=2:ny-1; for kk=1:nz
                if mask(jj,ii) == 0
                    var(tt,kk,jj-1:jj+1,ii-1:ii+1);
                    var(tt,kk,jj,ii) = nanmean(ans(:));
                end;
            end;end;end;  
        end;
    end;
    
    
    %fig(3);clf;pcolor(sq(var(1,end,:,:)));shading flat;colorbar;title(myVar);
    nc_varput([newDir,myFile],myVar,var)
%     nc_varput([newDir,myFile],myMask,1+0*mask) 
    
    %% salt
    myVar  = 'salt';
    myMask = 'mask_rho';
    var  = nc_varget([newDir,myFile],myVar);
%     mask = nc_varget([newDir,myFile],myMask);
%     %fig(1);clf;pcolor(mask);shading flat;colorbar
    %fig(2);clf;pcolor(sq(var(1,end,:,:)));shading flat;colorbar;title(myVar);
    [nt,nz,ny,nx] = size(var);   
    for tt=1:nt
        for nn=1:nIterations
            dum1 = var;
            for ii=2:nx-1; for jj=2:ny-1; for kk=1:nz
                if mask(jj,ii) == 0
                    var(tt,kk,jj-1:jj+1,ii-1:ii+1);
                    var(tt,kk,jj,ii) = nanmean(ans(:));
                end;
            end;end;end;    
        end;
    end;  
    
    %fig(3);clf;pcolor(sq(var(1,end,:,:)));shading flat;colorbar;title(myVar);
    nc_varput([newDir,myFile],myVar,var)
%     nc_varput([newDir,myFile],myMask,1+0*mask) 
        
    %% u
    myVar  = 'u_eastward';
    myMask = 'mask_rho';  % Fucking weird
    var  = nc_varget([newDir,myFile],myVar);
%     mask = nc_varget([newDir,myFile],myMask);
%     %fig(1);clf;pcolor(mask);shading flat;colorbar
    %fig(2);clf;pcolor(sq(var(1,end,:,:)));shading flat;colorbar;title(myVar);
    [nt,nz,ny,nx] = size(var);
    for tt=1:nt
        for nn=1:nIterations
            dum1 = var;
            for ii=2:nx-1; for jj=2:ny-1; for kk=1:nz
                if mask(jj,ii) == 0
                    var(tt,kk,jj-1:jj+1,ii-1:ii+1);
                    var(tt,kk,jj,ii) = nanmean(ans(:));
                end;
            end;end;end;    
        end;
    end;
    
    %fig(3);clf;pcolor(sq(var(1,end,:,:)));shading flat;colorbar;title(myVar);
    nc_varput([newDir,myFile],myVar,var) 
%     nc_varput([newDir,myFile],myMask,1+0*mask)
          
    %% v
    myFile = files(ff).name;
    myVar  = 'v_northward';
    myMask = 'mask_rho';  % Fucking weird
    var  = nc_varget([newDir,myFile],myVar);
%     mask = nc_varget([newDir,myFile],myMask);
%     %fig(1);clf;pcolor(mask);shading flat;colorbar
    %fig(2);clf;pcolor(sq(var(1,end,:,:)));shading flat;colorbar;title(myVar);
    [nt,nz,ny,nx] = size(var); 
    for tt=1:nt
        for nn=1:nIterations
            dum1 = var;
            for ii=2:nx-1; for jj=2:ny-1; for kk=1:nz
                if mask(jj,ii) == 0
                    var(tt,kk,jj-1:jj+1,ii-1:ii+1);
                    var(tt,kk,jj,ii) = nanmean(ans(:));
                end;
            end;end;end;    
        end;
    end;
    

    
    
    %fig(3);clf;pcolor(sq(var(1,end,:,:)));shading flat;colorbar;title(myVar);
    nc_varput([newDir,myFile],myVar,var) 
    nc_varput([newDir,myFile],myMask,1+0*mask)
    
end;
toc
