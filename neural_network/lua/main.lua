local object ={}

-- start
function object:start()
	Log:info(nn.sigmoid(0))
	Log:info(nn.sigmoid(1))
	Log:info(nn.sigmoid(2))
	Log:info(nn.sigmoid(3))
	Log:info(nn.sigmoid(4))
	Log:info(nn.sigmoid(5))
end

-- update
function object:update()
end

return setmetatable(object, Object)
