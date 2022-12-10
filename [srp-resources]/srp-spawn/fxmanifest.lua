





fx_version 'cerulean'
games {'gta5'}

-- dependency "durp-base"
-- dependency "raid_clothes"

client_script "@srp-lib/client/cl_interface.lua"

ui_page "html/index.html"
files({
	"html/*",
	"html/images/*",
	"html/css/*",
	"html/webfonts/*",
	"html/js/*"
})


client_script '@srp-lib/client/cl_rpc.lua'
client_script "client/*"

server_script '@srp-lib/server/sv_rpc.lua'
shared_script "shared/sh_spawn.lua" 
server_script "server/*"

lua54 'yes'