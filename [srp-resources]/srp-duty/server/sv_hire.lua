RegisterServerEvent("srp-jobsystem:addJobWhitelsitedPD")
AddEventHandler("srp-jobsystem:addJobWhitelsitedPD", function(cid, rank)
    local src = source
    exports.ghmattimysql:execute("INSERT INTO jobs_whitelist (cid, job, rank) VALUES (@cid, @job, @rank)", {['@cid'] = cid, ['@job'] = 'police', ['@rank'] = rank})
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('DoLongHudText', src, 'You hired '.. result[1].first_name ..' '.. result[1].last_name, 1)
        end
    end)
end)

RegisterServerEvent("srp-jobsystem:fireJobWhitelsitedPD")
AddEventHandler("srp-jobsystem:fireJobWhitelsitedPD", function(cid)
    local src = source
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        exports['ghmattimysql']:execute('SELECT * FROM jobs_whitelist WHERE cid = @cid', {['@cid'] = cid}, function(result2)
            if result[1] ~= nil and result2[1] ~= nil then
                if result2[1].job ~= 'police' then
                    TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = 'The person you are trying firing does not work for you!'})
                else
                    exports.ghmattimysql:execute("DELETE FROM jobs_whitelist WHERE `cid` = @cid AND `job` = @job", {['@cid'] = cid, ['@job'] = 'police'})
                    TriggerClientEvent('DoLongHudText', src, 'You fired '.. result[1].first_name ..' '.. result[1].last_name, 2)
                end
            end
        end) 
    end)
end)

-- DOJ -----------------------------------------------------------------------------------------------------------------------------------
--Judge----
RegisterServerEvent("srp-jobsystem:addJobWhitelsitedJudge")
AddEventHandler("srp-jobsystem:addJobWhitelsitedJudge", function(cid, rank)
    local src = source
    exports.ghmattimysql:execute("INSERT INTO jobs_whitelist (cid, job, rank) VALUES (@cid, @job, @rank)", {['@cid'] = cid, ['@job'] = 'judge', ['@rank'] = rank})
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('DoLongHudText', src, 'You hired '.. result[1].first_name ..' '.. result[1].last_name, 1)
        end
    end)
end)

RegisterServerEvent("srp-jobsystem:fireJobWhitelsitedJudge")
AddEventHandler("srp-jobsystem:fireJobWhitelsitedJudge", function(cid)
    local src = source
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        exports['ghmattimysql']:execute('SELECT * FROM jobs_whitelist WHERE cid = @cid', {['@cid'] = cid}, function(result2)
            if result[1] ~= nil and result2[1] ~= nil then
                if result2[1].job ~= 'judge' then
                    TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = 'You are no longer a Judge!'})
                else
                    exports.ghmattimysql:execute("DELETE FROM jobs_whitelist WHERE `cid` = @cid AND `job` = @job", {['@cid'] = cid, ['@job'] = 'judge'})
                    TriggerClientEvent('DoLongHudText', src, 'You fired '.. result[1].first_name ..' '.. result[1].last_name, 2)
                end
            end
        end) 
    end)
end)

--DA----

RegisterServerEvent("srp-jobsystem:addJobWhitelsitedDA")
AddEventHandler("srp-jobsystem:addJobWhitelsitedDA", function(cid, rank)
    local src = source
    exports.ghmattimysql:execute("INSERT INTO jobs_whitelist (cid, job, rank) VALUES (@cid, @job, @rank)", {['@cid'] = cid, ['@job'] = 'da', ['@rank'] = rank})
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('DoLongHudText', src, 'You hired '.. result[1].first_name ..' '.. result[1].last_name, 1)
        end
    end)
end)

RegisterServerEvent("srp-jobsystem:fireJobWhitelsitedDA")
AddEventHandler("srp-jobsystem:fireJobWhitelsitedDA", function(cid)
    local src = source
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        exports['ghmattimysql']:execute('SELECT * FROM jobs_whitelist WHERE cid = @cid', {['@cid'] = cid}, function(result2)
            if result[1] ~= nil and result2[1] ~= nil then
                if result2[1].job ~= 'da' then
                    TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = 'You are no longer a DA!'})
                else
                    exports.ghmattimysql:execute("DELETE FROM jobs_whitelist WHERE `cid` = @cid AND `job` = @job", {['@cid'] = cid, ['@job'] = 'da'})
                    TriggerClientEvent('DoLongHudText', src, 'You fired '.. result[1].first_name ..' '.. result[1].last_name, 2)
                end
            end
        end) 
    end)
end)

--ADA----

RegisterServerEvent("srp-jobsystem:addJobWhitelsitedADA")
AddEventHandler("srp-jobsystem:addJobWhitelsitedADA", function(cid, rank)
    local src = source
    exports.ghmattimysql:execute("INSERT INTO jobs_whitelist (cid, job, rank) VALUES (@cid, @job, @rank)", {['@cid'] = cid, ['@job'] = 'ada', ['@rank'] = rank})
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('DoLongHudText', src, 'You hired '.. result[1].first_name ..' '.. result[1].last_name, 1)
        end
    end)
end)

RegisterServerEvent("srp-jobsystem:fireJobWhitelsitedADA")
AddEventHandler("srp-jobsystem:fireJobWhitelsitedADA", function(cid)
    local src = source
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        exports['ghmattimysql']:execute('SELECT * FROM jobs_whitelist WHERE cid = @cid', {['@cid'] = cid}, function(result2)
            if result[1] ~= nil and result2[1] ~= nil then
                if result2[1].job ~= 'ada' then
                    TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = 'You are no longer a ADA!'})
                else
                    exports.ghmattimysql:execute("DELETE FROM jobs_whitelist WHERE `cid` = @cid AND `job` = @job", {['@cid'] = cid, ['@job'] = 'ada'})
                    TriggerClientEvent('DoLongHudText', src, 'You fired '.. result[1].first_name ..' '.. result[1].last_name, 2)
                end
            end
        end) 
    end)
end)

--Defender----

RegisterServerEvent("srp-jobsystem:addJobWhitelsitedDefender")
AddEventHandler("srp-jobsystem:addJobWhitelsitedDefender", function(cid, rank)
    local src = source
    exports.ghmattimysql:execute("INSERT INTO jobs_whitelist (cid, job, rank) VALUES (@cid, @job, @rank)", {['@cid'] = cid, ['@job'] = 'defender', ['@rank'] = rank})
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('DoLongHudText', src, 'You hired '.. result[1].first_name ..' '.. result[1].last_name, 1)
        end
    end)
end)

RegisterServerEvent("srp-jobsystem:fireJobWhitelsitedDefender")
AddEventHandler("srp-jobsystem:fireJobWhitelsitedDefender", function(cid)
    local src = source
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        exports['ghmattimysql']:execute('SELECT * FROM jobs_whitelist WHERE cid = @cid', {['@cid'] = cid}, function(result2)
            if result[1] ~= nil and result2[1] ~= nil then
                if result2[1].job ~= 'defender' then
                    TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = 'You are no longer a Defender!'})
                else
                    exports.ghmattimysql:execute("DELETE FROM jobs_whitelist WHERE `cid` = @cid AND `job` = @job", {['@cid'] = cid, ['@job'] = 'defender'})
                    TriggerClientEvent('DoLongHudText', src, 'You fired '.. result[1].first_name ..' '.. result[1].last_name, 2)
                end
            end
        end) 
    end)
end)

-- HEAT ----------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("srp-jobsystem:addCharacterPassHeat")
AddEventHandler("srp-jobsystem:addCharacterPassHeat", function(cid, rank)
    local src = source
    exports.ghmattimysql:execute("INSERT INTO character_passes (cid, name, rank) VALUES (@cid, @name, @rank)", {['@cid'] = cid, ['@name'] = 'heat', ['@rank'] = rank})
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('DoLongHudText', src, result[1].first_name ..' '.. result[1].last_name .. " Hired to Heat", 1)
        end
    end)
end)

RegisterServerEvent("srp-jobsystem:removeCharacterPassHeat")
AddEventHandler("srp-jobsystem:removeCharacterPassHeat", function(cid)
    local src = source
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result2)
        exports['ghmattimysql']:execute('SELECT * FROM character_passes WHERE cid = @cid', {['@cid'] = cid}, function(result)
                if result ~= nil then                
                    exports.ghmattimysql:execute("DELETE FROM character_passes WHERE `cid` = @cid AND `name` = @name", {['@cid'] = cid, ['@name'] = 'heat'})
                    TriggerClientEvent('DoLongHudText', src, result2[1].first_name .. " " .. result2[1].last_name .. " is no longer HEAT certified", 1)
                end  
        end)
    end)
end)

-- Bondi Boys ----------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("srp-jobsystem:addCharacterPassBondi")
AddEventHandler("srp-jobsystem:addCharacterPassBondi", function(cid, rank)
    local src = source
    exports.ghmattimysql:execute("INSERT INTO character_passes (cid, name, rank) VALUES (@cid, @name, @rank)", {['@cid'] = cid, ['@name'] = 'bondi_boys', ['@rank'] = rank})
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('DoLongHudText', src, result[1].first_name ..' '.. result[1].last_name .. " Hired to Bondi Boys", 1)
        end
    end)
end)

RegisterServerEvent("srp-jobsystem:removeCharacterPassBondi")
AddEventHandler("srp-jobsystem:removeCharacterPassBondi", function(cid)
    local src = source
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result2)
        exports['ghmattimysql']:execute('SELECT * FROM character_passes WHERE cid = @cid', {['@cid'] = cid}, function(result)
                if result ~= nil then                
                    exports.ghmattimysql:execute("DELETE FROM character_passes WHERE `cid` = @cid AND `name` = @name", {['@cid'] = cid, ['@name'] = 'bondi_boys'})
                    TriggerClientEvent('DoLongHudText', src, result2[1].first_name .. " " .. result2[1].last_name .. " is no longer a Bondi Boy", 1)
                end  
        end)
    end)
end)

-- Casino ----------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("srp-jobsystem:addCharacterPassCasino")
AddEventHandler("srp-jobsystem:addCharacterPassCasino", function(cid, rank)
    local src = source
    exports.ghmattimysql:execute("INSERT INTO character_passes (cid, name, rank) VALUES (@cid, @name, @rank)", {['@cid'] = cid, ['@name'] = 'casino', ['@rank'] = rank})
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('DoLongHudText', src, result[1].first_name ..' '.. result[1].last_name .. " Hired to Casino", 1)
        end
    end)
end)

RegisterServerEvent("srp-jobsystem:removeCharacterPassCasino")
AddEventHandler("srp-jobsystem:removeCharacterPassCasino", function(cid)
    local src = source
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result2)
        exports['ghmattimysql']:execute('SELECT * FROM character_passes WHERE cid = @cid', {['@cid'] = cid}, function(result)
                if result ~= nil then                
                    exports.ghmattimysql:execute("DELETE FROM character_passes WHERE `cid` = @cid AND `name` = @name", {['@cid'] = cid, ['@name'] = 'casino'})
                    TriggerClientEvent('DoLongHudText', src, result2[1].first_name .. " " .. result2[1].last_name .. " is no longer working for the Casino ", 1)
                end  
        end)
    end)
end)

-- Real Estate ----------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("srp-jobsystem:addCharacterPassRe")
AddEventHandler("srp-jobsystem:addCharacterPassRe", function(cid, rank)
    local src = source
    exports.ghmattimysql:execute("INSERT INTO character_passes (cid, name, rank) VALUES (@cid, @name, @rank)", {['@cid'] = cid, ['@name'] = 'real_estate', ['@rank'] = rank})
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('DoLongHudText', src, result[1].first_name ..' '.. result[1].last_name .. " Hired to Real Estate", 1)
        end
    end)
end)

RegisterServerEvent("srp-jobsystem:removeCharacterPassRe")
AddEventHandler("srp-jobsystem:removeCharacterPassRe", function(cid)
    local src = source
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result2)
        exports['ghmattimysql']:execute('SELECT * FROM character_passes WHERE cid = @cid', {['@cid'] = cid}, function(result)
                if result ~= nil then                
                    exports.ghmattimysql:execute("DELETE FROM character_passes WHERE `cid` = @cid AND `name` = @name", {['@cid'] = cid, ['@name'] = 'real_estate'})
                    TriggerClientEvent('DoLongHudText', src, result2[1].first_name .. " " .. result2[1].last_name .. " is no longer work for Grant!!", 1)
                end  
        end)
    end)
end)

-- Rockford Records ----------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("srp-jobsystem:addCharacterPassrr")
AddEventHandler("srp-jobsystem:addCharacterPassrr", function(cid, rank)
    local src = source
    exports.ghmattimysql:execute("INSERT INTO character_passes (cid, name, rank) VALUES (@cid, @name, @rank)", {['@cid'] = cid, ['@name'] = 'rockford_records', ['@rank'] = rank})
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('DoLongHudText', src, result[1].first_name ..' '.. result[1].last_name .. " Hired to Rockford Records", 1)
        end
    end)
end)

RegisterServerEvent("srp-jobsystem:removeCharacterPassrr")
AddEventHandler("srp-jobsystem:removeCharacterPassrr", function(cid)
    local src = source
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result2)
        exports['ghmattimysql']:execute('SELECT * FROM character_passes WHERE cid = @cid', {['@cid'] = cid}, function(result)
                if result ~= nil then                
                    exports.ghmattimysql:execute("DELETE FROM character_passes WHERE `cid` = @cid AND `name` = @name", {['@cid'] = cid, ['@name'] = 'rockford_records'})
                    TriggerClientEvent('DoLongHudText', src, result2[1].first_name .. " " .. result2[1].last_name .. " is no longer working at Rockford Records", 1)
                end  
        end)
    end)
end)

-- Yakuza ----------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("srp-jobsystem:addCharacterPassYakuza")
AddEventHandler("srp-jobsystem:addCharacterPassYakuza", function(cid, rank)
    local src = source
    exports.ghmattimysql:execute("INSERT INTO character_passes (cid, name, rank) VALUES (@cid, @name, @rank)", {['@cid'] = cid, ['@name'] = 'yakuza', ['@rank'] = rank})
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('DoLongHudText', src, result[1].first_name ..' '.. result[1].last_name .. " Hired to Yakuza", 1)
        end
    end)
end)

RegisterServerEvent("srp-jobsystem:removeCharacterPassYakuza")
AddEventHandler("srp-jobsystem:removeCharacterPassYakuza", function(cid)
    local src = source
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result2)
        exports['ghmattimysql']:execute('SELECT * FROM character_passes WHERE cid = @cid', {['@cid'] = cid}, function(result)
                if result ~= nil then                
                    exports.ghmattimysql:execute("DELETE FROM character_passes WHERE `cid` = @cid AND `name` = @name", {['@cid'] = cid, ['@name'] = 'yakuza'})
                    TriggerClientEvent('DoLongHudText', src, result2[1].first_name .. " " .. result2[1].last_name .. " is no longer Yakuza", 1)
                end  
        end)
    end)
end)

-- Winery -------------------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("srp-jobsystem:addCharacterPassWinery")
AddEventHandler("srp-jobsystem:addCharacterPassWinery", function(cid, rank)
    local src = source
    exports.ghmattimysql:execute("INSERT INTO character_passes (cid, name, rank) VALUES (@cid, @name, @rank)", {['@cid'] = cid, ['@name'] = 'winery', ['@rank'] = rank})
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('DoLongHudText', src, result[1].first_name ..' '.. result[1].last_name .. " is now eployed at Winery", 1)
        end
    end)
end)

RegisterServerEvent("srp-jobsystem:removeCharacterPassWinery")
AddEventHandler("srp-jobsystem:removeCharacterPassWinery", function(cid)
    local src = source
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result2)
        exports['ghmattimysql']:execute('SELECT * FROM character_passes WHERE cid = @cid', {['@cid'] = cid}, function(result)
                if result ~= nil then                
                    exports.ghmattimysql:execute("DELETE FROM character_passes WHERE `cid` = @cid AND `name` = @name", {['@cid'] = cid, ['@name'] = 'winery'})
                    TriggerClientEvent('DoLongHudText', src, result2[1].first_name .. " " .. result2[1].last_name .. " is no longer employed at the Winery", 1)
                end  
        end)
    end)
end)

---- Suits Hire / Fire -------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("srp-jobsystem:addCharacterPassSuits")
AddEventHandler("srp-jobsystem:addCharacterPassSuits", function(cid, rank)
    local src = source
    exports.ghmattimysql:execute("INSERT INTO character_passes (cid, name, rank) VALUES (@cid, @name, @rank)", {['@cid'] = cid, ['@name'] = 'suits', ['@rank'] = rank})
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('DoLongHudText', src, result[1].first_name ..' '.. result[1].last_name .. " is now a Suit", 1)
        end
    end)
end)

RegisterServerEvent("srp-jobsystem:removeCharacterPassSuits")
AddEventHandler("srp-jobsystem:removeCharacterPassSuits", function(cid)
    local src = source
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result2)
        exports['ghmattimysql']:execute('SELECT * FROM character_passes WHERE cid = @cid', {['@cid'] = cid}, function(result)
                if result ~= nil then                
                    exports.ghmattimysql:execute("DELETE FROM character_passes WHERE `cid` = @cid AND `name` = @name", {['@cid'] = cid, ['@name'] = 'suits'})
                    TriggerClientEvent('DoLongHudText', src, result2[1].first_name .. " " .. result2[1].last_name .. " is no longer a Suit", 1)
                end  
        end)
    end)
end)

---- AK HIRE / FIRE ----------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("srp-jobsystem:addCharacterPassAk_customs")
AddEventHandler("srp-jobsystem:addCharacterPassAk_customs", function(cid, rank)
    local src = source
    exports.ghmattimysql:execute("INSERT INTO character_passes (cid, name, rank) VALUES (@cid, @name, @rank)", {['@cid'] = cid, ['@name'] = 'ak_customs', ['@rank'] = rank})
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('DoLongHudText', src, result[1].first_name ..' '.. result[1].last_name .. " Hired to AK Customs", 1)
        end
    end)
end)

RegisterServerEvent("srp-jobsystem:removeCharacterPassAk_customs")
AddEventHandler("srp-jobsystem:removeCharacterPassAk_customs", function(cid)
    local src = source
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result2)
        exports['ghmattimysql']:execute('SELECT * FROM character_passes WHERE cid = @cid', {['@cid'] = cid}, function(result)
                if result ~= nil then                
                    exports.ghmattimysql:execute("DELETE FROM character_passes WHERE `cid` = @cid AND `name` = @name", {['@cid'] = cid, ['@name'] = 'ak_customs'})
                    TriggerClientEvent('DoLongHudText', src, result2[1].first_name .. " " .. result2[1].last_name .. " you are no longer employed at AK Customs", 1)
                end  
        end)
    end)
end)

---- Radical Coffee HIRE / FIRE ----------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("srp-jobsystem:addCharacterPassRadical")
AddEventHandler("srp-jobsystem:addCharacterPassRadical", function(cid, rank)
    local src = source
    exports.ghmattimysql:execute("INSERT INTO character_passes (cid, name, rank) VALUES (@cid, @name, @rank)", {['@cid'] = cid, ['@name'] = 'radical_coffee', ['@rank'] = rank})
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('DoLongHudText', src, result[1].first_name ..' '.. result[1].last_name .. " Hired to Radical Coffee", 1)
        end
    end)
end)

RegisterServerEvent("srp-jobsystem:removeCharacterPassRadical")
AddEventHandler("srp-jobsystem:removeCharacterPassRadical", function(cid)
    local src = source
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result2)
        exports['ghmattimysql']:execute('SELECT * FROM character_passes WHERE cid = @cid', {['@cid'] = cid}, function(result)
                if result ~= nil then                
                    exports.ghmattimysql:execute("DELETE FROM character_passes WHERE `cid` = @cid AND `name` = @name", {['@cid'] = cid, ['@name'] = 'radical_coffee'})
                    TriggerClientEvent('DoLongHudText', src, result2[1].first_name .. " " .. result2[1].last_name .. " you are no longer employed at Radical Coffee", 1)
                end  
        end)
    end)
end)

---- AOD HIRE / FIRE ----------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("srp-jobsystem:addCharacterPassAod")
AddEventHandler("srp-jobsystem:addCharacterPassAod", function(cid, rank)
    local src = source
    exports.ghmattimysql:execute("INSERT INTO character_passes (cid, name, rank) VALUES (@cid, @name, @rank)", {['@cid'] = cid, ['@name'] = 'aod', ['@rank'] = rank})
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('DoLongHudText', src, result[1].first_name ..' '.. result[1].last_name .. " Hired to AOD", 1)
        end
    end)
end)

RegisterServerEvent("srp-jobsystem:removeCharacterPassAod")
AddEventHandler("srp-jobsystem:removeCharacterPassAod", function(cid)
    local src = source
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result2)
        exports['ghmattimysql']:execute('SELECT * FROM character_passes WHERE cid = @cid', {['@cid'] = cid}, function(result)
                if result ~= nil then                
                    exports.ghmattimysql:execute("DELETE FROM character_passes WHERE `cid` = @cid AND `name` = @name", {['@cid'] = cid, ['@name'] = 'aod'})
                    TriggerClientEvent('DoLongHudText', src, result2[1].first_name .. " " .. result2[1].last_name .. " you are no longer apart of AOD", 1)
                end  
        end)
    end)
end)

---- Pearls HIRE / FIRE ----------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("srp-jobsystem:addCharacterPassPearls")
AddEventHandler("srp-jobsystem:addCharacterPassPearls", function(cid, rank)
    local src = source
    exports.ghmattimysql:execute("INSERT INTO character_passes (cid, name, rank) VALUES (@cid, @name, @rank)", {['@cid'] = cid, ['@name'] = 'pearls', ['@rank'] = rank})
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('DoLongHudText', src, result[1].first_name ..' '.. result[1].last_name .. " Hired to Pearls", 1)
        end
    end)
end)

RegisterServerEvent("srp-jobsystem:removeCharacterPassPearls")
AddEventHandler("srp-jobsystem:removeCharacterPassPearls", function(cid)
    local src = source
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result2)
        exports['ghmattimysql']:execute('SELECT * FROM character_passes WHERE cid = @cid', {['@cid'] = cid}, function(result)
                if result ~= nil then                
                    exports.ghmattimysql:execute("DELETE FROM character_passes WHERE `cid` = @cid AND `name` = @name", {['@cid'] = cid, ['@name'] = 'pearls'})
                    TriggerClientEvent('DoLongHudText', src, result2[1].first_name .. " " .. result2[1].last_name .. " you are no longer employed at Pearls", 1)
                end  
        end)
    end)
end)

---- VU HIRE / FIRE ----------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("srp-jobsystem:addCharacterPassVU")
AddEventHandler("srp-jobsystem:addCharacterPassVU", function(cid, rank)
    local src = source
    exports.ghmattimysql:execute("INSERT INTO character_passes (cid, name, rank) VALUES (@cid, @name, @rank)", {['@cid'] = cid, ['@name'] = 'vanilla_unicorn', ['@rank'] = rank})
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('DoLongHudText', src, result[1].first_name ..' '.. result[1].last_name .. " Hired to VU", 1)
        end
    end)
end)

RegisterServerEvent("srp-jobsystem:removeCharacterPassVU")
AddEventHandler("srp-jobsystem:removeCharacterPassVU", function(cid)
    local src = source
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result2)
        exports['ghmattimysql']:execute('SELECT * FROM character_passes WHERE cid = @cid', {['@cid'] = cid}, function(result)
                if result ~= nil then                
                    exports.ghmattimysql:execute("DELETE FROM character_passes WHERE `cid` = @cid AND `name` = @name", {['@cid'] = cid, ['@name'] = 'vanilla_unicorn'})
                    TriggerClientEvent('DoLongHudText', src, result2[1].first_name .. " " .. result2[1].last_name .. " you are no longer employed at VU", 1)
                end  
        end)
    end)
end)

---- EMS ------------------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("srp-jobsystem:addJobWhitelsitedEMS")
AddEventHandler("srp-jobsystem:addJobWhitelsitedEMS", function(cid, rank)
    local src = source
    exports.ghmattimysql:execute("INSERT INTO jobs_whitelist (cid, job, rank) VALUES (@cid, @job, @rank)", {['@cid'] = cid, ['@job'] = 'ems', ['@rank'] = rank})
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('DoLongHudText', src, 'You hired '.. result[1].first_name ..' '.. result[1].last_name, 1)
        end
    end)
end)

RegisterServerEvent("srp-jobsystem:fireJobWhitelsitedEMS")
AddEventHandler("srp-jobsystem:fireJobWhitelsitedEMS", function(cid)
    local src = source
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        exports['ghmattimysql']:execute('SELECT * FROM jobs_whitelist WHERE cid = @cid', {['@cid'] = cid}, function(result2)
            if result[1] ~= nil and result2[1] ~= nil then
                if result2[1].job ~= 'ems' then
                    TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = 'The person you are trying firing does not work for you!'})
                else
                    exports.ghmattimysql:execute("DELETE FROM jobs_whitelist WHERE `cid` = @cid AND `job` = @job", {['@cid'] = cid, ['@job'] = 'ems'})
                    TriggerClientEvent('DoLongHudText', src, 'You fired '.. result[1].first_name ..' '.. result[1].last_name, 2)
                end
            end
        end) 
    end)
end)

--- PDM -------------------------------------------------------------------------------------

RegisterServerEvent("srp-jobsystem:addJobWhitelsitedPDM")
AddEventHandler("srp-jobsystem:addJobWhitelsitedPDM", function(cid, rank)
    local src = source
    exports.ghmattimysql:execute("INSERT INTO jobs_whitelist (cid, job, rank) VALUES (@cid, @job, @rank)", {['@cid'] = cid, ['@job'] = 'pdm', ['@rank'] = rank})
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('DoLongHudText', src, 'You hired '.. result[1].first_name ..' '.. result[1].last_name, 1)
        end
    end)
end)

RegisterServerEvent("srp-jobsystem:fireJobWhitelsitedPDM")
AddEventHandler("srp-jobsystem:fireJobWhitelsitedPDM", function(cid)
    local src = source
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        exports['ghmattimysql']:execute('SELECT * FROM jobs_whitelist WHERE cid = @cid', {['@cid'] = cid}, function(result2)
            if result[1] ~= nil and result2[1] ~= nil then
                if result2[1].job ~= 'pdm' then
                    TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = 'The person you are trying firing does not work for you!'})
                else
                    exports.ghmattimysql:execute("DELETE FROM jobs_whitelist WHERE `cid` = @cid AND `job` = @job", {['@cid'] = cid, ['@job'] = 'pdm'})
                    TriggerClientEvent('DoLongHudText', src, 'You fired '.. result[1].first_name ..' '.. result[1].last_name, 2)
                end
            end
        end) 
    end)
end)

RegisterServerEvent("srp-jobsystem:addJobWhitelsitedNoodle")
AddEventHandler("srp-jobsystem:addJobWhitelsitedNoodle", function(cid, rank)
    local src = source
    exports.ghmattimysql:execute("INSERT INTO jobs_whitelist (cid, job, rank) VALUES (@cid, @job, @rank)", {['@cid'] = cid, ['@job'] = 'noodle_exchange', ['@rank'] = rank})
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('DoLongHudText', src, 'You hired '.. result[1].first_name ..' '.. result[1].last_name, 1)
        end
    end)
end)

RegisterServerEvent("srp-jobsystem:fireJobWhitelsitedNoodle")
AddEventHandler("srp-jobsystem:addJobWhitelsitedNoodle", function(cid)
    local src = source
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        exports['ghmattimysql']:execute('SELECT * FROM jobs_whitelist WHERE cid = @cid', {['@cid'] = cid}, function(result2)
            if result[1] ~= nil and result2[1] ~= nil then
                if result2[1].job ~= 'noodle_exchange' then
                    TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = 'The person you are trying firing does not work for you!'})
                else
                    exports.ghmattimysql:execute("DELETE FROM jobs_whitelist WHERE `cid` = @cid AND `job` = @job", {['@cid'] = cid, ['@job'] = 'noodle_exchange'})
                    TriggerClientEvent('DoLongHudText', src, 'You fired '.. result[1].first_name ..' '.. result[1].last_name, 2)
                end
            end
        end) 
    end)
end)

---- BS HIRE / FIRE ----------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("srp-jobsystem:addCharacterPassBS")
AddEventHandler("srp-jobsystem:addCharacterPassBS", function(cid, rank)
    local src = source
    exports.ghmattimysql:execute("INSERT INTO character_passes (cid, name, rank) VALUES (@cid, @name, @rank)", {['@cid'] = cid, ['@name'] = 'burger_shot', ['@rank'] = rank})
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('DoLongHudText', src, result[1].first_name ..' '.. result[1].last_name .. " Hired to burger shot", 1)
        end
    end)
end)

RegisterServerEvent("srp-jobsystem:removeCharacterPassBS")
AddEventHandler("srp-jobsystem:removeCharacterPassBS", function(cid)
    local src = source
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result2)
        exports['ghmattimysql']:execute('SELECT * FROM character_passes WHERE cid = @cid', {['@cid'] = cid}, function(result)
                if result ~= nil then                
                    exports.ghmattimysql:execute("DELETE FROM character_passes WHERE `cid` = @cid AND `name` = @name", {['@cid'] = cid, ['@name'] = 'burger_shot'})
                    TriggerClientEvent('DoLongHudText', src, result2[1].first_name .. " " .. result2[1].last_name .. " you are no longer employed at burger shot", 1)
                end  
        end)
    end)
end)


RegisterServerEvent("srp-jobsystem:addJobWhitelsitedSanders")
AddEventHandler("srp-jobsystem:addJobWhitelsitedSanders", function(cid, rank)
    local src = source
    exports.ghmattimysql:execute("INSERT INTO jobs_whitelist (cid, job, rank) VALUES (@cid, @job, @rank)", {['@cid'] = cid, ['@job'] = 'sanders', ['@rank'] = rank})
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('DoLongHudText', src, 'You hired '.. result[1].first_name ..' '.. result[1].last_name, 1)
        end
    end)
end)

RegisterServerEvent("srp-jobsystem:fireJobWhitelsitedSanders")
AddEventHandler("srp-jobsystem:fireJobWhitelsitedSanders", function(cid)
    local src = source
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        exports['ghmattimysql']:execute('SELECT * FROM jobs_whitelist WHERE cid = @cid', {['@cid'] = cid}, function(result2)
            if result[1] ~= nil and result2[1] ~= nil then
                if result2[1].job ~= 'sanders' then
                    TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = 'The person you are trying firing does not work for you!'})
                else
                    exports.ghmattimysql:execute("DELETE FROM jobs_whitelist WHERE `cid` = @cid AND `job` = @job", {['@cid'] = cid, ['@job'] = 'sanders'})
                    TriggerClientEvent('DoLongHudText', src, 'You fired '.. result[1].first_name ..' '.. result[1].last_name, 2)
                end
            end
        end) 
    end)
end)

RegisterServerEvent("srp-jobsystem:addJobWhitelsitedTow")
AddEventHandler("srp-jobsystem:addJobWhitelsitedTow", function(cid, rank)
    local src = source
    exports.ghmattimysql:execute("INSERT INTO jobs_whitelist (cid, job, rank) VALUES (@cid, @job, @rank)", {['@cid'] = cid, ['@job'] = 'towunion', ['@rank'] = rank})
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('DoLongHudText', src, 'You hired '.. result[1].first_name ..' '.. result[1].last_name, 1)
        end
    end)
end)

RegisterServerEvent("srp-jobsystem:fireJobWhitelsitedTow")
AddEventHandler("srp-jobsystem:fireJobWhitelsitedTow", function(cid)
    local src = source
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        exports['ghmattimysql']:execute('SELECT * FROM jobs_whitelist WHERE cid = @cid', {['@cid'] = cid}, function(result2)
            if result[1] ~= nil and result2[1] ~= nil then
                if result2[1].job ~= 'towunion' then
                    TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = 'The person you are trying firing does not work for you!'})
                else
                    exports.ghmattimysql:execute("DELETE FROM jobs_whitelist WHERE `cid` = @cid AND `job` = @job", {['@cid'] = cid, ['@job'] = 'towunion'})
                    TriggerClientEvent('DoLongHudText', src, 'You fired '.. result[1].first_name ..' '.. result[1].last_name, 2)
                end
            end
        end) 
    end)
end)

RegisterServerEvent("srp-jobsystem:addJobWhitelsitedWeed")
AddEventHandler("srp-jobsystem:addJobWhitelsitedWeed", function(cid, rank)
    local src = source
    exports.ghmattimysql:execute("INSERT INTO character_passes (cid, name, rank) VALUES (@cid, @name, @rank)", {['@cid'] = cid, ['@name'] = 'cosmic_cannabis', ['@rank'] = rank})
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('DoLongHudText', src, 'You hired '.. result[1].first_name ..' '.. result[1].last_name, 1)
        end
    end)
end)

RegisterServerEvent("srp-jobsystem:fireJobWhitelsitedWeed")
AddEventHandler("srp-jobsystem:fireJobWhitelsitedWeed", function(cid)
    local src = source
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        exports['ghmattimysql']:execute('SELECT * FROM character_passes WHERE cid = @cid', {['@cid'] = cid}, function(result2)
            if result[1] ~= nil and result2[1] ~= nil then
                if result2[1].name ~= 'cosmic_cannabis' then
                    TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = 'The person you are trying firing does not work for you!'})
                else
                    exports.ghmattimysql:execute("DELETE FROM character_passes WHERE `cid` = @cid AND `name` = @name", {['@cid'] = cid, ['@name'] = 'cosmic_cannabis'})
                    TriggerClientEvent('DoLongHudText', src, 'You fired '.. result[1].first_name ..' '.. result[1].last_name, 2)
                end
            end
        end) 
    end)
end)

RegisterServerEvent("srp-jobsystem:addJobWhitelsitedGal")
AddEventHandler("srp-jobsystem:addJobWhitelsitedGal", function(cid, rank)
    local src = source
    exports.ghmattimysql:execute("INSERT INTO character_passes (cid, name, rank) VALUES (@cid, @name, @rank)", {['@cid'] = cid, ['@name'] = 'art_gallery', ['@rank'] = rank})
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('DoLongHudText', src, 'You hired '.. result[1].first_name ..' '.. result[1].last_name, 1)
        end
    end)
end)

RegisterServerEvent("srp-jobsystem:fireJobWhitelsitedGal")
AddEventHandler("srp-jobsystem:fireJobWhitelsitedGal", function(cid)
    local src = source
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        exports['ghmattimysql']:execute('SELECT * FROM character_passes WHERE cid = @cid', {['@cid'] = cid}, function(result2)
            if result[1] ~= nil and result2[1] ~= nil then
                if result2[1].name ~= 'art_gallery' then
                    TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = 'The person you are trying firing does not work for you!'})
                else
                    exports.ghmattimysql:execute("DELETE FROM character_passes WHERE `cid` = @cid AND `name` = @name", {['@cid'] = cid, ['@name'] = 'art_gallery'})
                    TriggerClientEvent('DoLongHudText', src, 'You fired '.. result[1].first_name ..' '.. result[1].last_name, 2)
                end
            end
        end) 
    end)
end)

RegisterServerEvent("srp-jobsystem:addJobWhitelsitedLost")
AddEventHandler("srp-jobsystem:addJobWhitelsitedLost", function(cid, rank)
    local src = source
    exports.ghmattimysql:execute("INSERT INTO character_passes (cid, name, rank) VALUES (@cid, @name, @rank)", {['@cid'] = cid, ['@name'] = 'lostmc', ['@rank'] = rank})
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('srp-notification:client:Alert', src, {style = 'info', duration = 3000, message = 'You recruited '.. result[1].first_name ..' '.. result[1].last_name})
        end
    end)
end)

RegisterServerEvent("srp-jobsystem:fireJobWhitelsitedLost")
AddEventHandler("srp-jobsystem:fireJobWhitelsitedLost", function(cid)
    local src = source
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        exports['ghmattimysql']:execute('SELECT * FROM character_passes WHERE cid = @cid', {['@cid'] = cid}, function(result2)
            if result[1] ~= nil and result2[1] ~= nil then
                if result2[1].name ~= 'lostmc' then
                    TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = 'The person you are trying firing does not work for you!'})
                else
                    exports.ghmattimysql:execute("DELETE FROM character_passes WHERE `cid` = @cid AND `name` = @name", {['@cid'] = cid, ['@name'] = 'lostmc'})
                    TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = 'You removed '.. result[1].first_name ..' '.. result[1].last_name})
                end
            end
        end) 
    end)
end)

RegisterServerEvent("srp-jobsystem:addJobWhitelsitedRed")
AddEventHandler("srp-jobsystem:addJobWhitelsitedRed", function(cid, rank)
    local src = source
    exports.ghmattimysql:execute("INSERT INTO character_passes (cid, name, rank) VALUES (@cid, @name, @rank)", {['@cid'] = cid, ['@name'] = 'redcircle', ['@rank'] = rank})
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('srp-notification:client:Alert', src, {style = 'info', duration = 3000, message = 'You recruited '.. result[1].first_name ..' '.. result[1].last_name})
        end
    end)
end)

RegisterServerEvent("srp-jobsystem:fireJobWhitelsitedRed")
AddEventHandler("srp-jobsystem:fireJobWhitelsitedRed", function(cid)
    local src = source
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        exports['ghmattimysql']:execute('SELECT * FROM character_passes WHERE cid = @cid', {['@cid'] = cid}, function(result2)
            if result[1] ~= nil and result2[1] ~= nil then
                if result2[1].name ~= 'redcircle' then
                    TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = 'The person you are trying firing does not work for you!'})
                else
                    exports.ghmattimysql:execute("DELETE FROM character_passes WHERE `cid` = @cid AND `name` = @name", {['@cid'] = cid, ['@name'] = 'redcircle'})
                    TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = 'You removed '.. result[1].first_name ..' '.. result[1].last_name})
                end
            end
        end) 
    end)
end)

RegisterServerEvent("srp-jobsystem:addJobWhitelsitedUG")
AddEventHandler("srp-jobsystem:addJobWhitelsitedUG", function(cid, rank)
    local src = source
    exports.ghmattimysql:execute("INSERT INTO character_passes (cid, name, rank) VALUES (@cid, @name, @rank)", {['@cid'] = cid, ['@name'] = 'ug_casino', ['@rank'] = rank})
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('srp-notification:client:Alert', src, {style = 'info', duration = 3000, message = 'You recruited '.. result[1].first_name ..' '.. result[1].last_name})
        end
    end)
end)

RegisterServerEvent("srp-jobsystem:fireJobWhitelsitedUG")
AddEventHandler("srp-jobsystem:fireJobWhitelsitedUG", function(cid)
    local src = source
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        exports['ghmattimysql']:execute('SELECT * FROM character_passes WHERE cid = @cid', {['@cid'] = cid}, function(result2)
            if result[1] ~= nil and result2[1] ~= nil then
                if result2[1].name ~= 'ug_casino' then
                    TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = 'The person you are trying firing does not work for you!'})
                else
                    exports.ghmattimysql:execute("DELETE FROM character_passes WHERE `cid` = @cid AND `name` = @name", {['@cid'] = cid, ['@name'] = 'ug_casino'})
                    TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = 'You removed '.. result[1].first_name ..' '.. result[1].last_name})
                end
            end
        end) 
    end)
end)

-- RegisterCommand('hirepd', function(source, args)
-- 	local src = source
-- 	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
-- 	local cid = user:getCurrentCharacter().id
-- 	exports.ghmattimysql:execute('SELECT * FROM jobs_whitelist WHERE cid = ?', {cid}, function(result)
-- 		if result[1].job == 'police' and result[1].rank >= 7 then
-- 			TriggerClientEvent('srp-jobsystem:PoliceJobMenu', src)
-- 		else
-- 			TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = "You are not a police officer!"})
-- 		end
-- 	end)
-- end)

RegisterCommand('firepd', function(source, args)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM jobs_whitelist WHERE cid = ?', {cid}, function(result)
		if result[1].job == 'police' and result[1].rank >= 6 then
            TriggerClientEvent('srp-jobsystem:PoliceJobMenu2', src)
		else
            TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = "You are not a police officer!"})
		end
	end)
end)

RegisterCommand('hireems', function(source, args)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM jobs_whitelist WHERE cid = ?', {cid}, function(result)
		if result[1].job == 'ems' and result[1].rank >= 7 then
			TriggerClientEvent('srp-jobsystem:EMSJobMenu', src)
		else
			TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = "You are not ems!"})
		end
	end)
end)

RegisterCommand('fireems', function(source, args)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM jobs_whitelist WHERE cid = ?', {cid}, function(result)
		if result[1].job == 'ems' and result[1].rank >= 7 then
            TriggerClientEvent('srp-jobsystem:EMSJobMenu2', src)
		else
            TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = "You are not ems!"})
		end
	end)
end)

RegisterCommand('hirepdm', function(source, args)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM jobs_whitelist WHERE cid = ?', {cid}, function(result)
		if result[1].job == 'pdm' and result[1].rank >= 7 then
			TriggerClientEvent('srp-jobsystem:PDMJobMenu', src)
		else
			TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = "You are not a pdm worker!"})
		end
	end)
end)

RegisterCommand('firepdm', function(source, args)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM jobs_whitelist WHERE cid = ?', {cid}, function(result)
		if result[1].job == 'pdm' and result[1].rank >= 7 then
            TriggerClientEvent('srp-jobsystem:PDMJobMenu2', src)
		else
            TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = "You are not a pdm worker!"})
		end
	end)
end)

RegisterCommand('hiresanders', function(source, args)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM jobs_whitelist WHERE cid = ?', {cid}, function(result)
		if result[1].job == 'sanders' and result[1].rank >= 7 then
			TriggerClientEvent('srp-jobsystem:SandersJobMenu', src)
		else
			TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = "You are not a sanders worker!"})
		end
	end)
end)

RegisterCommand('firesanders', function(source, args)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM jobs_whitelist WHERE cid = ?', {cid}, function(result)
		if result[1].job == 'sanders' and result[1].rank >= 7 then
            TriggerClientEvent('srp-jobsystem:SandersJobMenu2', src)
		else
            TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = "You are not a sanders worker!"})
		end
	end)
end)

RegisterCommand('hirenoodle', function(source, args)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM jobs_whitelist WHERE cid = ?', {cid}, function(result)
		if result[1].job == 'noodle_exchange' and result[1].rank >= 7 then
			TriggerClientEvent('srp-jobsystem:NoodleJobMenu', src)
		else
			TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = "You are not an employee of Noodle Exchange!"})
		end
	end)
end)

RegisterCommand('firenoodle', function(source, args)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM jobs_whitelist WHERE cid = ?', {cid}, function(result)
		if result[1].job == 'noodle_exchange' and result[1].rank >= 7 then
            TriggerClientEvent('srp-jobsystem:NoodleJobMenu2', src)
		else
            TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = "You are not an employee of Noodle Exchange!"})
		end
	end)
end)

RegisterCommand("hirebs", function(source)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM character_passes WHERE cid = ?', {cid}, function(result)
		for i, v in pairs(result) do
			if v.name == "burger_shot" and v.rank >= 5 then
				TriggerClientEvent('srp-jobsystem:BSJobMenuHire', src)
			end
		end
	end)
end)

RegisterCommand("firebs", function(source)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM character_passes WHERE cid = ?', {cid}, function(result)
		for i, v in pairs(result) do
			if v.name == "burger_shot" and v.rank >= 5 then
				TriggerClientEvent('srp-jobsystem:BSJobMenuFire', src)
			end
		end
	end)
end)

RegisterCommand('releaseveh', function(source, args)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM jobs_whitelist WHERE cid = ?', {cid}, function(result)
		if result[1].job == 'towunion' and result[1].rank >= 7 then
            TriggerClientEvent('srp-jobsystem:releaseVehicle', src)
		else
            TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = "You are not a tow worker!"})
		end
	end)
end)

RegisterCommand('hireweed', function(source, args)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM character_passes WHERE cid = ?', {cid}, function(result)
		if result[1].name == 'cosmic_cannabis' and result[1].rank >= 4 then
			TriggerClientEvent('srp-jobsystem:WeedMenu', src)
		else
			TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = "You do not work for cosmic cannabis!"})
		end
	end)
end)

RegisterCommand('fireweed', function(source, args)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM character_passes WHERE cid = ?', {cid}, function(result)
		if result[1].name == 'cosmic_cannabis' and result[1].rank >= 4 then
            TriggerClientEvent('srp-jobsystem:WeedMenu2', src)
		else
            TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = "You do not work for cosmic cannabis!"})
		end
	end)
end)


RegisterCommand('hiregallery', function(source, args)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM character_passes WHERE cid = ?', {cid}, function(result)
		if result[1].name == 'art_gallery' and result[1].rank >= 4 then
			TriggerClientEvent('srp-jobsystem:GalMenu', src)
		else
			TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = "You do not work for the art gallery!"})
		end
	end)
end)

RegisterCommand('firegallery', function(source, args)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM character_passes WHERE cid = ?', {cid}, function(result)
		if result[1].name == 'art_gallery' and result[1].rank >= 4 then
            TriggerClientEvent('srp-jobsystem:GalMenu2', src)
		else
            TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = "You do not work for the art gallery!"})
		end
	end)
end)

RegisterCommand('hirelost', function(source, args)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM character_passes WHERE cid = ?', {cid}, function(result)
		if result[1].name == 'lostmc' and result[1].rank >= 4 then
			TriggerClientEvent('srp-jobsystem:LostMenu', src)
		else
			TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = "You are not part of the lost mc!"})
		end
	end)
end)

RegisterCommand('firelost', function(source, args)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM character_passes WHERE cid = ?', {cid}, function(result)
		if result[1].name == 'lostmc' and result[1].rank >= 4 then
            TriggerClientEvent('srp-jobsystem:LostMenu2', src)
		else
            TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = "You are not part of the lost mc!"})
		end
	end)
end)

RegisterCommand('hirered', function(source, args)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM character_passes WHERE cid = ?', {cid}, function(result)
		if result[1].name == 'redcircle' and result[1].rank >= 4 then
			TriggerClientEvent('srp-jobsystem:RedMenu', src)
		else
			TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = "You are not part of the redcircle!"})
		end
	end)
end)

RegisterCommand('firered', function(source, args)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM character_passes WHERE cid = ?', {cid}, function(result)
		if result[1].name == 'redcircle' and result[1].rank >= 4 then
            TriggerClientEvent('srp-jobsystem:RedMenu2', src)
		else
            TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = "You are not part of the redcircle!"})
		end
	end)
end)

RegisterCommand('hireug', function(source, args)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM character_passes WHERE cid = ?', {cid}, function(result)
		if result[1].name == 'ug_casino' and result[1].rank >= 4 then
			TriggerClientEvent('srp-jobsystem:UGMenu', src)
		else
			TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = "You are not part of the ug!"})
		end
	end)
end)

RegisterCommand('fireug', function(source, args)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM character_passes WHERE cid = ?', {cid}, function(result)
		if result[1].name == 'ug_casino' and result[1].rank >= 4 then
            TriggerClientEvent('srp-jobsystem:UGMenu2', src)
		else
            TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = "You are not part of the ug!"})
		end
	end)
end)

--- DOJ Hire / Fire ----------------------------------------------------------------------------

----Judge-----

RegisterCommand('hirejudge', function(source, args)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM jobs_whitelist WHERE cid = ?', {cid}, function(result)
		if result[1].job == 'judge' or 'da'  and result[1].rank >= 6 then
			TriggerClientEvent('srp-jobsystem:JudgeJobMenuHire', src)
		else
			TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = "You are now a Judge!"})
		end
	end)
end)

RegisterCommand('firejudge', function(source, args)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM jobs_whitelist WHERE cid = ?', {cid}, function(result)
		if result[1].job == 'judge' or 'da'  and result[1].rank >= 6 then
            TriggerClientEvent('srp-jobsystem:JudgeJobMenuFire', src) 
		else
            TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = "You are no longer a Judge!"})
		end
	end)
end)

----DA----

RegisterCommand('hireda', function(source, args)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM jobs_whitelist WHERE cid = ?', {cid}, function(result)
		if result[1].job == 'da' and result[1].rank >= 7 then
			TriggerClientEvent('srp-jobsystem:DAJobMenuHire', src)
		else
			TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = "You are now a DA!"})
		end
	end)
end)

RegisterCommand('fireda', function(source, args)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM jobs_whitelist WHERE cid = ?', {cid}, function(result)
		if result[1].job == 'da' and result[1].rank >= 6 then
            TriggerClientEvent('srp-jobsystem:DAJobMenuFire', src)
		else
            TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = "You are no longer a DA!"})
		end
	end)
end)

----ADA----

RegisterCommand('hireada', function(source, args)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM jobs_whitelist WHERE cid = ?', {cid}, function(result)
		if result[1].job == 'ada' or 'da' and result[1].rank >= 7 then
			TriggerClientEvent('srp-jobsystem:ADAJobMenuHire', src)
		else
			TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = "You are now a ADA!"})
		end
	end)
end)

RegisterCommand('fireada', function(source, args)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM jobs_whitelist WHERE cid = ?', {cid}, function(result)
		if result[1].job == 'ada' or 'da' and result[1].rank >= 6 then
            TriggerClientEvent('srp-jobsystem:ADAJobMenuFire', src)
		else
            TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = "You are no longer a ADA!"})
		end
	end)
end)

----Defender----

RegisterCommand('hiredefender', function(source, args)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM jobs_whitelist WHERE cid = ?', {cid}, function(result)
		if result[1].job == 'defender' or 'da' and result[1].rank >= 7 then
			TriggerClientEvent('srp-jobsystem:DefenderJobMenuHire', src)
		else
			TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = "You are now a Public Defender!"})
		end
	end)
end)

RegisterCommand('firedefender', function(source, args)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM jobs_whitelist WHERE cid = ?', {cid}, function(result)
		if result[1].job == 'defender' or 'da' and result[1].rank >= 6 then
            TriggerClientEvent('srp-jobsystem:DefenderJobMenuFire', src)
		else
            TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = "You are no longer a Pulic Defender!"})
		end
	end)
end)

--- Tow ---------------------

RegisterCommand('hiretow', function(source, args)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM jobs_whitelist WHERE cid = ?', {cid}, function(result)
		if result[1].job == 'towunion' and result[1].rank >= 7 then
			TriggerClientEvent('srp-jobsystem:TowJobMenuHire', src)
		else
			TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = "You are now a Union member!"})
		end
	end)
end)

RegisterCommand('firetow', function(source, args)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM jobs_whitelist WHERE cid = ?', {cid}, function(result)
		if result[1].job == 'towunion' and result[1].rank >= 6 then
            TriggerClientEvent('srp-jobsystem:TowJobMenuFire', src)
		else
            TriggerClientEvent('srp-notification:client:Alert', src, {style = 'error', duration = 3000, message = "You are not Union member!"})
		end
	end)
end)

---------- VU Hire / Fire ----------------------------------------------------

RegisterCommand("hirevu", function(source)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM character_passes WHERE cid = ?', {cid}, function(result)
		for i, v in pairs(result) do
			if v.name == "vanilla_unicorn" and v.rank >= 5 then
				TriggerClientEvent('srp-jobsystem:VUJobMenuHire', src)
			end
		end
	end)
end)

RegisterCommand("firevu", function(source)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM character_passes WHERE cid = ?', {cid}, function(result)
		for i, v in pairs(result) do
			if v.name == "vanilla_unicorn" and v.rank >= 5 then
				TriggerClientEvent('srp-jobsystem:VUJobMenuFire', src)
			end
		end
	end)
end)

---------- UG Casino Hire / Fire ----------------------------------------------------

RegisterCommand("hireugcasino", function(source)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM character_passes WHERE cid = ?', {cid}, function(result)
		for i, v in pairs(result) do
			if v.name == "ug_casino" and v.rank >= 5 then
				TriggerClientEvent('srp-jobsystem:ugCasinoJobMenuHire', src)
			end
		end
	end)
end)

RegisterServerEvent("srp-jobsystem:addCharacterPassUgCasino")
AddEventHandler("srp-jobsystem:addCharacterPassUgCasino", function(cid, rank)
    local src = source
    exports.ghmattimysql:execute("INSERT INTO character_passes (cid, name, rank) VALUES (@cid, @name, @rank)", {['@cid'] = cid, ['@name'] = 'ug_casino', ['@rank'] = rank})
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('DoLongHudText', src, result[1].first_name ..' '.. result[1].last_name .. " is now hired", 1)
        end
    end)
end)

RegisterCommand("fireugcasino", function(source)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	exports.ghmattimysql:execute('SELECT * FROM character_passes WHERE cid = ?', {cid}, function(result)
		for i, v in pairs(result) do
			if v.name == "ug_casino" and v.rank >= 5 then
				TriggerClientEvent('srp-jobsystem:ugCasinoJobMenuFire', src)
			end
		end
	end)
end)

RegisterServerEvent("srp-jobsystem:removeCharacterPassUgCasino")
AddEventHandler("srp-jobsystem:removeCharacterPassUgCasino", function(cid)
    local src = source
    exports['ghmattimysql']:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result2)
        exports['ghmattimysql']:execute('SELECT * FROM character_passes WHERE cid = @cid', {['@cid'] = cid}, function(result)
                if result ~= nil then                
                    exports.ghmattimysql:execute("DELETE FROM character_passes WHERE `cid` = @cid AND `name` = @name", {['@cid'] = cid, ['@name'] = 'ug_casino'})
                    TriggerClientEvent('DoLongHudText', src, "You have fired " .. result2[1].first_name .. " " .. result2[1].last_name, 2)
                end  
        end)
    end)
end)