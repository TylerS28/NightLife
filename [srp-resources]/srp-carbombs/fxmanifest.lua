fx_version "cerulean"
games {"gta5"}

author 'loleris'
description "lol-carbombs"

version "1.0.0"

client_scripts {
    "@srp-lib/client/cl_rpc.lua",
    "@srp-lib/client/cl_interface.lua",
    "client/*.lua"
}

server_scripts {
    "@srp-lib/server/sv_rpc.lua",
    "server/*.lua"
}