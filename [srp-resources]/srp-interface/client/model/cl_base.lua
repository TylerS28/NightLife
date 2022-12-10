-- CLOSE APP
function SetInterfaceFocus(hasKeyboard, hasMouse)
  SetNuiFocus(hasKeyboard, hasMouse)
end

exports('SetInterfaceFocus', SetInterfaceFocus)

RegisterNUICallback("srp-interface:closeApp", function(data, cb)
    SetInterfaceFocus(false, false)
    cb({data = {}, meta = {ok = true, message = 'done'}})
    Wait(800)
    TriggerEvent("attachedItems:block",false)
end)

RegisterNUICallback("srp-interface:applicationClosed", function(data, cb)
    TriggerEvent("srp-interface:application-closed", data.name, data)
    cb({data = {}, meta = {ok = true, message = 'done'}})
end)

-- FORCE CLOSE
RegisterCommand("srp-interface:force-close", function()
    SendInterfaceMessage({source = "srp-nui", app = "", show = false});
    SetInterfaceFocus(false, false)
end, false)

-- SMALL MAP
RegisterCommand("srp-interface:small-map", function()
  SetRadarBigmapEnabled(false, false)
end, false)

local function restartUI(withMsg)
  SendInterfaceMessage({ source = "srp-nui", app = "main", action = "restart" });
  if withMsg then
    TriggerEvent("DoLongHudText", "You can also use 'ui-r' as a shorter version to restart!")
  end
  Wait(5000)
  TriggerEvent("srp-interface:restarted")
  SendInterfaceMessage({ app = "hud", data = { display = true }, source = "srp-nui" })
  local cj = exports["police"]:getCurrentJob()
end
RegisterCommand("srp-interface:restart", function() restartUI(true) end, false)
RegisterCommand("ui-r", function() restartUI() end, false)
RegisterNetEvent("srp-interface:server-restart")
AddEventHandler("srp-interface:server-restart", restartUI)

RegisterCommand("srp-interface:debug:show", function()
    SendInterfaceMessage({ source = "srp-nui", app = "debuglogs", data = { display = true } });
end, false)

RegisterCommand("srp-interface:debug:hide", function()
    SendInterfaceMessage({ source = "srp-nui", app = "debuglogs", data = { display = false } });
end, false)

RegisterNUICallback("srp-interface:resetApp", function(data, cb)
    SetInterfaceFocus(false, false)
    cb({data = {}, meta = {ok = true, message = 'done'}})
    --sendCharacterData()
end)

RegisterNetEvent("srp-interface:server-relay")
AddEventHandler("srp-interface:server-relay", function(data)
    SendInterfaceMessage(data)
end)