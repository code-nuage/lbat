local colors = require("colors")
local terminal = require("terminal")
local config = require("config")

config.create_if_dont_exists()
config.load()

local path = arg[1]

if not path or path == "" then
    io.stderr:write("Bad usage: lbat <PATH>\n")
    os.exit(1)
    return
end

local file = io.open(path, "r")

if not file then
    io.stderr:write("Bad usage: ARG_1 must be a valid human readable file\n")
    os.exit(2)
    return
end

local prefix = colors.rgb(config.LINES_COLOR.r, config.LINES_COLOR.g, config.LINES_COLOR.b) .. "%5d" .. colors.rgb(config.STROKE_COLOR.r, config.STROKE_COLOR.g, config.STROKE_COLOR.b) .. "│ " .. colors.RESET
local prefix_wrap = "     " .. colors.rgb(config.STROKE_COLOR.r, config.STROKE_COLOR.g, config.STROKE_COLOR.b) .. "│ " .. colors.RESET

local function wrap_line(line, width)
    local t = {}
    local pos = 1
    local len = #line
    while pos <= len do
        table.insert(t, line:sub(pos, pos + width - 1))
        pos = pos + width
    end
    return t
end

local window_w, window_h = terminal.get_size()

io.write(colors.rgb(config.STROKE_COLOR.r, config.STROKE_COLOR.g, config.STROKE_COLOR.b, colors.MODES.background) .. "      " .. colors.RESET)
io.write(colors.rgb(config.STROKE_COLOR.r, config.STROKE_COLOR.g, config.STROKE_COLOR.b) .. string.rep("─", window_w - 6))
io.write("\n")

io.write(colors.RESET .. colors.rgb(config.STROKE_COLOR.r, config.STROKE_COLOR.g, config.STROKE_COLOR.b, colors.MODES.background) .. colors.BOLD .. " lbat " .. colors.RESET .. " " .. path)
io.write("\n")

io.write(colors.rgb(config.STROKE_COLOR.r, config.STROKE_COLOR.g, config.STROKE_COLOR.b, colors.MODES.background) .. "      " .. colors.RESET)
io.write(colors.rgb(config.STROKE_COLOR.r, config.STROKE_COLOR.g, config.STROKE_COLOR.b) .. string.rep("─", window_w - 6))

local text_width = window_w - 7

local i = 0
for line in file:lines() do
    i = i + 1
    local parts = wrap_line(line, text_width)
    io.write(string.format(prefix, i) .. (parts[1] or "") .. "\n")
    for j = 2, #parts do
        io.write(prefix_wrap .. parts[j] .. "\n")
    end
end


io.write(colors.rgb(config.STROKE_COLOR.r, config.STROKE_COLOR.g, config.STROKE_COLOR.b) .. "─────┴")
io.write(string.rep("─", window_w - 6))
io.write(colors.RESET)

file:close()