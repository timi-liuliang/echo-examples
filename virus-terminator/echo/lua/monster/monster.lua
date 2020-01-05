local object = {}
object.elapsedTime = 0.0
object.monsters = nil

-- start
function object:start()
	-- load level monster configs
	self:loadLevelMonsters()
end

-- update
function object:update()
	-- spawn monsters
	self:spawnMonsters()
end

-- spawn monsters
function object:spawnMonsters(elapsedTime)
	self.elapsedTime = self.elapsedTime + Engine:getFrameTime()
	
	for k, v in pairs(self.monsters) do
		local monster = self.monsters[k]
		if self.elapsedTime > monster.time then
			self:spawnMonster()
			
			self.monsters[k] = nil
		end
	end
end

-- spawn monster
function object:spawnMonster()
	local newMonster = Node.load("Res://scene/monster/monster_a.scene")
	if newMonster ~= nil then
		newMonster:setWorldPosition(self:getWorldPosition())
		newMonster:setParent(self)
	end
end

-- load level monster config
function object:loadLevelMonsters()
	local xmlContent = IO:loadFileToString("Res://config/monsters_spawn_config.xml")
	if xmlContent ~= nil then
		local xmlParser = require("lua.util.xmlSimple").newParser()
		local spawnMonstersConfig = xmlParser:ParseXmlText(xmlContent)
		self.monsters = spawnMonstersConfig.monsters:children()
		for i = 1, #self.monsters do
			local monster = self.monsters[i]
			monster.time = tonumber(monster["@time"])
		end	
	end
end

return setmetatable(object, Object)
