local object ={}
object.moveSpeed = 1.8
object.target = nil

-- start
function object:start()
end

-- update
function object:update()
	-- set target
	self:initTarget()
	
	if self.target~= nil then	
		local targetPos = self.target:getWorldPosition()
		local curPos = self:getWorldPosition()
		local dirWithLen = targetPos - curPos
		if dirWithLen:length() > 3.0 then
			local nextPos = curPos + dirWithLen:normalize() * self.moveSpeed
			self:setWorldPosition(nextPos)
			self:syncTransformTob2Body()
		else
			self:queueFree()
		end
	end
end

-- init target
function object:initTarget()
	if self.target == nil then
		self.target = self:getNode("/root/hero")	
	end
end

function object:beginContact()
	self:queueFree()
end

return setmetatable(object, Object)
