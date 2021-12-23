local object ={}
object.hero = nil
object.bullets = nil
object.cd = require("lua/util/cd"):new()
object.cdKey = nil

-- start
function object:start()
	self.cdKey = self:getParent():getName()
	self.cd:add(self.cdKey, 1.2)
	
	self.bullets = self:getNode("/root/bullets")
end

-- update
function object:update()
	-- frame time
	local elapsedTime = Engine:getFrameTime()
	
	self.cd:update(elapsedTime)
end

-- fire
function object:fire(initMoveDir, initMoveSpeed)
	if self.cd:isReady(self.cdKey) then
		local newBullet = Node.load("Res://scene/bullet/bullet_a.scene")
		if newBullet ~= nil then
			newBullet:setWorldPosition(self:getWorldPosition())
			newBullet:setParent(self.bullets)
			newBullet:setInitMoveState(initMoveDir, initMoveSpeed * 0.3)
		
			local orient = self:getWorldOrientation()
			local faceDir = orient:rotateVec3(vec3(0.0, 1.0, 0.0))
			newBullet:setMoveDir(faceDir)
		end

		self.cd:reset(self.cdKey)
	end
end

return setmetatable(object, Object)
