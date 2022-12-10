fx_version "cerulean"
games { "gta5" }


client_scripts {
    "@srp-sync/client/lib.lua",
    '@srp-lib/client/cl_interface.lua',
    "@srp-lib/client/cl_polyhooks.lua",
    "@srp-locales/client/lib.lua",
    "@srp-lib/client/cl_rpc.lua",
    "client/*",
}

server_scripts {
    "@oxmysql/lib/MySQL.lua", 
    "@srp-lib/server/sv_rpc.lua",
    "server/*",
}


shared_scripts {
    "shared/*",
} 
