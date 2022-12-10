RegisterServerEvent("srp-fw:sv:player_control_set")
AddEventHandler("srp-fw:sv:player_control_set", function(controlsTable)
    local src = source
    DPX.DB:UpdateControls(src, controlsTable, function(UpdateControls, err)
            if UpdateControls then
                -- we are good here.
            end
    end)
end)

RegisterServerEvent("srp-fw:sv:player_controls")
AddEventHandler("srp-fw:sv:player_controls", function()
    local src = source
    DPX.DB:GetControls(src, function(loadedControls, err)
        if loadedControls ~= nil then 
            TriggerClientEvent("srp-fw:cl:player_control", src, loadedControls) 
        else 
            TriggerClientEvent("srp-fw:cl:player_control",src, nil) print('controls fucked') 
        end
    end)
end)
