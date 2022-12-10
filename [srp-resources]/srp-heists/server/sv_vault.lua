RegisterServerEvent("utk_oh:openvault")
AddEventHandler("utk_oh:openvault", function(method)
    TriggerClientEvent("utk_oh:openvault_c", -1, method)
end)

local pLootLowerVault = false

RegisterServerEvent('srp-heists:loot_tray')
AddEventHandler('srp-heists:loot_tray', function()
    local src = source
    if not pLootLowerVault then
        pLootLowerVault = true
        TriggerClientEvent('srp-vault:grab', src)
        Citizen.Wait(40000)
        pLootLowerVault = false
    end
end)

RegisterServerEvent('srp-heists:cash_tray')
AddEventHandler('srp-heists:cash_tray', function()
    local src = source
    if not Loot then
        Loot = true
        TriggerClientEvent('srp-heists:grab_from_tray', src)
        Citizen.Wait(40000)
        Loot = false
    end
end)

RegisterServerEvent('srp-heists:vaultRobberyLog')
AddEventHandler('srp-heists:vaultRobberyLog', function()
    local src = source
    local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
    local charInfo = user:getCurrentCharacter()
    local pName = GetPlayerName(source)

    local connect = {
        {
          ["color"] = color,
          ["title"] = "** qpixel [Heists] **",
          ["description"] = "Steam Name: "..pName.." | Started Robbing The Vault",
        }
      }
      PerformHttpRequest("https://discord.com/api/webhooks/1012082919445106811/nW6Q9_stfzsaLFNGqvSRhzQnF3ppoPPvWEIXX0hFihYgUwzuiP3PdQ1odUvNHehJ8U02", function(err, text, headers) end, 'POST', json.encode({username = "qpixel | Job Payout Log", embeds = connect, avatar_url = "https://i.imgur.com/hMqEEQp.png"}), { ['Content-Type'] = 'application/json' })
end)