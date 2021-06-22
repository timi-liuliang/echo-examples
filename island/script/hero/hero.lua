-- Enum
local EMoveState = {
	Normal  = 0,
	Fall    = 1,
	Slide   = 2,
}

local object ={}
object.camera = nil
object.moveSpeed = 3.5
object.moveDir = vec3(0.0, 0.0, 0.0)
object.moveState = EMoveState.Normal
object.verticalSpeed = vec3(0.0, 0.0, 0.0)

-- start
function object:start()
	self.camera = self:getNode("main")
end

-- update
function object:update()
	-- update movestate
	self:updateMoveState()
			
	-- move by key event
	self:moveByKeyEvent()
end

-- fire
function object:fire()
	for i=0, self:getChildNum()-1 do
		local platform = self:getChildByIndex(i)
		local weapon = platform:getNode("weapon")
		
		weapon:fire(self.moveDir, self.moveSpeed)
	end
end

-- direction
function object:setDir(inDir)
	if inDir ~= nil and inDir:length() > 0.5 then
		local fromDir = vec3(1.0, 0.0, 0.0)
		local toDir = inDir:normalize()
		local quat = quaternion.fromVec3ToVec3(fromDir, toDir)
		self:setLocalOrientation(quat)
	end
end

-- horizon dir
function object:horizonDir(inDir)
	local dir = vec3(inDir.x, 0.0, inDir.z)
	return dir:normalize()
end

-- update move state
function object:updateMoveState()
	if not self:overlap() then
		self.moveState = EMoveState.Fall
		Log:error(EMoveState.Fall)
	else
		self.moveState = EMoveState.Normal
		self.verticalSpeed = vec3(0.0, 0.0, 0.0)
	end
end

-- move based on key event
function object:moveByKeyEvent()
	-- camera dir
	local orient = self.camera:getWorldOrientation()
	
	-- direction
	local leftDir = orient:rotateVec3(vec3(1.0, 0.0, 0.0))
	local rightDir = orient:rotateVec3(vec3(-1.0, 0.0, 0.0))
	local forwardDir = orient:rotateVec3(vec3(0.0, 0.0, 1.0))
	local backDir = orient:rotateVec3(vec3(0.0, 0.0, -1.0))
	
	local moveDir = vec3(0.0, 0.0, 0.0)
	
	if Input:isKeyDown(65) then
		moveDir = moveDir + self:horizonDir(leftDir)
	end
	if Input:isKeyDown(68) then
		moveDir = moveDir + self:horizonDir(rightDir)
	end
	if Input:isKeyDown(87) then
		moveDir = moveDir + self:horizonDir(forwardDir)
	end
	if Input:isKeyDown(83) then
		moveDir = moveDir + self:horizonDir(backDir)
	end

	if moveDir~=nil then
		self.moveDir = moveDir:normalize()
		
		local moveDistance = self.moveDir * self.moveSpeed * 0.035
		if self.moveState == EMoveState.Fall then
			local t = Engine:getFrameTime()
			moveDistance = moveDistance + self.verticalSpeed * t + 0.5 * vec3(0.0, -9.8, 0.0) * t * t
			
			-- update horizonal speed
			self.verticalSpeed = self.verticalSpeed + vec3(0.0, -9.8, 0.0) * t
		end

		self:move(moveDistance)
	end	
end

return setmetatable(object, Object)
