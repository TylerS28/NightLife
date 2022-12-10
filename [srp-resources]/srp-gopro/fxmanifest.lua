fx_version 'cerulean'
games { 'gta5' }

client_script "@dpx/client/lib.js"
server_script "@dpx/server/lib.js"
shared_script "@dpx/shared/lib.lua"

client_script "@srp-sync/client/lib.lua"
client_script "@srp-lib/client/cl_ui.lua"

client_scripts {
  '@srp-lib/client/cl_rpc.lua',
  'client/cl_*.lua',
  'client/cl_*.js',
}

server_scripts {
  "@oxmysql/lib/MySQL.lua",
	'@srp-lib/server/sv_rpc.lua',
	'@srp-lib/server/sv_sqlother.lua',
  'server/sv_*.lua',
  'server/sv_*.js',
}
