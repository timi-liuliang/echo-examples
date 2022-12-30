local ui ={}
ui.esc = nil

-- start
function ui:start()
	ui.esc = self:getNode("esc")
	
	Object.connect(Input, "onKeyDown", self, "onKeyDown")
end

-- update
function ui:update()

end

function ui:onKeyDown(key)
	if key == 27 then
		Log:info("esc clicked")
		ui.esc:setEnable(not ui.esc:isEnable())
	end
end

return setmetatable(ui, Object)
