package = "lbat"
version = "1.0-1"
source = {
   url = "git+https://github.com/code-nuage/lbat.git"
}
description = {
   summary = "A simple file reader",
   homepage = "https://github.com/code-nuage/lbat",
   license = "MIT"
}
dependencies = {
   "lua >= 5.1"
}
build = {
   type = "builtin",
   modules = {
      lbat = "src/main.lua",
      colors = "src/colors.lua",
      terminal = "src/terminal.lua"
   },
   install = {
      bin = {
         ["lbat"] = "bin/lbat.lua"
      }
   }
}
