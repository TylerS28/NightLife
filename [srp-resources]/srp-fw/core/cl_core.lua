DPX.Core.hasLoaded = false


function DPX.Core.Initialize(self)
    Citizen.CreateThread(function()
        while true do
            if NetworkIsSessionStarted() then
                TriggerEvent("srp-fw:playerSessionStarted")
                TriggerServerEvent("srp-fw:playerSessionStarted")
                break
            end
        end
    end)
end
DPX.Core:Initialize()

AddEventHandler("srp-fw:playerSessionStarted", function()
    while not DPX.Core.hasLoaded do
        --print("waiting in loop")
        Wait(100)
    end
    ShutdownLoadingScreen()
    DPX.SpawnManager:Initialize()
end)

RegisterNetEvent("srp-fw:waitForExports")
AddEventHandler("srp-fw:waitForExports", function()
    if not DPX.Core.ExportsReady then return end

    while true do
        Citizen.Wait(0)
        if exports and exports["srp-fw"] then
            TriggerEvent("srp-fw:exportsReady")
            return
        end
    end
end)

RegisterNetEvent("customNotification")
AddEventHandler("customNotification", function(msg, length, type)

	TriggerEvent("chatMessage","SYSTEM",4,msg)
end)

RegisterNetEvent("base:disableLoading")
AddEventHandler("base:disableLoading", function()
    print("player has spawned ")
    if not DPX.Core.hasLoaded then
         DPX.Core.hasLoaded = true
    end
end)

Citizen.CreateThread( function()
    TriggerEvent("base:disableLoading")
end)

-- Discord Rich Presence --

SetDiscordAppId("1046809402197413980")

Citizen.CreateThread(function()
	while true do
		SetDiscordRichPresenceAsset("spectrum") 
		SetDiscordRichPresenceAssetText("SpectrumRP") 
		SetRichPresence("Spectrum Roleplay") 
		Wait(5000)
	end
end)