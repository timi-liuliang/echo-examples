local object ={}

-- start
function object:start()
	local input = self:getInput(0)
	input:setImage("Res://model/banana.jpg")
	
	self:invoke()
	
	local output = self:getOutput(0)
	output:print()
end

-- update
function object:update()
end

return setmetatable(object, Object)
