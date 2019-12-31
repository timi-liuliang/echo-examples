local object ={}
object.moveDir = vec3(0.0, 0.0, 0.0)
object.moveSpeed = 2.0
object.life = 5.0

-- start
function object:start()
end

-- update
function object:update()
	local curPos = self:getLocalPosition()
	curPos = curPos + self.moveDir * self.moveSpeed
	
	self:setLocalPosition(curPos)
end

-- set move direction
function object:setMoveDir(moveDir)
	self.moveDir = moveDir:normalize()
end

return setmetatable(object, Object)
