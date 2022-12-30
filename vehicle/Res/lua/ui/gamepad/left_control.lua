require "lua.util.keys"

local object ={}

object.bg = nil
object.ball =nil
object.clickPos = nil
object.car = nil
object.isMoveing = false
object.moveDir = nil

-- start
function object:start()
	self.bg = self:getNode("bg")
	self.ball = self:getNode("bg/ball")
	self.car = self:getNode("/root/car")
end

-- update
function object:update()
	local steer = 0.0
		
	--Input:isKeyDown(Keys.A)
	if self.isMoveing or Input:isKeyDown(Keys.A) then	
		-- turn left
		steer = 1.0
	end
	if Input:isKeyDown(Keys.D) then	
		-- trun right
		steer = -1.0
	end

	self.car:setSteer(steer)
end

-- on click region
function object:onMouseButtonDown_left()
	-- change bg position
	local event = self:getMouseEvent()
	
	self.clickPos = event:getLocalPosition()
	self.bg:setLocalPosition(self.clickPos)
	
	self.isMoveing = true
end

-- on mouse moved
function object:onMouseButtonMove_left()
	if Input:isMouseButtonDown(0) then
		-- change ball position
		local event = self:getMouseEvent()
	
		local curPos = event:getLocalPosition()	
		local offset = curPos - self.clickPos	
		
		-- move terminator
		if offset:length() > 3.0 then
			self.moveDir = offset:normalize()
		end
		
		-- modify ball position
		if offset:length() > 70.0 then
			offset = offset:normalize() * 70.0			
		end
		self.ball:setLocalPosition(offset)
	end
end

-- on mouse up
function object:onMouseButtonUp_left()
	local zeroPosition = vec3(0.0, 0.0, 0.0)
	self.bg:setLocalPosition(zeroPosition)
	self.ball:setLocalPosition(zeroPosition)

	self.isMoveing = false
	self.moveDir = vec3(0.0, 0.0, 0.0)
end

function object:onMouseButtonLeave()
	self:onMouseButtonUp_left()
end

return setmetatable(object, Node)
