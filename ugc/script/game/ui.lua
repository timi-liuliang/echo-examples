local ui ={}
ui.esc = nil

-- start
function ui:start()
	ui.esc = self:getNode("esc")
end

-- update
function ui:update()
	if Input:isKeyDown(27) then
		Log:info("esc clicked")
		ui.esc:setEnable(not ui.esc:isEnable())
	end
end

return setmetatable(ui, Object)
