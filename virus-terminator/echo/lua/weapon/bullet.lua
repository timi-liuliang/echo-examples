local object ={}
object.moveDir = vec3(0.0, 0.0, 0.0)
object.moveSpeed = 2.0
object.life = 3.5

-- start
function object:start()
end

-- update
function object:update()
	-- update position
	local curPos = self:getLocalPosition()
	curPos = curPos + self.moveDir * self.moveSpeed
	
	self:setLocalPosition(curPos)
	
	-- update life
	self:updateLife()
end

-- set move direction
function object:setMoveDir(moveDir)
	self.moveDir = moveDir:normalize()
end

-- update life
function object:updateLife()
	local elapsedTime = Engine:getFrameTime()
	self.life = self.life - elapsedTime
	if self.life <= 0.0 then
		self:queueFree()
	end
end

return setmetatable(object, Object)
