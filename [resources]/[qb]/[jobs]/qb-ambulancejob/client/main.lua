QBCore = exports['qb-core']:GetCoreObject()

local getOutDict = 'switch@franklin@bed'
local getOutAnim = 'sleep_getup_rubeyes'
local canLeaveBed = true
local bedOccupying = nil
local bedObject = nil
local bedOccupyingData = nil
local closestBed = nil
local doctorCount = 0
local CurrentDamageList = {}
inBedDict = "anim@gangops@morgue@table@"
inBedAnim = "body_search"
isInHospitalBed = false
isBleeding = 0
bleedTickTimer, advanceBleedTimer = 0, 0
fadeOutTimer, blackoutTimer = 0, 0
legCount = 0
armcount = 0
headCount = 0
playerHealth = nil
isDead = false
isStatusChecking = false
statusChecks = {}
statusCheckTime = 0
isHealingPerson = false
healAnimDict = "mini@cpr@char_a@cpr_str"
healAnim = "cpr_pumpchest"
injured = {}
isRecovering = false

BodyParts = {
    ['HEAD'] =          { label = Lang:t('body.head'),          causeLimp = false, isDamaged = false, severity = 0 },
    ['NECK'] =          { label = Lang:t('body.neck'),          causeLimp = false, isDamaged = false, severity = 0 },
    ['SPINE'] =         { label = Lang:t('body.spine'),         causeLimp = true, isDamaged = false, severity = 0 },
    ['UPPER_BODY'] =    { label = Lang:t('body.upper_body'),    causeLimp = false, isDamaged = false, severity = 0 },
    ['LOWER_BODY'] =    { label = Lang:t('body.lower_body'),    causeLimp = true, isDamaged = false, severity = 0 },
    ['LARM'] =          { label = Lang:t('body.left_arm'),      causeLimp = false, isDamaged = false, severity = 0 },
    ['LHAND'] =         { label = Lang:t('body.left_hand'),     causeLimp = false, isDamaged = false, severity = 0 },
    ['LFINGER'] =       { label = Lang:t('body.left_fingers'),  causeLimp = false, isDamaged = false, severity = 0 },
    ['LLEG'] =          { label = Lang:t('body.left_leg'),      causeLimp = true, isDamaged = false, severity = 0 },
    ['LFOOT'] =         { label = Lang:t('body.left_foot'),     causeLimp = true, isDamaged = false, severity = 0 },
    ['RARM'] =          { label = Lang:t('body.right_arm'),     causeLimp = false, isDamaged = false, severity = 0 },
    ['RHAND'] =         { label = Lang:t('body.right_hand'),    causeLimp = false, isDamaged = false, severity = 0 },
    ['RFINGER'] =       { label = Lang:t('body.right_fingers'), causeLimp = false, isDamaged = false, severity = 0 },
    ['RLEG'] =          { label = Lang:t('body.right_leg'),     causeLimp = true, isDamaged = false, severity = 0 },
    ['RFOOT'] =         { label = Lang:t('body.right_foot'),    causeLimp = true, isDamaged = false, severity = 0 },
}

-- Functions

local function GetAvailableBed(bedId)
    local pos = GetEntityCoords(PlayerPedId())
    local retval = nil
    if bedId == nil then
        for k, v in pairs(Config.Locations["beds"]) do
            if not Config.Locations["beds"][k].taken then
                if #(pos - vector3(Config.Locations["beds"][k].coords.x, Config.Locations["beds"][k].coords.y, Config.Locations["beds"][k].coords.z)) < 500 then
                        retval = k
                end
            end
        end
    else
        if not Config.Locations["beds"][bedId].taken then
            if #(pos - vector3(Config.Locations["beds"][bedId].coords.x, Config.Locations["beds"][bedId].coords.y, Config.Locations["beds"][bedId].coords.z))  < 500 then
                retval = bedId
            end
        end
    end
    return retval
end

local function GetDamagingWeapon(ped)
    for k, v in pairs(Config.Weapons) do
        if HasPedBeenDamagedByWeapon(ped, k, 0) then
            return v
        end
    end

    return nil
end

local function IsDamagingEvent(damageDone, weapon)
    local luck = math.random(100)
    local multi = damageDone / Config.HealthDamage

    return luck < (Config.HealthDamage * multi) or (damageDone >= Config.ForceInjury or multi > Config.MaxInjuryChanceMulti or Config.ForceInjuryWeapons[weapon])
end

local function DoLimbAlert()
    if not isDead and not InLaststand then
        if #injured > 0 then
            local limbDamageMsg = ''
            if #injured <= Config.AlertShowInfo then
                for k, v in pairs(injured) do
                    limbDamageMsg = limbDamageMsg..Lang:t('info.pain_message', {limb = v.label, severity = Config.WoundStates[v.severity]})
                    if k < #injured then
                        limbDamageMsg = limbDamageMsg .. " | "
                    end
                end
            else
                limbDamageMsg = Lang:t('info.many_places')
            end
            QBCore.Functions.Notify(limbDamageMsg, "primary")
        end
    end
end

local function DoBleedAlert()
    if not isDead and tonumber(isBleeding) > 0 then
        QBCore.Functions.Notify(Lang:t('info.bleed_alert', {bleedstate = Config.BleedingStates[tonumber(isBleeding)].label}), "error")
    end
end

local function ApplyBleed(level)
    if isBleeding ~= 4 then
        if isBleeding + level > 4 then
            isBleeding = 4
        else
            isBleeding = isBleeding + level
        end
        DoBleedAlert()
    end
end

local function SetClosestBed()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local current = nil
    local dist = nil
    for k, v in pairs(Config.Locations["beds"]) do
        local dist2 = #(pos - vector3(Config.Locations["beds"][k].coords.x, Config.Locations["beds"][k].coords.y, Config.Locations["beds"][k].coords.z))
        if current then
            if dist2 < dist then
                current = k
                dist = dist2
            end
        else
            dist = dist2
            current = k
        end
    end
    if current ~= closestBed and not isInHospitalBed then
        closestBed = current
    end
end

local function IsInjuryCausingLimp()
    for k, v in pairs(BodyParts) do
        if v.causeLimp and v.isDamaged then
            return true
        end
    end
    return false
end

local function ProcessRunStuff(ped)
    if IsInjuryCausingLimp() then
        RequestAnimSet("move_m@injured")
        while not HasAnimSetLoaded("move_m@injured") do
            Wait(0)
        end
        SetPedMovementClipset(ped, "move_m@injured", 1 )
        SetPlayerSprint(PlayerId(), false)
    end
end

function ResetPartial()
    for k, v in pairs(BodyParts) do
        if v.isDamaged and v.severity <= 2 then
            v.isDamaged = false
            v.severity = 0
        end
    end

    for k, v in pairs(injured) do
        if v.severity <= 2 then
            v.severity = 0
            table.remove(injured, k)
        end
    end

    if isBleeding <= 2 then
        isBleeding = 0
        bleedTickTimer = 0
        advanceBleedTimer = 0
        fadeOutTimer = 0
        blackoutTimer = 0
    end

    TriggerServerEvent('hospital:server:SyncInjuries', {
        limbs = BodyParts,
        isBleeding = tonumber(isBleeding)
    })

    ProcessRunStuff(PlayerPedId())
    DoLimbAlert()
    DoBleedAlert()

    TriggerServerEvent('hospital:server:SyncInjuries', {
        limbs = BodyParts,
        isBleeding = tonumber(isBleeding)
    })
end

local function ResetAll()
    isBleeding = 0
    bleedTickTimer = 0
    advanceBleedTimer = 0
    fadeOutTimer = 0
    blackoutTimer = 0
    onDrugs = 0
    wasOnDrugs = false
    onPainKiller = 0
    wasOnPainKillers = false
    injured = {}

    for k, v in pairs(BodyParts) do
        v.isDamaged = false
        v.severity = 0
    end

    TriggerServerEvent('hospital:server:SyncInjuries', {
        limbs = BodyParts,
        isBleeding = tonumber(isBleeding)
    })

    CurrentDamageList = {}
    TriggerServerEvent('hospital:server:SetWeaponDamage', CurrentDamageList)

    ProcessRunStuff(PlayerPedId())
    DoLimbAlert()
    DoBleedAlert()

    TriggerServerEvent('hospital:server:SyncInjuries', {
        limbs = BodyParts,
        isBleeding = tonumber(isBleeding)
    })
    --TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", 100)
    --TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", 100)
end

local function loadAnimDict(dict)
	while(not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Wait(1)
	end
end

local function SetBedCam()
    isInHospitalBed = true
    canLeaveBed = false
    local player = PlayerPedId()

    DoScreenFadeOut(1000)

    while not IsScreenFadedOut() do
        Wait(100)
    end

	if IsPedDeadOrDying(player) then
		local pos = GetEntityCoords(player, true)
		NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z, GetEntityHeading(player), true, false)
    end

    bedObject = GetClosestObjectOfType(bedOccupyingData.coords.x, bedOccupyingData.coords.y, bedOccupyingData.coords.z, 1.0, bedOccupyingData.model, false, false, false)
    FreezeEntityPosition(bedObject, true)

    SetEntityCoords(player, bedOccupyingData.coords.x, bedOccupyingData.coords.y, bedOccupyingData.coords.z + 0.02)
    --SetEntityInvincible(PlayerPedId(), true)
    Wait(500)
    FreezeEntityPosition(player, true)

    loadAnimDict(inBedDict)

    TaskPlayAnim(player, inBedDict , inBedAnim, 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
    SetEntityHeading(player, bedOccupyingData.coords.w)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
    AttachCamToPedBone(cam, player, 31085, 0, 1.0, 1.0 , true)
    SetCamFov(cam, 90.0)
    local heading = GetEntityHeading(player)
    heading = (heading > 180) and heading - 180 or heading + 180
    SetCamRot(cam, -45.0, 0.0, heading, 2)

    DoScreenFadeIn(1000)

    Wait(1000)
    FreezeEntityPosition(player, true)
end

local function LeaveBed()
    local player = PlayerPedId()

    RequestAnimDict(getOutDict)
    while not HasAnimDictLoaded(getOutDict) do
        Wait(0)
    end

    FreezeEntityPosition(player, false)
    SetEntityInvincible(player, false)
    SetEntityHeading(player, bedOccupyingData.coords.w + 90)
    TaskPlayAnim(player, getOutDict , getOutAnim, 100.0, 1.0, -1, 8, -1, 0, 0, 0)
    Wait(4000)
    ClearPedTasks(player)
    TriggerServerEvent('hospital:server:LeaveBed', bedOccupying)
    FreezeEntityPosition(bedObject, true)
    RenderScriptCams(0, true, 200, true, true)
    DestroyCam(cam, false)

    bedOccupying = nil
    bedObject = nil
    bedOccupyingData = nil
    isInHospitalBed = false
end

local function DrawText3D(x, y, z, text)
	SetTextScale(0.3, 0.3)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 400
    DrawRect(0.0, 0.0+0.0110, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

local function IsInDamageList(damage)
    local retval = false
    if CurrentDamageList then
        for k, v in pairs(CurrentDamageList) do
            if CurrentDamageList[k] == damage then
                retval = true
            end
        end
    end
    return retval
end

local function CheckWeaponDamage(ped)
    local detected = false
    for k, v in pairs(QBCore.Shared.Weapons) do
        if HasPedBeenDamagedByWeapon(ped, GetHashKey(k), 0) then
            detected = true
            if not IsInDamageList(k) then
                TriggerEvent('chat:addMessage', {
                    color = { 255, 0, 0},
                    multiline = false,
                    args = {Lang:t('info.status'), v.damagereason}
                })
                CurrentDamageList[#CurrentDamageList+1] = k
            end
        end
    end
    if detected then
        TriggerServerEvent("hospital:server:SetWeaponDamage", CurrentDamageList)
    end
    ClearEntityLastDamageEntity(ped)
end

local function ApplyImmediateEffects(ped, bone, weapon, damageDone)
    local armor = GetPedArmour(ped)
    if Config.MinorInjurWeapons[weapon] and damageDone < Config.DamageMinorToMajor then
        if Config.CriticalAreas[Config.Bones[bone]] then
            if armor <= 0 then
                ApplyBleed(1)
            end
        end

        if Config.StaggerAreas[Config.Bones[bone]] and (Config.StaggerAreas[Config.Bones[bone]].armored or armor <= 0) then
            if math.random(100) <= math.ceil(Config.StaggerAreas[Config.Bones[bone]].minor) then
                SetPedToRagdoll(ped, 1500, 2000, 3, true, true, false)
            end
        end
    elseif Config.MajorInjurWeapons[weapon] or (Config.MinorInjurWeapons[weapon] and damageDone >= Config.DamageMinorToMajor) then
        if Config.CriticalAreas[Config.Bones[bone]] then
            if armor > 0 and Config.CriticalAreas[Config.Bones[bone]].armored then
                if math.random(100) <= math.ceil(Config.MajorArmoredBleedChance) then
                    ApplyBleed(1)
                end
            else
                ApplyBleed(1)
            end
        else
            if armor > 0 then
                if math.random(100) < (Config.MajorArmoredBleedChance) then
                    ApplyBleed(1)
                end
            else
                if math.random(100) < (Config.MajorArmoredBleedChance * 2) then
                    ApplyBleed(1)
                end
            end
        end

        if Config.StaggerAreas[Config.Bones[bone]] and (Config.StaggerAreas[Config.Bones[bone]].armored or armor <= 0) then
            if math.random(100) <= math.ceil(Config.StaggerAreas[Config.Bones[bone]].major) then
                SetPedToRagdoll(ped, 1500, 2000, 3, true, true, false)
            end
        end
    end
end

local function CheckDamage(ped, bone, weapon, damageDone)
    if weapon == nil then return end

    if Config.Bones[bone] and not isDead and not InLaststand then
        ApplyImmediateEffects(ped, bone, weapon, damageDone)

        if not BodyParts[Config.Bones[bone]].isDamaged then
            BodyParts[Config.Bones[bone]].isDamaged = true
            BodyParts[Config.Bones[bone]].severity = math.random(1, 3)
            injured[#injured+1] = {
                part = Config.Bones[bone],
                label = BodyParts[Config.Bones[bone]].label,
                severity = BodyParts[Config.Bones[bone]].severity
            }
        else
            if BodyParts[Config.Bones[bone]].severity < 4 then
                BodyParts[Config.Bones[bone]].severity = BodyParts[Config.Bones[bone]].severity + 1

                for k, v in pairs(injured) do
                    if v.part == Config.Bones[bone] then
                        v.severity = BodyParts[Config.Bones[bone]].severity
                    end
                end
            end
        end

        TriggerServerEvent('hospital:server:SyncInjuries', {
            limbs = BodyParts,
            isBleeding = tonumber(isBleeding)
        })

        ProcessRunStuff(ped)
    end
end

local function ProcessDamage(ped)
    if not isDead and not InLaststand and not onPainKillers then
        for k, v in pairs(injured) do
            if (v.part == 'LLEG' and v.severity > 1) or (v.part == 'RLEG' and v.severity > 1) or (v.part == 'LFOOT' and v.severity > 2) or (v.part == 'RFOOT' and v.severity > 2) then
                if legCount >= Config.LegInjuryTimer then
                    if not IsPedRagdoll(ped) and IsPedOnFoot(ped) then
                        local chance = math.random(100)
                        if (IsPedRunning(ped) or IsPedSprinting(ped)) then
                            if chance <= Config.LegInjuryChance.Running then
                                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08) -- change this float to increase/decrease camera shake
                                SetPedToRagdollWithFall(ped, 1500, 2000, 1, GetEntityForwardVector(ped), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
                            end
                        else
                            if chance <= Config.LegInjuryChance.Walking then
                                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08) -- change this float to increase/decrease camera shake
                                SetPedToRagdollWithFall(ped, 1500, 2000, 1, GetEntityForwardVector(ped), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
                            end
                        end
                    end
                    legCount = 0
                else
                    legCount = legCount + 1
                end
            elseif (v.part == 'LARM' and v.severity > 1) or (v.part == 'LHAND' and v.severity > 1) or (v.part == 'LFINGER' and v.severity > 2) or (v.part == 'RARM' and v.severity > 1) or (v.part == 'RHAND' and v.severity > 1) or (v.part == 'RFINGER' and v.severity > 2) then
                if armcount >= Config.ArmInjuryTimer then
                    local chance = math.random(100)

                    if (v.part == 'LARM' and v.severity > 1) or (v.part == 'LHAND' and v.severity > 1) or (v.part == 'LFINGER' and v.severity > 2) then
                        local isDisabled = 15
                        CreateThread(function()
                            while isDisabled > 0 do
                                if IsPedInAnyVehicle(ped, true) then
                                    DisableControlAction(0, 63, true) -- veh turn left
                                end

                                if IsPlayerFreeAiming(PlayerId()) then
                                    DisablePlayerFiring(PlayerId(), true) -- Disable weapon firing
                                end

                                isDisabled = isDisabled - 1
                                Wait(1)
                            end
                        end)
                    else
                        local isDisabled = 15
                        CreateThread(function()
                            while isDisabled > 0 do
                                if IsPedInAnyVehicle(ped, true) then
                                    DisableControlAction(0, 63, true) -- veh turn left
                                end

                                if IsPlayerFreeAiming(PlayerId()) then
                                    DisableControlAction(0, 25, true) -- Disable weapon firing
                                end

                                isDisabled = isDisabled - 1
                                Wait(1)
                            end
                        end)
                    end

                    armcount = 0
                else
                    armcount = armcount + 1
                end
            elseif (v.part == 'HEAD' and v.severity > 2) then
                if headCount >= Config.HeadInjuryTimer then
                    local chance = math.random(100)

                    if chance <= Config.HeadInjuryChance then
                        SetFlash(0, 0, 100, 10000, 100)

                        DoScreenFadeOut(100)
                        while not IsScreenFadedOut() do
                            Wait(0)
                        end

                        if not IsPedRagdoll(ped) and IsPedOnFoot(ped) and not IsPedSwimming(ped) then
                            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08) -- change this float to increase/decrease camera shake
                            SetPedToRagdoll(ped, 5000, 1, 2)
                        end

                        Wait(5000)
                        DoScreenFadeIn(250)
                    end
                    headCount = 0
                else
                    headCount = headCount + 1
                end
            end
        end
    end
end

RegisterNetEvent('hospital:client:Revive', function()
    local player = PlayerPedId()

    if isDead or InLaststand then
        local pos = GetEntityCoords(player, true)
        NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z, GetEntityHeading(player), true, false)
        isDead = false
        SetEntityInvincible(player, false)
        SetLaststand(false)
        isRecovering = true
    end

    if isInHospitalBed then
        loadAnimDict(inBedDict)
        TaskPlayAnim(player, inBedDict , inBedAnim, 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
        SetEntityInvincible(player, true)
        canLeaveBed = true
        isRecovering = true
    end

    if isRecovering then
        SetPlayerSprint(PlayerId(), false)
        print('is recovering',isRecovering)
    end

    TriggerServerEvent("hospital:server:RestoreWeaponDamage")
    SetEntityMaxHealth(player, 200)
    SetEntityHealth(player, 200)
    ClearPedBloodDamage(player)
    -- SetPlayerSprint(PlayerId(), true)
    ResetAll()
    ResetPedMovementClipset(player, 0.0)
    TriggerServerEvent('hud:server:RelieveStress', 100)
    TriggerServerEvent("hospital:server:SetDeathStatus", false)
    TriggerServerEvent("hospital:server:SetLaststandStatus", false)
    TriggerEvent("pd:deathcheck1", false)
    emsNotified = false
    QBCore.Functions.Notify(Lang:t('info.healthy'))
end)

RegisterNetEvent('hospital:client:SetPain', function()
    ApplyBleed(math.random(1,4))
    if not BodyParts[Config.Bones[24816]].isDamaged then
        BodyParts[Config.Bones[24816]].isDamaged = true
        BodyParts[Config.Bones[24816]].severity = math.random(1, 4)
        injured[#injured+1] = {
            part = Config.Bones[24816],
            label = BodyParts[Config.Bones[24816]].label,
            severity = BodyParts[Config.Bones[24816]].severity
        }
    end

    if not BodyParts[Config.Bones[40269]].isDamaged then
        BodyParts[Config.Bones[40269]].isDamaged = true
        BodyParts[Config.Bones[40269]].severity = math.random(1, 4)
        injured[#injured+1] = {
            part = Config.Bones[40269],
            label = BodyParts[Config.Bones[40269]].label,
            severity = BodyParts[Config.Bones[40269]].severity
        }
    end

    TriggerServerEvent('hospital:server:SyncInjuries', {
        limbs = BodyParts,
        isBleeding = tonumber(isBleeding)
    })
end)

RegisterNetEvent('hospital:client:KillPlayer', function()
    SetEntityHealth(PlayerPedId(), 0)
    TriggerServerEvent("hospital:server:SetDeathStatus", true)
end)

RegisterNetEvent('hospital:client:HealInjuries', function(type)
    if type == "full" then
        ResetAll()
    else
        ResetPartial()
    end
    TriggerServerEvent("hospital:server:RestoreWeaponDamage")
    QBCore.Functions.Notify(Lang:t('success.wounds_healed'), 'success')
end)

RegisterNetEvent('hospital:client:SendToBed', function(id, data, isRevive)
    bedOccupying = id
    bedOccupyingData = data
    SetBedCam()
    CreateThread(function ()
        Wait(5)
        if isRevive then
            QBCore.Functions.Notify(Lang:t('success.being_helped'), 'success')
            Wait(Config.AIHealTimer * 1000)
            TriggerEvent("hospital:client:Revive")
        else
            canLeaveBed = true
        end
    end)
end)

RegisterNetEvent('hospital:client:PutInBed', function(id, data, isRevive, info)
    bedOccupying = id
    bedOccupyingData = data
    SetBedCam()
    CreateThread(function ()
        Wait(5)
        if isRevive then
            QBCore.Functions.Notify(Lang:t('success.being_helped'), 'success')
            Wait(info.time * 60000)
            print(info.time)
            TriggerEvent("hospital:client:Revive")
        else
            canLeaveBed = true
        end
    end)
end)

RegisterNetEvent('hospital:client:SetBed', function(id, isTaken)
    Config.Locations["beds"][id].taken = isTaken
end)

RegisterNetEvent('hospital:client:JailSetBed', function(id, isTaken)
    Config.Locations['jailbeds'][id].taken = isTaken
end)

RegisterNetEvent('hospital:client:RespawnAtHospital', function()
    TriggerServerEvent("hospital:server:RespawnAtHospital")
    if exports["qb-policejob"]:IsHandcuffed() then
        TriggerEvent("police:client:GetCuffed", -1)
    end
    TriggerEvent("police:client:DeEscort")
end)

RegisterNetEvent('hospital:client:RespawnAtJail', function()
    TriggerServerEvent('hospital:server:RespawnAtJail')
    if exports['qb-policejob']:IsHandcuffed() then
        TriggerEvent("police:client:GetCuffed", -1)
    end
    TriggerEvent('police:client:DeEscord')
end)

RegisterNetEvent('venture:client:RespawnAtJail', function()
    TriggerServerEvent('venture:server:RespawnAtJail')
    if exports['qb-policejob']:IsHandcuffed() then
        TriggerEvent("police:client:GetCuffed", -1)
    end
    TriggerEvent('police:client:DeEscord')
end)

RegisterNetEvent('hospital:client:SendBillEmail', function(amount)
    SetTimeout(math.random(2500, 4000), function()
        local gender = Lang:t('info.mr')
        if QBCore.Functions.GetPlayerData().charinfo.gender == 1 then
            gender = Lang:t('info.mrs')
        end
        local charinfo = QBCore.Functions.GetPlayerData().charinfo
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = Lang:t('mail.sender'),
            subject = Lang:t('mail.subject'),
            message = Lang:t('mail.message', {gender = gender, lastname = charinfo.lastname, costs = amount}),
            button = {}
        })
    end)
end)

RegisterNetEvent('hospital:client:SetDoctorCount', function(amount)
    doctorCount = amount
end)

RegisterNetEvent('hospital:client:adminHeal', function()
    local ped = PlayerPedId()
    SetEntityHealth(ped, 200)
    TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", 100)
    TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", 100)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    local ped = PlayerPedId()
    TriggerServerEvent("hospital:server:SetDeathStatus", false)
    TriggerServerEvent('hospital:server:SetLaststandStatus', false)
    TriggerEvent("pd:deathcheck1", false)
    TriggerServerEvent("hospital:server:SetArmor", GetPedArmour(ped))
    if bedOccupying then
        TriggerServerEvent("hospital:server:LeaveBed", bedOccupying)
    end
    isDead = false
    deathTime = 0
    SetEntityInvincible(ped, false)
    SetPedArmour(ped, 0)
    ResetAll()
end)

-- Threads

CreateThread(function()
    for k, station in pairs(Config.Locations["stations"]) do
        local blip = AddBlipForCoord(station.coords.x, station.coords.y, station.coords.z)
        SetBlipSprite(blip, 61)
        SetBlipAsShortRange(blip, true)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 25)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(station.label)
        EndTextCommandSetBlipName(blip)
    end
end)

CreateThread(function()
    while true do
        sleep = 1000
        if isInHospitalBed and canLeaveBed then
            sleep = 0
            local pos = GetEntityCoords(PlayerPedId())
            exports['qb-ui']:showInteraction('[E] To get out of bed..')
            if IsControlJustReleased(0, 38) then
                exports['qb-ui']:hideInteraction()
                LeaveBed()
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        Wait((1000 * Config.MessageTimer))
        DoLimbAlert()
    end
end)

CreateThread(function()
    while true do
        Wait(1000)
        SetClosestBed()
        if isStatusChecking then
            statusCheckTime = statusCheckTime - 1
            if statusCheckTime <= 0 then
                statusChecks = {}
                isStatusChecking = false
            end
        end
    end
end)

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local health = GetEntityHealth(ped)
        local armor = GetPedArmour(ped)

        if not playerHealth then
            playerHealth = health
        end

        if not playerArmor then
            playerArmor = armor
        end

        local armorDamaged = (playerArmor ~= armor and armor < (playerArmor - Config.ArmorDamage) and armor > 0) -- Players armor was damaged
        local healthDamaged = (playerHealth ~= health) -- Players health was damaged

        local damageDone = (playerHealth - health)

        if armorDamaged or healthDamaged then
            local hit, bone = GetPedLastDamageBone(ped)
            local bodypart = Config.Bones[bone]
            local weapon = GetDamagingWeapon(ped)

            if hit and bodypart ~= 'NONE' then
                local checkDamage = true
                if damageDone >= Config.HealthDamage then
                    if weapon then
                        if armorDamaged and (bodypart == 'SPINE' or bodypart == 'UPPER_BODY') or weapon == Config.WeaponClasses['NOTHING'] then
                            checkDamage = false -- Don't check damage if the it was a body shot and the weapon class isn't that strong
                            if armorDamaged then
                                TriggerServerEvent("hospital:server:SetArmor", GetPedArmour(ped))
                            end
                        end

                        if checkDamage then
                            if IsDamagingEvent(damageDone, weapon) then
                                CheckDamage(ped, bone, weapon, damageDone)
                            end
                        end
                    end
                elseif Config.AlwaysBleedChanceWeapons[weapon] then
                    if armorDamaged and (bodypart == 'SPINE' or bodypart == 'UPPER_BODY') or weapon == Config.WeaponClasses['NOTHING'] then
                        checkDamage = false -- Don't check damage if the it was a body shot and the weapon class isn't that strong
                    end
                    if math.random(100) < Config.AlwaysBleedChance and checkDamage then
                        ApplyBleed(1)
                    end
                end
            end

            CheckWeaponDamage(ped)
        end

        playerHealth = health
        playerArmor = armor

        if not isInHospitalBed then
            ProcessDamage(ped)
        end
        Wait(100)
    end
end)

RegisterNetEvent('hospital:client:ReviveLittle', function()
    local player = PlayerPedId()

    if isDead then
        SetLaststand(false)
        local playerPos = GetEntityCoords(player, true)
        NetworkResurrectLocalPlayer(playerPos, true, true, false)
        isDead = false
        SetEntityInvincible(player, false)
    elseif InLaststand then
        local playerPos = GetEntityCoords(player, true)
        NetworkResurrectLocalPlayer(playerPos, true, true, false)
        isDead = false
        SetEntityInvincible(player, false)
        SetLaststand(false)
    end

    if isInHospitalBed then
        loadAnimDict(inBedDict)
        TaskPlayAnim(player, inBedDict , inBedAnim, 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
        SetEntityInvincible(player, true)
        canLeaveBed = true
    end

    TriggerServerEvent("hospital:server:RestoreWeaponDamage")
    SetEntityMaxHealth(player, 200)
    SetEntityHealth(player, 200)
    ClearPedBloodDamage(player)
    SetPlayerSprint(PlayerId(), true)
    ResetAll2()
    ResetPedMovementClipset(player, 0.0)
    TriggerServerEvent('hud:server:RelieveStress', 100)
    TriggerServerEvent("hospital:server:SetDeathStatus", false)
    TriggerServerEvent("hospital:server:SetLaststandStatus", false)
end)

function ResetAll2()
    isBleeding = 0
    bleedTickTimer = 0
    advanceBleedTimer = 0
    fadeOutTimer = 0
    blackoutTimer = 0
    onDrugs = 0
    wasOnDrugs = false
    onPainKiller = 0
    wasOnPainKillers = false
    injured = {}

    for k, v in pairs(BodyParts) do
        v.isDamaged = false
        v.severity = 0
    end

    TriggerServerEvent('hospital:server:SyncInjuries', {
        limbs = BodyParts,
        isBleeding = tonumber(isBleeding)
    })

    CurrentDamageList = {}
    TriggerServerEvent('hospital:server:SetWeaponDamage', CurrentDamageList)

    ProcessRunStuff(PlayerPedId())
    DoLimbAlert()
    DoBleedAlert()

    TriggerServerEvent('hospital:server:SyncInjuries', {
        limbs = BodyParts,
        isBleeding = tonumber(isBleeding)
    })
end


CreateThread(function()
    while true do
        sleep = 1000
        if LocalPlayer.state['isLoggedIn'] then
            local pos = GetEntityCoords(PlayerPedId())
            for k, checkins in pairs(Config.Locations["checking"]) do
                if #(pos - checkins) < 1.0 then
                    sleep = 5
                    --if doctorCount >= Config.MinimalDoctors then
                    --    exports['qb-ui']:showInteraction('Call Doctor')
                    --else
                    --    exports['qb-ui']:showInteraction('Check In')
                    --end
                    if IsControlJustReleased(0, 38) then
                        if doctorCount >= Config.MinimalDoctors then
                            TriggerServerEvent("hospital:server:SendDoctorAlert")
                        else
                            TriggerEvent('animations:client:EmoteCommandStart', {"notepad"})
                            QBCore.Functions.Progressbar("hospital_checkin", Lang:t('progress.checking_in'), 2000, false, true, {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }, {}, {}, {}, function() -- Done
                                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                                local bedId = GetAvailableBed()
                                if bedId then
                                    TriggerServerEvent("hospital:server:SendToBed", bedId, true)
                                else
                                    QBCore.Functions.Notify(Lang:t('error.beds_taken'), "error")
                                end
                            end, function() -- Cancel
                                TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                                QBCore.Functions.Notify(Lang:t('error.canceled'), "error")
                            end)
                        end
                    end
                --[[elseif #(pos - checkins) < 4.5 then
                    sleep = 5
                    if doctorCount >= Config.MinimalDoctors then
                        exports['qb-ui']:hideInteraction()
                    else
                        exports['qb-ui']:hideInteraction()
                    end]]
                end
            end

--             if closestBed and not isInHospitalBed then
--                 if #(pos - vector3(Config.Locations["beds"][closestBed].coords.x, Config.Locations["beds"][closestBed].coords.y, Config.Locations["beds"][closestBed].coords.z)) < 2 then
--                     sleep = 5
--                     DrawText3D(Config.Locations["beds"][closestBed].coords.x, Config.Locations["beds"][closestBed].coords.y, Config.Locations["beds"][closestBed].coords.z + 0.3, Lang:t('text.lie_bed'))
--                     if IsControlJustReleased(0, 38) then
--                         if GetAvailableBed(closestBed) then
--                             TriggerServerEvent("hospital:server:SendToBed", closestBed, false)
--                         else
--                             QBCore.Functions.Notify(Lang:t('error.beds_taken'), "error")
--                         end
--                     end
--                 end
--             end
         end
         Wait(sleep)
     end
 end)

RegisterNetEvent("ambulance:client:checkin")
AddEventHandler("ambulance:client:checkin", function()
    if LocalPlayer.state['isLoggedIn'] then
        local pos = GetEntityCoords(PlayerPedId())
        for k, checkins in pairs(Config.Locations["checking"]) do
            if #(pos - checkins) < 1.0 then
                sleep = 5
                QBCore.Functions.TriggerCallback("hospital:server:getEMS", function(enoughEMS)
                    if enoughEMS >= 4 then
                        TriggerServerEvent("hospital:server:SendDoctorAlert")
                    else
                        TriggerEvent('animations:client:EmoteCommandStart', {"notepad"})
                        QBCore.Functions.Progressbar("hospital_checkin", Lang:t('progress.checking_in'), 2000, false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {}, {}, {}, function() -- Done
                            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                            local bedId = GetAvailableBed()
                            if bedId then
                                TriggerServerEvent("hospital:server:SendToBed", bedId, true)
                            else
                                QBCore.Functions.Notify(Lang:t('error.beds_taken'), "error")
                            end
                        end, function() -- Cancel
                            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                            QBCore.Functions.Notify(Lang:t('error.canceled'), "error")
                        end)
                    end
                end)
            end
        end

        if closestBed and not isInHospitalBed then
            if #(pos - vector3(Config.Locations["beds"][closestBed].coords.x, Config.Locations["beds"][closestBed].coords.y, Config.Locations["beds"][closestBed].coords.z)) < 2 then
                sleep = 5
                DrawText3D(Config.Locations["beds"][closestBed].coords.x, Config.Locations["beds"][closestBed].coords.y, Config.Locations["beds"][closestBed].coords.z + 0.3, Lang:t('text.lie_bed'))
                if IsControlJustReleased(0, 38) then
                    if GetAvailableBed(closestBed) then
                        TriggerServerEvent("hospital:server:SendToBed", closestBed, false)
                    else
                        QBCore.Functions.Notify(Lang:t('error.beds_taken'), "error")
                    end
                end
            end
        end
    end
    Wait(sleep)
end)

------------------PILLBOX HOSPITAL---------------------
exports['qb-target']:AddBoxZone("ambualnceoutfits", vector3(300.7, -597.6, 43.2), 0.55, 1.05, {
    name = "emsoutfits",
    heading = 0,
    debugPoly = false,
    minZ=42.2,
    maxZ=43.2
    }, {
    options = {
        {
            type = "client",
            event = "raid_clothes:outfits",
            icon = "fas fa-tshirt",
            label = "Change Outfit",
            job = "ambulance",
        },
    },
    distance = 2.5
})
-- EMS BOSS MENU
exports['qb-target']:AddBoxZone("EMSBossMenu", vector3(335.4, -594.29, 43.23), 0.5, 0.5, {
    name = "EMSBossMenu",
    heading = 189.0,
    debugPoly = false,
    minZ = 43.03,
    maxZ = 43.23,
    }, {
        options = {
            {
                type = "client",
                event = "qb-management:client:OpenMenu",
                icon = "fas fa-sign-in-alt",
                label = "Open Boss Menu",
                job = "ambulance",
            },
        },
        distance = 2.5
})

-- TARGET CHECKIN
CreateThread(function()
    if doctorCount >= Config.MinimalDoctors then
        exports['qb-target']:AddBoxZone("hospitalCheckin", vector3(307.54, -595.3, 43.28), 0.5, 0.35, {
            name = "hospitalCheckin",
            heading = 337,
            debugPoly = false,
            minZ=43.08,
            maxZ=43.18,
            }, {
            options = {
                {
                    type = "client",
                    event = "hospital:client:deskAlert",
                    icon = "fas fa-sign-in-alt",
                    label = "Page Doctors",
                },
            },
            distance = 2.5
        })
    else
        exports['qb-target']:AddBoxZone("hospitalCheckin", vector3(307.54, -595.3, 43.28), 0.5, 0.35, {
            name = "hospitalCheckin",
            heading = 337,
            debugPoly = false,
            minZ=43.08,
            maxZ=43.18,
            }, {
            options = {
                {
                    type = "client",
                    event = "ambulance:client:checkin",
                    icon = "fas fa-sign-in-alt",
                    label = "Check In",
                },
                {
                    type = "client",
                    event = "hospital:client:deskAlert",
                    icon = "fas fa-sign-in-alt",
                    label = "Page Doctors",
                },
            },
            distance = 2.5
        })
    end
end)

-- TARGET ARMORY
-- Event
RegisterNetEvent('AmbulanceArmory', function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "hospital", Config.Items)
end)

exports['qb-target']:AddBoxZone("emsArmory", vector3(306.02, -602.42, 43.28), 1.0, 1.0, {
    name = "emsArmory",
    heading = 340,
    debugPoly = false,
    minZ = 42.28,
    maxZ = 44.08,
    }, {
        options = {
            {
                type = "client",
                event = "AmbulanceArmory",
                icon = "fas fa-shield-alt",
                label = "Open Armory",
                job = "ambulance"
            },
            {
                type = "client",
                event = "hospital:openEMSPersonal",
                icon = "fas fa-shield-alt",
                label = "Personal Stash",
                job = "ambulance"
            },
        },
        distance = 3
})

exports['qb-target']:AddBoxZone("emsVehicles", vector3(337.45654, -578.6309, 28.796842), 1.0, 1.0, {
    name = "emsVehicles",
    heading = 340,
    debugPoly = false,
    minZ = 25.28,
    maxZ = 32.08,
}, {
    options = {
        {
            type = "client",
            event = "venture:client:OpenGarage",
            icon = "fas fa-shield-alt",
            label = "EMS Garage",
            job = "ambulance"
        },
    },
    distance = 3
})

-- EMS Toggle Duty
exports['qb-target']:AddBoxZone("EMSDuty", vector3(307.36, -597.23, 43.28), 0.05, 0.25, {
    name = "EMSDuty",
    heading=341,
    debugPoly = false,
    minZ=43.48,
    maxZ=43.88
    }, {
        options = {
            {
                type = "client",
                event = "EMSToggle:Duty",
                icon = "fas fa-sign-in-alt",
                label = "Go On/Off Duty",
                job = "ambulance",
            },
        },
        distance = 1.5
})

exports['qb-target']:AddBoxZone("EMSDuty2", vector3(307.1, -597.14, 43.28), 0.05, 0.25, {
    name = "EMSDuty2",
    heading=341,
    debugPoly = false,
    minZ=43.48,
    maxZ=43.88
    }, {
        options = {
            {
                type = "client",
                event = "EMSToggle:Duty",
                icon = "fas fa-sign-in-alt",
                label = "Go On/Off Duty",
                job = "ambulance",
            },
        },
        distance = 1.5
})

--------------- Vice Roy Hospital-------------------------
-- EMS BOSS MENU
exports['qb-target']:AddBoxZone("ViceEMSBossMenu", vector3(-790.58, -1246.33, 7.34), 0.5, 0.5, {
    name = "ViceEMSBossMenu",
    heading = 189.0,
    debugPoly = false,
    minZ=7.14,
    maxZ=7.94
    }, {
        options = {
            {
                type = "client",
                event = "qb-management:client:OpenMenu",
                icon = "fas fa-sign-in-alt",
                label = "Open Boss Menu",
                job = "ambulance",
            },
        },
        distance = 2.5
})

-- TARGET CHECKIN
exports['qb-target']:AddBoxZone("VicehospitalCheckin", vector3(-817.06, -1237.13, 7.34), 0.5, 0.35, {
    name = "VicehospitalCheckin",
    heading = 337,
    debugPoly = false,
    minZ=7.14,
    maxZ=7.34
    }, {
        options = {
            {
                type = "client",
                event = "ambulance:client:checkin",
                icon = "fas fa-sign-in-alt",
                label = "Check In",
            },
            {
                type = "client",
                event = "hospital:client:deskAlert",
                icon = "fas fa-sign-in-alt",
                label = "Page Doctors",
            },
        },
        distance = 2.5
})

-- TARGET ARMORY
-- Event

exports['qb-target']:AddBoxZone("ViceemsArmory", vector3(-820.92, -1243.33, 7.34), 1.0, 1.0, {
    name = "ViceemsArmory",
    heading = 321,
    debugPoly = false,
    minZ=6.34,
    maxZ=8.74
    }, {
        options = {
            {
                type = "client",
                event = "AmbulanceArmory",
                icon = "fas fa-shield-alt",
                label = "Open Armory",
                job = "ambulance"
            },
            {
                type = "client",
                event = "hospital:openEMSPersonal",
                icon = "fas fa-box",
                label = "Personal Stash",
                job = "ambulance"
            },
        },
        distance = 3
})

-- EMS Toggle Duty
exports['qb-target']:AddBoxZone("ViceEMSDuty", vector3(-817.88, -1238.88, 7.34), 0.05, 0.25, {
    name = "ViceEMSDuty",
    heading=320,
    debugPoly = false,
    minZ=7.54,
    maxZ=7.94
    }, {
        options = {
            {
                type = "client",
                event = "EMSToggle:Duty",
                icon = "fas fa-sign-in-alt",
                label = "Go On/Off Duty",
                job = "ambulance",
            },
        },
        distance = 1.5
})

exports['qb-target']:AddBoxZone("EMSDuty2", vector3(-818.08, -1238.69, 7.34), 0.05, 0.25, {
    name = "EMSDuty2",
    heading=320,
    debugPoly = false,
    minZ=7.54,
    maxZ=7.94
    }, {
        options = {
            {
                type = "client",
                event = "EMSToggle:Duty",
                icon = "fas fa-sign-in-alt",
                label = "Go On/Off Duty",
                job = "ambulance",
            },
        },
        distance = 1.5
})


RegisterNetEvent('hospital:putinbed')
AddEventHandler('hospital:putinbed', function()
    local data = exports['qb-input']:ShowInput({
        header = "Put in Bed",
        submitText = "Submit",
        inputs = {
            {
                text = "City ID (#)", -- text you want to be displayed as a place holder
                name = "citizenid", -- name of the input should be unique otherwise it might override
                type = "number", -- type of the input
                isRequired = true, -- Optional [accepted values: true | false] but will submit the form if no value is inputted
                -- default = "CID-1234", -- Default text option, this is optional
            },
            {
                text = "Recovery Time (in minutes)", -- text you want to be displayed as a place holder
                name = "time", -- name of the input should be unique otherwise it might override
                type = "number", -- type of the input
                isRequired = true, -- Optional [accepted values: true | false] but will submit the form if no value is inputted
                -- default = "password123", -- Default text option, this is optional
            },
            {
                text = "Bill Price ($)", -- text you want to be displayed as a place holder
                name = "billprice", -- name of the input should be unique otherwise it might override
                type = "number", -- type of the input - number will not allow non-number characters in the field so only accepts 0-9
                isRequired = true, -- Optional [accepted values: true | false] but will submit the form if no value is inputted
                -- default = 1, -- Default number option, this is optional
            },
        },
    })

    if data ~= nil then
        -- for k,v in pairs(data) do
            -- print(k .. " : " .. v)
            print(data.citizenid)
            print(data.time)
            local bedId = GetAvailableBed()
            if bedId then
                TriggerServerEvent("hospital:server:PutInBed", bedId, true, data)
            else
                QBCore.Functions.Notify(Lang:t('error.beds_taken'), "error")
            end
        -- end
    end
end, false)



