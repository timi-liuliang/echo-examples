local main = { }
local uiFailed = nil
local houses = nil
local bgs = nil
local camera = nil
local craneNode = nil
local dropNode = nil
local currentHouse = nil
local preHouse = nil
local preHouseYHeight = -420.0
local isFailed = false
local isWaitingResult = false
local waitingResultTime = 0.0
local destCraneHeightY = 0.0
local cameraCraneOffsetY = nil

-- start
function main:start()
	uiFailed    = self:getNode("ui/failed")
	craneNode 	= self:getNode("crane")
	dropNode	= self:getNode("crane/dropHouse")
	houses 		= self:getNode("houses")
	bgs    		= self:getNode("bgs")
	camera 		= self:getNode("camera")
end

-- update
function main:update()
	-- drop house when click screen
	if(Input:getMouseButtonDown(0)) then
		self:dropHouse()
	end

	if currentHouse ~= nil then
		if currentHouse:getPositionY() < preHouseYHeight then
			self:onFail()
		end
	
		-- waiting result state
		if isWaitingResult then
			
			isWaitingResult = false
			waitingResultTime = 0.0
		end

		-- update crane node position
		if craneNode:getPositionY() < destCraneHeightY then
			local stepLen = (destCraneHeightY - craneNode:getPositionY()) * 0.004
			
			-- move crane
			craneNode:setPositionY(craneNode:getPositionY() + stepLen)
			
			-- move camera based on crane posY
			if cameraCraneOffsetY == nil then
				-- get the initialize camera crane offset
				cameraCraneOffsetY = camera:getPositionY() - craneNode:getPositionY()
			else
				local cameraY = craneNode:getPositionY() + cameraCraneOffsetY
				camera:setPositionY(cameraY)
			
				-- move bgs based on camera position(linear and logrithm function)
				local moveThreshold = 500
				local bgsY = math.max(cameraY - moveThreshold, 0.0) * 0.85
				bgs:setPositionY(bgsY)
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
		newHouse:setPosition(dropNode:getPosition())
		
		-- hidden drop node
		dropNode:setVisible(false)
		
		-- move up crane
		destCraneHeightY = preHouseYHeight + 700
		
		-- remember nodes
		preHouse = currentHouse
		currentHouse = newHouse
		
		isWaitingResult = true
		
		if preHouse ~= nil then
			preHouseYHeight = preHouse:getPositionY()
		end
	end
end

-- on faile
function main:onFail()
	--isFailed = true
end

return setmetatable(main, Node)
