local license = 0

local licenseArray = {}

RegisterServerEvent('srp-heists:check_if_robbed')
AddEventHandler('srp-heists:check_if_robbed', function(license)

local _source = source

if licenseArray[#licenseArray] ~= nil then
    for k, v in pairs(licenseArray) do
        if v == license then
        return
        end
    end
end

licenseArray[#licenseArray+1] = license

    TriggerClientEvent('sec:AllowHeist', _source)
end)

RegisterServerEvent('srp-heists:bankTruckLog')
AddEventHandler('srp-heists:bankTruckLog', function()
    local src = source
    local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
    local charInfo = user:getCurrentCharacter()
    local pName = GetPlayerName(source)

    local connect = {
        {
          ["color"] = color,
          ["title"] = "** qpixel [Heists] **",
          ["description"] = "Steam Name: "..pName.." | Started Robbing a Bank Truck",
        }
      }
      PerformHttpRequest("https://discord.com/api/webhooks/1012083110910894080/0mkEVrdq6hsTWoctJakXeKeeqRYL_2vVDvFJvTt4-9w_I0OVG2SmP0qNeC2y8bp9fkHr", function(err, text, headers) end, 'POST', json.encode({username = "qpixel | Job Payout Log", embeds = connect, avatar_url = "https://i.imgur.com/hMqEEQp.png"}), { ['Content-Type'] = 'application/json' })
end)