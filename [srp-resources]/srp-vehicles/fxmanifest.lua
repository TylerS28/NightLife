fx_version 'bodacious'
games { 'rdr3', 'gta5' }

client_scripts {
    '@srp-lib/client/cl_interface.lua',
    'client/*.lua',
    '@srp-lib/client/cl_main.lua',
}


server_scripts {
    'server/*.lua',
    '@srp-lib/server/sv_main.lua',
}

exports {
    'GetVehicleTable',
    'SetVehicleMods',
}