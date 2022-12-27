local QBCore = exports["qb-core"]:GetCoreObject()
local ActivePoliceGPS = {}
local UPDATE = 3
local active = {}

QBCore.Functions.CreateUseableItem("gps", function(source, item)
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
        TriggerClientEvent('qb-polgps:use', source)
    else
        TriggerEvent("QBCore:Notify", source, "GPS Is encrypted and can only be used by the police.", "error")
    end
end)

RegisterNetEvent('qb-polgps:server:ToggleGPS', function(toggle)
	-- local toggle = toggle
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.job.name == "police" then
		if active[source] == nil then active[source] = false end
		if not active[source] then
			active[source] = true
			TriggerClientEvent("QBCore:Notify", source, "Your GPS has been activated.")
			for k, v in pairs(QBCore.Functions.GetPlayers()) do
				local Player = QBCore.Functions.GetPlayer(v)
				if Player.PlayerData.job.name == "police" then
					if source ~= Player.PlayerData.source then
						TriggerClientEvent("QBCore:Notify", Player.PlayerData.source, "A police has activated a GPS.")
					end
				end
			end
			TriggerEvent("qb-polgps:add", {name = ("[%s] %s %s"):format(Player.PlayerData.metadata.callsign, Player.PlayerData.charinfo.firstname, Player.PlayerData.charinfo.lastname), src = source, color = 1})
		else
			active[source] = false
			TriggerClientEvent("QBCore:Notify", source, "Your GPS has been deactivated.")
			TriggerEvent("qb-polgps:remove", source)
			for k, v in pairs(QBCore.Functions.GetPlayers()) do
				local Player = QBCore.Functions.GetPlayer(v)
				if Player.PlayerData.job.name == "police" then
					if source ~= Player.PlayerData.source then
						TriggerClientEvent("QBCore:Notify", Player.PlayerData.source, "A police has deactivated a GPS.")
					end
				end
			end
		end
		TriggerClientEvent("qb-polgps:toggle", source, active[source])
    else
        TriggerClientEvent("QBCore:Notify", source, "GPS Is encrypted and can only be used by the police.", "error")
    end
end)

QBCore.Functions.CreateCallback('qb-polgps:server:GetItem', function(source, cb, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player ~= nil then
        local GPS = Player.Functions.GetItemByName(item)
        if GPS ~= nil and not Player.PlayerData.metadata["isdead"] and not Player.PlayerData.metadata["inlaststand"] then
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)


-- RegisterServerEvent("qb-polgps:add")
AddEventHandler("qb-polgps:add", function(person)
	ActivePoliceGPS[person.src] = person
	TriggerClientEvent("qb-polgps:toggle", person.src, true)
end)

-- RegisterServerEvent("qb-polgps:remove")
AddEventHandler("qb-polgps:remove", function(src)
	ActivePoliceGPS[src] = nil
	TriggerClientEvent("qb-polgps:toggle", src, false)
end)

AddEventHandler("playerDropped", function()
	if ActivePoliceGPS[source] then
		ActivePoliceGPS[source] = nil
	end
end)

CreateThread(function()
	local lastUpdateTime = os.time()
	while true do
		if os.difftime(os.time(), lastUpdateTime) >= UPDATE then
			for id, info in pairs(ActivePoliceGPS) do
				ActivePoliceGPS[id].coords = GetEntityCoords(GetPlayerPed(id))
				TriggerClientEvent("qb-polgps:updateAll", id, ActivePoliceGPS)
			end
			lastUpdateTime = os.time()
		end
		Wait(500)
	end
end)
