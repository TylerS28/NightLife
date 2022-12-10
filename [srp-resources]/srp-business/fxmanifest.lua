fx_version 'cerulean'
games { 'gta5' }

shared_script "@mka-array/Array.lua"

client_scripts {
    '@srp-lib/client/cl_rpc.lua',
    '@srp-lib/client/cl_ui.lua',
	'@srp-lib/client/cl_interface.lua',
    '@srp-errorlog/client/cl_errorlog.lua',
    'client/cl_*.lua',
}

shared_script {
    '@srp-lib/shared/sh_util.lua',
}

server_scripts {
    '@srp-lib/server/sv_rpc.lua',
    '@srp-lib/server/sv_sql.lua',
    'server/sv_*.lua',
}