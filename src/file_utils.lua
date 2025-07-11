local json = require("json")

local M = {}
M.__index = M

function M.new()
    local i = setmetatable({}, M)

    i.path = nil

    return i
end

function M:set_path(path)
    self.path = path
    return self
end

function M:read()
    local file = io.open(self.path, "r")

    if file then
        local data = file:read("*a")
        file:close()
        return data
    end
end

function M:read_json()
    local file = io.open(self.path, "r")

    if file then
        local data = file:read("*a")
        file:close()
        local json_data = json.decode(data)
        return json_data
    end
end

function M:write(data)
    local file = io.open(self.path, "w")

    if file then
        file:write(data)
        file:close()
    end
    return self
end

function M:write_json(data)
    local file = io.open(self.path, "w")

    if file then
        local json_data = json.encode(data)
        file:write(json_data)
        file:close()
    end
    return self
end

function M:append(data)
    local file = io.open(self.path, "a")

    if file then
        file:write(data)
        file:close()
    end
end

function M:wipe()
    local file = io.open(self.path, "w")
    if file then
        file:close()
    end
    return self
end

return M