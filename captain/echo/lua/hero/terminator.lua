local object ={}
object.moveSpeed = 100.0
object.moveDir = vec3(0.0, 0.0, 0.0)
object.bullets = nil

-- start
function object:start()
	self.bullets = self:getNode("/root/bullets")
end

-- update
function object:update()	
	-- move by key event
	self:moveByKeyEvent()
end

-- fire
function object:fire()
	for i=0, self:getChildNum()-1 do
		local platform = self:getChildByIndex(i)
		local weapon = platform:getNode("weapon")
		
		weapon:fire(self.moveDir, self.moveSpeed)
	end
end

-- move
function object:move(moveDir)
	if moveDir~=nil then
		self.moveDir = moveDir:normalize()	
		self:setLinearVelocity(self.moveDir * self.moveSpeed)
	end	
end

-- direction
function object:setDir(inDir)
	if inDir ~= nil and inDir:length() > 0.5 then
		local fromDir = vec3(1.0, 0.0, 0.0)
		local toDir = inDir:normalize()
		local quat = quaternion.fromVec3ToVec3(fromDir, toDir)
		self:setLocalOrientation(quat)
	end
end

-- move based on key event
function object:moveByKeyEvent()
	-- direction
	local leftDir = vec3(-1.0, 0.0, 0.0)
	local rightDir = vec3(1.0, 0.0, 0.0)
	local upDir = vec3(0.0, 1.0, 0.0)
	local downDir = vec3(0.0, -1.0, 0.0)
	
	local moveDir = vec3(0.0, 0.0, 0.0)
	
	if Input:isKeyDown(65) then
		moveDir = moveDir + leftDir
	end
	if Input:isKeyDown(68) then
		moveDir = moveDir + rightDir
	end
	if Input:isKeyDown(87) then
		moveDir = moveDir + upDir
	end
	if Input:isKeyDown(83) then
		moveDir = moveDir + downDir
	end

	self:move(moveDir)
end

return setmetatable(object, Object)
