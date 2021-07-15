local object ={}

object.lookAtPosition = nil
object.length = 10.0
object.pitch = 45.0
object.pitchSpeed = 0.3
object.yaw = 45.0
object.yawSpeed = 0.7
object.currentDir = vec3(0.0, 0.0, 1.0)

-- start
function object:start()
end

-- update
function object:update()
	self.lookAtPosition = self:getParent():getWorldPosition()
	
	local quat = quaternion.fromPitchYawRoll(self.pitch, self.yaw, 0.0)
	self:setWorldOrientation(quat)
	
	self.currentDir = quat:rotateVec3(vec3(0.0, 0.0, 1.0))
	local position = self.lookAtPosition - self.currentDir * self.length
	self:setWorldPosition(position)
end

function object:rotatePitchYaw(pitchDelta, yawDelta)
	self.pitch = math.clamp(self.pitch - pitchDelta * self.pitchSpeed, -89.0, 89.0)
	self.yaw = self.yaw - yawDelta * self.pitchSpeed
end

return setmetatable(object, Object)
