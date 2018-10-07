local object ={}

-- start
function object:start()
end

-- update
function object:update()
	local yawPitchRoll = self:getYawPitchRoll()
	yawPitchRoll.z = yawPitchRoll.z + 0.03

	--self:setYawPitchRoll(yawPitchRoll)
end

return setmetatable(object, Object)
