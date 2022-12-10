








fx_version "cerulean"

games { "gta5" }

description "Sanyo Fiber"

version "0.1.0"

ui_page 'nui/index.html'

files {
    'nui/**/*',
}

server_scripts {
    "@srp-lib/server/sv_npx.js",
    "@srp-lib/server/sv_rpc.js",
    "@srp-lib/server/sv_sql.js",
    "@srp-lib/shared/sh_cacheable.js",
    "@srp-lib/server/sv_asyncExports.js",
    "server/*.js",
}

client_scripts {
    "@srp-lib/client/cl_rpc.js",
    "client/*.js",
}
