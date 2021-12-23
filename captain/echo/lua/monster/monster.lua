local object = {}
object.elapsedTime = 0.0
object.hero = nil
object.waves = nil
object.currentWave = 0
object.monsters = nil
object.isGameOver = false

-- start
function object:start()
	-- load level monster configs
	self:loadLevelMonsters()
	
	self.hero = self:getNode("/root/hero")
end

-- update
function object:update()
	-- spawn monsters
	self:spawnMonsters()
end

-- spawn monsters
function object:spawnMonsters(elapsedTime)
	self.elapsedTime = self.elapsedTime + Engine:getFrameTime()
	
	if #self.monsters <=0 and self:getChildNum()<=0 then
		self:loadNextWaveMonsters()
	end
	
	for k, v in pairs(self.monsters) do
		local monster = self.monsters[k]
		if self.elapsedTime > monster.time then
			-- calc position
			local count = monster.count
			for i = 1, count do
				local range = monster.angle_range
				local angle = math.rad(monster.angle + math.random(-range, range))
				local dir   = vec3(math.cos(angle), math.sin(angle), 0.0)
				local pos   = dir:normalize() * monster.distance + self.hero:getWorldPosition()
			
				self:spawnMonster(pos)
			end
			
			self.monsters[k] = nil
		end
	end
end

-- spawn monster
function object:spawnMonster(pos)
	local newMonster = Node.load("Res://scene/monster/monster_a.scene")
	if newMonster ~= nil then
		newMonster:setWorldPosition(pos)
		newMonster:setParent(self)
	end
end

-- load next wave monsters
function object:loadNextWaveMonsters()
	-- return if game is over
	if self.isGameOver then return end	
		
	-- generate new monsters
	self.currentWave = self.currentWave + 1
	self.elapsedTime = 0.0
	
	Log:info("wave : " .. self.currentWave)
	
	if self.currentWave < #self.waves then
		local wave = self.waves[self.currentWave]
		
		self.monsters = wave:children()
		for i = 1, #self.monsters do
			local monster = self.monsters[i]
			monster.time 			= tonumber(monster["@time"])
			monster.angle 			= tonumber(monster["@angle"])
			monster.angle_range 	= tonumber(monster["@anglerange"])
			monster.distance 		= tonumber(monster["@distance"])
			monster.count			= tonumber(monster["@count"])
		end
	else
		-- Game victory
		self.isGameOver = true
		
		Log:info("Game Victory")
	end
end

-- load level monster config
function object:loadLevelMonsters()
	local xmlContent = IO:loadFileToString("Res://config/monsters_spawn_config.xml")
	if xmlContent ~= nil then
		local xmlParser = require("lua.util.xmlSimple").newParser()
		local spawnMonstersConfig = xmlParser:ParseXmlText(xmlContent)
		self.waves = spawnMonstersConfig.monsters:children()

		self:loadNextWaveMonsters()
	end
end

return setmetatable(object, Object)
