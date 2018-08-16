local Move = 
{
	posX = 10,
	step = 0.2,
}

-- start
function Move:start()
	log:info("start node live2dcubism")
end

-- update
function Move:update()
	if self.posX > 250 then
		self.posX = 10
	end
	
	if Input:getMouseButtonDown(0) then
		self.step = -self.step
	end

	self.posX = self.posX + self.step
	self:setPosX(self.posX)
end

return Move