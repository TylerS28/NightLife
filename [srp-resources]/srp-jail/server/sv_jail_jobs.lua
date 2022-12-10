-- Jail Jobs Reduce Time --

RegisterServerEvent('srp-jail:removeTime')
AddEventHandler("srp-jail:removeTime", function(pAmt)
    local src = source
    local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    exports.oxmysql:execute("SELECT * FROM `characters` WHERE id = @cid", {['cid'] = char.id}, function(data)
        local recent = tonumber(data[1].jail_time)
        exports.oxmysql:execute("UPDATE `characters` SET `jail_time` = @time WHERE `id` = @cid", {['time'] = recent - tonumber(pAmt), ['cid'] = char.id})
    end)
end)