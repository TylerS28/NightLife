DPX.SpawnManager = {}

RegisterServerEvent('srp-fw:spawnInitialized')
AddEventHandler('srp-fw:spawnInitialized', function()
    local src = source
    TriggerClientEvent('srp-fw:spawnInitialized', src)
end)