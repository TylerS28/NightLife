previewEnabled = false
local usedItemId, usedItemSlot, usedItemMetadata

RegisterNetEvent("srp-racing:addedActiveRace")
AddEventHandler("srp-racing:addedActiveRace", function(race)
    print("ADDING ACTIVE RACE")
    activeRaces[race.id] = race

    if not config.nui.hudOnly then
        SendNUIMessage({
            activeRaces = activeRaces
        })
    end

    TriggerEvent("srp-racing:api:addedActiveRace", race, activeRaces)
    TriggerEvent("srp-racing:api:updatedState", { activeRaces = activeRaces })
end)

RegisterNetEvent("srp-racing:removedActiveRace")
AddEventHandler("srp-racing:removedActiveRace", function(id)
    print("REMOVE ACTIVE RACE")
    activeRaces[id] = nil

    if not config.nui.hudOnly then
        SendNUIMessage({
            activeRaces = activeRaces
        })
    end

    TriggerEvent("srp-racing:api:removedActiveRace", activeRaces)
    TriggerEvent("srp-racing:api:updatedState", { activeRaces = activeRaces })
end)

RegisterNetEvent("srp-racing:updatedActiveRace")
AddEventHandler("srp-racing:updatedActiveRace", function(race)
    if activeRaces[race.id] then
        activeRaces[race.id] = race
    end

    if not config.nui.hudOnly then
        SendNUIMessage({
            activeRaces = activeRaces
        })
    end

    TriggerEvent("srp-racing:api:updatedActiveRace", activeRaces)
    TriggerEvent("srp-racing:api:updatedState", { activeRaces = activeRaces })
end)

RegisterNetEvent("srp-racing:endRace")
AddEventHandler("srp-racing:endRace", function(race)
    print("RACE FUCKING END")
    SendNUIMessage({
        showHUD = false
    })

    TriggerEvent("srp-racing:api:raceEnded", race)
    TriggerEvent('srp-racing:srp-racing:api:updatedStat')
    cleanupRace()
end)

RegisterNetEvent("srp-racing:raceHistory")
AddEventHandler("srp-racing:raceHistory", function(race)
    finishedRaces[#finishedRaces + 1] = race

    if race then
        if not config.nui.hudOnly then
            SendNUIMessage({
                leaderboardData = race
            })
        end
    end

    TriggerEvent("srp-racing:api:raceHistory", race)
    TriggerEvent("srp-racing:api:updatedState", { finishedRaces = finishedRaces })
end)

RegisterNetEvent("srp-racing:startRace")
AddEventHandler("srp-racing:startRace", function(race, startTime)
    TriggerEvent("srp-racing:api:startingRace", startTime)
    -- Wait for race countdown
    Citizen.Wait(startTime - 3000)

    SendNUIMessage({
        type = "countdown",
        start = 3,
    })

    PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS")
    Citizen.Wait(1000)
    PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS")
    Citizen.Wait(1000)
    PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS")
    Citizen.Wait(1000)
    PlaySoundFrontend(-1, "Oneshot_Final", "MP_MISSION_COUNTDOWN_SOUNDSET")

    if not curRace then
        initRace(race)
        TriggerEvent("srp-racing:api:raceStarted", race)
    end
end)

RegisterNetEvent("srp-racing:updatePosition")
AddEventHandler("srp-racing:updatePosition", function(position)
    -- print("Position is now: " .. position)
    SendNUIMessage({
        HUD = { position = position }
    })
end)

RegisterNetEvent("srp-racing:dnfRace")
AddEventHandler("srp-racing:dnfRace", function()
    SendNUIMessage({
        HUD = { dnf = true }
    })

    TriggerEvent("srp-racing:api:dnfRace", race)
end)

RegisterNetEvent("srp-racing:startDNFCountdown")
AddEventHandler("srp-racing:startDNFCountdown", function(dnfTime)
    SendNUIMessage({
        HUD = { dnfTime = dnfTime }
    })
end)

function round(x, n) 
    return tonumber(string.format("%." .. n .. "f", x))
end

RegisterNetEvent("srp-racing:finishedRace")
AddEventHandler("srp-racing:finishedRace", function(position, time, pEnterAmt)
    if position == 1 then
        RPC.execute('srp-racing:awardPlayer', math.random(40, 50) + round(pEnterAmt / 6, 0))
    elseif position == 2 then
        RPC.execute('srp-racing:awardPlayer', math.random(20, 30))
    elseif position == 3 then
        RPC.execute('srp-racing:awardPlayer', math.random(10))
    end
    SendNUIMessage({
        HUD = {
            position = position,
            finished = time,
        }
    })
end)

RegisterNetEvent("srp-racing:joinedRace")
AddEventHandler("srp-racing:joinedRace", function(race)
    race.start.pos = tableToVector3(race.start.pos)
    spawnCheckpointObjects(race.start, config.startObjectHash)
end)

RegisterNetEvent("srp-racing:leftRace")
AddEventHandler("srp-racing:leftRace", function()
    cleanupProps()
    TriggerEvent('srp-racing:api:updatedState')
end)

RegisterNetEvent("srp-racing:playerJoinedYourRace")
AddEventHandler("srp-racing:playerJoinedYourRace", function(characterId, name)
    if characterId == getCharacterId() then return end

    TriggerEvent("srp-racing:api:playerJoinedYourRace", characterId, name)
end)

RegisterNetEvent("srp-racing:playerLeftYourRace")
AddEventHandler("srp-racing:playerLeftYourRace", function(characterId, name)
    if characterId == getCharacterId() then return end

    TriggerEvent("srp-racing:api:playerLeftYourRace", characterId, name)
end)

RegisterNetEvent("srp-racing:addedPendingRace")
AddEventHandler("srp-racing:addedPendingRace", function(race)
    pendingRaces[race.id] = race
    if not config.nui.hudOnly then
        SendNUIMessage({
            pendingRaces = pendingRaces
        })
    end

    TriggerEvent("srp-racing:api:addedPendingRace", race, pendingRaces)
    TriggerEvent("srp-racing:api:updatedState", { pendingRaces = pendingRaces })
end)

RegisterNetEvent("srp-racing:removedPendingRace")
AddEventHandler("srp-racing:removedPendingRace", function(id)
    pendingRaces[id] = nil

    SendNUIMessage({ pendingRaces = pendingRaces })

    TriggerEvent("srp-racing:api:removedPendingRace", pendingRaces)
    TriggerEvent("srp-racing:api:updatedState", {pendingRaces=pendingRaces})
end)

RegisterNetEvent("srp-racing:startCreation")
AddEventHandler("srp-racing:startCreation", function()
    startRaceCreation()
end)

RegisterNetEvent("srp-racing:addedRace")
AddEventHandler("srp-racing:addedRace", function(newRace, newRaces)
    if not races then return end
    races = newRaces

    SendNUIMessage({
        races = newRaces
    })

    TriggerEvent("srp-racing:api:addedRace")
    TriggerEvent("srp-racing:api:updatedState", {races=races})
end)

local function openAliasTextbox()
  exports['srp-interface']:openApplication('textbox', {
    callbackUrl = 'srp-interface:racing:input:alias',
    key = 1,
    items = {{icon = "pencil-alt", label = "Alias", name = "alias"}},
    show = true
  })
end

AddEventHandler("srp-inventory:itemUsed", function(item, metadata, inventoryName, slot)
  if item ~= "racingusb2" then return end
  usedItemId = item
  usedItemSlot = slot
  usedItemMetadata = json.decode(metadata)

  local characterId = exports["isPed"]:isPed("cid")
  if characterId ~= usedItemMetadata.characterId then
    TriggerEvent("DoLongHudText", "You don't own this usb!", 2)
    return
  end

  if usedItemMetadata.Alias then
    TriggerEvent("DoLongHudText", "Alias can't be changed for this usb!", 2)
    return
  end

  openAliasTextbox()
end)

RegisterInterfaceCallback("srp-interface:racing:input:alias", function(data, cb)
  cb({data = {}, meta = {ok = true, message = ''}})
  exports['srp-interface']:closeApplication('textbox')
  local alias = data.values.alias

  if usedItemMetadata.Alias then return end

  if not alias then
    TriggerEvent("DoLongHudText", "No alias entered!", 2)
    return
  end

  local success, msg = RPC.execute("srp-racing:setAlias", usedItemId, usedItemSlot, usedItemMetadata, alias)
  if success then
    exports["srp-phone"]:phoneNotification("racen", "Welcome to the underground, " .. alias .. ".", "From the PM", 5000)
  else
    TriggerEvent("DoLongHudText", msg or "Alias could not be set.", 2)
    if msg == "Alias already taken!" then
      openAliasTextbox()
    end
  end
end)

-- RegisterCommand("srp-racing:giveRacingUSB", function()
--     RPC.execute("srp-racing:giveRacingUSB")
-- end)

AddEventHandler("onResourceStop", function (resourceName)
    if resourceName ~= GetCurrentResourceName() then return end

    cleanupProps()
    clearBlips()
    ClearGpsMultiRoute()
end)

RegisterNetEvent('srp-racing:api:currentRace')
AddEventHandler("srp-racing:api:currentRace", function(currentRace)
    print(json.encode(currentRace))
    -- print("FUCK THIS SHIT HERE******************************************************")
    isRacing = currentRace ~= nil
    if isRacing then
        startBubblePopper(currentRace)
    end
end)