





fx_version 'cerulean'
games {'gta5'}

--client_script "@npx/client/lib.js"
--server_script "@npx/server/lib.js"
--shared_script "@npx/shared/lib.lua"

client_script "@srp-errorlog/client/cl_errorlog.lua"
client_script "@srp-sync/client/lib.lua"

server_script "@srp-lib/server/sv_asyncExports.lua"

shared_script "@srp-lib/shared/sh_util.lua"

client_scripts {
  '@srp-lib/client/cl_rpc.lua',
  'cl_*.lua'
}

server_scripts {
  '@srp-lib/server/sv_sql.lua',
  '@srp-lib/server/sv_rpc.lua',
  'sv_*.lua'
}
