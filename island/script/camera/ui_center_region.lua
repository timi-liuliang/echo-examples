local object ={}

object.clickPos = nil
object.isMoving = false
object.mainCamera = nil

-- start
function object:start()
	self.mainCamera = self:getNode("/root/island/hero/main")
end

-- update
function object:update()
end

-- on click down
function object:onMouseButtonDown()
	-- change bg position
	local event = self:getMouseEvent()
	
	self.clickPos = event:getLocalPosition()	
	self.isMoveing = true
end

-- on mouse button move
function object:onMouseButtonMove()
	if self.isMoveing then
		local event  = self:getMouseEvent()
		local curPos = event:getLocalPosition()	
		local offset = curPos - self.clickPos	
		
		-- rotate camera
		self.mainCamera:rotatePitchYaw(0.0, 0.0)
		--self.mainCamera:rotatePitchYaw(offset.y, offset.x)
		
		self.clickPos = curPos
	end
end

-- on mouse button up
function object:onMouseButtonUp()
	self.isMoveing = false
end

-- on mouse button leave
function object:onMouseButtonLeave()
	self.isMoveing = false
end

return setmetatable(object, Object)
