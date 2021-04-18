local cd ={ data={} }

-- start
function cd:new()
    local result = {}
    for k, v in pairs(self) do
        result[k] = v
    end

    return result
end

-- update
function cd:update(elapsedTime)
    for k, v in pairs(self.data) do
        if v.waitTime > 0.0 then
            v.waitTime = v.waitTime - elapsedTime
        end
    end
end

-- add
function cd:add(key, cdTime)
    local item = { maxWaitTime = cdTime, waitTime = cdTime }
    self.data[key] = item
end

-- remove
function cd:remove(key)
    if self.data[key] ~= nil then
        self.data[key] = nil
    end
end

-- reset
function cd:reset(key)
    local item = self.data[key]
    if item ~= nil then
        item.waitTime = item.maxWaitTime;
    end
end

-- is ready
function cd:isReady(key)
    local item = self.data[key]
    if item and item.waitTime <= 0.0 then
        return true
    end

    return false
end

-- get wait time
function cd:waitTime(key)
    local item = self.data[key]
    if item ~= nil then
        return item.waitTime
    end
    
    return 1000000.0
end

return cd
