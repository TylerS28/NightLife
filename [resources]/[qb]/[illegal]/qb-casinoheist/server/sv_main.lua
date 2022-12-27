QBCore = exports['qb-core']:GetCoreObject()

--- Method to get the amount of cops on duty
--- @return amount number - Amount of cops on duty
getCopCount = function()
    local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for _, Player in pairs(players) do
        if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    return amount
end

RegisterNetEvent('qb-casinoheist:server:SetPowerPlant', function(state, playerId)
    Shared.PowerplantHit = state
    TriggerClientEvent('qb-casinoheist:client:SetPowerPlant', -1, state)
    print('^3[qb-casinoheist] ^5Power Station Hit '..tostring(state)..'^7')

    if state then
        Wait(2000)
        if getCopCount() >= Shared.MinCops then
            TriggerEvent('qb-doorlock:server:updateState', 'lh34casino-shower-wall', false, false, false, true, false, true, playerId)
            print('^3[qb-casinoheist] ^5Unlocked hidden door Room 503..^7')
        else
            print('^3[qb-casinoheist] ^5Not enough cops online..^7')
        end
    end
end)

RegisterNetEvent('qb-casinoheist:server:GrabFlashlight', function()
    local src = source
    local coords = GetEntityCoords(GetPlayerPed(src))
    if #(coords - vector3(936.78, -53.47, 21.56)) > 15 then
        exports['qb-core']:ExploitBan(src, "casinoh-flashlight")
    end

    if exports['qb-inventory']:GetItemByName(src, 'weapon_flashlight') then
        TriggerClientEvent('QBCore:Notify', src, "You already have a flashlight..", "error")
    else
        exports['qb-inventory']:AddItem(src, 'weapon_flashlight', 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['weapon_flashlight'], 'add', 1)
    end
end)

AddEventHandler('explosionEvent', function(sender, ev)
    local src = tonumber(sender)
    local coords = vector3(ev.posX, ev.posY, ev.posZ)
    if ev.explosionType == 2 and #(coords - vector3(983.15, 15.74, 51.31)) < 3 then
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then return end
        Shared.TunnelHit = true
        print('^3[qb-casinoheist] ^5'..Player.PlayerData.name..' Casino Tunnel Explosion^7')
        TriggerEvent("qb-log:server:CreateLog", "casinoheist", "Tunnel Explosion", "black", "**".. Player.PlayerData.name .. "** (citizenid: *"..Player.PlayerData.citizenid.."* | id: *"..src.."*) Casino Tunnel Explosion")
        TriggerClientEvent('qb-casinoheist:client:SetTunnelHit', -1, true)
    end
end)

RegisterNetEvent('qb-casinoheist:server:RemoveThermite', function()
    local src = source
    exports['qb-inventory']:RemoveItem(src, 'thermite', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['thermite'], "remove", 1)
end)

RegisterNetEvent('qb-casinoheist:server:RemoveMagnet', function()
    local src = source
    exports['qb-inventory']:RemoveItem(src, 'casino_magnet', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['casino_magnet'], "remove", 1)
end)

QBCore.Functions.CreateCallback('qb-casinoheist:server:GetConfig', function(source, cb)
    cb(Shared)
end)

QBCore.Functions.CreateCallback('qb-casinoheist:server:GetCopCount', function(source, cb)
    local amount = getCopCount()
    cb(amount)
end)
