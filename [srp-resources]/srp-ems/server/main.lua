RegisterServerEvent('admin:revivePlayer')
AddEventHandler('admin:revivePlayer', function(target)
	if target ~= nil then
		TriggerClientEvent('admin:revivePlayerClient', target)
		TriggerClientEvent('srp-hospital:client:RemoveBleed', target) 
        TriggerClientEvent('srp-hospital:client:ResetLimbs', target)
	end
end)

RegisterServerEvent('srp-ems:heal')
AddEventHandler('srp-ems:heal', function(target)
	TriggerClientEvent('srp-ems:heal', target) 	
end)

RegisterServerEvent('srp-ems:heal2')
AddEventHandler('srp-ems:heal2', function(target)
	TriggerClientEvent('srp-ems:big', target)
end)