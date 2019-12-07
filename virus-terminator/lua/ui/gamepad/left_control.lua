local object ={}

object.bg = nil

-- start
function object:start()
	self.bg = self:getNode("bg")
end

-- update
function object:update()
end

function object:on_clicked_UiEventRegionRect()
	-- change bg position
	Log:error("a")
	local localPos = self.bg:getLocalPosition()
	Log:error("b")
	localPos.x = localPos.x + 10
	Log:error("c")
	self.bg:setLocalPosition(localPos)
	Log:error("d")
end

return setmetatable(object, Node)
