fx_version 'cerulean'
games { 'rdr3', 'gta5' }

client_scripts {
    "@srp-lib/client/cl_rpc.lua",
    "@srp-lib/client/cl_interface.lua",
    'client/*.lua'
}

server_scripts {
    "@srp-lib/server/sv_rpc.lua",
    'server/*.lua'
}
 