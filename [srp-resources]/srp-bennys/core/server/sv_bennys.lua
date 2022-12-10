local hmm = vehicleBaseRepairCost

RegisterServerEvent('srp-bennys:attemptPurchase')
AddEventHandler('srp-bennys:attemptPurchase', function(cheap, type, upgradeLevel)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
    if type == "repair" then
        if user:getCash() >= hmm then
            user:removeMoney(hmm)
            TriggerClientEvent('srp-bennys:purchaseSuccessful', src)

            exports["srp-log"]:AddLog("Bennys", 
                src, 
                "Repair", 
                { amount = tostring(hmm) })
        else
            TriggerClientEvent('srp-bennys:purchaseFailed', src)
        end
    elseif type == "performance" then
        if user:getCash() >= vehicleCustomisationPrices[type].prices[upgradeLevel] then
            TriggerClientEvent('srp-bennys:purchaseSuccessful', src)
            user:removeMoney(vehicleCustomisationPrices[type].prices[upgradeLevel])

            exports["srp-log"]:AddLog("Bennys", 
                src, 
                "Performance", 
                { amount = tostring(vehicleCustomisationPrices[type].prices[upgradeLevel]) })
        else
            TriggerClientEvent('srp-bennys:purchaseFailed', src)
        end
    else
        if user:getCash() >= vehicleCustomisationPrices[type].price then
            TriggerClientEvent('srp-bennys:purchaseSuccessful', src)
            user:removeMoney(vehicleCustomisationPrices[type].price)

            exports["srp-log"]:AddLog("Bennys", 
                src, 
                "Other", 
                { type = tostring(type), amount = tostring(vehicleCustomisationPrices[type].price) })
        else
            TriggerClientEvent('srp-bennys:purchaseFailed', src)
        end
    end
end)

RegisterServerEvent('srp-bennys:updateRepairCost')
AddEventHandler('srp-bennys:updateRepairCost', function(cost)
    hmm = cost
end)

RegisterServerEvent('srp-bennys:repairciv')
AddEventHandler('srp-bennys:repairciv', function(amount)
    local src = source
    local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
    if (user:getCash() >= amount) then
        user:removeMoney(amount)
        TriggerClientEvent("bennys:civ:repair:cl", src)

        exports["srp-log"]:AddLog("Bennys", 
            src, 
            "Repair Civ", 
            { amount = tostring(amount) })
    end
end)

RegisterServerEvent('srp-bennys:payPublicBennys')
AddEventHandler('srp-bennys:payPublicBennys', function()
    local src = source
    local user = exports["srp-fw"]:getModule("Player"):GetUser(src)

    if user:getCash() >= 250 then
        user:removeMoney(250)
        TriggerClientEvent('srp-bennys:repairVeh', src)
        TriggerEvent('DoLongHudText', "You Have Been Charged For: $750!", 2)
    else
        TriggerClientEvent('DoLongHudText', src, 'You need $750', 2)
    end
end)
