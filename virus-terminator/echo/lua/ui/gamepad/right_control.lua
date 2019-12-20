local object ={}

object.bg = nil
object.clickPos = nil

-- start
function object:start()
	self.bg = self:getNode("bg")
end

-- update
function object:update()
end

function object:on_clicked_right()
	-- change bg position
	local event = self:getMouseEvent()
	
	self.clickPos = event:getLocalPosition()
	self.bg:setLocalPosition(self.clickPos)
end

return setmetatable(object, Node)
