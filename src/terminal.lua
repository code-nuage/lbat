local M = {}

function M.get_size()
    local f, result

    f = io.popen("stty size 2>/dev/null")
    if f then
        result = f:read("*a")
        f:close()
        local rows, cols = result:match("(%d+)%s+(%d+)")
        return tonumber(cols), tonumber(rows)
    end

    return 0, 0
end

return M