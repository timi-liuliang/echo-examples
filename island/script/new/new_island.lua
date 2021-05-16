local object ={}

-- start
function object:start()
end

-- update
function object:update()
end

function object:onPlay()
	-- log
	Log:info("play game")
	
		-- load new game scene
	local newScene = Node.load("Res://scene/island/heart/heart.scene")
	if newScene~=nil then
		newScene:setParent(self:getParent())
	end	
	
	-- quit self
	self:queueFree()
end

return setmetatable(object, Object)
