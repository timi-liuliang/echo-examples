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
	if inDir ~= nil then
		local dir = inDir:normalize()
		local quat = quaternionx.fromVec3ToVec3(vec3(1.0, 0.0, 0.0), dir)
		self:setLocalOrientation(quat)
	end
end

return setmetatable(object, Object)
