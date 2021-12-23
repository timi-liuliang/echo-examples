local object ={}
object.moveSpeed = 150.0
object.target = nil
object.blood  = 5

-- start
function object:start()
end

-- update
function object:update()
	if self.blood <= 0 then
		self:queueFree()
	end
	
	-- set target
	self:initTarget()
	
	if self.target~= nil then	
		local targetPos = self.target:getWorldPosition()
		local curPos = self:getWorldPosition()
		local dirWithLen = targetPos - curPos
		if dirWithLen:length() > 3.0 then
			local velocity = dirWithLen:normalize() * self.moveSpeed
			self:setLinearVelocity(velocity)
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
	--self.blood = 0
end

return setmetatable(object, Object)
