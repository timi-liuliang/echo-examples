local object ={}

-- start
function object:start()

end

-- update
function object:update()

end

-- quit
function object:onQuitGame()
	Log:info("quit game")
	
	Application:quit()
end

return setmetatable(object, Object)
