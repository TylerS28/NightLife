QBCore = exports['qb-core']:GetCoreObject()
IsInside = false
ClosestHouse = nil
HasHouseKey = false
contractOpen = false
local isOwned = false
local cam = nil
local viewCam = false
local FrontCam = false
local stashLocation = nil
local outfitLocation = nil
local logoutLocation = nil
local OwnedHouseBlips = {}
local UnownedHouseBlips = {}
local CurrentDoorBell = 0
local rangDoorbell = nil
local houseObj = {}
local POIOffsets = nil
local entering = false
local data = nil
local CurrentHouse = nil
local RamsDone = 0
local keyholderMenu = {}
local keyholderOptions = {}
local fetchingHouseKeys = false

RegisterCommand('furni', function()
    openFurniture()
end)

RegisterNetEvent("qpixel-housing:editOptions", function(pParams)
    if pParams.action == "enter" then
        enterEdit(pParams.propertyId)
    elseif pParams.action == "exit" then
        exitEdit(true)
    elseif pParams.action == "garage" then
        setGarage()
    elseif pParams.action == "stash" then
        setInventory()
    elseif pParams.action == "backdoor" then
        setBackdoor()
    elseif pParams.action == "wardrobe" then
        setCharChanger()
    elseif pParams.action == "crafting" then
        switchBenchInventory(true)
    elseif pParams.action == "furniture" then
        openFurniture()
    end
end)

function openFurniture()
   --[[  if Housing.currentlyEditing == false then
        --TriggerEvent("DoLongHudText", "Out of edit mode", 2)
        return
    end

    if not hasCorrectFlags("canHaveFurniture", Housing.currentlyEditing) then
        --TriggerEvent("DoLongHudText", "Unavailable for property.", 2)
        return
    end

    if not Housing.currentlyInsideBuilding then
        --TriggerEvent("DoLongHudText", "you're not inside the property", 2)
        return
    end
 ]]
    buildFurnitureData(ClosestHouse)
end

function buildFurnitureData(ClosestHouse)
    --[[ local zoneData = Housing.typeInfo[Housing.info[ClosestHouse].model].zone
    local off = zoneData.offset ]]
    local center = vector3(Config.Houses[ClosestHouse].coords.enter.x, Config.Houses[ClosestHouse].coords.enter.y, Config.Houses[ClosestHouse].coords.enter.z)
    local hasCraftingProg = true
    local hasProgression = false

    if hasCraftingProg then
        local progressionData = 0
        hasProgression = progressionData ~= nil and progressionData > 0
    end

    local specials = {}
    if hasProgression or (not hasCraftingProg) then
        specials[#specials+1] = "gr_prop_gr_bench_02b"
    end

    local data = {
        name = ClosestHouse,
        special = specials,
        autosave = true,
        zone = {
            pos = center,
            length = 30.0,
            width = 30.0,
            minZ = 50.0,
            maxZ = 2.0,
            heading = 0.0
        },
        modules = {
            "objects",
        },
    }

    TriggerServerEvent("CheckFurniture", data, ClosestHouse)
end


--[[ {"autosave":true,
"modules":["objects"],
"special":[],
"zone":
    {"minZ":2.0,
    "pos":{"x":1010.8424072265625,"y":-423.6152038574219,"z":6.36940336227417},
    "maxZ":8.0,
    "heading":0.0,
    "width":22.0,
    "length":12.0},
    "name":"mp3"}

    [{"changed":true,
    "coords":"{\"y\":2536.699951171875,\"z\":12.59767150878906,\"x\":714.5999755859375}",
    "realName":"vw_prop_casino_slot_02a",
    "quat":"{\"y\":-0.0,\"z\":-0.70710664987564,\"w\":0.70710682868957,\"x\":0.0}",
    "id":-1,
    "dataK":1,
    "model":-1519644200}]

    [{"realName":"v_corp_facebeanbag",
    "changed":true,
    "dataK":1,
    "quat":"{\"y\":0.0,\"z\":0.0,\"w\":1.0,\"x\":0.0}",
    "model":-896397685,
    "id":-1,
    "coords":"{\"y\":-422.5,\"z\":5.39499998092651,\"x\":1003.0}"},
    
    {"realName":"v_res_cherubvase","changed":true,"dataK":2,"quat":"{\"y\":0.0,\"z\":0.0,\"w\":1.0,\"x\":0.0}","model":-730024798,"id":-1,"coords":"{\"y\":-423.6000061035156,\"z\":5.29484128952026,\"x\":1003.6993408203125}"},{"realName":"v_res_fashmag1","changed":true,"dataK":3,"quat":"{\"y\":0.0,\"z\":0.0,\"w\":1.0,\"x\":0.0}","model":-2042781782,"id":-1,"coords":"{\"y\":-423.70001220703127,\"z\":5.39151906967163,\"x\":1002.5999755859375}"}] ]]

-- Functions

local function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

local function openHouseAnim()
    loadAnimDict("anim@heists@keycard@")
    TaskPlayAnim( PlayerPedId(), "anim@heists@keycard@", "exit", 5.0, 1.0, -1, 16, 0, 0, 0, 0 )
    Wait(400)
    ClearPedTasks(PlayerPedId())
end

local function openContract(bool)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "toggle",
        status = bool,
    })
    contractOpen = bool
end

local function GetClosestPlayer()
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(PlayerPedId())
    for i=1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = #(pos - coords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
	end
	return closestPlayer, closestDistance
end

local function DoRamAnimation(bool)
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

local function setViewCam(coords, h, yaw)
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords.x, coords.y, coords.z, yaw, 0.00, h, 80.00, false, 0)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 500, true, true)
    viewCam = true
end

local function InstructionButton(ControlButton)
    ScaleformMovieMethodAddParamPlayerNameString(ControlButton)
end

local function InstructionButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

local function CreateInstuctionScaleform(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    InstructionButton(GetControlInstructionalButton(1, 194, true))
    InstructionButtonMessage(Lang:t("info.exit_camera"))
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()
    return scaleform
end

local function FrontDoorCam(coords)
    DoScreenFadeOut(150)
    Wait(500)
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coords.x, coords.y, coords.z + 0.5, 0.0, 0.00, coords.h - 180, 80.00, false, 0)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 500, true, true)
    TriggerEvent('qb-weathersync:client:EnableSync')
    FrontCam = true
    FreezeEntityPosition(PlayerPedId(), true)
    Wait(500)
    DoScreenFadeIn(150)
    SendNUIMessage({
        type = "frontcam",
        toggle = true,
        label = Config.Houses[ClosestHouse].adress
    })
    CreateThread(function()
        while FrontCam do
            local instructions = CreateInstuctionScaleform("instructional_buttons")
            DrawScaleformMovieFullscreen(instructions, 255, 255, 255, 255, 0)
            SetTimecycleModifier("scanline_cam_cheap")
            SetTimecycleModifierStrength(1.0)
            if IsControlJustPressed(1, 194) then -- Backspace
                DoScreenFadeOut(150)
                SendNUIMessage({
                    type = "frontcam",
                    toggle = false,
                })
                Wait(500)
                RenderScriptCams(false, true, 500, true, true)
                FreezeEntityPosition(PlayerPedId(), false)
                SetCamActive(cam, false)
                DestroyCam(cam, true)
                ClearTimecycleModifier("scanline_cam_cheap")
                cam = nil
                FrontCam = false
                Wait(500)
                DoScreenFadeIn(150)
            end

            local getCameraRot = GetCamRot(cam, 2)

            -- ROTATE UP
            if IsControlPressed(0, 32) then -- W
                if getCameraRot.x <= 0.0 then
                    SetCamRot(cam, getCameraRot.x + 0.7, 0.0, getCameraRot.z, 2)
                end
            end

            -- ROTATE DOWN
            if IsControlPressed(0, 33) then -- S
                if getCameraRot.x >= -50.0 then
                    SetCamRot(cam, getCameraRot.x - 0.7, 0.0, getCameraRot.z, 2)
                end
            end

            -- ROTATE LEFT
            if IsControlPressed(0, 34) then -- A
                SetCamRot(cam, getCameraRot.x, 0.0, getCameraRot.z + 0.7, 2)
            end

            -- ROTATE RIGHT
            if IsControlPressed(0, 35) then -- D
                SetCamRot(cam, getCameraRot.x, 0.0, getCameraRot.z - 0.7, 2)
            end

            Wait(1)
        end
    end)
end

local function disableViewCam()
    if viewCam then
        RenderScriptCams(false, true, 500, true, true)
        SetCamActive(cam, false)
        DestroyCam(cam, true)
        viewCam = false
    end
end

local function SetClosestHouse() -- ORIGINAL FUNTION BEFORE GARAGE EDIT
    local pos = GetEntityCoords(PlayerPedId(), true)
    local current = nil
    local dist = nil
    if not IsInside then
        for id, house in pairs(Config.Houses) do
            local distcheck = #(pos - vector3(Config.Houses[id].coords.enter.x, Config.Houses[id].coords.enter.y, Config.Houses[id].coords.enter.z))
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
        ClosestHouse = current
        if ClosestHouse ~= nil and tonumber(dist) < 30 then
            QBCore.Functions.TriggerCallback('qb-houses:server:ProximityKO', function(key, owned)
                HasHouseKey = key
                isOwned = owned
            end, ClosestHouse)
        end
    end
    TriggerEvent('qb-garages:client:setHouseGarage', ClosestHouse, HasHouseKey)
end

local function setHouseLocations()
    if ClosestHouse ~= nil then
        QBCore.Functions.TriggerCallback('qb-houses:server:getHouseLocations', function(result)
            if result ~= nil then
                if result.stash ~= nil then
                    stashLocation = json.decode(result.stash)
                end

                if result.outfit ~= nil then
                    outfitLocation = json.decode(result.outfit)
                end

                if result.logout ~= nil then
                    logoutLocation = json.decode(result.logout)
                end
            end
        end, ClosestHouse)
    end
end

local function UnloadDecorations()
	if ObjectList ~= nil then
		for k, v in pairs(ObjectList) do
			if DoesEntityExist(v.object) then
				DeleteObject(v.object)
			end
		end
	end
end

local function LoadDecorations(house)
	if Config.Houses[house].decorations == nil or next(Config.Houses[house].decorations) == nil then
		QBCore.Functions.TriggerCallback('qb-houses:server:getHouseDecorations', function(result)
			Config.Houses[house].decorations = result
			if Config.Houses[house].decorations ~= nil then
				ObjectList = {}
				for k, v in pairs(Config.Houses[house].decorations) do
					if Config.Houses[house].decorations[k] ~= nil then
						if Config.Houses[house].decorations[k].object ~= nil then
							if DoesEntityExist(Config.Houses[house].decorations[k].object) then
								DeleteObject(Config.Houses[house].decorations[k].object)
							end
						end
						local modelHash = GetHashKey(Config.Houses[house].decorations[k].hashname)
						RequestModel(modelHash)
						while not HasModelLoaded(modelHash) do
							Wait(10)
						end
						local decorateObject = CreateObject(modelHash, Config.Houses[house].decorations[k].x, Config.Houses[house].decorations[k].y, Config.Houses[house].decorations[k].z, false, false, false)
						SetEntityRotation(decorateObject, Config.Houses[house].decorations[k].rotx, Config.Houses[house].decorations[k].roty, Config.Houses[house].decorations[k].rotz)
						ObjectList[Config.Houses[house].decorations[k].objectId] = {hashname = Config.Houses[house].decorations[k].hashname, x = Config.Houses[house].decorations[k].x, y = Config.Houses[house].decorations[k].y, z = Config.Houses[house].decorations[k].z, rotx = Config.Houses[house].decorations[k].rotx, roty = Config.Houses[house].decorations[k].roty, rotz = Config.Houses[house].decorations[k].rotz, object = decorateObject, objectId = Config.Houses[house].decorations[k].objectId}
						FreezeEntityPosition(decorateObject, true)
					end
				end
			end
		end, house)
	elseif Config.Houses[house].decorations ~= nil then
		ObjectList = {}
		for k, v in pairs(Config.Houses[house].decorations) do
			if Config.Houses[house].decorations[k] ~= nil then
				if Config.Houses[house].decorations[k].object ~= nil then
					if DoesEntityExist(Config.Houses[house].decorations[k].object) then
						DeleteObject(Config.Houses[house].decorations[k].object)
					end
				end
				local modelHash = GetHashKey(Config.Houses[house].decorations[k].hashname)
				RequestModel(modelHash)
				while not HasModelLoaded(modelHash) do
					Wait(10)
				end
				local decorateObject = CreateObject(modelHash, Config.Houses[house].decorations[k].x, Config.Houses[house].decorations[k].y, Config.Houses[house].decorations[k].z, false, false, false)
				Config.Houses[house].decorations[k].object = decorateObject
				SetEntityRotation(decorateObject, Config.Houses[house].decorations[k].rotx, Config.Houses[house].decorations[k].roty, Config.Houses[house].decorations[k].rotz)
				ObjectList[Config.Houses[house].decorations[k].objectId] = {hashname = Config.Houses[house].decorations[k].hashname, x = Config.Houses[house].decorations[k].x, y = Config.Houses[house].decorations[k].y, z = Config.Houses[house].decorations[k].z, rotx = Config.Houses[house].decorations[k].rotx, roty = Config.Houses[house].decorations[k].roty, rotz = Config.Houses[house].decorations[k].rotz, object = decorateObject, objectId = Config.Houses[house].decorations[k].objectId}
				FreezeEntityPosition(decorateObject, true)
			end
		end
	end
end

local function CheckDistance(target, distance)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)

    return #(pos - target) <= distance
end

-- GUI Functions

function CloseMenuFull()
    exports['qb-menu']:closeMenu()
end

local function RemoveHouseKey(citizenData)
    TriggerServerEvent('qb-houses:server:removeHouseKey', ClosestHouse, citizenData)
    CloseMenuFull()
end

local function getKeyHolders()
    if fetchingHouseKeys then return end
    fetchingHouseKeys = true

    local p = promise.new()
    QBCore.Functions.TriggerCallback('qb-houses:server:getHouseKeyHolders', function(holders)
        p:resolve(holders)
    end,ClosestHouse)

    return Citizen.Await(p)
end

function HouseKeysMenu()
    local holders = getKeyHolders()
    fetchingHouseKeys = false

    if holders == nil or next(holders) == nil then
        QBCore.Functions.Notify(Lang:t("error.no_key_holders"), "error", 3500)
        CloseMenuFull()
    else
        keyholderMenu = {}

        for k, v in pairs(holders) do
            keyholderMenu[#keyholderMenu+1] = {
                header = holders[k].firstname .. " " .. holders[k].lastname,
                params = {
                    event = "qb-houses:client:OpenClientOptions",
                    args = {
                        citizenData = holders[k]
                    }
                }
            }
        end
        exports['qb-menu']:openMenu(keyholderMenu)
    end

end

local function optionMenu(citizenData)
    keyholderOptions = {
        {
            header = Lang:t("menu.remove_key"),
            params = {
                event = "qb-houses:client:RevokeKey",
                args = {
                    citizenData = citizenData
                }
            }
        },
        {
            header = Lang:t("menu.back"),
            params = {
                event = "qb-houses:client:removeHouseKey",
                args = {}
            }
        },
    }

    exports['qb-menu']:openMenu(keyholderOptions)
end

-- Shell Configuration
local function getDataForHouseTier(house, coords)
    if Config.Houses[house].tier == 1 then
        return exports['qb-interior']:CreateApartmentShell(coords)
    elseif Config.Houses[house].tier == 2 then
        return exports['qb-interior']:CreateTier1House(coords)
    elseif Config.Houses[house].tier == 3 then
        return exports['qb-interior']:CreateTrevorsShell(coords)
    elseif Config.Houses[house].tier == 4 then
        return exports['qb-interior']:CreateCaravanShell(coords)
    elseif Config.Houses[house].tier == 5 then
        return exports['qb-interior']:CreateLesterShell(coords)
    elseif Config.Houses[house].tier == 6 then
        return exports['qb-interior']:CreateRanchShell(coords)
    elseif Config.Houses[house].tier == 7 then
        return exports['qb-interior']:CreateHouseRobbery(coords)
    -- Warehouse Shells (addon) https://k4mb1.tebex.io/package/4673185
    elseif Config.Houses[house].tier == 8 then
        return exports['qb-interior']:CreateWarehouse1(coords)
    elseif Config.Houses[house].tier == 9 then
        return exports['qb-interior']:CreateWarehouse2(coords)
    elseif Config.Houses[house].tier == 10 then
        return exports['qb-interior']:CreateWarehouse3(coords)
    -- Highend Shells (addon) https://k4mb1.tebex.io/package/4673131
    elseif Config.Houses[house].tier == 11 then
        return exports['qb-interior']:CreateHighend1(coords)
    elseif Config.Houses[house].tier == 12 then
        return exports['qb-interior']:CreateHighend2(coords)
    elseif Config.Houses[house].tier == 13 then
        return exports['qb-interior']:CreateHighend3(coords)
    -- Deluxe Shells (addon) https://k4mb1.tebex.io/package/4673159
    elseif Config.Houses[house].tier == 14 then
        return exports['qb-interior']:CreateHighend(coords)
    elseif Config.Houses[house].tier == 15 then
        return exports['qb-interior']:CreateHighendV2(coords)
    elseif Config.Houses[house].tier == 16 then
        return exports['qb-interior']:CreateMichael(coords)
    -- Office Shells (addon) https://k4mb1.tebex.io/package/4673258
    elseif Config.Houses[house].tier == 17 then
        return exports['qb-interior']:CreateOffice2(coords)
    elseif Config.Houses[house].tier == 18 then
        return exports['qb-interior']:CreateOfficeBig(coords)
    -- Store Shells (addon) https://k4mb1.tebex.io/package/4673264
    elseif Config.Houses[house].tier == 19 then
        return exports['qb-interior']:CreateBarber(coords)
    elseif Config.Houses[house].tier == 20 then
        return exports['qb-interior']:CreateGunstore(coords)
    elseif Config.Houses[house].tier == 21 then
        return exports['qb-interior']:CreateStore1(coords)
    elseif Config.Houses[house].tier == 22 then
        return exports['qb-interior']:CreateStore2(coords)
    elseif Config.Houses[house].tier == 23 then
        return exports['qb-interior']:CreateStore3(coords)
    -- Medium Housing Shells (addon) https://k4mb1.tebex.io/package/4672307
    elseif Config.Houses[house].tier == 24 then
        return exports['qb-interior']:CreateFranklinAunt(coords)
    elseif Config.Houses[house].tier == 25 then
        return exports['qb-interior']:CreateMedium2(coords)
    elseif Config.Houses[house].tier == 26 then
        return exports['qb-interior']:CreateMedium3(coords)
    -- Drug Lab Shells (addon) https://k4mb1.tebex.io/package/4672285
    elseif Config.Houses[house].tier == 27 then
        return exports['qb-interior']:CreateCoke(coords)
    elseif Config.Houses[house].tier == 28 then
        return exports['qb-interior']:CreateCoke2(coords)
    elseif Config.Houses[house].tier == 29 then
        return exports['qb-interior']:CreateMeth(coords)
    elseif Config.Houses[house].tier == 30 then
        return exports['qb-interior']:CreateWeed2(coords)
    -- Garage Shells (addon) https://k4mb1.tebex.io/package/4673177
    elseif Config.Houses[house].tier == 31 then
        return exports['qb-interior']:CreateGarageLow(coords)
    elseif Config.Houses[house].tier == 32 then
        return exports['qb-interior']:CreateGarageMed(coords)
    elseif Config.Houses[house].tier == 33 then
        return exports['qb-interior']:CreateGarageHigh(coords)
    elseif Config.Houses[house].tier == 34 then
        return exports['qb-interior']:CreateContainer2(coords)
    elseif Config.Houses[house].tier == 35 then
       return exports['qb-interior']:CreateFurniStash1(coords)
    elseif Config.Houses[house].tier == 36 then
       return exports['qb-interior']:CreateFurniStash3(coords)
    else
        QBCore.Functions.Notify('Invalid house tier', 'error')
    end
end

local function enterOwnedHouse(house)
    CurrentHouse = house
    ClosestHouse = house
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.25)
    openHouseAnim()
    IsInside = true
    Wait(250)
    local coords = { x = Config.Houses[house].coords.enter.x, y = Config.Houses[house].coords.enter.y, z= Config.Houses[house].coords.enter.z - Config.MinZOffset}
    LoadDecorations(house)
    data = getDataForHouseTier(house, coords)
    Wait(100)
    houseObj = data[1]
    POIOffsets = data[2]
    entering = true
    Wait(500)
    TriggerServerEvent('qb-houses:server:SetInsideMeta', house, true)
    TriggerEvent('qb-weathersync:client:DisableSync')
    TriggerEvent('qb-weed:client:getHousePlants', house)
    entering = false
    setHouseLocations()
    CloseMenuFull()
end

local function LeaveOwnedHouse(house)
    if not FrontCam then
        IsInside = false
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.25)
        openHouseAnim()
        Wait(250)
        DoScreenFadeOut(250)
        Wait(500)
        exports['qb-interior']:DespawnInterior(houseObj, function()
            UnloadDecorations()
            TriggerEvent('qb-weathersync:client:EnableSync')
            Wait(250)
            DoScreenFadeIn(250)
            SetEntityCoords(PlayerPedId(), Config.Houses[CurrentHouse].coords.enter.x, Config.Houses[CurrentHouse].coords.enter.y, Config.Houses[CurrentHouse].coords.enter.z + 0.2)
            SetEntityHeading(PlayerPedId(), Config.Houses[CurrentHouse].coords.enter.h)
            TriggerEvent('backitems:showagain')
            TriggerEvent('qb-weed:client:leaveHouse')
            TriggerServerEvent('qb-houses:server:SetInsideMeta', house, false)
            CurrentHouse = nil
        end)
    end
end

local function enterNonOwnedHouse(house)
    CurrentHouse = house
    ClosestHouse = house
    TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.25)
    openHouseAnim()
    IsInside = true
    Wait(250)
    local coords = { x = Config.Houses[ClosestHouse].coords.enter.x, y = Config.Houses[ClosestHouse].coords.enter.y, z= Config.Houses[ClosestHouse].coords.enter.z - Config.MinZOffset}
    LoadDecorations(house)
    data = getDataForHouseTier(house, coords)
    houseObj = data[1]
    POIOffsets = data[2]
    entering = true
    Wait(500)
    TriggerServerEvent('qb-houses:server:SetInsideMeta', house, true)
    TriggerEvent('qb-weathersync:client:DisableSync')
    TriggerEvent('qb-weed:client:getHousePlants', house)
    entering = false
    InOwnedHouse = true
    setHouseLocations()
end

-- Is there a purpose to this?
local function LeaveNonOwnedHouse(house)
    if not FrontCam then
        IsInside = false
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.25)
        openHouseAnim()
        Wait(250)
        DoScreenFadeOut(250)
        Wait(500)
        exports['qb-interior']:DespawnInterior(houseObj, function()
            UnloadDecorations()
            TriggerEvent('qb-weathersync:client:EnableSync')
            Wait(250)
            DoScreenFadeIn(250)
            SetEntityCoords(PlayerPedId(), Config.Houses[CurrentHouse].coords.enter.x, Config.Houses[CurrentHouse].coords.enter.y, Config.Houses[CurrentHouse].coords.enter.z + 0.2)
            SetEntityHeading(PlayerPedId(), Config.Houses[CurrentHouse].coords.enter.h)
            InOwnedHouse = false
            TriggerEvent('backitems:showagain')
            TriggerEvent('qb-weed:client:leaveHouse')
            TriggerServerEvent('qb-houses:server:SetInsideMeta', house, false)
            CurrentHouse = nil
        end)
    end
end

local function isNearHouses()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)

    if ClosestHouse ~= nil then
        local dist = #(pos - vector3(Config.Houses[ClosestHouse].coords.enter.x, Config.Houses[ClosestHouse].coords.enter.y, Config.Houses[ClosestHouse].coords.enter.z))
        if dist <= 1.5 then
            if HasHouseKey then
                return true
            end
        end
    end
end

exports('isNearHouses', isNearHouses)

-- Events
-- CUSTOM REAL ESTATE JOB
RegisterNetEvent('qb-houses:client:deletehouses', function(selectedHouse)
    Config.Houses[selectedHouse.name] = nil
    SetClosestHouse()
end)
-- END JOB


RegisterNetEvent('qb-houses:server:sethousedecorations', function(house, decorations)
	Config.Houses[house].decorations = decorations
	if IsInside and ClosestHouse == house then
		LoadDecorations(house)
	end
end)

RegisterNetEvent('qb-houses:client:sellHouse', function()
    if ClosestHouse and HasHouseKey then
        TriggerServerEvent('qb-houses:server:viewHouse', ClosestHouse)
    end
end)

RegisterNetEvent('qb-houses:client:EnterHouse', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)

    if ClosestHouse ~= nil then
        local dist = #(pos - vector3(Config.Houses[ClosestHouse].coords.enter.x, Config.Houses[ClosestHouse].coords.enter.y, Config.Houses[ClosestHouse].coords.enter.z))
        if dist <= 1.5 then
            if HasHouseKey then
                enterOwnedHouse(ClosestHouse)
            else
                if not Config.Houses[ClosestHouse].locked then
                    enterNonOwnedHouse(ClosestHouse)
                end
            end
        end
    end
end)

RegisterNetEvent('qb-houses:client:RequestRing', function()
    if ClosestHouse ~= nil then
        TriggerServerEvent('qb-houses:server:RingDoor', ClosestHouse)
    end
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function() -- GARAGE EDIT
    TriggerServerEvent('qb-houses:client:setHouses')
    TriggerServerEvent('qb-houses:server:FetchGarages')
    SetClosestHouse()
    TriggerEvent('qb-houses:client:setupHouseBlips')
    if Config.UnownedBlips then TriggerEvent('qb-houses:client:setupHouseBlips2') end
    Wait(100)
    TriggerServerEvent("qb-houses:server:setHouses")
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    IsInside = false
    ClosestHouse = nil
    HasHouseKey = false
    isOwned = false
    for k, v in pairs(OwnedHouseBlips) do
        RemoveBlip(v)
    end
    if Config.UnownedBlips then
        for k,v in pairs(UnownedHouseBlips) do
            RemoveBlip(v)
        end
    end
end)

RegisterNetEvent('qb-houses:client:setHouseConfig', function(houseConfig)
    Config.Houses = houseConfig
end)

RegisterNetEvent('qb-houses:client:lockHouse', function(bool, house)
    Config.Houses[house].locked = bool
end)

RegisterNetEvent('qb-houses:client:createHouses', function(apartmentnumber, price, tier) -- GARAGE EDIT
    local pos = GetEntityCoords(PlayerPedId())
    local heading = GetEntityHeading(PlayerPedId())
	local s1, s2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
    local street = GetStreetNameFromHashKey(s1)
    local coords = {
        enter 	= { x = pos.x, y = pos.y, z = pos.z, h = heading},
        cam 	= { x = pos.x, y = pos.y, z = pos.z, h = heading, yaw = -10.00},
    }
    street = 'No. ' .. apartmentnumber .. ' ' .. street:gsub('%-', ' ')
    if tier > 36 then
        QBCore.Functions.Notify("Tier 36 is the limit") 
    else
    TriggerServerEvent('qb-houses:server:addNewHouse', street, coords, price, tier)
    if Config.UnownedBlips then TriggerServerEvent('qb-houses:server:createBlip') end
    end
end)

RegisterNetEvent('qb-houses:client:createHousesM', function()
    local pos = GetEntityCoords(PlayerPedId())
    local heading = GetEntityHeading(PlayerPedId())
	local s1, s2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
    local street = GetStreetNameFromHashKey(s1)
    local coords = {
        enter 	= { x = pos.x, y = pos.y, z = pos.z, h = heading},
        cam 	= { x = pos.x, y = pos.y, z = pos.z, h = heading, yaw = -10.00},
    }
    street = street:gsub("%-", " ")
    local price = "10000"
    local tier = "1"
    TriggerServerEvent('qb-houses:server:addNewHouse', street, coords, price, tier)
    if Config.UnownedBlips then TriggerServerEvent('qb-houses:server:createBlip') end
end)

RegisterNetEvent('qb-houses:client:addGarage', function() -- ORIGINAL EVENT BEFORE GARAGE EDIT
    if ClosestHouse ~= nil then
        local pos = GetEntityCoords(PlayerPedId())
        local heading = GetEntityHeading(PlayerPedId())
        local coords = {
            x = pos.x,
            y = pos.y,
            z = pos.z,
            h = heading,
        }
        TriggerServerEvent('qb-houses:server:addGarage', ClosestHouse, coords)
    else
        QBCore.Functions.Notify(Lang:t("error.no_house"), "error")
    end
end)

RegisterNetEvent('qb-houses:client:toggleDoorlock', function()
    local pos = GetEntityCoords(PlayerPedId())
    local dist = #(pos - vector3(Config.Houses[ClosestHouse].coords.enter.x, Config.Houses[ClosestHouse].coords.enter.y, Config.Houses[ClosestHouse].coords.enter.z))
    if dist <= 1.5 then
        if HasHouseKey then
            if Config.Houses[ClosestHouse].locked then
                TriggerServerEvent('qb-houses:server:lockHouse', false, ClosestHouse)
                QBCore.Functions.Notify(Lang:t("success.unlocked"), "success", 2500)
            else
                TriggerServerEvent('qb-houses:server:lockHouse', true, ClosestHouse)
                QBCore.Functions.Notify(Lang:t("error.locked"), "error", 2500)
            end
        else
            QBCore.Functions.Notify(Lang:t("error.no_keys"), "error", 3500)
        end
    else
        QBCore.Functions.Notify(Lang:t("error.no_door"), "error", 3500)
    end
end)

RegisterNetEvent('qb-houses:client:RingDoor', function(player, house)
    if ClosestHouse == house and IsInside then
        CurrentDoorBell = player
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "doorbell", 0.1)
        QBCore.Functions.Notify(Lang:t("info.door_ringing"))
    end
end)

RegisterNetEvent('qb-houses:client:giveHouseKey', function()
    local player, distance = GetClosestPlayer()
    if player ~= -1 and distance < 2.5 and ClosestHouse ~= nil then
        local playerId = GetPlayerServerId(player)
        local pedpos = GetEntityCoords(PlayerPedId())
        local housedist = #(pedpos - vector3(Config.Houses[ClosestHouse].coords.enter.x, Config.Houses[ClosestHouse].coords.enter.y, Config.Houses[ClosestHouse].coords.enter.z))
        if housedist < 10 then
            TriggerServerEvent('qb-houses:server:giveHouseKey', playerId, ClosestHouse)
        else
            QBCore.Functions.Notify(Lang:t("error.no_door"), "error")
        end
    elseif ClosestHouse == nil then
        QBCore.Functions.Notify(Lang:t("error.no_house"), "error")
    else
        QBCore.Functions.Notify(Lang:t("error.no_one_near"), "error")
    end
end)

RegisterNetEvent('qb-houses:client:removeHouseKey', function()
    if ClosestHouse ~= nil then
        local pedpos = GetEntityCoords(PlayerPedId())
        local housedist = #(pedpos - vector3(Config.Houses[ClosestHouse].coords.enter.x, Config.Houses[ClosestHouse].coords.enter.y, Config.Houses[ClosestHouse].coords.enter.z))
        if housedist <= 5 then
            QBCore.Functions.TriggerCallback('qb-houses:server:getHouseOwner', function(result)
                if QBCore.Functions.GetPlayerData().citizenid == result then
                    HouseKeysMenu()
                else
                    QBCore.Functions.Notify(Lang:t("error.not_owner"), "error")
                end
            end, ClosestHouse)
        else
            QBCore.Functions.Notify(Lang:t("error.no_door"), "error")
        end
    else
        QBCore.Functions.Notify(Lang:t("error.no_door"), "error")
    end
end)

RegisterNetEvent('qb-houses:client:RevokeKey', function(data)
    RemoveHouseKey(data.citizenData)
end)

RegisterNetEvent('qb-houses:client:refreshHouse', function(data)
    Wait(100)
    SetClosestHouse()
end)

RegisterNetEvent('qb-houses:client:SpawnInApartment', function(house)
    local pos = GetEntityCoords(PlayerPedId())
    if rangDoorbell ~= nil then
        if #(pos - vector3(Config.Houses[house].coords.enter.x, Config.Houses[house].coords.enter.y, Config.Houses[house].coords.enter.z)) > 5 then
            return
        end
    end
    ClosestHouse = house
    enterNonOwnedHouse(house)
end)

RegisterNetEvent('qb-houses:client:enterOwnedHouse', function(house)
    QBCore.Functions.GetPlayerData(function(PlayerData)
		if PlayerData.metadata["injail"] == 0 then
			enterOwnedHouse(house)
		end
	end)
end)

RegisterNetEvent('qb-houses:client:LastLocationHouse', function(houseId)
    QBCore.Functions.GetPlayerData(function(PlayerData)
		if PlayerData.metadata["injail"] == 0 then
			enterOwnedHouse(houseId)
		end
	end)
end)

RegisterNetEvent('qb-houses:client:setupHouseBlips', function() -- Setup owned on load
    CreateThread(function()
        Wait(2000)
        if LocalPlayer.state['isLoggedIn'] then
            QBCore.Functions.TriggerCallback('qb-houses:server:getOwnedHouses', function(ownedHouses)
                if ownedHouses then
                    for k, v in pairs(ownedHouses) do
                        local house = Config.Houses[ownedHouses[k]]
                        HouseBlip = AddBlipForCoord(house.coords.enter.x, house.coords.enter.y, house.coords.enter.z)
                        SetBlipSprite (HouseBlip, 40)
                        SetBlipDisplay(HouseBlip, 4)
                        SetBlipScale  (HouseBlip, 0.65)
                        SetBlipAsShortRange(HouseBlip, true)
                        SetBlipColour(HouseBlip, 3)
                        AddTextEntry('OwnedHouse', house.adress)
                        BeginTextCommandSetBlipName('OwnedHouse')
                        EndTextCommandSetBlipName(HouseBlip)
                        OwnedHouseBlips[#OwnedHouseBlips+1] = HouseBlip
                    end
                end
            end)
        end
    end)
end)

RegisterNetEvent('qb-houses:client:setupHouseBlips2', function() -- Setup unowned on load
    for k,v in pairs(Config.Houses) do
        if not v.owned then
            HouseBlip2 = AddBlipForCoord(v.coords.enter.x, v.coords.enter.y, v.coords.enter.z)
            SetBlipSprite (HouseBlip2, 40)
            SetBlipDisplay(HouseBlip2, 4)
            SetBlipScale  (HouseBlip2, 0.65)
            SetBlipAsShortRange(HouseBlip2, true)
            SetBlipColour(HouseBlip2, 3)
            AddTextEntry('UnownedHouse', Lang:t("info.house_for_sale"))
            BeginTextCommandSetBlipName('UnownedHouse')
            EndTextCommandSetBlipName(HouseBlip2)
            UnownedHouseBlips[#UnownedHouseBlips+1] = HouseBlip2
        end
    end
end)

RegisterNetEvent('qb-houses:client:createBlip', function(coords) -- Create unowned on command
    NewHouseBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite (NewHouseBlip, 40)
    SetBlipDisplay(NewHouseBlip, 4)
    SetBlipScale  (NewHouseBlip, 0.65)
    SetBlipAsShortRange(NewHouseBlip, true)
    SetBlipColour(NewHouseBlip, 3)
    AddTextEntry('NewHouseBlip', Lang:t("info.house_for_sale"))
    BeginTextCommandSetBlipName('NewHouseBlip')
    EndTextCommandSetBlipName(NewHouseBlip)
    UnownedHouseBlips[#UnownedHouseBlips+1] = NewHouseBlip
end)

RegisterNetEvent('qb-houses:client:refreshBlips', function() -- Refresh unowned on buy
    for k,v in pairs(UnownedHouseBlips) do RemoveBlip(v) end
    Wait(250)
    TriggerEvent('qb-houses:client:setupHouseBlips2')
end)

RegisterNetEvent('qb-houses:client:SetClosestHouse', function()
    SetClosestHouse()
end)

RegisterNetEvent('qb-houses:client:viewHouse', function(houseprice, brokerfee, bankfee, taxes, firstname, lastname)
    setViewCam(Config.Houses[ClosestHouse].coords.cam, Config.Houses[ClosestHouse].coords.cam.h, Config.Houses[ClosestHouse].coords.yaw)
    Wait(500)
    openContract(true)
    SendNUIMessage({
        type = "setupContract",
        firstname = firstname,
        lastname = lastname,
        street = Config.Houses[ClosestHouse].adress,
        houseprice = houseprice,
        brokerfee = brokerfee,
        bankfee = bankfee,
        taxes = taxes,
        totalprice = (houseprice + brokerfee + bankfee + taxes)
    })
end)

RegisterNetEvent('qb-houses:client:setLocation', function(data)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local coords = {x = pos.x, y = pos.y, z = pos.z}
    if IsInside then
        if HasHouseKey then
            if data.id == 'setstash' then
                TriggerServerEvent('qb-houses:server:setLocation', coords, ClosestHouse, 1)
            elseif data.id == 'setoutift' then
                TriggerServerEvent('qb-houses:server:setLocation', coords, ClosestHouse, 2)
            elseif data.id == 'setlogout' then
                TriggerServerEvent('qb-houses:server:setLocation', coords, ClosestHouse, 3)
            end
        else
            QBCore.Functions.Notify(Lang:t("error.not_owner"), "error")
        end
    else
        QBCore.Functions.Notify(Lang:t("error.not_in_house"), "error")
    end
end)

RegisterNetEvent('qb-houses:client:setstashLocation', function(data) -- mine
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local coords = {x = pos.x, y = pos.y, z = pos.z}
    if IsInside then
        if HasHouseKey then
            TriggerServerEvent('qb-houses:server:setLocation', coords, ClosestHouse, 1)
            QBCore.Functions.Notify("Already set Stash", "success")
        else
            QBCore.Functions.Notify(Lang:t("error.not_owner"), "error")
        end
    else
        QBCore.Functions.Notify(Lang:t("error.not_in_house"), "error")
    end
end)

RegisterNetEvent('qb-houses:client:setoutfitLocation', function(data) -- mine
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local coords = {x = pos.x, y = pos.y, z = pos.z}
    if IsInside then
        if HasHouseKey then
            TriggerServerEvent('qb-houses:server:setLocation', coords, ClosestHouse, 2)
            QBCore.Functions.Notify("Already set Outfit", "success")
        else
            QBCore.Functions.Notify(Lang:t("error.not_owner"), "error")
        end
    else
        QBCore.Functions.Notify(Lang:t("error.not_in_house"), "error")
    end
end)

RegisterNetEvent('qb-houses:client:setlogoutLocation', function(data) -- mine
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local coords = {x = pos.x, y = pos.y, z = pos.z}
    if IsInside then
        if HasHouseKey then
            TriggerServerEvent('qb-houses:server:setLocation', coords, ClosestHouse, 3)
            QBCore.Functions.Notify("Already set Logout", "success")
        else
            QBCore.Functions.Notify(Lang:t("error.not_owner"), "error")
        end
    else
        QBCore.Functions.Notify(Lang:t("error.not_in_house"), "error")
    end
end)

RegisterNetEvent('qb-houses:client:refreshLocations', function(house, location, type)
    if ClosestHouse == house then
        if IsInside then
            if type == 1 then
                stashLocation = json.decode(location)
            elseif type == 2 then
                outfitLocation = json.decode(location)
            elseif type == 3 then
                logoutLocation = json.decode(location)
            end
        end
    end
end)

RegisterNetEvent('qb-houses:client:HomeInvasion', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local Skillbar = exports['qb-skillbar']:GetSkillbarObject()
    if ClosestHouse ~= nil then
        QBCore.Functions.TriggerCallback('police:server:IsPoliceForcePresent', function(IsPresent)
            if IsPresent then
                local dist = #(pos - vector3(Config.Houses[ClosestHouse].coords.enter.x, Config.Houses[ClosestHouse].coords.enter.y, Config.Houses[ClosestHouse].coords.enter.z))
                if Config.Houses[ClosestHouse].IsRaming == nil then
                    Config.Houses[ClosestHouse].IsRaming = false
                end
                if dist < 1 then
                    if Config.Houses[ClosestHouse].locked then
                        if not Config.Houses[ClosestHouse].IsRaming then
                            DoRamAnimation(true)
                            local success = exports['qb-lock']:StartLockPickCircle(3,40)
	                        if success then
                            --[[Skillbar.Start({
                                duration = math.random(5000, 10000),
                                pos = math.random(10, 30),
                                width = math.random(10, 20),
                            }, function()]]
                                if RamsDone + 1 >= Config.RamsNeeded then
                                    TriggerServerEvent('qb-houses:server:lockHouse', false, ClosestHouse)
                                    QBCore.Functions.Notify(Lang:t("success.home_invasion"), 'success')
                                    TriggerServerEvent('qb-houses:server:SetHouseRammed', true, ClosestHouse)
                                    TriggerServerEvent('qb-houses:server:SetRamState', false, ClosestHouse)
                                    DoRamAnimation(false)
                                else
                                    if success then
                                        DoRamAnimation(true)
                                    --[[Skillbar.Repeat({
                                        duration = math.random(500, 1000),
                                        pos = math.random(10, 30),
                                        width = math.random(5, 12),
                                    })]]
                                        RamsDone = RamsDone + 1
                                    end
                                end
                            --end, function()
                            else
                                RamsDone = 0
                                TriggerServerEvent('qb-houses:server:SetRamState', false, ClosestHouse)
                                QBCore.Functions.Notify(Lang:t("error.failed_invasion"), 'error')
                                DoRamAnimation(false)
                            end
                            TriggerServerEvent('qb-houses:server:SetRamState', true, ClosestHouse)
                        else
                            QBCore.Functions.Notify(Lang:t("error.inprogress_invasion"), 'error')
                        end
                    else
                        QBCore.Functions.Notify(Lang:t("error.already_open"), 'error')
                    end
                else
                    QBCore.Functions.Notify(Lang:t("error.no_house"), "error")
                end
            else
                QBCore.Functions.Notify(Lang:t("error.no_police"), 'error')
            end
        end)
    else
        QBCore.Functions.Notify(Lang:t("error.no_house"), "error")
    end
end)

RegisterNetEvent('qb-houses:client:SetRamState', function(bool, house)
    Config.Houses[house].IsRaming = bool
end)

RegisterNetEvent('qb-houses:client:SetHouseRammed', function(bool, house)
    Config.Houses[house].IsRammed = bool
end)

RegisterNetEvent('qb-houses:client:ResetHouse', function()
    if ClosestHouse ~= nil then
        if Config.Houses[ClosestHouse].IsRammed == nil then
            Config.Houses[ClosestHouse].IsRammed = false
            TriggerServerEvent('qb-houses:server:SetHouseRammed', false, ClosestHouse)
            TriggerServerEvent('qb-houses:server:SetRamState', false, ClosestHouse)
        end
        if Config.Houses[ClosestHouse].IsRammed then
            openHouseAnim()
            TriggerServerEvent('qb-houses:server:SetHouseRammed', false, ClosestHouse)
            TriggerServerEvent('qb-houses:server:SetRamState', false, ClosestHouse)
            TriggerServerEvent('qb-houses:server:lockHouse', true, ClosestHouse)
            RamsDone = 0
            QBCore.Functions.Notify(Lang:t("success.lock_invasion"), 'success')
        else
            QBCore.Functions.Notify(Lang:t("error.no_invasion"), 'error')
        end
    end
end)

RegisterNetEvent('qb-houses:client:ExitOwnedHouse', function()
    local door = vector3(Config.Houses[CurrentHouse].coords.enter.x + POIOffsets.exit.x, Config.Houses[CurrentHouse].coords.enter.y + POIOffsets.exit.y, Config.Houses[CurrentHouse].coords.enter.z - Config.MinZOffset + POIOffsets.exit.z)
    if CheckDistance(door, 1.5) then
        LeaveOwnedHouse(CurrentHouse)
    end
end)

RegisterNetEvent('qb-houses:client:FrontDoorCam', function()
    local door = vector3(Config.Houses[CurrentHouse].coords.enter.x + POIOffsets.exit.x, Config.Houses[CurrentHouse].coords.enter.y + POIOffsets.exit.y, Config.Houses[CurrentHouse].coords.enter.z - Config.MinZOffset + POIOffsets.exit.z)
    if CheckDistance(door, 1.5) then
        FrontDoorCam(Config.Houses[CurrentHouse].coords.enter)
    end
end)

RegisterNetEvent('qb-houses:client:AnswerDoorbell', function()
    local door = vector3(Config.Houses[CurrentHouse].coords.enter.x + POIOffsets.exit.x, Config.Houses[CurrentHouse].coords.enter.y + POIOffsets.exit.y, Config.Houses[CurrentHouse].coords.enter.z - Config.MinZOffset + POIOffsets.exit.z)
    if CheckDistance(door, 1.5) and CurrentDoorBell ~= 0 then
        TriggerServerEvent("qb-houses:server:OpenDoor", CurrentDoorBell, ClosestHouse)
        CurrentDoorBell = 0
    end
end)

RegisterNetEvent('qb-houses:client:OpenStash', function()
    local stashLoc = vector3(stashLocation.x, stashLocation.y, stashLocation.z)
    if CheckDistance(stashLoc, 1.5) then
        local other = {
            maxweight = Config.StashSize[Config.Houses[CurrentHouse].tier],
            maxslots = Config.StashSlots[Config.Houses[CurrentHouse].tier],
        }
        TriggerServerEvent("inventory:server:OpenInventory", "stash", CurrentHouse, other)
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "StashOpen", 0.4)
        TriggerEvent("inventory:client:SetCurrentStash", CurrentHouse)
    end
end)

RegisterNetEvent('qb-houses:client:ChangeCharacter', function(source)
    local stashLoc = vector3(logoutLocation.x, logoutLocation.y, logoutLocation.z)
    if CheckDistance(stashLoc, 1.5) then
        DoScreenFadeOut(250)
        while not IsScreenFadedOut() do
            Wait(10)
        end
        exports['qb-interior']:DespawnInterior(houseObj, function()
            TriggerEvent('qb-weathersync:client:EnableSync')
            SetEntityCoords(PlayerPedId(), Config.Houses[CurrentHouse].coords.enter.x, Config.Houses[CurrentHouse].coords.enter.y, Config.Houses[CurrentHouse].coords.enter.z + 0.5)
            SetEntityHeading(PlayerPedId(), Config.Houses[CurrentHouse].coords.enter.h)
            InOwnedHouse = false
            IsInside = false
            TriggerServerEvent('qb-houses:server:LogoutLocation', source)
        end)
    end
end)

RegisterNetEvent('qb-houses:client:ChangeOutfit', function()
    local outfitLoc = vector3(outfitLocation.x, outfitLocation.y, outfitLocation.z)
    if CheckDistance(outfitLoc, 1.5) then
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "Clothes1", 0.4)
        TriggerEvent('raid_clothes:outfits')
    end
end)

RegisterNetEvent('qb-houses:client:ViewHouse', function()
    local houseCoords = vector3(Config.Houses[ClosestHouse].coords.enter.x, Config.Houses[ClosestHouse].coords.enter.y, Config.Houses[ClosestHouse].coords.enter.z)
    if CheckDistance(houseCoords, 1.5) then
        TriggerServerEvent('qb-houses:server:viewHouse', ClosestHouse)
    end
end)

RegisterNetEvent('qb-houses:client:KeyholderOptions', function(data)
    optionMenu(data.citizenData)
end)
-- NUI Callbacks

RegisterNUICallback('HasEnoughMoney', function(data, cb)
    QBCore.Functions.TriggerCallback('qb-houses:server:HasEnoughMoney', function(hasEnough)
    end, data.objectData)
end)

RegisterNUICallback('buy', function()
    openContract(false)
    disableViewCam()
    Config.Houses[ClosestHouse].owned = true
    if Config.UnownedBlips then TriggerEvent('qb-houses:client:refreshBlips') end
    TriggerServerEvent('qb-houses:server:buyHouse', ClosestHouse)
end)

RegisterNUICallback('exit', function()
    openContract(false)
    disableViewCam()
end)

-- Threads

CreateThread(function()
    Wait(1000)
    TriggerServerEvent('qb-houses:server:setHouses')
    SetClosestHouse()
    TriggerEvent('qb-houses:client:setupHouseBlips')
    if Config.UnownedBlips then TriggerEvent('qb-houses:client:setupHouseBlips2') end
    Wait(100)
    TriggerEvent('qb-garages:client:setHouseGarage', ClosestHouse, HasHouseKey)
    TriggerServerEvent("qb-houses:server:setHouses")
end)

Citizen.CreateThread(function()
    if LocalPlayer.state['isLoggedIn'] then
        isLoggedIn = true
        TriggerServerEvent('qb-houses:server:setHouses')
        TriggerServerEvent('qb-houses:server:FetchGarages')
        currJob = QBCore.Functions.GetPlayerData().job.name
    end
end)

CreateThread(function()
    while true do
        Wait(5000)
        if LocalPlayer.state['isLoggedIn'] then
            if not IsInside then
                SetClosestHouse()
            end
        end
    end
end)

CreateThread(function()
    local shownMenu = false

    while true do
        local pos = GetEntityCoords(PlayerPedId())
        local inRange = false
        local nearLocation = false
        local houseMenu = {}

        if ClosestHouse ~= nil then
            local dist2 = vector3(Config.Houses[ClosestHouse].coords.enter.x, Config.Houses[ClosestHouse].coords.enter.y, Config.Houses[ClosestHouse].coords.enter.z)
            if #(pos.xy - dist2.xy) < 30 then
                inRange = true
                if HasHouseKey then
                    -- ENTER HOUSE
                    if not IsInside then
                        if ClosestHouse ~= nil then
                            if #(pos - dist2) <= 1.5 then
                                exports['qb-ui']:showInteraction("House")
                                if IsControlJustPressed(0, 38) then
                                    TriggerEvent("qb-houses:client:EnterHouse")
                                end
                                nearLocation = true
                            elseif #(pos - dist2) <= 2.0 then
                                exports['qb-ui']:hideInteraction()
                            end
                        end
                    else
                        if not entering and POIOffsets ~= nil then
                            local exitOffset = vector3(Config.Houses[CurrentHouse].coords.enter.x + POIOffsets.exit.x, Config.Houses[CurrentHouse].coords.enter.y + POIOffsets.exit.y, Config.Houses[CurrentHouse].coords.enter.z - Config.MinZOffset + POIOffsets.exit.z + 1.0)
                            if #(pos - exitOffset) <= 1.5 then
                                exports['qb-ui']:showInteraction("[E] Exit House [G] Front Camera")
                                if IsControlJustPressed(0, 38) then
                                    TriggerEvent("qb-houses:client:ExitOwnedHouse")
                                elseif IsControlJustPressed(0, 47) then
                                    TriggerEvent("qb-houses:client:FrontDoorCam")
                                end

                                if CurrentDoorBell ~= 0 then
                                    exports['qb-ui']:showInteraction("[H] Answer Door Bell")
                                    if IsControlJustPressed(0, 74) then
                                        TriggerEvent("qb-houses:client:AnswerDoorbell")
                                    end
                                end
                                nearLocation = true
                            elseif #(pos - exitOffset) <= 2.0 then
                                exports['qb-ui']:hideInteraction()
                            end
                        end
                    end
                else
                    if ClosestHouse ~= nil and not IsInside  then
                        if not isOwned then
                            local houseCoords = vector3(Config.Houses[ClosestHouse].coords.enter.x, Config.Houses[ClosestHouse].coords.enter.y, Config.Houses[ClosestHouse].coords.enter.z)
                            if #(pos - houseCoords) <= 1.5 then
                                if not viewCam and Config.Houses[ClosestHouse].locked then
                                    exports['qb-ui']:showInteraction("[E] View House")
                                    if IsControlJustPressed(0, 38) then
                                        TriggerEvent("qb-houses:client:ViewHouse")
                                    end
                                    nearLocation = true
                                end
                            elseif #(pos - houseCoords) <= 2.0 then
                                exports['qb-ui']:hideInteraction()
                            end
                        end

                        if isOwned then
                            local houseCoords = vector3(Config.Houses[ClosestHouse].coords.enter.x, Config.Houses[ClosestHouse].coords.enter.y, Config.Houses[ClosestHouse].coords.enter.z)
                            if #(pos - houseCoords) <= 1.5 then
                                nearLocation = true
                                exports['qb-ui']:showInteraction("[G] Ring the Doorbell")
                                if IsControlJustPressed(0, 47) then
                                    TriggerEvent("qb-houses:client:RequestRing")
                                end

                                if not Config.Houses[ClosestHouse].locked then
                                    exports['qb-ui']:showInteraction("[E] Enter Unlocked House")
                                    if IsControlJustPressed(0, 38) then
                                        TriggerEvent("qb-houses:client:EnterHouse")
                                    end

                                    if QBCore.Functions.GetPlayerData().job.name == 'police' then
                                        exports['qb-ui']:showInteraction("[E] Lock Door")
                                        if IsControlJustPressed(0, 38) then
                                            TriggerEvent("qb-houses:client:ResetHouse")
                                        end
                                    end
                                end
                            elseif #(pos - houseCoords) <= 2.0 then
                                exports['qb-ui']:hideInteraction()
                            end
                        end
                    end

                    if IsInside and CurrentHouse ~= nil and not entering then
                        if POIOffsets ~= nil then
                            local exitOffset = vector3(Config.Houses[CurrentHouse].coords.enter.x + POIOffsets.exit.x, Config.Houses[CurrentHouse].coords.enter.y + POIOffsets.exit.y, Config.Houses[CurrentHouse].coords.enter.z - Config.MinZOffset + POIOffsets.exit.z + 1.0)
                            if #(pos - exitOffset) <= 1.5 then
                                exports['qb-ui']:showInteraction("[E] Exit Property")
                                if IsControlJustPressed(0, 47) then
                                    TriggerEvent("qb-houses:client:ExitOwnedHouse")
                                end
                                nearLocation = true
                            end
                        end
                    end
                end

                if IsInside and CurrentHouse ~= nil and not entering and isOwned then
                    if stashLocation ~= nil then
                        if #(pos - vector3(stashLocation.x, stashLocation.y, stashLocation.z)) <= 1.5 then
                            nearLocation = true
                            exports['qb-ui']:showInteraction("[E] Stash")
                            if IsControlJustPressed(0, 38) then
                                TriggerEvent("qb-houses:client:OpenStash")
                            end

                        elseif #(pos - vector3(stashLocation.x, stashLocation.y, stashLocation.z)) <= 2 then
                            exports['qb-ui']:hideInteraction()
                        end
                    end

                    if outfitLocation ~= nil then
                        if #(pos - vector3(outfitLocation.x, outfitLocation.y, outfitLocation.z)) <= 1.5 then
                            nearLocation = true
                            exports['qb-ui']:showInteraction("[E] Outfits")
                            if IsControlJustPressed(0, 38) then
                                TriggerEvent("raid_clothes:outfits")
                            end
                        elseif #(pos - vector3(outfitLocation.x, outfitLocation.y, outfitLocation.z)) <= 2 then
                            exports['qb-ui']:hideInteraction()
                        end
                    end

                    if logoutLocation ~= nil then
                        if #(pos - vector3(logoutLocation.x, logoutLocation.y, logoutLocation.z)) <= 1.5 then
                            nearLocation = true
                            exports['qb-ui']:showInteraction("[E] Logout")
                            if IsControlJustPressed(0, 38) then
                                ExecuteCommand('logout')
                                --TriggerServerEvent('qb-houses:server:LogoutLocation', source)
                                --TriggerEvent("qb-houses:client:ChangeCharacter", source)
                            end
                        elseif #(pos - vector3(logoutLocation.x, logoutLocation.y, logoutLocation.z)) < 2 then
                            exports['qb-ui']:hideInteraction()
                        end
                    end
                end
            end
        end

        if not inRange then
            Wait(1500)

            if shownMenu then
                CloseMenuFull()
                shownMenu = false
            end
        end
        Wait(3)
    end
end)

RegisterCommand('getoffset', function()
    local coords = GetEntityCoords(PlayerPedId())
    local houseCoords = vector3(
        Config.Houses[CurrentHouse].coords.enter.x,
        Config.Houses[CurrentHouse].coords.enter.y,
        Config.Houses[CurrentHouse].coords.enter.z - Config.MinZOffset
    )
    if IsInside then
        local xdist = coords.x - houseCoords.x
        local ydist = coords.y - houseCoords.y
        local zdist = coords.z - houseCoords.z
        print('X: '..xdist)
        print('Y: '..ydist)
        print('Z: '..zdist)
    end
end)

exports('GetCurrentHouse', function() -- added for p22 weed plants script
	return IsInside
end)

exports('isInHouse', function()
    if IsInside then
        print(IsInside)
        return true
    end
    return false
end)

RegisterNetEvent("qb-houses:client:DeleteHouse", function()
    if QBCore.Functions.GetPlayerData().job.name == 'realestate' then
        if ClosestHouse ~= nil then
            TriggerServerEvent("qb-houses:server:DeleteHouse", ClosestHouse)
        else
            QBCore.Functions.Notify('No House Nearby', 'error')
        end
    else
        QBCore.Functions.Notify('Real Estate Only', 'error')
    end
end)
RegisterNetEvent("qb-houses:client:removeMenuForAgent", function(house) -- This was to make sure the entry menu went away because the default QB-Houses uses that instead of targeting
    if ClosestHouse ~= nil then
        if ClosestHouse == house then
            ClosestHouse = nil    
        end
    end
end)