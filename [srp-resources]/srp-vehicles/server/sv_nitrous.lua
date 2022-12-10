RegisterServerEvent('srp-vehicles:ApplyNitrous')
AddEventHandler('srp-vehicles:ApplyNitrous', function()
     TriggerClientEvent("srp-nitro:client:placeNitro", source)
end) 

RegisterServerEvent('srp-nitro:server:particlefx')
AddEventHandler('srp-nitro:server:particlefx', function(veh)
     TriggerClientEvent('srp-nitro:client:particlefx', -1, veh)
end)

RegisterServerEvent('srp-nitro:server:particlefisfis')
AddEventHandler('srp-nitro:server:particlefisfis', function(type, veh)
     if type == 'fisfisacc' then
          TriggerClientEvent('srp-nitro:client:particlefisfis', -1, 'fisfisac', veh)
     elseif type == 'fisfiskapatt' then
          TriggerClientEvent('srp-nitro:client:particlefisfis', -1, 'fisfiskapat', veh)
     end
end)