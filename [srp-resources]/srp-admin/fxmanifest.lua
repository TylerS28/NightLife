fx_version "cerulean"
description "AdminUI"
author "loleris"
version '0.0.1'
game "gta5"

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    '@srp-lib/server/sv_sqlother.lua',
    '@srp-lib/server/sv_rpc.lua',
    '@srp-lib/server/sv_rpc.js',
    '@srp-lib/server/sv_sql.lua',
    '@srp-lib/server/sv_sql.js',
    'dist/server/*.js',
    'server/sv_*.lua'
}

client_scripts {
    '@srp-lib/client/cl_rpc.js',
    '@srp-lib/client/cl_rpc.lua',
    '@srp-lib/client/cl_poly.js',
    'dist/client/*.js',
    'client/cl_*.lua',
}