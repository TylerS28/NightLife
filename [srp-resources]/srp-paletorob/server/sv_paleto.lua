Doors = {
    ["P1"] = {{loc = vector3(-105.41538238525, 6471.6791992188, 31.621948242188), txtloc = vector3(-105.41538238525, 6471.6791992188, 31.621948242188), state = nil, locked = true}},
}

RegisterServerEvent("srp-paleto:startcheck")
AddEventHandler("srp-paleto:startcheck", function(bank)
    local src = source

    if not Paleto.Banks[bank].onaction == true then
        if (os.time() - Paleto.cooldown) > Paleto.Banks[bank].lastrobbed then
            Paleto.Banks[bank].onaction = true
            TriggerClientEvent("srp-paleto:outcome", src, true, bank)
            TriggerClientEvent("srp-paleto:policenotify", -1, bank)
        else
            TriggerClientEvent("srp-paleto:outcome", src, false, "This bank recently robbed. You need to wait "..math.floor((Paleto.cooldown - (os.time() - Paleto.Banks[bank].lastrobbed)) / 60)..":"..math.fmod((Paleto.cooldown - (os.time() - Paleto.Banks[bank].lastrobbed)), 60))
        end
    else
        TriggerClientEvent("srp-paleto:outcome", src, false, "This bank is currently being robbed.")
    end
end)

RegisterCommand("testy", function()
    local src = source
    local reward = math.random(Paleto.mincash, Paleto.maxcash)
	
	if Paleto.blackmoney then
        TriggerClientEvent("player:receiveItem", src, "markedbills", 1)
        -- Player.Functions.AddItem('markedbills', 1, false, {worth = math.random(4500, 7000)})
    else
        if Paleto.blackmoney then
            TriggerClientEvent("player:receiveItem", src, "markedbills", 1)
            -- Player.Functions.AddItem('markedbills', 1, false, {worth = math.random(4500, 7000)})
        end
    end
end)

RegisterServerEvent("srp-paleto:lootup")
AddEventHandler("srp-paleto:lootup", function(var, var2)
    TriggerClientEvent("srp-paleto:lootup_c", -1, var, var2)
end)

RegisterServerEvent("srp-paleto:toggleVault")
AddEventHandler("srp-paleto:toggleVault", function(key, state)
    Doors[key][1].locked = state
    TriggerClientEvent("srp-paleto:toggleVault", -1, key, state)
end)

RegisterServerEvent("srp-paleto:updateVaultState")
AddEventHandler("srp-paleto:updateVaultState", function(key, state)
    Doors[key][1].state = state
end)

RegisterServerEvent("srp-paleto:startLoot")
AddEventHandler("srp-paleto:startLoot", function(data, name, players)
    local src = source

    for i = 10, #players, 10 do
        TriggerClientEvent("srp-paleto:startLoot_c", players[i], data, name)
    end
    TriggerClientEvent("srp-paleto:startLoot_c", src, data, name)
end)

RegisterServerEvent("srp-paleto:stopHeist")
AddEventHandler("srp-paleto:stopHeist", function(name)
    TriggerClientEvent("srp-paleto:stopHeist_c", -1, name)
end)

RegisterServerEvent("srp-paleto:rewardCash")
AddEventHandler("srp-paleto:rewardCash", function()
    local src = source
    local reward = math.random(Paleto.mincash, Paleto.maxcash)
	
	if Paleto.blackmoney then
        TriggerClientEvent("player:receiveItem", src, "markedbills", 250)
    else
        TriggerClientEvent("player:receiveItem", src, "markedbills", 425)
    end
end)

RegisterServerEvent("srp-paleto:setCooldown")
AddEventHandler("srp-paleto:setCooldown", function(name)
    Paleto.Banks[name].lastrobbed = os.time()
    Paleto.Banks[name].onaction = false
    TriggerClientEvent("srp-paleto:resetDoorState", -1, name)
end)

RPC.register("srp-paleto:getBanks", function(source)
    return Paleto.Banks, Doors
end)

 RegisterCommand("aan", function()
     TriggerClientEvent('srp-paleto:UseGreenLapTop', source)
 end)

-- RegisterServerEvent('rick:removeLaptop')
-- AddEventHandler('rick:removeLaptop', function()
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(src)
--     Player.Functions.RemoveItem('green-laptop', 1)
-- end)


local doorCheckPaleto = false

RegisterServerEvent("srp-paleto:getGetDoorStateSV")
AddEventHandler("srp-paleto:getGetDoorStateSV", function()
    TriggerClientEvent('srp-paleto:getDoorCheckCL', -1, doorCheckPaleto)
end)

RegisterServerEvent("srp-paleto:getGetDoorStateSVSV")
AddEventHandler("srp-paleto:getGetDoorStateSVSV", function(paletoBanksDoors)
    doorCheckPaleto = paletoBanksDoors
end)

RegisterServerEvent("srp-paleto:openDoor")
AddEventHandler("srp-paleto:openDoor", function(coords, method)
    TriggerClientEvent("srp-paleto:OpenPaletoDoor", -1)
end)

RegisterServerEvent("srp-paleto:closeDoor")
AddEventHandler("srp-paleto:closeDoor", function(coords, method)
    TriggerClientEvent("srp-paleto:ClosePaletoDoor", -1)
end)