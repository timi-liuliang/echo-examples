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
main.uiScoreText = nil
main.audioPlayer = nil
main.preHouseYHeight = -420.0
main.isFailed = false
main.isWaitingResult = false
main.waitingResultTime = 0.0
main.destCraneHeightY = 0.0
main.cameraCraneOffsetY = nil
main.maxHousesCount = 10
main.housesQueue = require("lua/util/queue"):new()

-- score
main.score = 0
main.bestScore = 0

-- start
function main:start()
	self.root			= self:getNode("/root")
	self.uiScoreText	= self:getNode("ui/score")
	self.uiFailed    	= self:getNode("ui/failed")
	self.craneNode 		= self:getNode("crane")
	self.dropNode		= self:getNode("crane/crane/dropHouse")
	self.houses 		= self:getNode("houses")
	self.bgs    		= self:getNode("bgs")
	self.audioPlayer    = self:getNode("audio/bg_music")
	self.camera 		= self:getNode("camera")
	self.craneTimeline	= self:getNode("crane/crane/timeline")
	if self.craneTimeline ~= nil then
		self.craneTimeline:play("move")
	end

	-- connect
	Object.connect(Input, "clicked", self, "dropHouse")
	
	-- load score
	self:loadScore()
	
	-- init camera Y position
	self:initCameraYPos()
	self:initCraneNodeYPos()
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
				self.score = self.score + 1	
				self.uiScoreText:setText(tostring(self.score))
			end
		end

		-- update crane node position
		if self.craneNode:getWorldPositionY() < self.destCraneHeightY then
			local stepLen = (self.destCraneHeightY - self.craneNode:getWorldPositionY()) * 0.04
			
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
				local moveThreshold = 250 / 960 * self.camera:getHeight() + self.score * 0.1
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
		local offset = self.camera:getHeight() * 0.73
		self.destCraneHeightY = self.preHouseYHeight + offset
		
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

		-- connect collison event
		Object.connect(newHouse, "beginContact", self, "onHouseBeginContact")
	else
		Log:error("new house is nil")
	end
end

-- remove pre house
function main:processPreHouses(preHouse)
	-- push to tail
	self.housesQueue:push(preHouse)
	
	-- disconnect collision event
	Object.disconnect(preHouse, "beginContact", self, "onHouseBeginContact")
	
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
	if self.isFailed == false then
		self.isFailed = true
		self.uiFailed:setVisible(true)
	
		-- save score
		self:saveScore()
	
		-- play music
		self.audioPlayer:playOneShot("Res://audio/failed.mp3")
	end
end

function main:on_clicked_restart()
	self.root:onRestartGame()
end

-- on house collision event
function main:onHouseBeginContact()
	self.audioPlayer:playOneShot("Res://audio/collision.mp3")
end

function main:loadScore()
	if IO:isExist("User://score.json") then	
		local content = IO:loadFileToString("User://score.json")
		if content ~= nil then
			local table = require("lua/util/json").decode(content)
			if table ~= nil then
				self.bestScore = table.score
				Log:info("bsetScore : " .. self.bestScore)
			end
		end
	else
		Log:info("file [score.json] doesn't exist.")
	end
end

function main:saveScore()
	if(self.score > self.bestScore) then
		self.bestScore = self.score
	
		local json = require("lua/util/json")	
		local content = json.encode({ score=self.bestScore })
	
		IO:saveStringToFile("User://score.json", content)
	end

	-- output score info
	Log:info("game over")
	Log:info("score :" .. self.score)
	Log:info("bestScore :" .. self.bestScore)
	
	-- update ui display
	local uiScoreText     = self:getNode("ui/failed/scores_bg/score")
	local uiBestScoreText = self:getNode("ui/failed/scores_bg/bestscore")
	uiScoreText:setText("score " .. tostring(self.score))
	uiBestScoreText:setText("best  " .. tostring(self.bestScore)) 
end

function main:initCameraYPos()
	local halfDesignHeight = GameSettings:getDesignHeight() * 0.5
	local halfCameraHeight = self.camera:getHeight() * 0.5
	
	self.camera:setWorldPositionY(halfCameraHeight - halfDesignHeight)
end

-- 8/10 positin in camera y space
function main:initCraneNodeYPos()
	local offset = self.camera:getHeight() * 0.27
	local cameraY = self.camera:getWorldPositionY()
	
	self.craneNode:setWorldPositionY(cameraY + offset)
end

return setmetatable(main, Node)
