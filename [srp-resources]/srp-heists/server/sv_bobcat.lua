pCanBlow = false
canloot = false

RegisterServerEvent("srp-bobcat:effect")
AddEventHandler("srp-bobcat:effect", function(method)
    TriggerClientEvent("lumo:effectoutside", -1, method)
end)

RegisterServerEvent("srp-bobcat:effect2")
AddEventHandler("srp-bobcat:effect2", function(method)
    TriggerClientEvent("lumo:effectinside", -1, method)
end)

RegisterServerEvent("srp-bobcat:bubbles")
AddEventHandler("srp-bobcat:bubbles", function()
    canloot = true
    TriggerClientEvent("srp-bobcat:bubbles", -1)
end)

local searched1 = false
local searched2 = false
local searched3 = false

RegisterServerEvent("srp-bobcat:search_crate_1")
AddEventHandler("srp-bobcat:search_crate_1", function()
    local source = source
    
    if searched1 then
        TriggerClientEvent("DoLongHudText", source, "Already Searched")
    elseif canloot then
        TriggerClientEvent("srp-bobcat:search_crate_1", source)
        searched1 = true
    end
end)

RegisterServerEvent("srp-bobcat:search_crate_2")
AddEventHandler("srp-bobcat:search_crate_2", function()
    local source = source
    
    if searched2 then
        TriggerClientEvent("DoLongHudText", source, "Already Searched")
    elseif canloot then
        TriggerClientEvent("srp-bobcat:search_crate_2", source)
        searched2 = true
    end
end)

RegisterServerEvent("srp-bobcat:search_crate_3")
AddEventHandler("srp-bobcat:search_crate_3", function()
    local source = source
    
    if searched3 then
        TriggerClientEvent("DoLongHudText", source, "Already Searched")
    elseif canloot then
        TriggerClientEvent("srp-bobcat:search_crate_3", source)
        searched3 = true
    end
end)

RegisterServerEvent("aspect:particleserver")
AddEventHandler("aspect:particleserver", function(method)
    TriggerClientEvent("aspect:ptfxparticle", -1, method)
end)

RegisterServerEvent('srp-bobcat:blow_door')
AddEventHandler('srp-bobcat:blow_door', function()
    if not pCanBlow then
        pCanBlow = true
        TriggerClientEvent('srp-heists:explosion_ped_walk', source)
    end
end)

RegisterServerEvent('srp-heists:bobcatLog')
AddEventHandler('srp-heists:bobcatLog', function()
    local src = source
    local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
    local charInfo = user:getCurrentCharacter()
    local pName = GetPlayerName(source)

    local connect = {
        {
          ["color"] = color,
          ["title"] = "** qpixel [Heists] **",
          ["description"] = "Steam Name: "..pName.." | Started Robbing Bobcat Security",
        }
      }
      PerformHttpRequest("https://discord.com/api/webhooks/1012083045362315294/zediHwvM85za47VQMbE2pFzan7E0FGKScelN0ue9s2CTYTXSRsXhJ1kPA1EQwHUc4rnQ", function(err, text, headers) end, 'POST', json.encode({username = "qpixel | Job Payout Log", embeds = connect, avatar_url = "https://i.imgur.com/hMqEEQp.png"}), { ['Content-Type'] = 'application/json' })
end)