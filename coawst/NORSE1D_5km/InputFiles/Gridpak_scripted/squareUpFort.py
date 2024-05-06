import numpy as np

file='fort.temp'

data=np.loadtxt(file,delimiter=',')

#print(data)
#print(data[0,0])
#print(data[0,1],data[1,1],data[2,1],data[3,1])
#print(data[0,0],data[1,0],data[2,0],data[3,0])

xCenter = (data[0,0]+data[1,0]+data[2,0]+data[3,0])/4
yCenter = (data[0,1]+data[1,1]+data[2,1]+data[3,1])/4

dataNew = data

dataNew[0,0] = xCenter - 12500
dataNew[1,0] = xCenter - 12500
dataNew[2,0] = xCenter + 12500  
dataNew[3,0] = xCenter + 12500

dataNew[0,1] = yCenter + 12500  
dataNew[1,1] = yCenter - 12500
dataNew[2,1] = yCenter - 12500
dataNew[3,1] = yCenter + 12500.00000001


#print(xCenter,yCenter)
#print(dataNew)

np.savetxt('fort.temp',dataNew,fmt='%12.10f',delimiter=' ')



#file.close()
