local YoloV5 ={}
YoloV5.videoCapture = nil

-- start
function YoloV5:start()
	self.videoCapture = self:getNode("VideoCapture")
	self.videoCapture:openDevice()
	Log:info("start video capture")
end

-- update
function YoloV5:update()
end

-- on click start button
function YoloV5:onMouseButtonDownStartButton()
	
end

return setmetatable(YoloV5, Object)
