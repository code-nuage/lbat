local colors = require("colors")
local terminal = require("terminal")

local path = arg[1]

if not path or path == "" then
    io.stderr:write("Bad usage: bat <PATH>\n")
    os.exit(1)
    return
end

local file = io.open(path, "r")

if not file then
    io.stderr:write("Bad usage: ARG_1 must be a valid human readable file\n")
    os.exit(2)
    return
end

local window_w, window_h = terminal.get_size()

io.write(colors.CYAN)
io.write(colors.colorize(string.rep("─", window_w / 2 - #path / 2 - 1), colors.CYAN))
io.write(colors.colorize(" " .. path .. " ", colors.BOLD))
io.write(colors.colorize(string.rep("─", window_w / 2 - #path / 2 - 1), colors.CYAN))

io.write("\n\n")

local i = 0
for line in file:lines() do
    i = i + 1
    print(string.format("%s%4d%s%s│ %s %s", colors.rgb(127, 127, 127), i, colors.CYAN, colors.BOLD, colors.RESET, line))
end

io.write("\n")
io.write(colors.CYAN)
io.write(string.rep("─", window_w))
io.write(colors.RESET)

file:close()