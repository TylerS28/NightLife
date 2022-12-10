RegisterServerEvent("srp-baycity:getGetDoorStateSV")
AddEventHandler("srp-baycity:getGetDoorStateSV", function()
    TriggerClientEvent('srp-baycity:getDoorCheckCL', -1, doorCheckbaycity)
end)

RegisterServerEvent("srp-particleserverbaycity")
AddEventHandler("srp-particleserverbaycity", function(method)
    TriggerClientEvent("srp-ptfxparticlebaycity", -1, method)
end)

RegisterServerEvent("srp-particleserverbaycity1")
AddEventHandler("srp-particleserverbaycity1", function(method)
    TriggerClientEvent("srp-ptfxparticlebaycity1", -1, method)
end)
