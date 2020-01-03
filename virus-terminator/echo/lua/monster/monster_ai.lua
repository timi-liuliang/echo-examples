local object ={}
object.moveSpeed = 1.8
object.target = nil

-- start
function object:start()
	-- set target
	self.target = self:getNode("/root/hero")
end

-- update
function object:update()
	local targetPos = self.target:getWorldPosition()
	local curPos = self:getWorldPosition()
	local dirWithLen = targetPos - curPos
	if dirWithLen:length() > 3.0 then
		local nextPos = curPos + dirWithLen:normalize() * self.moveSpeed
		self:setWorldPosition(nextPos)
	else
		self:queueFree()
	end	
end

return setmetatable(object, Object)
