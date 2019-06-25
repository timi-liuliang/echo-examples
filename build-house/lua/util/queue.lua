local queue = { first = 0,  last = -1,  data = {}}

-- push 
function queue:push (value)
 	local last = self.last + 1
      	self.last = last
      	self.data[last] = value
end
    
-- front
function queue:front()
	return self.data[self.first]
end

-- back
function queue:back()
	return self.data[self.last]
end

-- pop 
function queue:pop ()
	-- check
	if self.first > self.last then 
		error("list is empty") 
	end
		
	-- pop value
	local value = self.data[self.first]
	
	 -- to allow garbage collection
	self.data[self.first] = nil
	self.first = self.first + 1

	return value
end

-- size
function queue:size()
	local num = self.last - self.first	
	if num >= 0 then
		return num + 1
	else
		return 0		
	end
end

return  queue