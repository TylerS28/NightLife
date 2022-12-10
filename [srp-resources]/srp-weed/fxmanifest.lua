fx_version "cerulean"
games { "gta5" }

shared_script {
    "@srp-lib/shared/sh_util.lua",
    "shared/*",
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "@srp-lib/server/sv_rpc.lua",
    "server/*",
}

client_scripts {
    "@srp-lib/client/cl_rpc.lua",
    "@srp-lib/client/cl_interface.lua",
    "@srp-sync/client/lib.lua",
    "@srp-lib/client/cl_polyhooks.lua",
    "@srp-locales/client/lib.lua",
    "client/*",
}