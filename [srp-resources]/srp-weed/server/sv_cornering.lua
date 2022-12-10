RPC.register("srp-weed:startCorner", function(pSource, pCoords)
    return true
end)

RPC.register("srp-weed:cornerPed", function(pSource, pCoords, pPed, pVehicle)
    TriggerClientEvent("srp-weed:cornerPed", pSource, pPed, pCoords, pVehicle)
    return true
end)

RPC.register("srp-weed:cornerSyncHandoff", function(pSource, pCoords, pPed)
    TriggerClientEvent("srp-weed:cornerSyncHandoff", pSource, pPed)
    return true
end)

RPC.register("srp-weed:cornerSale", function(pSource, pCoords, pNetId, CurrentCornerZone, baggieInfo)
    local user = exports["srp-fw"]:getModule("Player"):GetUser(pSource)
    TriggerClientEvent("inventory:removeItem", -1, "weedbaggie", 1)
        if math.random (1,5) < 3 then
            user:addMoney(math.random(450,2500))
        end
    return true
end)

RPC.register("srp-weed:prepareBaggies", function(pSource, pInfo)
    TriggerClientEvent("inventory:removeItem", -1, "emptybaggies", CornerConfig.BaggiesPerBrick)
    return true
end)

RPC.register("srp-weed:stopCorner", function(pSource)
    TriggerLatentClientEvent('srp-weed:cleanCornerPeds',pSource)
    return false
end)