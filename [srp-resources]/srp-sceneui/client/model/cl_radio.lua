--[[RegisterNUICallback("srp-ui:hudUpdateRadioSettings", function(data, cb)
    exports["srp-fw"]:getModule("SettingsData"):setSettingsTableGlobal({ ["tokovoip"] = data.settings }, true)
    cb({ data = {}, meta = { ok = true, message = 'done' } })
end)

RegisterNUICallback("srp-ui:hudUpdateKeybindSettings", function(data, cb)
    exports["srp-fw"]:getModule("DataControls"):encodeSetBindTable(data.controls)
    cb({ data = {}, meta = { ok = true, message = 'done' } })
end)]]