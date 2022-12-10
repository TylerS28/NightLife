-- CLOSE APP
function SetUIFocus(hasKeyboard, hasMouse)
    --  HasNuiFocus = hasKeyboard or hasMouse
    
      SetNuiFocus(hasKeyboard, hasMouse)
    
      -- TriggerEvent("srp-voice:focus:set", HasNuiFocus, hasKeyboard, hasMouse)
      -- TriggerEvent("srp-binds:should-execute", not HasNuiFocus)
    end
    
    exports('SetUIFocus', SetUIFocus)
    
    RegisterNUICallback("srp-ui:closeApp", function(data, cb)
        SetUIFocus(false, false)
        cb({data = {}, meta = {ok = true, message = 'done'}})
        Wait(800)
        TriggerEvent("attachedItems:block",false)
    end)
    
    RegisterNUICallback("srp-ui:applicationClosed", function(data, cb)
        TriggerEvent("srp-ui:application-closed", data.name, data)
        cb({data = {}, meta = {ok = true, message = 'done'}})
    end)
    
    -- FORCE CLOSE
    RegisterCommand("srp-ui:force-close", function()
        SendUIMessage({source = "srp-nui", app = "", show = false});
        SetUIFocus(false, false)
    end, false)
    
    -- SMALL MAP
    RegisterCommand("srp-ui:small-map", function()
      SetRadarBigmapEnabled(false, false)
    end, false)
    
    local function restartUI(withMsg)
      SendUIMessage({ source = "srp-nui", app = "main", action = "restart" });
      if withMsg then
        TriggerEvent("DoLongHudText", "You can also use 'ui-r' as a shorter version to restart!")
      end
      Wait(5000)
      TriggerEvent("srp-ui:restarted")
      SendUIMessage({ app = "hud", data = { display = true }, source = "srp-nui" })
      local cj = exports["police"]:getCurrentJob()
      if cj ~= "unemployed" then
        TriggerEvent("srp-jobmanager:playerBecameJob", cj)
        TriggerServerEvent("srp-jobmanager:fixPaychecks", cj)
      end
      loadPublicData()
    end
    RegisterCommand("srp-ui:restart", function() restartUI(true) end, false)
    RegisterCommand("ui-r", function() restartUI() end, false)
    RegisterNetEvent("srp-ui:server-restart")
    AddEventHandler("srp-ui:server-restart", restartUI)
    
    RegisterCommand("srp-ui:debug:show", function()
        SendUIMessage({ source = "srp-nui", app = "debuglogs", data = { display = true } });
    end, false)
    
    RegisterCommand("srp-ui:debug:hide", function()
        SendUIMessage({ source = "srp-nui", app = "debuglogs", data = { display = false } });
    end, false)
    
    RegisterNUICallback("srp-ui:resetApp", function(data, cb)
        SetUIFocus(false, false)
        cb({data = {}, meta = {ok = true, message = 'done'}})
        sendCharacterData()
    end)
    
    RegisterNetEvent("srp-ui:server-relay")
    AddEventHandler("srp-ui:server-relay", function(data)
        SendUIMessage(data)
    end)
    
    RegisterNetEvent("isJudge")
    AddEventHandler("isJudge", function()
      sendAppEvent("character", { job = "judge" })
    end)
    
    RegisterNetEvent("isJudgeOff")
    AddEventHandler("isJudgeOff", function()
      sendAppEvent("character", { job = "unemployed" })
    end)
    
    RegisterNetEvent("srp-jobmanager:playerBecameJob")
    AddEventHandler("srp-jobmanager:playerBecameJob", function(job)
      sendAppEvent("character", { job = job })
    end)
    