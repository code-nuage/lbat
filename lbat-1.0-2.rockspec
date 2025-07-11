package = "lbat"
version = "1.0-2"
source = {
   url = "git+https://github.com/code-nuage/lbat.git"
}
description = {
   summary = "A simple file reader",
   homepage = "https://github.com/code-nuage/lbat",
   license = "MIT"
}
dependencies = {
   "lua >= 5.1",
   "luafilesystem >= 1.8.0-1"
}
build = {
   type = "builtin",
   modules = {
      lbat = "src/main.lua",
      json = "src/json.lua",
      colors = "src/colors.lua",
      file_utils = "src/file_utils.lua",
      terminal = "src/terminal.lua",
      config = "src/config.lua"
   },
   install = {
      bin = {
         ["lbat"] = "bin/lbat.lua"
      }
   }
}
