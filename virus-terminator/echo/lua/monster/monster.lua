local object ={}
object.elapsedTime = 0.0

-- start
function object:start()
end

-- update
function object:update()
	self.elapsedTime = self.elapsedTime + Engine:getFrameTime()
	if self.elapsedTime > 5.0 then
		self:spawnMonster()
		
		self.elapsedTime = 0.0
	end
end

-- spawn monster
function object:spawnMonster()
	local newMonster = Node.load("Res://scene/monster/monster_a.scene")
	if newMonster ~= nil then
		newMonster:setWorldPosition(self:getWorldPosition())
		newMonster:setParent(self)
	end
end

return setmetatable(object, Object)
