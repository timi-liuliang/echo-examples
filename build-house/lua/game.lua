local main = { }
main.root = nil
main.uiFailed = nil
main.houses = nil
main.bgs = nil
main.camera = nil
main.craneNode = nil
main.dropNode = nil
main.craneTimeline = nil
main.currentHouse = nil
main.preHouse = nil
main.uiScoreNumber = 0
main.uiScoreText = nil
main.preHouseYHeight = -420.0
main.isFailed = false
main.isWaitingResult = false
main.waitingResultTime = 0.0
main.destCraneHeightY = 0.0
main.cameraCraneOffsetY = nil
main.maxHousesCount = 10
main.housesQueue = require("lua/util/queue"):new()

-- start
function main:start()
	self.root			= self:getNode("/root")
	self.uiScoreText	= self:getNode("ui/score")
	self.uiFailed    	= self:getNode("ui/failed")
	self.craneNode 		= self:getNode("crane")
	self.dropNode		= self:getNode("crane/crane/dropHouse")
	self.houses 		= self:getNode("houses")
	self.bgs    		= self:getNode("bgs")
	self.camera 		= self:getNode("camera")
	self.craneTimeline	= self:getNode("crane/crane/timeline")
	if self.craneTimeline ~= nil then
		self.craneTimeline:play("move")
	end

	-- connect
	Object.connect(Input, "clicked", self, "dropHouse")
end

-- update
function main:update()
	if self.currentHouse ~= nil then	
		if self.currentHouse:getWorldPositionY() < self.preHouseYHeight then
			self:onFail()
		end
	
		-- waiting result state
		if self.isWaitingResult then
			self.waitingResultTime = self.waitingResultTime - 0.02
			if self.waitingResultTime < 0.0 then
				self.isWaitingResult = false
				self.waitingResultTime = 0.0
				
				-- update score display
				self.uiScoreNumber = self.uiScoreNumber + 1	
				self.uiScoreText:setText(tostring(self.uiScoreNumber))
			end
		end

		-- update crane node position
		if self.craneNode:getWorldPositionY() < self.destCraneHeightY then
			local stepLen = (self.destCraneHeightY - self.craneNode:getWorldPositionY()) * 0.004
			
			-- move crane
			self.craneNode:setWorldPositionY(self.craneNode:getWorldPositionY() + stepLen)
			
			-- move camera based on crane posY
			if self.cameraCraneOffsetY == nil then
				-- get the initialize camera crane offset
				self.cameraCraneOffsetY = self.camera:getWorldPositionY() - self.craneNode:getWorldPositionY()
			else
				local cameraY = self.craneNode:getWorldPositionY() + self.cameraCraneOffsetY
				self.camera:setWorldPositionY(cameraY)
			
				-- move bgs based on camera position(linear and logrithm function)
				local moveThreshold = 500
				local bgsY = math.max(cameraY - moveThreshold, 0.0) * 0.85
				self.bgs:setWorldPositionY(bgsY)
			end
		end
	end
end

-- drop house
function main:dropHouse()
	if self.isFailed then
		return
	end

	local newHouse = Node.load("Res://scene/house.scene")
	if newHouse~=nil then
		newHouse:setParent(self.houses)
		newHouse:setWorldPosition(self.dropNode:getWorldPosition())
		
		-- hidden drop node
		self.dropNode:setVisible(false)
		
		-- move up crane
		self.destCraneHeightY = self.preHouseYHeight + 700
		
		-- remember nodes
		self.preHouse = self.currentHouse
		self.currentHouse = newHouse
		
		self.isWaitingResult = true
		self.waitingResultTime = 2.5
		
		if self.preHouse ~= nil then
			self.preHouseYHeight = self.preHouse:getWorldPositionY()
				
			-- process pre house
			self:processPreHouses(self.preHouse)
		end
	else
		Log:error("new house is nil")
	end
end

-- remove pre house
function main:processPreHouses(preHouse)
	-- push to tail
	self.housesQueue:push(preHouse)
	
	-- remove house
	if self.housesQueue:size() > self.maxHousesCount then
		-- pop and delete
		local housePoped = self.housesQueue:pop()
		
		-- set static body
		local house = self.housesQueue:front()
		if house ~= nil then
			house:setType("Static")
		end

		-- free poped house
		housePoped:queueFree()
	end
end

-- on faile
function main:onFail()
	self.isFailed = true
	self.uiFailed:setVisible(true)
end

function main:on_clicked_restart()
	self.root:onRestartGame()
end

return setmetatable(main, Node)
