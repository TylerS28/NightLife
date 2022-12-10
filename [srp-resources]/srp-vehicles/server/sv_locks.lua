RegisterServerEvent('srp-keys:attemptLockSV')
AddEventHandler('srp-keys:attemptLockSV', function(targetVehicle, plate)
    TriggerClientEvent('srp-keys:attemptLock', source, targetVehicle, plate)
end)