fx_version 'adamant'
games { 'gta5' }

client_script {
    '@srp-lib/client/cl_rpc.lua',
	'@srp-lib/client/cl_ui.lua',
	'@srp-lib/client/cl_interface.lua',
    '@srp-lib/client/cl_ui.js',
    'client/cl_*.lua'
}

server_script {
    '@srp-lib/server/sv_rpc.lua',
    'server/sv_*.lua'
}

exports {
    'canHandOffPackages'
}