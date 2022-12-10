cooldownglobal = 0
Available = true

RegisterServerEvent("srp-fleeca:startcheck")
AddEventHandler("srp-fleeca:startcheck", function(bank)
    local _source = source
    globalonaction = true
    TriggerClientEvent('inventory:removeItem', _source, 'hacklaptop', 1)
    TriggerClientEvent("srp-fleeca:outcome", _source, true, bank)
end)

RegisterServerEvent("srp-fleeca:TimePoggers")
AddEventHandler("srp-fleeca:TimePoggers", function()
    local _source = source
    TriggerClientEvent("srp-fleeca:outcome", _source, false, "A bank as been recently robbed. You need to wait "..math.floor((fleeca.cooldown - (os.time() - cooldownglobal)) / 60)..":"..math.fmod((fleeca.cooldown - (os.time() - cooldownglobal)), 60))
end)

RegisterServerEvent("srp-fleeca:DoorAccessPoggers")
AddEventHandler("srp-fleeca:DoorAccessPoggers", function()
    local _source = source
    TriggerClientEvent("srp-fleeca:outcome", _source, false, "There is a bank currently being robbed.")
end)

RegisterServerEvent("srp-fleeca:lootup")
AddEventHandler("srp-fleeca:lootup", function(var, var2)
    TriggerClientEvent("srp-fleeca:lootup_c", -1, var, var2)
end)

RegisterServerEvent("srp-fleeca:openDoor")
AddEventHandler("srp-fleeca:openDoor", function(coords, method)
    TriggerClientEvent("srp-fleeca:openDoor_c", -1, coords, method)
end)

RegisterServerEvent("srp-fleeca:startLoot")
AddEventHandler("srp-fleeca:startLoot", function(data, name)
    TriggerClientEvent("srp-fleeca:startLoot_c", -1, data, name)
end)

RegisterServerEvent("srp-fleeca:stopHeist")
AddEventHandler("srp-fleeca:stopHeist", function(name)
    TriggerClientEvent("srp-fleeca:stopHeist_c", -1, name)
end)

RegisterServerEvent("srp-fleeca:rewardCash")
AddEventHandler("srp-fleeca:rewardCash", function()
    local reward = math.random(1, 2)
    local mathfunc = math.random(200)
    local rare = math.random(1,1)
    
    if mathfunc == 15 then
      TriggerClientEvent('srp-user:receiveItem', source, 'heistusb4', 1)
    end
    TriggerClientEvent("srp-user:receiveItem", source, "band", reward)
end)

RegisterServerEvent("srp-fleeca:setCooldown")
AddEventHandler("srp-fleeca:setCooldown", function(name)
    cooldownglobal = os.time()
    globalonaction = false
    TriggerClientEvent("srp-fleeca:resetDoorState", -1, name)
end)

RegisterServerEvent("srp-fleeca:getBanksSV")
AddEventHandler("srp-fleeca:getBanksSV", function()
    local banks = fleeca.Banks
    TriggerClientEvent('srp-fleeca:getBanks', -1, fleeca.Banks)
end)

local cooldownAttempts = 5

RegisterServerEvent("srp-fleeca:getHitSV")
AddEventHandler("srp-fleeca:getHitSV", function()
    TriggerClientEvent('srp-fleeca:getHit', -1, cooldownAttempts)
end)

RegisterServerEvent("srp-fleeca:getHitSVSV")
AddEventHandler("srp-fleeca:getHitSVSV", function(fleecaBanksTimes)
    cooldownAttempts = fleecaBanksTimes
end)

local doorCheckFleeca = false

RegisterServerEvent("srp-fleeca:getGetDoorStateSV")
AddEventHandler("srp-fleeca:getGetDoorStateSV", function()
    TriggerClientEvent('srp-fleeca:getDoorCheckCL', -1, doorCheckFleeca)
end)

RegisterServerEvent("srp-fleeca:getGetDoorStateSVSV")
AddEventHandler("srp-fleeca:getGetDoorStateSVSV", function(fleecaBanksDoors)
    doorCheckFleeca = fleecaBanksDoors
end)


RegisterServerEvent("srp-fleeca:getTimeSV")
AddEventHandler("srp-fleeca:getTimeSV", function()
    TriggerClientEvent('srp-fleeca:GetTimeCL', -1, cooldownglobal)
end)

RegisterServerEvent("srp-fleeca:getTime2SV")
AddEventHandler("srp-fleeca:getTime2SV", function()
    TriggerClientEvent('srp-fleeca:GetTime2CL', -1, (os.time() - fleeca.cooldown))
end)

RegisterServerEvent("srp-fleeca:getDoorAccessSV")
AddEventHandler("srp-fleeca:getDoorAccessSV", function()
    TriggerClientEvent('srp-fleeca:GetDoorAccessCL', -1, globalonaction)
end)

RegisterServerEvent('charge:fleeca')
AddEventHandler('charge:fleeca', function(amount, bankname)
  local _source = source
  local user = exports["srp-fw"]:getModule("Player"):GetUser(source)

    if user:getCash() >= amount then
        user:removeMoney(amount)
        TriggerClientEvent('aspect:bankemail', source, bankname)
    else
        TriggerClientEvent('DoLongHudText', source, 'You dont have enough money!', 2)
    end
end)

RegisterServerEvent('srp-robbery:server:setBankState')
AddEventHandler('srp-robbery:server:setBankState', function(bankId, state)
    if bankId == "pacific" then
       print('[QUEER]')
    else
        if not robberyBusy then
            Config.SmallBanks[bankId]["isOpened"] = state
            TriggerClientEvent('srp-robbery:client:setBankState', -1, bankId, state)
            TriggerEvent('srp-robbery:server:SetSmallbankTimeout', bankId)
            TriggerEvent('aspect:bankstore', bankId, state)
        end
    end
    robberyBusy = true
end)

RegisterServerEvent('srp-robbery:server:SetSmallbankTimeout')
 AddEventHandler('srp-robbery:server:SetSmallbankTimeout', function(BankId)
     if not robberyBusy then
        Citizen.Wait(3600000)
        Config.SmallBanks[BankId]["isOpened"] = false
        timeOut = false
        robberyBusy = false
        TriggerClientEvent('srp-robbery:client:ResetFleecaLockers', -1, BankId)
        TriggerEvent('lh-banking:server:SetBankClosed', BankId, false)
     end
 end)


local Loot = false

RegisterServerEvent('srp-fleeca:tut_tut')
AddEventHandler('srp-fleeca:tut_tut', function()
    local src = source
    if not Loot then
        Loot = true
        TriggerClientEvent('srp-fleeca:grab', src)
        Citizen.Wait(40000)
        Loot = false
    end
end)

RegisterServerEvent('voidrp-heists:fleeca_availability')
AddEventHandler('voidrp-heists:fleeca_availability', function()
    local src = source
    
    if Available then
        TriggerClientEvent('srp-heists:fleeca_available', src)
    else
        TriggerClientEvent('srp-heists:fleeca_unavailable', src)
    end
end)

RegisterServerEvent('srp-heists:fleecaBankLog')
AddEventHandler('srp-heists:fleecaBankLog', function()
    local src = source
    local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
    local charInfo = user:getCurrentCharacter()
    local pName = GetPlayerName(source)

    local connect = {
        {
          ["color"] = color,
          ["title"] = "** qpixel [Heists] **",
          ["description"] = "Steam Name: "..pName.." | Started Robbing a Fleeca Bank",
        }
      }
      PerformHttpRequest("https://discord.com/api/webhooks/1012083008263684217/pt-XMDUWT8y93DpqGme9uMX_5RfXUmg1xCJxzaps92t0wfR4WcMq9FXRD2jIr7Kf81WW", function(err, text, headers) end, 'POST', json.encode({username = "qpixel | Job Payout Log", embeds = connect, avatar_url = "https://i.imgur.com/hMqEEQp.png"}), { ['Content-Type'] = 'application/json' })
end)