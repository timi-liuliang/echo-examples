local object ={}

-- start
function object:start()
	local x = nn.sigmoid(0)
	Log:info(x)
end

-- update
function object:update()
end

return setmetatable(object, Object)
