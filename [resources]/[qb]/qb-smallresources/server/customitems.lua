local QBCore = exports['qb-core']:GetCoreObject()


QBCore.Functions.CreateUseableItem("wingsuit_open",function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("qb-wingsuit-use", source, item.name)
end)

QBCore.Functions.CreateUseableItem("pailandshovel",function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("qb-sandcastles", source, item.name)
end)

QBCore.Functions.CreateUseableItem('legacybox' , function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('venture:legacy', source, item.name)
end)