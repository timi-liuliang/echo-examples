local array = { first = 0,  last = -1,  data = {}}

-- new
function array:new()
	local result = {}
	for k, v in pairs(self) do
		result[k] = v
	end
	
	return result
end

-- push 
function array:push (value)
 	local last = self.last + 1
      	self.last = last
      	self.data[last] = value
end
    
-- front
function array:front()
	return self.data[self.first]
end

-- back
function array:back()
	return self.data[self.last]
end

-- pop 
function array:pop ()
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
function array:size()
	local num = self.last - self.first	
	if num >= 0 then
		return num + 1
	else
		return 0		
	end
end

return  array