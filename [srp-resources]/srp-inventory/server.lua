RegisterServerEvent("srp-inventory:cash:remove")
AddEventHandler("srp-inventory:cash:remove", function(src,amount)
    local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
    user:removeMoney(tonumber(amount))
end)

RegisterServerEvent('srp-inventory:addCashInkset')
AddEventHandler('srp-inventory:addCashInkset', function(amount)
    local user = exports['srp-fw']:getModule("Player"):GetUser(source)
    local charInfo = user:getCurrentCharacter()
    local identifiers = GetPlayerIdentifiers(source)

    user:addMoney(amount)

    local connect = {
        {
          ["color"] = color,
          ["title"] = "** srp [Inventory] | Inked Money Bag **",
          ["description"] = "Inked Money Bag Log | Amount: $"..amount.. "\n State ID: ".. charInfo.id .. "\n Steam ID: "..identifiers[1],
        }
      }
      PerformHttpRequest("https://discord.com/api/webhooks/1012082763383443506/t6A19Euf_ky1OmsjGIhTvmv35XVjiL5UaSqyvrHbiwK6ckSz64OcFLQqJw0CVl8VeyfG", function(err, text, headers) end, 'POST', json.encode({username = "qpixel | Job Payout Log", embeds = connect, avatar_url = "https://i.imgur.com/hMqEEQp.png"}), { ['Content-Type'] = 'application/json' })
end)

AddEventHandler('inventory:saveHoneyItem', function(pSource, pItemId, pAmount, pCost, pTargetInv)
    local user = exports["srp-fw"]:getModule("Player"):GetUser(pSource)

    if not user then return end

    exports["srp-log"]:AddLog("Exploiter", user, ("User duped inventory item [%s]x%s"):format(pItemId or 'N/A', pAmount or 'N/A'), { item = pItemId, amount = pAmount, target = pTargetInv})
end)

AddEventHandler('onResourceStart', function(resource)    
	if resource == GetCurrentResourceName() then
    print('DELETE ALL DROPS')
    exports.oxmysql:execute( "DELETE FROM user_inventory2 WHERE name like '%Drop-%'" )
	end
end)