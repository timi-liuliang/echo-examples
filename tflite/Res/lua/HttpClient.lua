local object ={}

-- start
function object:start()
	self:getRequest("www.baidu.com", 80, "/")
end

-- update
function object:update()
end

return setmetatable(object, Object)
