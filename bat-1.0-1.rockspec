package = "bat"
version = "1.0-1"
source = {
   url = "git+https://github.com/code-nuage/bat.git"
}
description = {
   summary = "A simple file reader",
   homepage = "https://github.com/code-nuage/bat",
   license = "MIT"
}
dependencies = {
   "lua >= 5.1"
}
build = {
   type = "builtin",
   install = {
      bin = {
         ["bat"] = "src/main.lua"
      }
   }
}
