QBCore = exports['qb-core']:GetCoreObject()
local isLoggedIn = false
local InApartment = false
local ClosestHouse = nil
local CurrentApartment = nil
local IsOwned = false
local CurrentDoorBell = 0
local CurrentOffset = 0
local houseObj = {}
local POIOffsets = nil
local rangDoorbell = nil

-- local isLoggedIn = false
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
end)

function DoRamAnimation(bool)
    local ped = PlayerPedId()
    local dict = "missheistfbi3b_ig7"
    local anim = "lift_fibagent_loop"
    if bool then
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Wait(1)
        end
        TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, 1, -1, false, false, false)
    else
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Wait(1)
        end
        TaskPlayAnim(ped, dict, "exit", 8.0, 8.0, -1, 1, -1, false, false, false)
    end
end

RegisterNetEvent('qb-apartments:choose')
AddEventHandler('qb-apartments:choose',function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    local dialog = exports['qb-input']:ShowInput({
        header = "APARTMENT RAID - Use the Persons CID not STATE ID ex: SFW01927",
        submitText = "Enter",
        inputs = {
            {
                text = "Citizen ID (#)",
                name = "citizenid",
                type = "text",
                isRequired = true 
            },
        },
    })

    if dialog then
        QBCore.Functions.TriggerCallback('apartments:PoliceApartment', function(result)
            if result then
                if PlayerData.job.grade.level > 2 then
                    if exports['qb-inventory']:HasItem('police_stormram') then
                        DoRamAnimation(true)
                        if exports['qb-buffs']:HasBuff("luck") then
                            local seconds = math.random(7,10)
                            local circles = math.random(3,6)
                            local success = exports['qb-lock']:StartLockPickCircle(circles, seconds, success)
                            if success then
                                altaapartment = result.type
                                EnterApartment(altaapartment, result.name)
                                DoRamAnimation(false)
                            else
                                DoRamAnimation(false)
                                QBCore.Functions.Notify("You exhausted yourself!", "error" , 5000)
                            end
                        else
                            local seconds = math.random(5,8)
                            local circles = math.random(6,9)
                            local success = exports['qb-lock']:StartLockPickCircle(circles, seconds, success)
                            if success then
                                altaapartment = result.type
                                EnterApartment(altaapartment, result.name)
                                DoRamAnimation(false)
                            else
                                DoRamAnimation(false)
                                QBCore.Functions.Notify("You exhausted yourself!", "error" , 5000)
                            end
                        end
                    else
                        QBCore.Functions.Notify("You expect to ram the door with your shoulder? Go get a ram!", "error" , 5000)
                    end
                else
                    QBCore.Functions.Notify("Your superior wont like this, Get a higher rank!.. Are you on duty?", "error")
                end
            end
        end, dialog.citizenid)
    end
end)

-- Handlers

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    CurrentApartment = nil
    InApartment = false
    CurrentOffset = 0
    isLoggedIn = false
end)

CreateThread(function()
    local blip = AddBlipForCoord(-270.96, -957.76, 31.24)
    SetBlipSprite(blip, 475)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 5)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Apartment')
    EndTextCommandSetBlipName(blip)
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        if houseObj ~= nil then
            exports['qb-interior']:DespawnInterior(houseObj, function()
                CurrentApartment = nil
                TriggerEvent('qb-weathersync:client:EnableSync')
                DoScreenFadeIn(500)
                while not IsScreenFadedOut() do
                    Wait(10)
                end
                SetEntityCoords(PlayerPedId(), Apartments.Locations[ClosestHouse].coords.enter.x, Apartments.Locations[ClosestHouse].coords.enter.y,Apartments.Locations[ClosestHouse].coords.enter.z)
                SetEntityHeading(PlayerPedId(), Apartments.Locations[ClosestHouse].coords.enter.w)
                Wait(1000)
                InApartment = false
                DoScreenFadeIn(1000)
            end)
        end
    end
end)

-- Functions

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

function openHouseAnim()
    loadAnimDict("anim@heists@keycard@")
    TaskPlayAnim( PlayerPedId(), "anim@heists@keycard@", "exit", 5.0, 1.0, -1, 16, 0, 0, 0, 0 )
    Wait(400)
    ClearPedTasks(PlayerPedId())
end

RegisterNetEvent('apartments:client:Logout', function(source)
    --TriggerServerEvent('qb-houses:server:LogoutLocation', source)
    ExecuteCommand('logout')
end)

function EnterApartment(house, apartmentId, new)
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.1)
    openHouseAnim()
    Wait(250)
    QBCore.Functions.TriggerCallback('apartments:GetApartmentOffset', function(offset)
        if offset == nil or offset == 0 then
            QBCore.Functions.TriggerCallback('apartments:GetApartmentOffsetNewOffset', function(newoffset)
                if newoffset > 230 then
                    newoffset = 210
                end
                CurrentOffset = newoffset
                TriggerServerEvent("apartments:server:AddObject", apartmentId, house, CurrentOffset)
                local coords = { x = Apartments.Locations[house].coords.enter.x, y = Apartments.Locations[house].coords.enter.y, z = Apartments.Locations[house].coords.enter.z - CurrentOffset}
                data = exports['qb-interior']:CreateApartmentFurnished(coords)
                Wait(100)
                houseObj = data[1]
                POIOffsets = data[2]
                InApartment = true
                CurrentApartment = apartmentId
                ClosestHouse = house
                rangDoorbell = nil
                Wait(500)
                TriggerEvent('qb-weathersync:client:DisableSync')
                Wait(100)
                TriggerServerEvent('qb-apartments:server:SetInsideMeta', house, apartmentId, true, false)
                TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_close", 0.1)
                TriggerServerEvent("QBCore:Server:SetMetaData", "currentapartment", CurrentApartment)
            end, house)
        else
            if offset > 230 then
                offset = 210
            end
            if ClosestHouse == nil then
                ClosestHouse = house
            end
            CurrentOffset = offset
            TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.1)
            TriggerServerEvent("apartments:server:AddObject", apartmentId, house, CurrentOffset)
            local coords = { x = Apartments.Locations[ClosestHouse].coords.enter.x, y = Apartments.Locations[ClosestHouse].coords.enter.y, z = Apartments.Locations[ClosestHouse].coords.enter.z - CurrentOffset}
            data = exports['qb-interior']:CreateApartmentFurnished(coords)
            Wait(100)
            houseObj = data[1]
            POIOffsets = data[2]
            InApartment = true
            CurrentApartment = apartmentId
            Wait(500)
            TriggerEvent('qb-weathersync:client:DisableSync')
            Wait(100)
            TriggerServerEvent('qb-apartments:server:SetInsideMeta', house, apartmentId, true, true)
            TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_close", 0.1)
            TriggerServerEvent("QBCore:Server:SetMetaData", "currentapartment", CurrentApartment)
        end
        if new ~= nil then
            if new then
                TriggerEvent('qb-interior:client:SetNewState', true)
            else
                TriggerEvent('qb-interior:client:SetNewState', false)
            end
        else
            TriggerEvent('qb-interior:client:SetNewState', false)
        end
    end, apartmentId)

    Wait(1400)

    exports['qb-target']:AddBoxZone("ApartmentStash", vector3(Apartments.Locations[ClosestHouse].coords.enter.x - POIOffsets.stash.x, Apartments.Locations[ClosestHouse].coords.enter.y - POIOffsets.stash.y, Apartments.Locations[ClosestHouse].coords.enter.z - CurrentOffset + POIOffsets.stash.z), 1.2, 1.2, { 
        name = "ApartmentStash", 
        heading=270, 
        debugPoly = false,
        minZ = Apartments.Locations[ClosestHouse].coords.enter.z - CurrentOffset + POIOffsets.stash.z-1,
        maxZ = Apartments.Locations[ClosestHouse].coords.enter.z - CurrentOffset + POIOffsets.stash.z+1, 
        }, {
        options = { 
            { 
                type = "client", 
                event = "apartments:client:OpenStash", 
                icon = 'fas fa-box', 
                label = 'Open Stash', 
            }
        },
        distance = 1.5,
    })
    
    exports['qb-target']:AddBoxZone("ApartmentClothing", vector3(Apartments.Locations[ClosestHouse].coords.enter.x - POIOffsets.clothes.x, Apartments.Locations[ClosestHouse].coords.enter.y - POIOffsets.clothes.y, Apartments.Locations[ClosestHouse].coords.enter.z - CurrentOffset + POIOffsets.clothes.z), 1.6, 1.6, { 
        name = "ApartmentClothing", 
        heading=270, 
        debugPoly = false,
        minZ = Apartments.Locations[ClosestHouse].coords.enter.z - CurrentOffset + POIOffsets.clothes.z-1, 
        maxZ = Apartments.Locations[ClosestHouse].coords.enter.z - CurrentOffset + POIOffsets.clothes.z+2, 
        }, {
        options = { 
            { 
                type = "client", 
                event = "raid_clothes:outfits", 
                icon = 'fas fa-tshirt', 
                label = 'Change Outfit', 
            }
        },
        distance = 1.5,
    })
    
    exports['qb-target']:AddBoxZone("ApartmentLogout", vector3(Apartments.Locations[ClosestHouse].coords.enter.x - POIOffsets.logout.x, Apartments.Locations[ClosestHouse].coords.enter.y + POIOffsets.logout.y, Apartments.Locations[ClosestHouse].coords.enter.z - CurrentOffset + POIOffsets.logout.z), 1.6, 1.6, { 
        name = "ApartMentLogout", 
        heading=270, 
        debugPoly = false,
        minZ = Apartments.Locations[ClosestHouse].coords.enter.z - CurrentOffset + POIOffsets.logout.z-1, 
        maxZ = Apartments.Locations[ClosestHouse].coords.enter.z - CurrentOffset + POIOffsets.logout.z+2, 
        }, {
        options = { 
            { 
                type = "client", 
                event = "apartments:client:Logout", 
                icon = 'fas fa-sign-out-alt', 
                label = 'Log Out', 
            }
        },
        distance = 1.5,
    })
    
    exports['qb-target']:AddBoxZone("ApartmentExit", vector3(Apartments.Locations[ClosestHouse].coords.enter.x - POIOffsets.exit.x, Apartments.Locations[ClosestHouse].coords.enter.y - POIOffsets.exit.y, Apartments.Locations[ClosestHouse].coords.enter.z - CurrentOffset + POIOffsets.exit.z), 1.6, 1.6, {
        name = "ApartmentExit", 
        heading=270, 
        debugPoly = false,
        minZ = Apartments.Locations[ClosestHouse].coords.enter.z - CurrentOffset + POIOffsets.exit.z-1, 
        maxZ = Apartments.Locations[ClosestHouse].coords.enter.z - CurrentOffset + POIOffsets.exit.z+2, 
        }, {
        options = { 
            { 
                type = "client", 
                event = "apartments:client:LeaveApartment", 
                icon = 'fas fa-house-user', 
                label = 'Leave Apartment', 
            }
        },
        distance = 1.5,
    })
end

exports['qb-target']:AddCircleZone("EnterAppartments", vector3(-269.79, -961.35, 31.52), 0.21, {
    name = "EnterAppartments",
    useZ=false,
    debugPoly = false,
    }, {
    options = {
        {
            event = "apartments:client:EnterApartment",
            icon = "fas fa-house-user",
            label = "Enter Apartment",
        },
        {
            event = "apartments:client:DoorbellMenu",
            icon = "fas fa-bell",
            label = "Ring Doorbell",
        },
        {
            event = "qb-apartments:choose",
            icon = "fas fa-power-off",
            label = "Raid apartment",
            job = 'police'
        },
    },
    distance = 2.0
})

function LeaveApartment(house)
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.1)
    openHouseAnim()
    TriggerServerEvent("qb-apartments:returnBucket")
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(10) end
    exports['qb-interior']:DespawnInterior(houseObj, function()
        TriggerEvent('qb-weathersync:client:EnableSync')
        SetEntityCoords(PlayerPedId(), Apartments.Locations[house].coords.enter.x, Apartments.Locations[house].coords.enter.y,Apartments.Locations[house].coords.enter.z)
        SetEntityHeading(PlayerPedId(), Apartments.Locations[house].coords.enter.w)
        Wait(1000)
        TriggerServerEvent("apartments:server:RemoveObject", CurrentApartment, house)
        TriggerServerEvent('qb-apartments:server:SetInsideMeta', CurrentApartment, false)
        CurrentApartment = nil
        InApartment = false
        CurrentOffset = 0
        DoScreenFadeIn(1000)
        TriggerEvent('backitems:showagain')
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_close", 0.1)
        TriggerServerEvent("QBCore:Server:SetMetaData", "currentapartment", nil)
    end)
    exports['qb-target']:RemoveZone("ApartmentStash")
    exports['qb-target']:RemoveZone("ApartmentClothing")
    exports['qb-target']:RemoveZone("ApartmentExit")
    exports['qb-target']:RemoveZone("ApartmentLogout")
end

function SetClosestApartment()
    local pos = GetEntityCoords(PlayerPedId())
    local current = nil
    local dist = nil
    for id, house in pairs(Apartments.Locations) do
        local distcheck = #(pos - vector3(Apartments.Locations[id].coords.enter.x, Apartments.Locations[id].coords.enter.y, Apartments.Locations[id].coords.enter.z))
        if current ~= nil then
            if distcheck < dist then
                current = id
                dist = distcheck
            end
        else
            dist = distcheck
            current = id
        end
    end
    if current ~= ClosestHouse and LocalPlayer.state['isLoggedIn'] and not InApartment then
        ClosestHouse = current
        QBCore.Functions.TriggerCallback('apartments:IsOwner', function(result)
            IsOwned = result
        end, ClosestHouse)
    end
end

function MenuOwners()
    QBCore.Functions.TriggerCallback('apartments:GetAvailableApartments', function(apartments)
        if next(apartments) == nil then
            QBCore.Functions.Notify("Nobody at home", "error", 3500)
            closeMenuFull()
        else
            local vehicleMenu = {
                {
                    header = "Tenants",
                    isMenuHeader = true
                }
            }

            for k, v in pairs(apartments) do
                vehicleMenu[#vehicleMenu+1] = {
                    header = v,
                    txt = "",
                    params = {
                        event = "apartments:client:RingMenu",
                        args = {
                            apartmentId = k
                        }
                    }

                }
            end

            vehicleMenu[#vehicleMenu+1] = {
                header = "Close",
                txt = "",
                params = {
                    event = "qb-menu:client:closeMenu"
                }

            }
            exports['qb-menu']:openMenu(vehicleMenu)
        end
    end, ClosestHouse)
end

function closeMenuFull()
    exports['qb-menu']:closeMenu()
end

-- Events

RegisterNetEvent('apartments:client:SpawnInApartment', function(apartmentId, apartment)
    local pos = GetEntityCoords(PlayerPedId())
    if rangDoorbell ~= nil then
        local doorbelldist = #(pos - vector3(Apartments.Locations[rangDoorbell].coords.enter.x, Apartments.Locations[rangDoorbell].coords.enter.y,Apartments.Locations[rangDoorbell].coords.enter.z))
        if doorbelldist > 5 then
            QBCore.Functions.Notify("You are too far from door!")
            return
        end
    end
    ClosestHouse = apartment
    EnterApartment(apartment, apartmentId, true)
    IsOwned = true
end)

RegisterNetEvent('qb-apartments:client:LastLocationHouse', function(apartmentType, apartmentId)
    ClosestHouse = apartmentType
    EnterApartment(apartmentType, apartmentId, false)
end)

RegisterNetEvent('apartments:client:SetHomeBlip', function(home)
    CreateThread(function()
        SetClosestApartment()
        for name, apartment in pairs(Apartments.Locations) do
            RemoveBlip(Apartments.Locations[name].blip)

            Apartments.Locations[name].blip = AddBlipForCoord(Apartments.Locations[name].coords.enter.x, Apartments.Locations[name].coords.enter.y, Apartments.Locations[name].coords.enter.z)
            if (name == home) then
                SetBlipSprite(Apartments.Locations[name].blip, 475)
            else
                SetBlipSprite(Apartments.Locations[name].blip, 476)
            end
            SetBlipDisplay(Apartments.Locations[name].blip, 4)
            SetBlipScale(Apartments.Locations[name].blip, 0.65)
            SetBlipAsShortRange(Apartments.Locations[name].blip, true)
            SetBlipColour(Apartments.Locations[name].blip, 3)

            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(Apartments.Locations[name].label)
            EndTextCommandSetBlipName(Apartments.Locations[name].blip)
        end
    end)
end)

RegisterNetEvent('apartments:client:RingMenu', function(data)
    rangDoorbell = ClosestHouse
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "doorbell", 0.1)
    TriggerServerEvent("apartments:server:RingDoor", data.apartmentId, ClosestHouse)
end)

RegisterNetEvent('apartments:client:RingDoor', function(player, house)
    CurrentDoorBell = player
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "doorbell", 0.1)
    QBCore.Functions.Notify("Someone ringing on door")
end)

RegisterNetEvent('apartments:client:DoorbellMenu', function()
    MenuOwners()
end)

RegisterNetEvent('apartments:client:EnterApartment', function()
    QBCore.Functions.TriggerCallback('apartments:GetOwnedApartment', function(result)
        if result ~= nil then
            EnterApartment(ClosestHouse, result.name)
        end
    end)
end)

RegisterNetEvent('apartments:client:UpdateApartment', function()
    local apartmentType = ClosestHouse
    local apartmentLabel = Apartments.Locations[ClosestHouse].label
    TriggerServerEvent("apartments:server:UpdateApartment", apartmentType, apartmentLabel)
    IsOwned = true
end)

RegisterNetEvent('apartments:client:OpenDoor', function()
    TriggerServerEvent("apartments:server:OpenDoor", CurrentDoorBell, CurrentApartment, ClosestHouse)
    CurrentDoorBell = 0
end)

RegisterNetEvent('apartments:client:LeaveApartment', function()
    LeaveApartment(ClosestHouse)
end)

RegisterNetEvent('apartments:client:OpenStash', function()
    if CurrentApartment ~= nil then
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "StashOpen", 0.4)
        TriggerServerEvent("inventory:server:OpenInventory", "stash", CurrentApartment)
        TriggerEvent("inventory:client:SetCurrentStash", CurrentApartment)
    end
end)

-- Threads

CreateThread(function()
    while true do
        if LocalPlayer.state['isLoggedIn'] and not InApartment then
            SetClosestApartment()
        end
        Wait(10000)
    end
end)

CreateThread(function()
    local shownHeader = false
    while true do
        local sleep = 1000
        if isLoggedIn and ClosestHouse then
            sleep = 5
            local text = ''
            if InApartment then
                local inRange = false
                local pos = GetEntityCoords(PlayerPedId())
                local entrancedist = #(pos - vector3(Apartments.Locations[ClosestHouse].coords.enter.x - POIOffsets.exit.x, Apartments.Locations[ClosestHouse].coords.enter.y - POIOffsets.exit.y, Apartments.Locations[ClosestHouse].coords.enter.z - CurrentOffset + POIOffsets.exit.z))
                local stashdist = #(pos - vector3(Apartments.Locations[ClosestHouse].coords.enter.x - POIOffsets.stash.x, Apartments.Locations[ClosestHouse].coords.enter.y - POIOffsets.stash.y, Apartments.Locations[ClosestHouse].coords.enter.z - CurrentOffset + POIOffsets.stash.z))
                local outfitsdist = #(pos - vector3(Apartments.Locations[ClosestHouse].coords.enter.x - POIOffsets.clothes.x, Apartments.Locations[ClosestHouse].coords.enter.y - POIOffsets.clothes.y, Apartments.Locations[ClosestHouse].coords.enter.z - CurrentOffset + POIOffsets.clothes.z))
                local logoutdist = #(pos - vector3(Apartments.Locations[ClosestHouse].coords.enter.x - POIOffsets.logout.x, Apartments.Locations[ClosestHouse].coords.enter.y + POIOffsets.logout.y, Apartments.Locations[ClosestHouse].coords.enter.z - CurrentOffset + POIOffsets.logout.z))

                --Exit
                if entrancedist <= 1.5 then
                    inRange = true
                    text = '[E] Exit Apartment'
                    if IsControlJustPressed(0, 38) then
                        TriggerEvent('apartments:client:LeaveApartment')
                    end
                end


                --Stash
                if stashdist <= 1.5 then
                    inRange = true
                    text = '[E] Stash'
                    if IsControlJustPressed(0, 38) then
                        TriggerEvent('apartments:client:OpenStash')
                    end
                end
 
                --Outfits
                if outfitsdist <= 1.5 then
                    inRange = true
                    text = '[E] Outfits'
                    local x = Apartments.Locations[ClosestHouse].coords.enter.x - POIOffsets.clothes.x
                    local y = Apartments.Locations[ClosestHouse].coords.enter.y - POIOffsets.clothes.y
                    local z = Apartments.Locations[ClosestHouse].coords.enter.z - CurrentOffset + POIOffsets.clothes.z
                    if IsControlJustPressed(0, 38) then
                        TriggerEvent('raid_clothes:outfits')
                    end
                end

                if logoutdist <= 1.5 then
                    inRange = true
                    text = '[E] Logout'
                    if IsControlJustPressed(0, 38) then
                        TriggerEvent('apartments:client:Logout')
                    end
                end
                
                if inRange and not shownHeader then
                    shownHeader = true
                    exports['qb-ui']:showInteraction(text)
                end

                if not inRange and shownHeader then
                    shownHeader = false
                    exports['qb-ui']:hideInteraction()
                end

            else
                local inRange = false
                local entrance = #(GetEntityCoords(PlayerPedId()) - vector3(-269.46, -961.2, 31.23))

                if IsOwned then
                    if entrance <= 1.5 then
                        inRange = true
                        text = 'Apartments'
                    end
                end

                if inRange and not shownHeader then
                    shownHeader = true
                    exports['qb-ui']:showInteraction(text)
                end

                if not inRange and shownHeader then
                    shownHeader = false
                    exports['qb-ui']:hideInteraction()
                end
            end
        end
        Wait(sleep)
    end
end)

exports('GetCurrentApartment', function() -- added for p22 weed plants script
	return InApartment
end)

exports('isInApt', function()
    if InApartment then
        print(InApartment)
        return true
    end
    return false
end)