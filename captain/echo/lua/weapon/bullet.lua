local object ={}
object.initDir = vec3(0.0, 0.0, 0.0)
object.initSpeed = 0.0
object.moveDir = vec3(0.0, 0.0, 0.0)
object.moveSpeed = 350.0
object.life = 3.5

-- start
function object:start()
end

-- update
function object:update()
	-- update position
	local finalLinearVelocity = self.initDir * self.initSpeed + self.moveDir * self.moveSpeed
	self:setLinearVelocity(finalLinearVelocity)
	
	-- update life
	self:updateLife()
end

-- set init move state
function object:setInitMoveState(dir, speed)
	self.initDir = dir:normalize()
	self.initSpeed = speed
end

-- set move direction
function object:setMoveDir(moveDir)
	self.moveDir = moveDir:normalize()
	
	-- orientation
	local orient = quaternion.fromVec3ToVec3(vec3(1.0, 0.0, 0.0), self.moveDir)
	self:setLocalOrientation(orient)	
end

-- update life
function object:updateLife()
	local elapsedTime = Engine:getFrameTime()
	self.life = self.life - elapsedTime
	if self.life <= 0.0 then
		self:queueFree()
	end
end

-- begin contact
function object:beginContact()
	self:queueFree()
end

return setmetatable(object, Object)
