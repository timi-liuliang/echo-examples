local object ={}
object.perlineNode = nil
object.size = 1

-- start
function object:start()
	self.perlineNode = self:getNodeByName("ImagePerlinNoise0")
end

-- update
function object:update()
end

function object:onBigger()
	self.size = self.size + 1
	self.size = math.fmod(self.size, 4)
	
	local finalSize = (self.size + 1) * 256
	self.perlineNode:setWidth(finalSize)
	self.perlineNode:setHeight(finalSize)
	
	Log:info("set scene size" .. finalSize)
end

return setmetatable(object, Object)
