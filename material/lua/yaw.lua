local Move = 
{
	yangle = 0.0,
}

-- start
function Move:start()
	log:info("start node live2dcubism")
end

-- update
function Move:update()
	if self.yangle > 8.0 then
		self.yangle = 10
	end

	self.yangle = self.yangle + 0.001
	self:yaw(0.01)
end

return Move