RegisterServerEvent('srp-jobs:dodoLogisticsPayout')
AddEventHandler('srp-jobs:dodoLogisticsPayout', function()
    local src = tonumber(source)
    local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
    local payment = math.random(250, 325)

    user:addBank(payment)
    TriggerClientEvent('DoLongHudText', src, 'You completed the delivery and got $'..payment , 1)
end)