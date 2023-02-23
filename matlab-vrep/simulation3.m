vrep=remApi('remoteApi');
vrep.simxFinish(-1);
clientID=vrep.simxStart('127.0.0.1',19999,true,true,5000,5);
if (clientID>-1)
    disp('connected')
    [returnCode,left_motor]=vrep.simxGetObjectHandle (clientID,'Pioneer_p3dx_leftMotor',vrep.simx_opmode_blocking);
    [returnCode,front_Sensor]=vrep.simxGetObjectHandle (clientID,'Pioneer_p3dx_ultrasonicSensor5',vrep.simx_opmode_blocking);
    [returnCode,camera]=vrep.simxGetObjectHandle (clientID,'Pioneer_p3dx_VisionSensor',vrep.simx_opmode_blocking);

    [returnCode]=vrep.simxSetJointTargetVelocity(clientID,left_motor,3,vrep.simx_opmode_blocking);
    [returnCode,detectionState,detectedPoint,~,~]=vrep.simxReadProximitySensor(clientID,front_Sensor,vrep.simx_opmode_streaming);
    [returnCode,resolution,image]=vrep.simxGetVisionSensorImage2(clientID,camera,0,vrep.simx_opmode_blocking);
    for i=1:50
      [returnCode,detectionState,detectedPoint,~,~]=vrep.simxReadProximitySensor(clientID,front_Sensor,vrep.simx_opmode_buffer);
      [returnCode,resolution,image]=vrep.simxGetVisionSensorImage2(clientID,camera,0,vrep.simx_opmode_buffer);
      imshow(image)
      disp(norm(detectedPoint));
      pause(0.1);
    end
  [returnCode]=vrep.simxSetJointTargetVelocity(clientID,left_motor,0,vrep.simx_opmode_blocking)
vrep.simxFinish(-1);
end 
vrep.delete();