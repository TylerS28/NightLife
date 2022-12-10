fx_version 'cerulean'
games {'gta5'}

ui_page "html/index.html"

files({
	"html/*",
	"html/img/*",
	"html/css/*",
	"html/font/*",
	"html/js/*"
})

client_script "@srp-lib/client/cl_ui.lua"
client_script "@srp-lib/client/cl_interface.lua"


client_scripts {
	"client/*.lua",
	"@srp-lib/client/cl_polyhooks.lua",
	"@srp-lib/client/cl_ui.lua",
	'@srp-lib/client/cl_rpc.lua',
	'client/model/*.lua'
	
}
server_scripts {
	"server/*",
	"@srp-lib/server/sv_asyncExports.lua",
	'@srp-lib/server/sv_rpc.lua',
	'@srp-lib/server/sv_sql.lua',
}
