local main = { }
local uiFailed = nil
local houses = nil
local bgs = nil
local camera = nil
local craneNode = nil
local dropNode = nil
local craneTimeline = nil
local currentHouse = nil
local preHouse = nil
local uiScoreNumber = 0
local uiScoreText = nil
local preHouseYHeight = -420.0
local isFailed = false
local isWaitingResult = false
local waitingResultTime = 0.0
local destCraneHeightY = 0.0
local cameraCraneOffsetY = nil
local maxHousesCount = 10
local housesQueue = require("lua/util/queue")

-- start
function main:start()
	uiScoreText		= self:getNode("ui/score")
	uiFailed    	= self:getNode("ui/failed")
	craneNode 		= self:getNode("crane")
	dropNode		= self:getNode("crane/crane/dropHouse")
	houses 			= self:getNode("houses")
	bgs    			= self:getNode("bgs")
	camera 		 	= self:getNode("camera")
	craneTimeline	= self:getNode("crane/crane/timeline")
	if craneTimeline ~= nil then
		craneTimeline:play("move")
	end
end

-- update
function main:update()
	-- drop house when click screen
	if(Input:getMouseButtonDown(0)) then
		self:dropHouse()
	end

	if currentHouse ~= nil then	
		if currentHouse:getWorldPositionY() < preHouseYHeight then
			self:onFail()
		end
	
		-- waiting result state
		if isWaitingResult then
			waitingResultTime = waitingResultTime - 0.02
			if waitingResultTime < 0.0 then
				isWaitingResult = false
				waitingResultTime = 0.0
				
				-- update score display
				uiScoreNumber = uiScoreNumber + 1	
				uiScoreText:setText(tostring(uiScoreNumber))
			end
		end

		-- update crane node position
		if craneNode:getWorldPositionY() < destCraneHeightY then
			local stepLen = (destCraneHeightY - craneNode:getWorldPositionY()) * 0.004
			
			-- move crane
			craneNode:setWorldPositionY(craneNode:getWorldPositionY() + stepLen)
			
			-- move camera based on crane posY
			if cameraCraneOffsetY == nil then
				-- get the initialize camera crane offset
				cameraCraneOffsetY = camera:getWorldPositionY() - craneNode:getWorldPositionY()
			else
				local cameraY = craneNode:getWorldPositionY() + cameraCraneOffsetY
				camera:setWorldPositionY(cameraY)
			
				-- move bgs based on camera position(linear and logrithm function)
				local moveThreshold = 500
				local bgsY = math.max(cameraY - moveThreshold, 0.0) * 0.85
				bgs:setWorldPositionY(bgsY)
			end
		end
	end
end

-- drop house
function main:dropHouse()
	if isFailed then
		return
	end

	local newHouse = Node.load("Res://scene/house.scene")
	if newHouse~=nil then
		newHouse:setParent(houses)
		newHouse:setWorldPosition(dropNode:getWorldPosition())
		
		-- hidden drop node
		dropNode:setVisible(false)
		
		-- move up crane
		destCraneHeightY = preHouseYHeight + 700
		
		-- remember nodes
		preHouse = currentHouse
		currentHouse = newHouse
		
		isWaitingResult = true
		waitingResultTime = 2.5
		
		if preHouse ~= nil then
			preHouseYHeight = preHouse:getWorldPositionY()
				
			-- process pre house
			self:processPreHouses(preHouse)
		end
	end
end

-- remove pre house
function main:processPreHouses(preHouse)
	-- push to tail
	housesQueue:push(preHouse)
	
	-- remove house
	if housesQueue:size() > maxHousesCount then
		-- pop and delete
		local housePoped = housesQueue:pop()
		
		-- set static body
		local house = housesQueue:front()
		if house ~= nil then
			house:setType("Static")
		end

		-- free poped house
		housePoped:queueFree()
	end
end

-- on faile
function main:onFail()
	isFailed = true
	uiFailed:setVisible(true)
end

return setmetatable(main, Node)
