local object ={}
local neuralNetWork = nil
local dataViewer = nil

-- start
function object:start()
	neuralNetWork = self:getNode("neural_net_work")
	dataViewer    = self:getNode("data")
	
	-- train function y = 2.0 * x
	neuralNetWork:train({1}, {1})
	neuralNetWork:train({2}, {4})
	neuralNetWork:train({3}, {6})
	neuralNetWork:train({4}, {8})
	neuralNetWork:train({5}, {10})
	neuralNetWork:train({6}, {12})
	
	-- test
	local output = neuralNetWork:computeOutput({1})
	for k,v in pairs(output) do
		Log:info(v)
	end

	-- display data
	
	-- display result line
end

-- update
function object:update()
end

return setmetatable(object, Node)
