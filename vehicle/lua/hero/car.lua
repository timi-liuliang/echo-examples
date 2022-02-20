require "lua.util.keys"

-- Enum move state
local EMoveState = {
	Normal  = 0,
	Fall    = 1,
	Slide   = 2,
	Jump    = 3,
}

local car ={}
car.camera = nil
car.moveState = EMoveState.Fall

-- start
function car:start()
	self.camera = self:getNode("Camera3D")
end

-- update
function car:update()
	-- update movestate
	--self:updateMoveState()
end

return setmetatable(car, Object)
