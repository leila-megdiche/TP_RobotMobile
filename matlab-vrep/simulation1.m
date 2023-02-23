vrep=remApi('remoteApi');
vrep.simxFinish(-1);
clientID=vrep.simxStart('127.0.0.1',19999,true,true,5000,5);
if (clientID>-1)
    disp('connected')
    [returnCode,left_motor]=vrep.simxGetObjectHandle (clientID,'Pioneer_p3dx_leftMotor',vrep.simx_opmode_blocking)
    [returnCode]=vrep.simxSetJointTargetVelocity(clientID,left_motor,3,vrep.simx_opmode_blocking)
    pause(5)
        [returnCode]=vrep.simxSetJointTargetVelocity(clientID,left_motor,0,vrep.simx_opmode_blocking)
vrep.simxFinish(-1);
end 
vrep.delete();