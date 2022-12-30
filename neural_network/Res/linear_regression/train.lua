local object ={}
local neuralNetWork = nil
local dataViewer = nil

-- start
function object:start()
	neuralNetWork = self:getNode("neural_net_work")
	dataViewer    = self:getNode("data")
	
	-- train function y = 2.0 * x
	-- train 1000 times
	for i= 1, 1000 do
		neuralNetWork:train({{1}}, {{1}})
		neuralNetWork:train({{2}}, {{4}})
		neuralNetWork:train({{3}}, {{6}})
		neuralNetWork:train({{4}}, {{8}})
		neuralNetWork:train({{5}}, {{10}})
		neuralNetWork:train({{6}}, {{12}})
	end
	
	-- test
	local output = neuralNetWork:computeOutput({{4}})
	for k,v in pairs(output) do
		for k1, v1 in pairs(v) do
			Log:info(v1)
		end
	end

	-- display data
	
	-- display result line
end

-- update
function object:update()
end

return setmetatable(object, Node)
