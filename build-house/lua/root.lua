local object ={}

-- start
function object:start()
end

-- update
function object:update()
end

function object:onRestartGame()
	local scenes = self:getNode("scenes")
	
	-- unload old game scene
	while scenes:getChildNum() > 0 do
		local childNode = scenes:getChildByIndex(0)
		childNode:queueFree()
	end
	
	-- load new game scene
	local newGame = Node.load("Res://scene/game.scene")
	if newGame~=nil then
		newGame:setParent(self:getNode("scenes"))
	end
end

return setmetatable(object, Object)
