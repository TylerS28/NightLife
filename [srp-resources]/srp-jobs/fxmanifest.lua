fx_version 'bodacious'
games { 'rdr3', 'gta5' }


server_export 'AddJob' 
client_script "@srp-sync/client/lib.lua"
client_script "@srp-lib/client/cl_ui.lua"
client_script '@srp-lib/client/cl_interface.lua'

ui_page 'html/ui.html'
files {
	'html/ui.html',
	'html/pricedown.ttf',
	'html/cursor.png',
	'html/background.png',
	'html/styles.css',
	'html/scripts.js',
	'html/debounce.min.js',
}


client_scripts {
  '@srp-lib/client/cl_rpc.lua',
  'client/cl_*.lua',
  "@PolyZone/client.lua",
}


server_scripts {
  '@srp-lib/server/sv_rpc.lua',
  '@srp-lib/server/sv_sql.lua',
  'server/sv_*.lua',
}

exports {
	'canGrabGoods',
	'canDropGoods',
	'isTowing',
	'IsAbleImp'
}