local object ={}

-- start
function object:start()
end

-- update
function object:update()
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
		local quat = quaternionx.fromVec3ToVec3(fromDir, toDir)
		self:setLocalOrientation(quat)
	end
end

return setmetatable(object, Object)
