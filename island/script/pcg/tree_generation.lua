local TreeGenerator ={}

-- start
function TreeGenerator:start()
	self:generateTrees("Res://model/tree/pine_tree_a.scene", 128, os.time())
	self:generateTrees("Res://model/tree/small_tree.scene", 64, os.time() * 2.0)
	self:generateTrees("Res://model/grass/grass_1.scene", 64, os.time() * 3.0)
	self:generateTrees("Res://model/stone/flint.scene", 64, os.time() * 4.0)
end

-- update
function TreeGenerator:update()
end

-- generate trees
function TreeGenerator:generateTrees(treePathName, count, seed)	
	-- set random seed
	math.randomseed(seed)
	
	-- count
	for i=1, count, 1 do
		local treeA = Node.load(treePathName)
		if treeA~=nil then
			local xPos = math.random(0, 12800) * 0.01
			local yPos = math.random(0, 12800) * 0.01
			local scale = math.random(80, 100) * 0.01
			
			treeA:setWorldPosition(vec3(xPos, 0.0, yPos))
			treeA:setLocalScaling(vec3(scale, scale, scale))
			treeA:setParent(self)
		end
	end
end

return setmetatable(TreeGenerator, Object)
