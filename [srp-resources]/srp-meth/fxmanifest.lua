fx_version 'cerulean'

games { 'gta5' }
shared_script {
  "@srp-lib/server/sv_rpc.lua",
  "@srp-lib/server/sv_sql.lua",
  "@srp-lib/server/sv_asyncExports.lua"
}

client_scripts {
  "@srp-sync/client/lib.lua",
  '@srp-lib/client/cl_interface.lua',
  "@srp-lib/client/cl_polyhooks.lua",
  "@srp-locales/client/lib.lua",
  "@srp-lib/client/cl_rpc.lua",
  'client/cl_*.lua',
  "@PolyZone/client.lua",
}

server_scripts {
  "@srp-lib/server/sv_rpc.lua",
  'server/sv_*.lua',
  'server/sv_*.js',
  'build-server/sv_*.js',
}
  