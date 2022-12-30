local object ={}
object.pcg = nil

-- start
function object:start()
	self.pcg = self:getNode("PCGFlowGraph")
end

-- update
function object:update()
end

function object:onPlay()
	-- generate world
	Log:info("generate world")
	self.pcg:run()
	
	-- log
	Log:info("play game")
	
	-- load new game scene
	local newScene = Node.load("Res://scene/island/template/a/template.scene")
	if newScene~=nil then
		newScene:setParent(self:getParent())
	end	
	
	-- quit self
	self:queueFree()
end

return setmetatable(object, Object)
