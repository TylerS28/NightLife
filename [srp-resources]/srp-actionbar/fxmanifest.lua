





fx_version 'cerulean'
games {"gta5"}

description "actionbar"

client_scripts {
  "@srp-errorlog/client/cl_errorlog.lua",
  '@srp-lib/client/cl_rpc.lua',
  "client.lua",
}

shared_script {
  '@srp-lib/shared/sh_util.lua'
}

server_scripts {
  '@srp-lib/server/sv_rpc.lua',
  '@srp-lib/server/sv_sql.lua',
}