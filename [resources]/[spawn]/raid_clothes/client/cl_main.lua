QBCore = exports['qb-core']:GetCoreObject()
priceWithTax = nil
currentsteamid = nil
local currentFadeStyle = 255
PlayerData = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
	PlayerData = QBCore.Functions.GetPlayerData()
    QBCore.Functions.TriggerCallback("skins:getSteamId", function(result)
        currentsteamid = result
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
	PlayerData.job = job
end)

function ExportRecords()
    openMenu({
		{menu = "character", label = "Clothing", selected = true},
		{menu = "accessoires", label = "Accessories", selected = false}
	})
end

local enabled = false
local player = false
local firstChar = false
local cam = false
local customCam = false
local oldPed = false
local startingMenu = false

local drawable_names = {"face", "masks", "hair", "torsos", "legs", "bags", "shoes", "neck", "undershirts", "vest", "decals", "jackets"}
local prop_names = {"hats", "glasses", "earrings", "mouth", "lhand", "rhand", "watches", "braclets"}
local head_overlays = {"Blemishes","FacialHair","Eyebrows","Ageing","Makeup","Blush","Complexion","SunDamage","Lipstick","MolesFreckles","ChestHair","BodyBlemishes","AddBodyBlemishes","eyecolor"}
local face_features = {"Nose_Width","Nose_Peak_Hight","Nose_Peak_Lenght","Nose_Bone_High","Nose_Peak_Lowering","Nose_Bone_Twist","EyeBrown_High","EyeBrown_Forward","Cheeks_Bone_High","Cheeks_Bone_Width","Cheeks_Width","Eyes_Openning","Lips_Thickness","Jaw_Bone_Width","Jaw_Bone_Back_Lenght","Chimp_Bone_Lowering","Chimp_Bone_Lenght","Chimp_Bone_Width","Chimp_Hole","Neck_Thikness"}
local tatCategory = GetTatCategs()
local tattooHashList = CreateHashList()

local isService = false
local passedClothing = true

local currentPrice = 0

local MenuData = {
    clothing_shop = {
        text = "To buy clothes",
        displayName = "Clothing Store",
        basePrice = 200
    },
    barber_shop = {
        text = "Fix your ugly mug",
        displayName = "Barber Shop",
        basePrice = 200
    },
    tattoo_shop = {
        text = "Become edgy",
        displayName = "Tattoo Parlor",
        basePrice = 200
    }
}

local listening = false

function RefreshUI()
    hairColors = {}
    for i = 0, GetNumHairColors()-1 do
        local outR, outG, outB= GetPedHairRgbColor(i)
        hairColors[i] = {outR, outG, outB}
    end

    makeupColors = {}
    for i = 0, GetNumMakeupColors()-1 do
        local outR, outG, outB= GetPedMakeupRgbColor(i)
        makeupColors[i] = {outR, outG, outB}
    end

    eyecolors = {}
    eyecolors[1] = {82, 94, 55}
    eyecolors[2] = {38, 52, 25}
    eyecolors[3] = {131, 183, 213}
    eyecolors[4] = {62, 102, 163}
    eyecolors[5] = {141, 104, 51}
    eyecolors[6] = {82, 55, 17}
    eyecolors[7] = {208, 132, 24}
    eyecolors[8] = {190, 190, 190}
    eyecolors[9] = {190, 190, 200}
    eyecolors[10] = {215, 66, 245}
    eyecolors[11] = {245, 236, 66}
    eyecolors[12] = {161, 97, 207}
    eyecolors[13] = {0, 0, 0}
    eyecolors[14] = {82, 78, 78}
    eyecolors[15] = {219, 125, 57}
    eyecolors[16] = {211, 214, 0}
    eyecolors[17] = {209, 209, 209}
    eyecolors[18] = {255, 54, 54}
    eyecolors[19] = {255, 133, 89}
    eyecolors[20] = {219, 219, 219}
    eyecolors[21] = {255, 125, 125}
    eyecolors[22] = {125, 168, 89}
    eyecolors[23] = {204, 179, 90}
    eyecolors[24] = {90, 118, 204}
    eyecolors[25] = {145, 136, 106}
    eyecolors[26] = {194, 150, 2}
    eyecolors[27] = {33, 33, 33}
    eyecolors[28] = {255, 33, 33}
    eyecolors[29] = {247, 82, 82}
    eyecolors[30] = {86, 240, 222}
    eyecolors[31] = {230, 255, 252}
    eyecolors[32] = {225, 247, 245}
    eyecolors[33] = {81, 110, 83}

    SendNUIMessage({
        type="colors",
        hairColors=hairColors,
        makeupColors=makeupColors,
        hairColor=GetPedHair(),
        eyecolor = eyecolors
    })

    SendNUIMessage({
        type="colors",
        hairColors=hairColors,
        makeupColors=makeupColors,
        hairColor=GetPedHair()
    })
    SendNUIMessage({
        type = "menutotals",
        drawTotal = GetDrawablesTotal(),
        propDrawTotal = GetPropDrawablesTotal(),
        textureTotal = GetTextureTotals(),
        headoverlayTotal = GetHeadOverlayTotals(),
        skinTotal = GetSkinTotal(),
        fadeTotal = GetFadeTotal()
    })
    SendNUIMessage({
        type = "barber_shop",
        headBlend = GetPedHeadBlendData(),
        headOverlay = GetHeadOverlayData(),
        headStructure = GetHeadStructureData()
    })
    SendNUIMessage({
        type = "clothing_shopdata",
        drawables = GetDrawables(),
        props = GetProps(),
        drawtextures = GetDrawTextures(),
        proptextures = GetPropTextures(),
        skin = GetSkin(),
        currentFade = currentFadeStyle,
        oldPed = oldPed,
    })
    SendNUIMessage({
        type = "tattoo_shop",
        totals = tatCategory,
        values = GetTats()
    })
end

function GetSkin()
    for i = 1, #frm_skins do
        if (GetHashKey(frm_skins[i]) == GetEntityModel(PlayerPedId())) then
            return {name="skin_male", value=i}
        end
    end
    for i = 1, #fr_skins do
        if (GetHashKey(fr_skins[i]) == GetEntityModel(PlayerPedId())) then
            return {name="skin_female", value=i}
        end
    end
    return false
end

function GetDrawables()
    drawables = {}
    local model = GetEntityModel(PlayerPedId())
    local mpPed = false
    if (model == `mp_f_freemode_01` or model == `mp_m_freemode_01`) then
        mpPed = true
    end
    for i = 0, #drawable_names-1 do
        if mpPed and drawable_names[i+1] == "undershirts" and GetPedDrawableVariation(player, i) == -1 then
            SetPedComponentVariation(player, i, 15, 0, 2)
        end
        drawables[i] = {drawable_names[i+1], GetPedDrawableVariation(player, i)}
    end
    return drawables
end

function GetProps()
    props = {}
    for i = 0, #prop_names-1 do
        props[i] = {prop_names[i+1], GetPedPropIndex(player, i)}
    end
    return props
end

function GetDrawTextures()
    textures = {}
    for i = 0, #drawable_names-1 do
        table.insert(textures, {drawable_names[i+1], GetPedTextureVariation(player, i)})
    end
    return textures
end

function GetPropTextures()
    textures = {}
    for i = 0, #prop_names-1 do
        table.insert(textures, {prop_names[i+1], GetPedPropTextureIndex(player, i)})
    end
    return textures
end

function GetDrawablesTotal()
    drawables = {}
    for i = 0, #drawable_names - 1 do
        drawables[i] = {drawable_names[i+1], GetNumberOfPedDrawableVariations(player, i)}
    end
    return drawables
end

function GetPropDrawablesTotal()
    props = {}
    for i = 0, #prop_names - 1 do
        props[i] = {prop_names[i+1], GetNumberOfPedPropDrawableVariations(player, i)}
    end
    return props
end

function GetTextureTotals()
    local values = {}
    local draw = GetDrawables()
    local props = GetProps()

    for idx = 0, #draw-1 do
        local name = draw[idx][1]
        local value = draw[idx][2]
        values[name] = GetNumberOfPedTextureVariations(player, idx, value)
    end

    for idx = 0, #props-1 do
        local name = props[idx][1]
        local value = props[idx][2]
        values[name] = GetNumberOfPedPropTextureVariations(player, idx, value)
    end
    return values
end

function SetClothing(drawables, props, drawTextures, propTextures)
    for i = 1, #drawable_names do
        if drawables[0] == nil then
            if drawable_names[i] == "undershirts" and drawables[tostring(i-1)][2] == -1 then
                SetPedComponentVariation(player, i-1, 15, 0, 2)
            else
                SetPedComponentVariation(player, i-1, drawables[tostring(i-1)][2], drawTextures[i][2], 2)
            end
        else
            if drawable_names[i] == "undershirts" and drawables[i-1][2] == -1 then
                SetPedComponentVariation(player, i-1, 15, 0, 2)
            else
                SetPedComponentVariation(player, i-1, drawables[i-1][2], drawTextures[i][2], 2)
            end
        end
    end

    for i = 1, #prop_names do
        local propZ = (drawables[0] == nil and props[tostring(i-1)][2] or props[i-1][2])
        ClearPedProp(player, i-1)
        SetPedPropIndex(player, i-1, propZ, propTextures[i][2], true)
    end
end

function GetSkinTotal()
  return {
    #frm_skins,
    #fr_skins
  }
end

local toggleClothing = {}
function ToggleProps(data)
    local name = data["name"]

    selectedValue = has_value(drawable_names, name)
    if (selectedValue > -1) then
        if (toggleClothing[name] ~= nil) then
            SetPedComponentVariation(
                player,
                tonumber(selectedValue),
                tonumber(toggleClothing[name][1]),
                tonumber(toggleClothing[name][2]), 2)
            toggleClothing[name] = nil
        else
            toggleClothing[name] = {
                GetPedDrawableVariation(player, tonumber(selectedValue)),
                GetPedTextureVariation(player, tonumber(selectedValue))
            }

            local value = -1
            if name == "undershirts" or name == "torsos" then
                value = 15
                if name == "undershirts" and GetEntityModel(PlayerPedId()) == GetHashKey('mp_f_freemode_01') then
                    value = -1
                end
            end
            if name == "legs" then
                value = 14
            end

            SetPedComponentVariation(
                player,
                tonumber(selectedValue),
                value, 0, 2)
        end
    else
        selectedValue = has_value(prop_names, name)
        if (selectedValue > -1) then
            if (toggleClothing[name] ~= nil) then
                SetPedPropIndex(
                    player,
                    tonumber(selectedValue),
                    tonumber(toggleClothing[name][1]),
                    tonumber(toggleClothing[name][2]), true)
                toggleClothing[name] = nil
            else
                toggleClothing[name] = {
                    GetPedPropIndex(player, tonumber(selectedValue)),
                    GetPedPropTextureIndex(player, tonumber(selectedValue))
                }
                ClearPedProp(player, tonumber(selectedValue))
            end
        end
    end
end

function SaveToggleProps()
    for k in pairs(toggleClothing) do
        local name  = k
        selectedValue = has_value(drawable_names, name)
        if (selectedValue > -1) then
            SetPedComponentVariation(
                player,
                tonumber(selectedValue),
                tonumber(toggleClothing[name][1]),
                tonumber(toggleClothing[name][2]), 2)
            toggleClothing[name] = nil
        else
            selectedValue = has_value(prop_names, name)
            if (selectedValue > -1) then
                SetPedPropIndex(
                    player,
                    tonumber(selectedValue),
                    tonumber(toggleClothing[name][1]),
                    tonumber(toggleClothing[name][2]), true)
                toggleClothing[name] = nil
            end
        end
    end
end

function LoadPed(data)
    SetSkin(data.model, true)
    SetClothing(data.drawables, data.props, data.drawtextures, data.proptextures)
    Wait(500)
    SetPedHairColor(player, tonumber(data.hairColor[1]), tonumber(data.hairColor[2]))
    SetPedHeadBlend(data.headBlend)
    SetHeadStructure(data.headStructure)
    SetHeadOverlayData(data.headOverlay)
    setTattoosAndFacial(nil, data.fadeStyle)
    return
end

function GetCurrentPed()
    player = PlayerPedId()
    return {
        model = GetEntityModel(PlayerPedId()),
        hairColor = GetPedHair(),
        eyecolor = GetPedEyeColor(player),
        headBlend = GetPedHeadBlendData(),
        headOverlay = GetHeadOverlayData(),
        headStructure = GetHeadStructure(),
        drawables = GetDrawables(),
        props = GetProps(),
        drawtextures = GetDrawTextures(),
        proptextures = GetPropTextures(),
        fadeStyle = currentFadeStyle,
    }
end

function PlayerModel(data)
    local skins = nil
    if (data['name'] == 'skin_male') then
        skins = frm_skins
    else
        skins = fr_skins
    end
    local skin = skins[tonumber(data['value'])]
    rotation(180.0)
    SetSkin(GetHashKey(skin), true)
    Wait(1)
    rotation(180.0)
end

local function ToggleClothingToLoadPed()
    local ped = PlayerPedId()
    local drawables = GetDrawablesTotal()

    for num, _ in pairs(drawables) do
        if drawables[num][2] > 1 then
            component = tonumber(num)
            SetPedComponentVariation(ped, component, 1, 0, 0)
            Wait(250)
            SetPedComponentVariation(ped, component, 0, 0, 0)
            break
        end
    end
end

local inSpawn = false
AddEventHandler("raid_clothes:inSpawn", function(pInSpawn)
    inSpawn = pInSpawn
end)

function SetSkin(model, setDefault)
    SetEntityInvincible(PlayerPedId(),true)
    if IsModelInCdimage(model) and IsModelValid(model) then
        RequestModel(model)
        while (not HasModelLoaded(model)) do
            Wait(0)
        end
        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)
        player = PlayerPedId()
        FreezePedCameraRotation(player, true)
        SetPedMaxHealth(player, 200)
        ToggleClothingToLoadPed()
        SetPedDefaultComponentVariation(player)
        if inSpawn then
            SetEntityHealth(player, GetEntityMaxHealth(player))
        end
        if setDefault and model ~= nil and not isCustomSkin(model) and (model == `mp_f_freemode_01` or model == `mp_m_freemode_01`) then
            SetPedHeadBlendData(player, 0, 0, 0, 15, 0, 0, 0, 1.0, 0, false)
            SetPedComponentVariation(player, 11, 0, 1, 0)
            SetPedComponentVariation(player, 8, 0, 1, 0)
            SetPedComponentVariation(player, 6, 1, 2, 0)
            SetPedHeadOverlayColor(player, 1, 1, 0, 0)
            SetPedHeadOverlayColor(player, 2, 1, 0, 0)
            SetPedHeadOverlayColor(player, 4, 2, 0, 0)
            SetPedHeadOverlayColor(player, 5, 2, 0, 0)
            SetPedHeadOverlayColor(player, 8, 2, 0, 0)
            SetPedHeadOverlayColor(player, 10, 1, 0, 0)
            SetPedHeadOverlay(player, 1, 0, 0.0)
            SetPedHairColor(player, 1, 1)
        end
    end
    SetEntityInvincible(PlayerPedId(),false)
end


RegisterNUICallback('updateclothes', function(data, cb)
    toggleClothing[data["name"]] = nil
    selectedValue = has_value(drawable_names, data["name"])
    if (selectedValue > -1) then
        SetPedComponentVariation(player, tonumber(selectedValue), tonumber(data["value"]), tonumber(data["texture"]), 2)
        cb({
            GetNumberOfPedTextureVariations(player, tonumber(selectedValue), tonumber(data["value"]))
        })
    else
        selectedValue = has_value(prop_names, data["name"])
        if (tonumber(data["value"]) == -1) then
            ClearPedProp(player, tonumber(selectedValue))
        else
            SetPedPropIndex(player, tonumber(selectedValue), tonumber(data["value"]), tonumber(data["texture"]), true)
        end
        cb({
            GetNumberOfPedPropTextureVariations(
                player,
                tonumber(selectedValue),
                tonumber(data["value"])
            )
        })
    end
end)

RegisterNUICallback('customskin', function(data, cb)
    if canUseCustomSkins() then
        local valid_model = isInSkins(data)
        if valid_model then
            SetSkin(GetHashKey(data), true)
        end
    end
end)

RegisterNUICallback('setped', function(data, cb)
    PlayerModel(data)
    RefreshUI()
    cb('ok')
end)

RegisterNUICallback('resetped', function(data, cb)
    LoadPed(oldPed)
    cb('ok')
end)

-- Barber

function GetPedHeadBlendData()
    local blob = string.rep("\0\0\0\0\0\0\0\0", 6 + 3 + 1) -- Generate sufficient struct memory.
    if not Citizen.InvokeNative(0x2746BD9D88C5C5D0, player, blob, true) then -- Attempt to write into memory blob.
        return nil
    end

    return {
        shapeFirst = string.unpack("<i4", blob, 1),
        shapeSecond = string.unpack("<i4", blob, 9),
        shapeThird = string.unpack("<i4", blob, 17),
        skinFirst = string.unpack("<i4", blob, 25),
        skinSecond = string.unpack("<i4", blob, 33),
        skinThird = string.unpack("<i4", blob, 41),
        shapeMix = string.unpack("<f", blob, 49),
        skinMix = string.unpack("<f", blob, 57),
        thirdMix = string.unpack("<f", blob, 65),
        hasParent = string.unpack("b", blob, 73) ~= 0,
    }
end

function SetPedHeadBlend(data)
    if data ~= nil then
        SetPedHeadBlendData(player,
            tonumber(data['shapeFirst']),
            tonumber(data['shapeSecond']),
            tonumber(data['shapeThird']),
            tonumber(data['skinFirst']),
            tonumber(data['skinSecond']),
            tonumber(data['skinThird']),
            tonumber(data['shapeMix']),
            tonumber(data['skinMix']),
            tonumber(data['thirdMix']),
            false
        )
    end
end

function GetHeadOverlayData()
    local headData = {}
    for i = 1, #head_overlays do
        if head_overlays[i] == "eyecolor" then
            headData[i] = {}
            headData[i].name = "eyecolor"
            headData[i].val = GetPedEyeColor(player)
        else
            local retval, overlayValue, colourType, firstColour, secondColour, overlayOpacity = GetPedHeadOverlayData(player, i-1)
            if retval then
                headData[i] = {}
                headData[i].name = head_overlays[i]
                headData[i].overlayValue = overlayValue
                headData[i].colourType = colourType
                headData[i].firstColour = firstColour
                headData[i].secondColour = secondColour
                headData[i].overlayOpacity = overlayOpacity
            end
        end
    end
    return headData
end

function SetHeadOverlayData(data)
    if json.encode(data) ~= "[]" then
        for i = 1, #head_overlays do
            if data[i].name == "eyecolor" then
                SetPedEyeColor(player, tonumber(data[i].val))
            else
                SetPedHeadOverlay(player,  i-1, tonumber(data[i].overlayValue),  tonumber(data[i].overlayOpacity))
            end
            -- SetPedHeadOverlayColor(player, i-1, data[i].colourType, data[i].firstColour, data[i].secondColour)
        end

        SetPedHeadOverlayColor(player, 0, 0, tonumber(data[1].firstColour), tonumber(data[1].secondColour))
        SetPedHeadOverlayColor(player, 1, 1, tonumber(data[2].firstColour), tonumber(data[2].secondColour))
        SetPedHeadOverlayColor(player, 2, 1, tonumber(data[3].firstColour), tonumber(data[3].secondColour))
        SetPedHeadOverlayColor(player, 3, 0, tonumber(data[4].firstColour), tonumber(data[4].secondColour))
        SetPedHeadOverlayColor(player, 4, 2, tonumber(data[5].firstColour), tonumber(data[5].secondColour))
        SetPedHeadOverlayColor(player, 5, 2, tonumber(data[6].firstColour), tonumber(data[6].secondColour))
        SetPedHeadOverlayColor(player, 6, 0, tonumber(data[7].firstColour), tonumber(data[7].secondColour))
        SetPedHeadOverlayColor(player, 7, 0, tonumber(data[8].firstColour), tonumber(data[8].secondColour))
        SetPedHeadOverlayColor(player, 8, 2, tonumber(data[9].firstColour), tonumber(data[9].secondColour))
        SetPedHeadOverlayColor(player, 9, 0, tonumber(data[10].firstColour), tonumber(data[10].secondColour))
        SetPedHeadOverlayColor(player, 10, 1, tonumber(data[11].firstColour), tonumber(data[11].secondColour))
        SetPedHeadOverlayColor(player, 11, 0, tonumber(data[12].firstColour), tonumber(data[12].secondColour))
    end
end

function GetHeadOverlayTotals()
    local totals = {}
    for i = 1, #head_overlays do
        if head_overlays[i] ~= "eyecolor" then
            totals[head_overlays[i]] = GetNumHeadOverlayValues(i-1)
        end
    end
    return totals
end

function GetPedHair()
    local hairColor = {}
    hairColor[1] = GetPedHairColor(player)
    hairColor[2] = GetPedHairHighlightColor(player)
    return hairColor
end

function GetHeadStructureData()
    local structure = {}
    for i = 1, #face_features do
        structure[face_features[i]] = GetPedFaceFeature(player, i-1)
    end
    return structure
end

function GetHeadStructure(data)
    local structure = {}
    for i = 1, #face_features do
        structure[i] = GetPedFaceFeature(player, i-1)
    end
    return structure
end

function SetHeadStructure(data)
    for i = 1, #face_features do
        SetPedFaceFeature(player, i-1, data[i])
    end
end




RegisterNUICallback('saveheadblend', function(data, cb)
    SetPedHeadBlendData(player,
    tonumber(data.shapeFirst),
    tonumber(data.shapeSecond),
    tonumber(data.shapeThird),
    tonumber(data.skinFirst),
    tonumber(data.skinSecond),
    tonumber(data.skinThird),
    tonumber(data.shapeMix) / 100,
    tonumber(data.skinMix) / 100,
    tonumber(data.thirdMix) / 100, false)
    cb('ok')
end)

RegisterNUICallback('savehaircolor', function(data, cb)
    SetPedHairColor(player, tonumber(data['firstColour']), tonumber(data['secondColour']))
end)

RegisterNUICallback('saveeyecolor', function(data, cb)
    SetPedEyeColor(player,  tonumber(data['firstColour']))
end)

RegisterNUICallback('savefacefeatures', function(data, cb)
    local index = has_value(face_features, data["name"])
    if (index <= -1) then return end
    local scale = tonumber(data["scale"]) / 100
    SetPedFaceFeature(player, index, scale)
    cb('ok')
end)

RegisterNUICallback('saveheadoverlay', function(data, cb)
    if data["name"] == "fadeStyle" then
        setTattoosAndFacial(nil, tonumber(data["value"]))
      else
        local index = has_value(head_overlays, data["name"])
        SetPedHeadOverlay(player,  index, tonumber(data["value"]), tonumber(data["opacity"]) / 100)
      end
      cb('ok')
end)

RegisterNUICallback('saveheadoverlaycolor', function(data, cb)
    local index = has_value(head_overlays, data["name"])
    local success, overlayValue, colourType, firstColour, secondColour, overlayOpacity = GetPedHeadOverlayData(player, index)
    local sColor = tonumber(data['secondColour'])
    if (sColor == nil) then
        sColor = tonumber(data['firstColour'])
    end
    SetPedHeadOverlayColor(player, index, colourType, tonumber(data['firstColour']), sColor)
    cb('ok')
end)

-- UTIL SHIT

function has_value (tab, val)
    for index = 1, #tab do
        if tab[index] == val then
            return index-1
        end
    end
    return -1
end

function EnableGUI(enable, menu, pPriceText, pPrice,disableDestroyCams)
    enabled = enable
    SetCustomNuiFocus(enable, enable)
    SendNUIMessage({
        type = "enableclothing_shop",
        enable = enable,
        menu = menu,
        priceText = pPriceText,
        price = pPrice
    })

    if (not enable and not startingMenu) then
        SaveToggleProps()
        oldPed = {}
        DestroyAllCams(true)
        RenderScriptCams(false, true, 1, true, true)
    end
end

function CustomCamera(position,ending)
    if startingMenu and position == "torso" then return end
    if not enabled then return end
    if customCam  then
        FreezePedCameraRotation(player, false)
        SetCamActive(cam, false)
        if not ending and not startingMenu then
            RenderScriptCams(false,  false,  0,  true,  true)
            if (DoesCamExist(cam)) then
               DestroyCam(cam, false)
            end
        end
        customCam = false
    else
        if (DoesCamExist(cam)) then
            DestroyCam(cam, false)
        end

        local pos = GetEntityCoords(player, true)
        if not startingMenu then
            SetEntityRotation(player, 0.0, 0.0, 0.0, 1, true)
        end

        FreezePedCameraRotation(player, true)

        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetCamCoord(cam, player)
        SetCamRot(cam, 0.0, 0.0, 0.0)

        SetCamActive(cam, true)
        RenderScriptCams(true,  false,  0,  true,  true)

        SwitchCam(position)
        customCam = true
    end
end

function rotation(dir)
    local pedRot = GetEntityHeading(PlayerPedId())+dir
    SetEntityHeading(PlayerPedId(), pedRot % 360)
end

function TogRotation()
    local pedRot = GetEntityHeading(PlayerPedId())+90 % 360
    SetEntityHeading(PlayerPedId(), math.floor(pedRot / 90) * 90.0)
end

function SwitchCam(name)
    if name == "cam" then
        TogRotation()
        return
    end

    local pos = GetEntityCoords(player, true)
    local bonepos = false
    if (name == "head") then
        bonepos = GetPedBoneCoords(player, 31086)
        if startingMenu then
            bonepos = vector3(bonepos.x - 0.7, bonepos.y + 0.0, bonepos.z + 0.05)
        else
            bonepos = vector3(bonepos.x - 0.1, bonepos.y + 0.4, bonepos.z + 0.05)
        end

    end
    if (name == "torso") then
        bonepos = GetPedBoneCoords(player, 11816)
        bonepos = vector3(bonepos.x - 0.4, bonepos.y + 2.2, bonepos.z + 0.2)
    end
    if (name == "leg") then
        bonepos = GetPedBoneCoords(player, 46078)

        if startingMenu then
            bonepos = vector3(bonepos.x - 0.9, bonepos.y + 0.0, bonepos.z-0.2)
        else
            bonepos = vector3(bonepos.x - 0.1, bonepos.y + 1, bonepos.z)
        end

    end

    SetCamCoord(cam, bonepos.x, bonepos.y, bonepos.z)
    if startingMenu and name ~= "torso" then
        SetCamRot(cam, 0.0, 0.0, 250.0)
    else
        SetCamRot(cam, 0.0, 0.0, 180.0)
    end

end

RegisterNetEvent("clothing:close", function()
    TriggerEvent("backitems:displayItems", true)
    EnableGUI(false, false)
end)

RegisterNUICallback('escape', function(data, cb)
    local shouldSave = data['save'] or false
    local newFadeStyle = data["fadeStyle"] or 255
    if shouldSave and currentPrice > 0 then
        QBCore.Functions.TriggerCallback("clothing:purchase", function(result)
            if not result then
                QBCore.Functions.Notify("You don't have enough money!")
                --TriggerEvent("notify", "Yeteri kadar paran yok!", 2)
                shouldSave = false
            end
        end, currentPrice)
    end
    if not startingMenu then
        TriggerServerEvent("Police:getMeta")
    end
    Save(shouldSave,true, newFadeStyle)
    cb('ok')
    TriggerEvent("backitems:displayItems", true)
end)

RegisterNUICallback('togglecursor', function(data, cb)
    if not startingMenu then
        CustomCamera("torso")
        SetCustomNuiFocus(false, false)
        FreezePedCameraRotation(player, false)
    end
    cb('ok')
end)

RegisterNUICallback('rotate', function(data, cb)
    if (data["key"] == "left") then
        rotation(20)
    else
        rotation(-20)
    end
    cb('ok')
end)

RegisterNUICallback('switchcam', function(data, cb)
    CustomCamera(data['name'])
    cb('ok')
end)

RegisterNUICallback('toggleclothes', function(data, cb)
    ToggleProps(data)
    cb('ok')
end)

-- Tattooooooos

function GetTats()
    local tempTats = {}
    if currentTats == nil then return {} end
    for i = 1, #currentTats do
        for key in pairs(tattooHashList) do
            for j = 1, #tattooHashList[key] do
                if tattooHashList[key][j][1] == currentTats[i][2] then
                    tempTats[key] = j
                end
            end
        end
    end
    return tempTats
end

function SetTats(data)
    currentTats = {}
    print("applying")
    for k, v in pairs(data) do
        for categ in pairs(tattooHashList) do
            if k == categ then
                local something = tattooHashList[categ][tonumber(v)]
                if something ~= nil then
                    table.insert(currentTats, {something[2], something[1]})
                end
            end
        end
    end
    ClearPedDecorations(PlayerPedId())
    for i = 1, #currentTats do
        ApplyPedOverlay(PlayerPedId(), currentTats[i][1], currentTats[i][2])
    end
end

RegisterNUICallback('settats', function(data, cb)
    setTattoosAndFacial(data["tats"], currentFadeStyle)
    cb('ok')
end)


--------------------------------------------------------------------
-- Main menu

function OpenMenu(name, pPriceText, pPrice)
    TriggerEvent("backitems:displayItems", false)
    player = PlayerPedId()
    oldPed = GetCurrentPed()
    local isAllowed = false
    if(oldPed.model == 1885233650 or oldPed.model == -1667301416) then isAllowed = true end
    if((oldPed.model ~= 1885233650 or oldPed.model ~= -1667301416) and (name == "clothing_shop" or name == "tattoo_shop" or name == "barber_shop")) then isAllowed = true end
    if isAllowed then
        FreezePedCameraRotation(player, true)
        RefreshUI()
        EnableGUI(true, name, pPriceText, pPrice)
        TriggerEvent("inmenu", true)
    else
        QBCore.Functions.Notify("Welcome!")
    end
end

function Save(save, close, newFadeStyle)
    if save then
        print(newFadeStyle)
        print("RESETTING DATA")
        currentFadeStyle = newFadeStyle
        data = GetCurrentPed()
        if (GetCurrentPed().model == GetHashKey("mp_f_freemode_01") or GetCurrentPed().model == GetHashKey("mp_m_freemode_01")) and startingMenu then
            -- nothing
        else
            passedClothing = true
        end
        if not startingMenu or passedClothing then
            TriggerServerEvent("raid_clothes:insert_character_current", data)
            TriggerServerEvent("raid_clothes:insert_character_face", data)
            TriggerServerEvent("raid_clothes:set_tats", currentTats)
            TriggerEvent("qb-spawn:finishedClothing","Finished")
        elseif not passedClothing then
            passedClothing = true
            Wait(2000)
            OpenMenu("barber_shop")
            return
        end
    else
        TriggerEvent("qb-spawn:finishedClothing","Old")
        LoadPed(oldPed)
    end

    if close then
        EnableGUI(false, false)
    end

    TriggerEvent("inmenu", false)
    TriggerEvent("ressurection:relationships:norevive")
    TriggerEvent("gangs:setDefaultRelations")
    TriggerEvent("facewear:update")
    TriggerEvent('np-weapons:getAmmo')
    CustomCamera('torso',true)
    startingMenu = false
end

AddEventHandler("initialSpawnModelLoaded", function()
    TriggerServerEvent("clothing:checkIfNew")
end)

RegisterNetEvent("raid_clothes:inService", function(service)
    isService = service
end)

RegisterNetEvent("raid_clothes:hasEnough", function(menu)
    if menu == "tattoo_shop" then
        TriggerServerEvent("raid_clothes:retrieve_tats")
        while currentTats == nil do
            Wait(1)
        end
    end
    OpenMenu(menu)
end)
RegisterNetEvent("raid_clothes:hasEnough1", function(menu)
    OpenMenu()
end)

RegisterCommand("refreshchar", function()
    if not IsPedSwimming(PlayerPedId()) and not IsEntityInWater(PlayerPedId()) and not IsPedFalling(PlayerPedId()) then
        local health = 0
        health = GetEntityHealth(PlayerPedId())
        armor = GetPedArmour(PlayerPedId())
        Wait(500)
        TriggerServerEvent("raid_clothes:get_character_current") 
        TriggerServerEvent("raid_clothes:get_character_face")
        TriggerServerEvent("raid_clothes:retrieve_tats")
        ClearPedScubaGearVariation(PlayerPedId())
        Wait(500)
        SetEntityHealth(PlayerPedId(), health)
        AddArmourToPed(PlayerPedId(), armor)
    end
end)

RegisterNetEvent("raid_clothes:setclothes", function(data,alreadyExist)
    player = PlayerPedId()
    local function setDefault()
        --- decapritated function
    end

	if not data.model and alreadyExist <= 0 then
        setDefault()
        return
    end

    if not data.model and alreadyExist >= 1 then
        return
    end

    model = data.model
    model = model ~= nil and tonumber(model) or false

	if not IsModelInCdimage(model) or not IsModelValid(model) then
        setDefault()
        return
    end
    TriggerEvent("backitems:displayItems", false)
    SetSkin(model, false)
    Wait(500)
    SetClothing(data.drawables, data.props, data.drawtextures, data.proptextures)
    Wait(500)
	TriggerEvent("facewear:update")
    TriggerServerEvent("raid_clothes:get_character_face", nil, data.fadeStyle)
    TriggerServerEvent("raid_clothes:retrieve_tats")
    TriggerEvent("backitems:displayItems", true)
end)

RegisterNetEvent("raid_clothes:AdminSetModel", function(model)
    local hashedModel = GetHashKey(model)
    if not IsModelInCdimage(hashedModel) or not IsModelValid(hashedModel) then return end
    SetSkin(hashedModel, true)
end)

RegisterNetEvent("raid_clothes:defaultReset", function()
    local sex = PlayerData.sex
    Wait(1000)
    if sex ~= 0 then
        SetSkin(`mp_f_freemode_01`, true)
    else
        SetSkin(`mp_m_freemode_01`, true)
    end
    OpenMenu("clothing_shop")
    startingMenu = true
    passedClothing = false
end)

RegisterNetEvent("raid_clothes:settattoos", function(playerTattoosList)
    currentTats = playerTattoosList
    SetTats(GetTats(currentTats))
    -- setTattoosAndFacial(nil, currentFadeStyle)
end) 

RegisterNetEvent("raid_clothes:setpedfeatures", function(data)
    player = PlayerPedId()
    if data == false then
        SetSkin(GetEntityModel(PlayerPedId()), true)
        return
    end
    local head = data.headBlend
    local haircolor = data.hairColor

    SetPedHeadBlendData(player,
        tonumber(head['shapeFirst']),
        tonumber(head['shapeSecond']),
        tonumber(head['shapeThird']),
        tonumber(head['skinFirst']),
        tonumber(head['skinSecond']),
        tonumber(head['skinThird']),
        tonumber(head['shapeMix']),
        tonumber(head['skinMix']),
        tonumber(head['thirdMix']),
        false
    )
    SetHeadStructure(data.headStructure)
    SetPedHairColor(player, tonumber(haircolor[1]), tonumber(haircolor[2]))
    SetHeadOverlayData(data.headOverlay)
    currentFadeStyle = data.fadeStyle
    setTattoosAndFacial(nil, currentFadeStyle)
end)

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent('raid_clothes:outfits', function(pAction, pId, pName)
    if pAction == 1 then
        TriggerServerEvent("raid_clothes:set_outfit",pId, pName, GetCurrentPed())
    elseif pAction == 2 then
        TriggerServerEvent("raid_clothes:remove_outfit",pId)
    elseif pAction == 3 then
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "Clothes1", 0.6)
        TriggerServerEvent("raid_clothes:get_outfit", pId)
        TriggerEvent("backitems:displayItems", true)
        TriggerEvent("backitems:start")
    else
        TriggerServerEvent("raid_clothes:list_outfits")
    end
end)

RegisterNetEvent('raid_clothes:outfits_boss', function(pAction, pId, pName)
    if pAction == 1 then
        TriggerServerEvent("raid_clothes:set_outfit",pId, pName, GetCurrentPed())
    elseif pAction == 2 then
        TriggerServerEvent("raid_clothes:remove_outfit",pId)
    elseif pAction == 3 then
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "Clothes1", 0.6)
        TriggerServerEvent("raid_clothes:get_outfit", pId)
        TriggerEvent("backitems:displayItems", true)
        TriggerEvent("backitems:start")
    else
        TriggerServerEvent("raid_clothes:list_outfits_boss")
    end
end)
 
function GetFadeTotal()
    local data = getFacialDecorationsData()
    return #data
end

function isFreemodeModel(pModelHash)
    return pModelHash == `mp_f_freemode_01` or pModelHash == `mp_m_freemode_01`
  end

function getFacialDecorationsData()
    local playerPed = PlayerPedId()
    local playerModel = GetEntityModel(playerPed)
    if isFreemodeModel(playerModel) then
      return FADE_CONFIGURATIONS[playerModel == `mp_m_freemode_01` and "male" or "female"]
    else
      return {}
    end
end

function setTattoosAndFacial(pTattoos, pFadeStyle)
    local fadeStyle = tonumber(pFadeStyle) or 255
    local playerPed = PlayerPedId()
    local playerModel = GetEntityModel(playerPed)

    ClearPedFacialDecorations(playerPed)

    if fadeStyle and fadeStyle > 0 and fadeStyle ~= 255 and isFreemodeModel(playerModel) then
        local facialDecoration = FADE_CONFIGURATIONS[playerModel == `mp_m_freemode_01` and "male" or "female"][fadeStyle]
        if facialDecoration then
            Wait(1)
            SetPedFacialDecoration(playerPed, facialDecoration[1], facialDecoration[2])
        end
    end


    currentTats = {}
    if pTattoos then
        for k, v in pairs(pTattoos) do
            for categ in pairs(tattooHashList) do
                if k == categ then
                    local tattoo = tattooHashList[categ][tonumber(v)]
                    if tattoo ~= nil then
                        currentTats[#currentTats + 1] = {tattoo[2], tattoo[1]}
                    end
                end
            end
        end
    end

    for i = 1, #currentTats do
        ApplyPedOverlay(playerPed, currentTats[i][1], currentTats[i][2])
    end
end


function SetCustomNuiFocus(hasKeyboard, hasMouse)
  HasNuiFocus = hasKeyboard or hasMouse
  SetNuiFocus(hasKeyboard, hasMouse)
end

CreateThread(function()
    addBlips()
    SetCustomNuiFocus(false, false)

    while true do
        Wait(0)
        if enabled then
            if (IsControlJustReleased(1, 25)) then
                SetCustomNuiFocus(true, true)
                FreezePedCameraRotation(player, true)
            end
            if (IsControlJustReleased(1, 202)) then
                SetCustomNuiFocus(true, true)
                FreezePedCameraRotation(player, true)
            end
            InvalidateIdleCam()
        end
    end
end)

local function listenForKeypress(zoneName, zoneData, isFree)
    listening = true
    CreateThread(function()
        QBCore.Functions.TriggerCallback("PriceWithTaxString", function(result)
            priceWithTax = result
        end, zoneData.basePrice, "Services")
        Wait(1000)
        while listening do
            if IsControlJustReleased(0, 38) then
                if zoneName == "tattoo_shop" then
                    TriggerServerEvent("raid_clothes:retrieve_tats")
                    while currentTats == nil do
                        Wait(0)
                    end
                end

                currentPrice = isFree and 0 or priceWithTax.total
                priceWithTax.text = isFree and 0 or priceWithTax.text
                OpenMenu(zoneName, priceWithTax.text, currentPrice)
                exports['qb-ui']:hideInteraction()
            end
            Wait(0)
        end
    end)
end

local showBarberShopBlips = true
local showTattooShopBlips = true
local showClothingShopBlips = true

RegisterNetEvent('hairDresser:ToggleHair', function()
   showBarberShopBlips = not showBarberShopBlips
   for _, item in pairs(barberShops) do
        if not showBarberShopBlips then
            if item.blip ~= nil then
                RemoveBlip(item.blip)
            end
        else
            item.blip = AddBlipForCoord(item[1], item[2], item[2])
            SetBlipSprite(item.blip, 71)
            SetBlipColour(item.blip, 1)
            SetBlipScale(item.blip, 0.6)
            SetBlipAsShortRange(item.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Barber Shop")
            EndTextCommandSetBlipName(item.blip)
        end
    end
end)

RegisterNetEvent('tattoo:ToggleTattoo')
AddEventHandler('tattoo:ToggleTattoo', function()
   showTattooShopBlips = not showTattooShopBlips
   for _, item in pairs(tattoosShops) do
        if not showTattooShopBlips then
            if item.blip ~= nil then
                RemoveBlip(item.blip)
            end
        else
            item.blip = AddBlipForCoord(item[1], item[2], item[2])
            SetBlipSprite(item.blip, 75)
            SetBlipColour(item.blip, 1)
            SetBlipScale(item.blip, 0.6)
            SetBlipAsShortRange(item.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Tattoo Shop")
            EndTextCommandSetBlipName(item.blip)
        end
    end
end)

RegisterNetEvent('clothing:ToggleClothing')
AddEventHandler('clothing:ToggleClothing', function()
    showClothingShopBlips = not showClothingShopBlips
    for _, item in pairs(clothingShops) do
        if not showTattooShopBlips then
            if item.blip ~= nil then
                RemoveBlip(item.blip)
            end
        else
            item.blip = AddBlipForCoord(item[1], item[2], item[2])
            SetBlipSprite(item.blip, 73)
            SetBlipColour(item.blip, 5)
            SetBlipScale(item.blip, 0.6)
            SetBlipAsShortRange(item.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Clothing Shop")
            EndTextCommandSetBlipName(item.blip)
        end
    end
end)

function addBlips()
    showBarberShopBlips = false
    showTattooShopBlips = false
    showClothingShopBlips = false
    TriggerEvent('hairDresser:ToggleHair')
    TriggerEvent('tattoo:ToggleTattoo')
    TriggerEvent('clothing:ToggleClothing')
end

RegisterNetEvent('raid_clothes:openClothing', function(pDontShowBarber, pShouldCost)
    if pShouldCost ~= nil and pShouldCost then
        currentPrice = priceWithTax.total
        priceWithTax.text = priceWithTax.text
        OpenMenu("clothing_shop", priceWithTax.text, currentPrice)
        startingMenu = false
    else
        currentPrice = 0
        OpenMenu("clothing_shop", '', 0)
        startingMenu = true
    end
    passedClothing = pDontShowBarber or false
end)

local inzone = false
AddEventHandler("qb-polyzone:enter", function(zone, data)
    local currentZone = MenuData[zone]
    if currentZone then
        inzone = true
        exports['qb-ui']:showInteraction("[E] Store")
        listenForKeypress(zone, currentZone, ((data and data.isFree) and true or false))
    end
end)

AddEventHandler("qb-polyzone:exit", function(zone)
    local currentZone = MenuData[zone]
    if currentZone then
        inzone = false
        listening = false
        exports['qb-ui']:hideInteraction()
    end
end)

local hairTied = false
local currentHairStyle = nil
local supportedModels = {
    [`mp_f_freemode_01`] = 4,
    [`mp_m_freemode_01`] = 2,
}

AddEventHandler("np-inventory:itemUsed", function(item)
    if item ~= "hairtie" then return end
    local hairValue = supportedModels[GetEntityModel(PlayerPedId())]
    if hairValue == nil then return end
    TriggerEvent("animation:PlayAnimation", "hairtie")
    Wait(1000)
    if not hairTied then
        hairTied = true
        local draw = GetPedDrawableVariation(PlayerPedId(), 2)
        local text = GetPedTextureVariation(PlayerPedId(), 2)
        local pal = GetPedPaletteVariation(PlayerPedId(), 2)
        currentHairStyle = { draw, text, pal }
        SetPedComponentVariation(PlayerPedId(), 2, hairValue, text, pal)
    else
        hairTied = false
        SetPedComponentVariation(PlayerPedId(), 2, currentHairStyle[1], currentHairStyle[2], currentHairStyle[3])
    end
end)


RegisterUICallback("qb-ui:raid_clothes:addOutfitPrompt", function(data, cb)
    cb({ data = {}, meta = { ok = true, message = 'done' } })
    Wait(1) --wait to fix ui bug?
    exports['np-ui']:openApplication('textbox', {
        callbackUrl = 'qb-ui:raid_clothes:addOutfit',
        key = data.key,
        items = {
          {
            icon = "pencil-alt",
            label = "Outfit Name",
            name = "outfitname",
          },
        },
        show = true,
    })
end)

function dump(o)
	if type(o) == 'table' then
	   local s = '{ '
	   for k,v in pairs(o) do
		  if type(k) ~= 'number' then k = '"'..k..'"' end
		  s = s .. '['..k..'] = ' .. dump(v) .. ','
	   end
	   return s .. '} '
	else
	   return tostring(o)
	end
 end

RegisterUICallback("qb-ui:raid_clothes:addOutfit", function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    exports['np-ui']:closeApplication('textbox')

    local outfitSlot = data[2].value
    local outfitName = data[1].value
    if outfitName == nil then outfitName = "" end

    TriggerServerEvent("raid_clothes:set_outfit", outfitSlot, outfitName, GetCurrentPed())
end)

RegisterUICallback("qb-ui:raid_clothes:changeOutfit", function(data, cb)
    cb({ data = {}, meta = { ok = true, message = 'done' } })
    TriggerServerEvent("raid_clothes:get_outfit", data.key)
    TriggerEvent("backitems:displayItems", true)
    Citizen.Wait(100)
    TriggerEvent("raid_clothes:outfits")
end)

RegisterUICallback("qb-ui:raid_clothes:deleteOutfit", function(data, cb)
    cb({ data = {}, meta = { ok = true, message = 'done' } })
    TriggerServerEvent('raid_clothes:remove_outfit', data.key)
    Citizen.Wait(100)
    TriggerEvent("raid_clothes:outfits")
end)

function GetNearestVehicleOutfit()
    local vehicle = QBCore.Functions.GetClosestVehicle()  
    local plate = GetVehicleNumberPlateText(vehicle)  
    if vehicle ~= 0 and vehicle then
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped) 
        local vehpos = GetEntityCoords(vehicle)
        if #(pos - vehpos) < 5.0 and not IsPedInAnyVehicle(ped) then
            return plate
        end
    end
end

RegisterUICallback("qb-ui:raid_clothes:changeOutfitVeh", function(data, cb)
    cb({ data = {}, meta = { ok = true, message = 'done' } })
    local plate = GetNearestVehicleOutfit()
    TriggerServerEvent("raid_clothes:get_outfitVeh", data.key, plate)
    TriggerEvent("backitems:displayItems", true)
    Citizen.Wait(100)
    TriggerEvent("raid_clothes:outfitsVeh")
end)

RegisterUICallback("qb-ui:raid_clothes:deleteOutfitVeh", function(data, cb)
    cb({ data = {}, meta = { ok = true, message = 'done' } })
    local plate = GetNearestVehicleOutfit()
    TriggerServerEvent('raid_clothes:remove_outfitVeh', data.key, plate)
    Citizen.Wait(100)
    TriggerEvent("raid_clothes:outfitsVeh")
end)

RegisterNetEvent('raid_clothes:ListOutfits', function(skincheck)
    if inzone or exports['qb-apartments']:isInApt() then
        local menuData = {}
        local takenSlots = {}
        for i = 1, #skincheck do
            local slot = tonumber(skincheck[i].slot)
            takenSlots[slot] = true


            menuData[1] = {
                title = "<center><strong>Your Outfits</strong></center>",
                description = '',
                key = 1,
                action = ""
            }

            menuData[#menuData + 1] = {
                title = slot .. " | " .. skincheck[i].name,
                description = '',
                key = slot,
                children = {
                    { title = "Change Outfit", action = "qb-ui:raid_clothes:changeOutfit", key = slot},
                    { title = "Delete Outfit", action = "qb-ui:raid_clothes:deleteOutfit", key = slot},
                }
            }
        end

        if #menuData > 0 then
            if #menuData < 20 then
                --Find first empty slot
                local emptySlot = -1
                for i=1,20 do
                    if emptySlot == -1 and takenSlots[i] == nil then
                        emptySlot = i
                    end
                end
                menuData[#menuData + 1] = {
                    title = "Save Current Outfit",
                    description = '',
                    key = emptySlot,
                    action = "qb-ui:raid_clothes:addOutfitPrompt"
                }
            end
            --exports["xz-menu"]:openMenu(menuData)
            exports['np-ui']:showContextMenu(menuData)
            --exports['qb-ui']:showContextMenu(menuData)
        else
            menuData[1] = {
                title = "Save Current Outfit",
                description = '',
                key = 1,
                action = "qb-ui:raid_clothes:addOutfitPrompt",
            }
            --exports["xz-menu"]:openMenu(menuData)
            exports['np-ui']:showContextMenu(menuData)
            --exports['qb-ui']:showContextMenu(menuData)
        end
    else
        QBCore.Functions.Notify("You have to be near clothing shop or in apartment or house")
    end
end)

RegisterUICallback("qb-ui:raid_clothes:addOutfitVeh", function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    exports['np-ui']:closeApplication('textbox')

    local outfitSlot = data[2].value
    local outfitName = data[1].value
    if outfitName == nil then outfitName = "" end
    local plate = GetNearestVehicleOutfit()
    TriggerServerEvent("raid_clothes:set_outfitVeh", outfitSlot, outfitName, GetCurrentPed(), plate)
end)

RegisterUICallback("qb-ui:raid_clothes:addOutfitPromptVehicle", function(data, cb)
    cb({ data = {}, meta = { ok = true, message = 'done' } })
    Wait(1) --wait to fix ui bug?
    exports['np-ui']:openApplication('textbox', {
        callbackUrl = 'qb-ui:raid_clothes:addOutfitVeh',
        key = data.key,
        items = {
          {
            icon = "pencil-alt",
            label = "Outfit Name",
            name = "outfitname",
          },
        },
        show = true,
    })
end)

RegisterNetEvent('rhodo-outfits:openOutfitMenu', function(skincheck, plate)
    local menuData = {}
    local takenSlots = {}
    for i = 1, #skincheck do
        local slot = tonumber(skincheck[i].slot)
        takenSlots[slot] = true


        menuData[1] = {
            title = "<center><strong>Your Outfits</strong></center>",
            description = '',
            key = 1,
            action = ""
        }

        menuData[#menuData + 1] = {
            title = slot .. " | " .. skincheck[i].name,
            description = '',
            key = slot,
            children = {
                { 
                    title = "Change Outfit", 
                    action = "qb-ui:raid_clothes:changeOutfitVeh", 
                    key = slot
                },
                { 
                    title = "Delete Outfit", 
                    action = "qb-ui:raid_clothes:deleteOutfitVeh", 
                    key = slot, 
                    plate = plate
                },
            }
        }
    end

    if #menuData > 0 then
        if #menuData < 20 then
            --Find first empty slot
            local emptySlot = -1
            for i=1,20 do
                if emptySlot == -1 and takenSlots[i] == nil then
                    emptySlot = i
                end
            end
            menuData[#menuData + 1] = {
                title = "Save Current Outfit",
                description = '',
                key = emptySlot,
                action = "qb-ui:raid_clothes:addOutfitPromptVehicle",
                plate = plate
            }
        end
        exports['np-ui']:showContextMenu(menuData)
    else
        menuData[1] = {
            title = "Save Current Outfit",
            description = '',
            key = 1,
            action = "qb-ui:raid_clothes:addOutfitPromptVehicle",
            plate = plate
        }
        exports['np-ui']:showContextMenu(menuData)
    end
end)

RegisterNetEvent('raid_clothes:outfitsVeh', function()
    local plate = GetNearestVehicleOutfit()
    TriggerServerEvent("raid_clothes:list_outfitsVeh", plate)
end)

RegisterNetEvent('raid_clothes:ListOutfits_boss', function(skincheck)
    --if inzone or exports['qb-apartments']:isInApt() then
        local menuData = {}
        local takenSlots = {}
        for i = 1, #skincheck do
            local slot = tonumber(skincheck[i].slot)
            takenSlots[slot] = true


            menuData[1] = {
                title = "<center><strong>Your Outfits</strong></center>",
                description = '',
                key = 1,
                action = ""
            }

            menuData[#menuData + 1] = {
                title = slot .. " | " .. skincheck[i].name,
                description = '',
                key = slot,
                children = {
                    { title = "Change Outfit", action = "qb-ui:raid_clothes:changeOutfit", key = slot},
                    { title = "Delete Outfit", action = "qb-ui:raid_clothes:deleteOutfit", key = slot},
                }
            }
        end

        if #menuData > 0 then
            if #menuData < 20 then
                --Find first empty slot
                local emptySlot = -1
                for i=1,20 do
                    if emptySlot == -1 and takenSlots[i] == nil then
                        emptySlot = i
                    end
                end
                menuData[#menuData + 1] = {
                    title = "Save Current Outfit",
                    description = '',
                    key = emptySlot,
                    action = "qb-ui:raid_clothes:addOutfitPrompt"
                }
            end
            --exports["xz-menu"]:openMenu(menuData)
            exports['np-ui']:showContextMenu(menuData)
            --exports['qb-ui']:showContextMenu(menuData)
        else
            menuData[1] = {
                title = "Save Current Outfit",
                description = '',
                key = 1,
                action = "qb-ui:raid_clothes:addOutfitPrompt"
            }
            --exports["xz-menu"]:openMenu(menuData)
            exports['np-ui']:showContextMenu(menuData)
            --exports['qb-ui']:showContextMenu(menuData)
        end
    --else
    --    QBCore.Functions.Notify("You have to be near clothing shop or in apartment or house")
    --end
end)

function IsNearShopMenu()
    local dstchecked = 1000
    local plyPos = GetEntityCoords(GetPlayerPed(PlayerId()), false)
	for i = 1, #clothingShops do
		shop = clothingShops[i]
		local comparedst = Vdist(plyPos.x, plyPos.y, plyPos.z,shop[1], shop[2], shop[3])
		if comparedst < dstchecked then
			dstchecked = comparedst
		end

		if comparedst < 5.0 then
			DrawMarker(27,shop[1], shop[2], shop[3], 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 1.7001, 0, 55, 240, 20, 0, 0, 0, 0)
		end
	end
	return dstchecked
end

exports("IsNearShopMenu", IsNearShopMenu)