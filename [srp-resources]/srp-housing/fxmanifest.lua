fx_version "cerulean"
games { "gta5" }

client_script "@srp-lib/client/cl_interface.lua"

shared_scripts {
	"@srp-lib/shared/sh_util.lua",
	"shared/*",
}

server_scripts {
	"@oxmysql/lib/MySQL.lua",
	"@srp-lib/server/sv_rpc.lua",
    "server/*",
}

client_scripts {
	'@srp-lib/client/cl_ui.lua',
	"@srp-lib/client/cl_rpc.lua",
	"client/*",
}