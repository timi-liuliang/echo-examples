local object ={}

-- start
function object:start()

end

-- update
function object:update()

end

-- back home
function object:onBackHome()
	Log:error("back home")
end

-- quit
function object:onQuitGame()
	Log:error("quit game")
	
	Application:quit()
end

return setmetatable(object, Object)
