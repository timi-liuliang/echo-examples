local object ={}

object.bg = nil
object.ball =nil
object.clickPos = nil
object.terminator = nil

-- start
function object:start()
	self.bg = self:getNode("bg")
	self.ball = self:getNode("bg/ball")
	self.terminator = self:getNode("/root/terminator")
end

-- update
function object:update()
end

-- on click region
function object:onMouseButtonDown_left()
	-- change bg position
	local event = self:getMouseEvent()
	
	self.clickPos = event:getLocalPosition()
	self.bg:setLocalPosition(self.clickPos)
end

-- on mouse moved
function object:onMouseButtonMove_left()
	if Input:isMouseButtonDown(0) then
		-- change ball position
		local event = self:getMouseEvent()
	
		local curPos = event:getLocalPosition()
		local offset = {}
		offset.x = curPos.x-self.clickPos.x
		offset.y = curPos.y-self.clickPos.y
		offset.z = curPos.z-self.clickPos.z
		self.ball:setLocalPosition(offset)

		-- move terminator
		self.terminator:move(offset)
	end
end

-- on mouse up
function object:onMouseButtonUp_left()
	local zeroPosition = { x=0.0, y=0.0, z=0.0}
	self.bg:setLocalPosition(zeroPosition)
	self.ball:setLocalPosition(zeroPosition)
end

return setmetatable(object, Node)
