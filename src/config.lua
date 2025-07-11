local lfs = require("lfs")

local file_utils = require("file_utils")

local M = {
    PATH = os.getenv("HOME") .. "/.config/lbat/config.json"
}

local function ensure_directory_exists(path)
    local current = ""
    for dir in path:gmatch("[^/]+") do
        current = current .. "/" .. dir
        if not lfs.attributes(current, "mode") then
            local ok, err = lfs.mkdir(current)
            if not ok then
                error("Failed to create directory '" .. current .. "': " .. tostring(err))
            end
        end
    end
end

local function dirname(path)
    return path:match("(.+)/[^/]*$")
end

function M.create_if_dont_exists()
    local f = io.open(M.PATH, "r")
    if f then
        f:close()
    else
        local dir = dirname(M.PATH)
        ensure_directory_exists(dir)

        local nf = file_utils.new()
        :set_path(M.PATH)
        :write_json({
            lines_color = {r = 127, g = 127, b = 127},
            stroke_color = {r = 255, g = 255, b = 0}
        })
    end
end

function M.load()
    local f = file_utils:new():set_path(M.PATH):read_json()
    M.LINES_COLOR = f["lines_color"]
    M.STROKE_COLOR = f["stroke_color"]
end

return M