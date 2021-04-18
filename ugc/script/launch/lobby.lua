local lobby ={}

-- start
function lobby:start()
end

-- update
function lobby:update()
end

-- mouse donw
function lobby:onNewGame()
	-- log info
	Log:info("new game")
	
	-- load new game scene
	local newScene = Node.load("Res://scene/new/new_island.scene")
	if newScene~=nil then
		newScene:setParent(self:getParent())
	end	
		
	-- quit self
	self:queueFree()
end

-- continue
function lobby:onContinue()
	-- log info
	Log:info("continue game")
	
	-- load new game scene
	local newScene = Node.load("Res://scene/island/heart/heart.scene")
	if newScene~=nil then
		newScene:setParent(self:getParent())
	end	
		
	-- quit self
	self:queueFree()
end

-- quit game
function lobby:onQuitGame()
end

return setmetatable(lobby, Object)
