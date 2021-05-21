local object ={}
object.perlineNode = nil

-- start
function object:start()
	self.perlineNode = self:getNodeByName("ImagePerlinNoise0")
end

-- update
function object:update()
end

function object:onBigger()
	Log:info("bigger")
	
	self.perlineNode:setWidth(512)
	self.perlineNode:setHeight(512)
end

return setmetatable(object, Object)
