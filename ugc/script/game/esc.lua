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
function object:onQuit()
	Log:error("quit game")
end

return setmetatable(object, Object)
