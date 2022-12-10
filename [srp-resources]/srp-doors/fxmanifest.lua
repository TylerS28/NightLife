





fx_version 'cerulean'

games {
    'gta5',
    'rdr3'
}

client_scripts {
  '@srp-lib/client/cl_rpc.lua',
  '@srp-lib/client/cl_ui.lua',
  '@srp-lib/client/cl_interface.lua',
  '@srp-lib/client/cl_polyhooks.lua',
	'client/cl_*.lua'
}

shared_scripts {
  '@srp-lib/shared/sh_util.lua',
	"shared/*.lua"
}

server_scripts {
  '@srp-lib/server/sv_rpc.lua',
  '@srp-lib/server/sv_sql.lua',
	'server/*.lua'
}