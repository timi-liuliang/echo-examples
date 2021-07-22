local TreeGenerator ={}

-- start
function TreeGenerator:start()
	self:generateTrees("Res://model/tree/pine_tree_a.scene", 128)
end

-- update
function TreeGenerator:update()
end

-- generate trees
function TreeGenerator:generateTrees(treePathName, count)	
	-- set random seed
	math.randomseed(os.time())
	
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
