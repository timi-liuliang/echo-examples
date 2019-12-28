local object ={}

-- direction
object.leftDir = vec3(-1.0, 0.0, 0.0)
object.rightDir = vec3(1.0, 0.0, 0.0)
object.upDir = vec3(0.0, 1.0, 0.0)
object.downDir = vec3(0.0, -1.0, 0.0)

-- start
function object:start()
end

-- update
function object:update()
	if Input:isKeyDown(65) then
		self:move(self.leftDir)
	end
	if Input:isKeyDown(68) then
		self:move(self.rightDir)
	end
	if Input:isKeyDown(87) then
		self:move(self.upDir)
	end
	if Input:isKeyDown(83) then
		self:move(self.downDir)
	end
end

-- move
function object:move(offset)
	local curPos = self:getLocalPosition()
	curPos = curPos + offset
	
	self:setLocalPosition(curPos)
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

return setmetatable(object, Object)
