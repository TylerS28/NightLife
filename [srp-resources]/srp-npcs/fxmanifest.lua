





fx_version "cerulean"

games {"gta5"}

description "NPCs Handler"

version "0.1.0"

client_script "@srp-errorlog/client/cl_errorlog.lua"
client_script "@srp-lib/client/cl_flags.lua"
client_script "@srp-lib/client/cl_rpc.lua"
server_script "@srp-lib/server/sv_rpc.lua"

client_scripts {
  "client/classes/*.lua",
  "client/*.lua"
}

shared_scripts {
  "@srp-lib/shared/sh_util.lua",
  "shared/sh_*.lua"
}

server_scripts {
  "server/sv_*.lua"
}
