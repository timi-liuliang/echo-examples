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
	curPos.x = curPos.x + offset.x
	curPos.y = curPos.y + offset.y
	curPos.z = curPos.z + offset.z
	
	self:setLocalPosition(curPos)
end

return setmetatable(object, Object)
