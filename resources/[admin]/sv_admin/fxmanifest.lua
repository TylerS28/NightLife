fx_version 'cerulean'
games { 'gta5' }



ui_page "ui-build/index.html"

files {
  "ui-build/*",
}

client_scripts {
  '@nlrp-rpc/client/cl_main.lua',
  'config.lua',
  'client/cl_*.lua',
}

server_scripts {
  '@nlrp-rpc/server/sv_main.lua',
  'config.lua',
  'server/sv_*.lua',
}

