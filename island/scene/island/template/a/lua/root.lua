local object ={}

-- start
function object:start()
end

-- update
function object:update()
end

function object:onBackHome()
	-- log
	Log:info("back game")
	
	-- load new game scene
	local newScene = Node.load("Res://scene/lobby/lobby.scene")
	if newScene~=nil then
		newScene:setParent(self:getParent())
	end	
	
	-- quit self
	self:queueFree()
end

return setmetatable(object, Object)
