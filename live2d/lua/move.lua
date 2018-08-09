local Move = 
{
	posX = 10,
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

	self.posX = self.posX + 0.1
	self:setPosX(self.posX)
end

return Move