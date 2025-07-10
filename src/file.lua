local M = {}
M.__index = M

function M.new()
    local i = setmetatable({}, M)

    i.file = nil

    return i
end

function M.open()
    
end



return M