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

return setmetatable(object, Object)
