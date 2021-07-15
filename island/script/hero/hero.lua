require "script.util.keys"

-- Enum move state
local EMoveState = {
	Normal  = 0,
	Fall    = 1,
	Slide   = 2,
	Jump    = 3,
}

local hero ={}
hero.camera = nil
hero.moveSpeed = 3.5
hero.moveDir = vec3(0.0, 0.0, 0.0)
hero.moveState = EMoveState.Fall
hero.verticalSpeed = 0.0
hero.spine = nil

-- start
function hero:start()
	self.camera = self:getNode("main")
	self.spine = self:getNode("Spine")
	
	-- key down
	Object.connect(Input, "onKeyDown", self, "onKeyDown")
end

-- update
function hero:update()
	-- update movestate
	self:updateMoveState()
			
	-- move by key event
	self:moveByKeyEvent()
end

-- fire
function hero:fire()
	for i=0, self:getChildNum()-1 do
		local platform = self:getChildByIndex(i)
		local weapon = platform:getNode("weapon")
		
		weapon:fire(self.moveDir, self.moveSpeed)
	end
end

-- direction
function hero:setDir(inDir)
	if inDir ~= nil and inDir:length() > 0.5 then
		local fromDir = vec3(1.0, 0.0, 0.0)
		local toDir = inDir:normalize()
		local quat = quaternion.fromVec3ToVec3(fromDir, toDir)
		self:setLocalOrientation(quat)
	end
end

-- horizon dir
function hero:horizonDir(inDir)
	local dir = vec3(inDir.x, 0.0, inDir.z)
	return dir:normalize()
end

-- update move state
function hero:updateMoveState()
	local unitDir = vec3(0.0, -1.0, 0.0)
	local distance = self:getContactOffset()* 1.05
	if not self:sweep( unitDir, distance) then
		if self.verticalSpeed < 0.0 then
			self.moveState = EMoveState.Fall
		else
			self.moveState = EMoveState.Jump
		end
	else
		self.moveState = EMoveState.Normal
		self.verticalSpeed = 0.0
	end
end

-- move based on key event
function hero:moveByKeyEvent()
	-- camera dir
	local orient = self.camera:getWorldOrientation()
	
	-- direction
	local leftDir = orient:rotateVec3(vec3(1.0, 0.0, 0.0))
	local rightDir = orient:rotateVec3(vec3(-1.0, 0.0, 0.0))
	local forwardDir = orient:rotateVec3(vec3(0.0, 0.0, 1.0))
	local backDir = orient:rotateVec3(vec3(0.0, 0.0, -1.0))
	
	local moveDir = vec3(0.0, 0.0, 0.0)
	
	if Input:isKeyDown(Keys.A) then
		moveDir = moveDir + self:horizonDir(leftDir)
		
		-- face left
		self.spine:setLocalScaling(vec3(0.004, 0.004, 1.0))
	end
	if Input:isKeyDown(Keys.D) then
		moveDir = moveDir + self:horizonDir(rightDir)
		
		-- face right
		self.spine:setLocalScaling(vec3(-0.004, 0.004, 1.0))
	end
	if Input:isKeyDown(Keys.W) then
		moveDir = moveDir + self:horizonDir(forwardDir)
	end
	if Input:isKeyDown(Keys.S) then
		moveDir = moveDir + self:horizonDir(backDir)
	end

	if moveDir~=nil then
		self.moveDir = moveDir:normalize()
		
		local moveDistance = self.moveDir * self.moveSpeed * 0.035
		if self.moveState == EMoveState.Fall or self.moveState == EMoveState.Jump then
			local t = Engine:getFrameTime()
			local verticalDistance = self.verticalSpeed * t + 0.5 * (-9.8) * t * t
			moveDistance = moveDistance + vec3(0.0, verticalDistance, 0.0)
			
			-- update horizonal speed
			self.verticalSpeed = self.verticalSpeed + (-9.8) * t
		end

		self:move(moveDistance)
		
		-- play animation
		if moveDistance:length() > 0.01 then
			self.spine:playAnim("run", true)
		else
			self.spine:playAnim("idle", true)
		end
	end	
end

function hero:onKeyDown(key)
	if key == Keys.Space then	
		if self.moveState == EMoveState.Normal then
			-- jump
			Log:info("hero jump")
			self.verticalSpeed = 6.0
			
			-- move up a little
			self:move(vec(0.0, 0.1, 0.0))
		end
	end

	if key == Keys.F then
		self.spine:playAnim("attack", false)
	end

	Log:error(key)
	if key == Keys.Tab then
		self.camera:rotatePitchYaw(0.0, 90.0)
	end
end

return setmetatable(hero, Object)
