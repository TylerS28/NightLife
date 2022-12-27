local QBCore = exports['qb-core']:GetCoreObject()
local BackEngineVehicles = { 'ninef', 'adder', 'vagner', 't20', 'infernus', 'zentorno', 'reaper', 'comet2', 'comet3', 'jester', 'jester2', 
'cheetah', 'cheetah2', 'prototipo', 'turismor', 'pfister811', 'ardent', 'nero', 'nero2', 'tempesta', 'vacca', 'bullet', 'osiris', 'entityxf', 
'turismo2', 'fmj', 're7b', 'tyrus', 'italigtb', 'penetrator', 'monroe', 'ninef2', 'stingergt', 'surfer', 'surfer2', 'comet3', }

--------------------------------------------------
------ESSENTIAL CODING / DONT MESS WITH THIS------
--------------------------------------------------
isLoggedIn = true
PlayerJob = {}
local onDuty = false

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = PlayerJob.onduty
end)
RegisterNetEvent('QBCore:Client:SetDuty')
AddEventHandler('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
end)
local function saveVehicle()
    local plyPed = PlayerPedId()
    local veh = QBCore.Functions.GetClosestVehicle()
    local vehicleMods = {
        mods = {},
    }
    vehicleMods.mods[11] = GetVehicleMod(veh,11)
    vehicleMods.mods[12] = GetVehicleMod(veh,12)
    vehicleMods.mods[13] = GetVehicleMod(veh,13)
    vehicleMods.mods[15] = GetVehicleMod(veh,15)
    vehicleMods.mods[18] = IsToggleModOn(veh, 18)

local myCar = QBCore.Functions.GetVehicleProperties(veh)
    TriggerServerEvent('updateVehicle',myCar)
end
function IsBackEngine(vehModel)
    for _, model in pairs(BackEngineVehicles) do
        if GetHashKey(model) == vehModel then
            return true
        end
    end
    return false
end

--^^^^^^^^^^^^^^^DONT TOUCH ABOVE THIS LINE^^^^^^^^^^^^^^^--


--------------------------
------PARTS CRAFTING------
--------------------------

------FILLING NITROUS------
---------------------------
RegisterNetEvent('craft:fillnitrous')
AddEventHandler("craft:fillnitrous", function()
    local playerPed = PlayerPedId()
    QBCore.Functions.Progressbar("craft_engine0", "Refilling Nitrous Bottle...", 25000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        anim = "machinic_loop_mechandplayer",
        flags = 18,
    }, {}, {}, function() -- Done
        --local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(3,40)
        if success then
            StopAnimTask(playerPed, animDict, anim, 1.0)
            TriggerServerEvent("craft:fillnitrous")
            ClearPedTasks(playerPed)
        else
            QBCore.Functions.Notify("Failed!", "error")
            StopAnimTask(playerPed, animDict, anim, 1.0)
            ClearPedTasks(playerPed)
        end
    end, function() -- Cancel
        StopAnimTask(playerPed, animDict, anim, 1.0)
        QBCore.Functions.Notify("Failed!", "error")
        ClearPedTasks(playerPed)
    end)
end)

RegisterNetEvent('craft:nitrous')
AddEventHandler("craft:nitrous", function()
    QBCore.Functions.Progressbar("craft_engine0", "Building Nitrous...", 25000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        anim = "machinic_loop_mechandplayer",
        flags = 18,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(3,40)
        if success then
            StopAnimTask(playerPed, animDict, anim, 1.0)
            TriggerServerEvent("craft:craftnitrous")
            ClearPedTasks(playerPed)
        else
            QBCore.Functions.Notify("Failed!", "error")
            StopAnimTask(playerPed, animDict, anim, 1.0)
            ClearPedTasks(playerPed)
        end
    end, function() -- Cancel
        StopAnimTask(playerPed, animDict, anim, 1.0)
        QBCore.Functions.Notify("Failed!", "error")
        ClearPedTasks(playerPed)
    end)
end)

------ENGINE------
------------------
RegisterNetEvent('craft:engine0')
AddEventHandler("craft:engine0", function()
    QBCore.Functions.Progressbar("craft_engine0", "Building Engine...", 25000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        anim = "machinic_loop_mechandplayer",
        flags = 18,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(3,10)
        if success then
            StopAnimTask(playerPed, animDict, anim, 1.0)
            TriggerServerEvent("craft:engine0")
            ClearPedTasks(playerPed)
        else
            QBCore.Functions.Notify("Failed!", "error")
            ClearPedTasks(playerPed)
        end
    end, function() -- Cancel
        StopAnimTask(playerPed, animDict, anim, 1.0)
        QBCore.Functions.Notify("Failed!", "error")
        ClearPedTasks(playerPed)
    end)
end)

RegisterNetEvent('craft:engine1')
AddEventHandler("craft:engine1", function()
    QBCore.Functions.Progressbar("craft_engine1", "Building Engine...", 25000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        anim = "machinic_loop_mechandplayer",
        flags = 18,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(3,10)
        if success then
            StopAnimTask(playerPed, animDict, anim, 1.0)
            TriggerServerEvent("craft:engine1")
            ClearPedTasks(playerPed)
        else
            QBCore.Functions.Notify("Failed!", "error")
            ClearPedTasks(playerPed)
        end
    end, function() -- Cancel
        StopAnimTask(playerPed, animDict, anim, 1.0)
        QBCore.Functions.Notify("Failed!", "error")
        ClearPedTasks(playerPed)
    end)
end)

RegisterNetEvent('craft:engine2')
AddEventHandler("craft:engine2", function()
    QBCore.Functions.Progressbar("craft_engine2", "Building Engine...", 25000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        anim = "machinic_loop_mechandplayer",
        flags = 18,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(3,9)
        if success then
            StopAnimTask(playerPed, animDict, anim, 1.0)
            TriggerServerEvent("craft:engine2")
            ClearPedTasks(playerPed)
        else
            QBCore.Functions.Notify("Failed!", "error")
            ClearPedTasks(playerPed)
        end
    end, function() -- Cancel
        StopAnimTask(playerPed, animDict, anim, 1.0)
        QBCore.Functions.Notify("Failed!", "error")
        ClearPedTasks(playerPed)
    end)
end)

RegisterNetEvent('craft:engine3')
AddEventHandler("craft:engine3", function()
    QBCore.Functions.Progressbar("craft_engine3", "Building Engine...", 25000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        anim = "machinic_loop_mechandplayer",
        flags = 18,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(4,9)
        if success then
            StopAnimTask(playerPed, animDict, anim, 1.0)
            TriggerServerEvent("craft:engine3")
            ClearPedTasks(playerPed)
        else
            QBCore.Functions.Notify("Failed!", "error")
            ClearPedTasks(playerPed)
        end
    end, function() -- Cancel
        StopAnimTask(playerPed, animDict, anim, 1.0)
        QBCore.Functions.Notify("Failed!", "error")
        ClearPedTasks(playerPed)
    end)
end)

RegisterNetEvent('craft:engine4')
AddEventHandler("craft:engine4", function()
    QBCore.Functions.Progressbar("craft_engine4", "Building Engine...", 25000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        anim = "machinic_loop_mechandplayer",
        flags = 18,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(4,8)
        if success then
            StopAnimTask(playerPed, animDict, anim, 1.0)
            TriggerServerEvent("craft:engine4")
            ClearPedTasks(playerPed)
        else
            QBCore.Functions.Notify("Failed!", "error")
            ClearPedTasks(playerPed)
        end
    end, function() -- Cancel
        StopAnimTask(playerPed, animDict, anim, 1.0)
        QBCore.Functions.Notify("Failed!", "error")
        ClearPedTasks(playerPed)
    end)
end)

-- BRAKES
RegisterNetEvent('craft:brake0')
AddEventHandler("craft:brake0", function()
    QBCore.Functions.Progressbar("craft_brake0", "Building Brake Setup...", 22000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        anim = "machinic_loop_mechandplayer",
        flags = 18,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(3,9)
        if success then
            StopAnimTask(playerPed, animDict, anim, 1.0)
            TriggerServerEvent("craft:brake0")
            ClearPedTasks(playerPed)
        else
            QBCore.Functions.Notify("Failed!", "error")
            ClearPedTasks(playerPed)
        end
    end, function() -- Cancel
        StopAnimTask(playerPed, animDict, anim, 1.0)
        QBCore.Functions.Notify("Failed!", "error")
        ClearPedTasks(playerPed)
    end)
end)

RegisterNetEvent('craft:brake1')
AddEventHandler("craft:brake1", function()
    QBCore.Functions.Progressbar("craft_brake1", "Building Brake Setup...", 22000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        anim = "machinic_loop_mechandplayer",
        flags = 18,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(3,9)
        if success then
            StopAnimTask(playerPed, animDict, anim, 1.0)
            TriggerServerEvent("craft:brake1")
            ClearPedTasks(playerPed)
        else
            QBCore.Functions.Notify("Failed!", "error")
            ClearPedTasks(playerPed)
        end
    end, function() -- Cancel
        StopAnimTask(playerPed, animDict, anim, 1.0)
        QBCore.Functions.Notify("Failed!", "error")
        ClearPedTasks(playerPed)
    end)
end)

RegisterNetEvent('craft:brake2')
AddEventHandler("craft:brake2", function()
    QBCore.Functions.Progressbar("craft_brake2", "Building Brake Setup...", 22000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        anim = "machinic_loop_mechandplayer",
        flags = 18,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(3,9)
        if success then
            StopAnimTask(playerPed, animDict, anim, 1.0)
            TriggerServerEvent("craft:brake2")
            ClearPedTasks(playerPed)
        else
            QBCore.Functions.Notify("Failed!", "error")
            ClearPedTasks(playerPed)
        end
    end, function() -- Cancel
        StopAnimTask(playerPed, animDict, anim, 1.0)
        QBCore.Functions.Notify("Failed!", "error")
        ClearPedTasks(playerPed)
    end)
end)

RegisterNetEvent('craft:brake3')
AddEventHandler("craft:brake3", function()
    QBCore.Functions.Progressbar("craft_brake3", "Building Brake Setup...", 22000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        anim = "machinic_loop_mechandplayer",
        flags = 18,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(3,9)
        if success then
            StopAnimTask(playerPed, animDict, anim, 1.0)
            TriggerServerEvent("craft:brake3")
            ClearPedTasks(playerPed)
        else
            QBCore.Functions.Notify("Failed!", "error")
            ClearPedTasks(playerPed)
        end
    end, function() -- Cancel
        StopAnimTask(playerPed, animDict, anim, 1.0)
        QBCore.Functions.Notify("Failed!", "error")
        ClearPedTasks(playerPed)
    end)
end)

-- Transmission
RegisterNetEvent('craft:transmission0')
AddEventHandler("craft:transmission0", function()
    QBCore.Functions.Progressbar("craft_transmission0", "Building Transmission...", 24000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        anim = "machinic_loop_mechandplayer",
        flags = 18,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(3,9)
        if success then
            StopAnimTask(playerPed, animDict, anim, 1.0)
            TriggerServerEvent("craft:transmission0")
            ClearPedTasks(playerPed)
        else
            QBCore.Functions.Notify("Failed!", "error")
            ClearPedTasks(playerPed)
        end
    end, function() -- Cancel
        StopAnimTask(playerPed, animDict, anim, 1.0)
        QBCore.Functions.Notify("Failed!", "error")
        ClearPedTasks(playerPed)
    end)
end)

RegisterNetEvent('craft:transmission1')
AddEventHandler("craft:transmission1", function()
    QBCore.Functions.Progressbar("craft_transmission1", "Building Transmission...", 24000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        anim = "machinic_loop_mechandplayer",
        flags = 18,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(3,9)
        if success then
            StopAnimTask(playerPed, animDict, anim, 1.0)
            TriggerServerEvent("craft:transmission1")
            ClearPedTasks(playerPed)
        else
            QBCore.Functions.Notify("Failed!", "error")
            ClearPedTasks(playerPed)
        end
    end, function() -- Cancel
        StopAnimTask(playerPed, animDict, anim, 1.0)
        QBCore.Functions.Notify("Failed!", "error")
        ClearPedTasks(playerPed)
    end)
end)

RegisterNetEvent('craft:transmission2')
AddEventHandler("craft:transmission2", function()
    QBCore.Functions.Progressbar("craft_transmission2", "Building Transmission...", 24000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        anim = "machinic_loop_mechandplayer",
        flags = 18,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(3,9)
        if success then
            StopAnimTask(playerPed, animDict, anim, 1.0)
            TriggerServerEvent("craft:transmission2")
            ClearPedTasks(playerPed)
        else
            QBCore.Functions.Notify("Failed!", "error")
            ClearPedTasks(playerPed)
        end
    end, function() -- Cancel
        StopAnimTask(playerPed, animDict, anim, 1.0)
        QBCore.Functions.Notify("Failed!", "error")
        ClearPedTasks(playerPed)
    end)
end)

RegisterNetEvent('craft:transmission3')
AddEventHandler("craft:transmission3", function()
    QBCore.Functions.Progressbar("craft_transmission3", "Building Transmission...", 24000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        anim = "machinic_loop_mechandplayer",
        flags = 18,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(3,9)
        if success then
            StopAnimTask(playerPed, animDict, anim, 1.0)
            TriggerServerEvent("craft:transmission3")
            ClearPedTasks(playerPed)
        else
            QBCore.Functions.Notify("Failed!", "error")
            ClearPedTasks(playerPed)
        end
    end, function() -- Cancel
        StopAnimTask(playerPed, animDict, anim, 1.0)
        QBCore.Functions.Notify("Failed!", "error")
        ClearPedTasks(playerPed)
    end)
end)

-- Suspension
RegisterNetEvent('craft:suspension0')
AddEventHandler("craft:suspension0", function()
    QBCore.Functions.Progressbar("craft_suspension0", "Building Suspension...", 24000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        anim = "machinic_loop_mechandplayer",
        flags = 18,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(3,9)
        if success then
            StopAnimTask(playerPed, animDict, anim, 1.0)
            TriggerServerEvent("craft:suspension0")
            ClearPedTasks(playerPed)
        else
            QBCore.Functions.Notify("Failed!", "error")
            ClearPedTasks(playerPed)
        end
    end, function() -- Cancel
        StopAnimTask(playerPed, animDict, anim, 1.0)
        QBCore.Functions.Notify("Failed!", "error")
        ClearPedTasks(playerPed)
    end)
end)

RegisterNetEvent('craft:suspension1')
AddEventHandler("craft:suspension1", function()
    QBCore.Functions.Progressbar("craft_suspension1", "Building Suspension...", 24000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        anim = "machinic_loop_mechandplayer",
        flags = 18,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(3,9)
        if success then
            StopAnimTask(playerPed, animDict, anim, 1.0)
            TriggerServerEvent("craft:suspension1")
            ClearPedTasks(playerPed)
        else
            QBCore.Functions.Notify("Failed!", "error")
            ClearPedTasks(playerPed)
        end
    end, function() -- Cancel
        StopAnimTask(playerPed, animDict, anim, 1.0)
        QBCore.Functions.Notify("Failed!", "error")
        ClearPedTasks(playerPed)
    end)
end)

RegisterNetEvent('craft:suspension2')
AddEventHandler("craft:suspension2", function()
    QBCore.Functions.Progressbar("craft_suspension2", "Building Suspension...", 24000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        anim = "machinic_loop_mechandplayer",
        flags = 18,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(3,9)
        if success then
            StopAnimTask(playerPed, animDict, anim, 1.0)
            TriggerServerEvent("craft:suspension2")
            ClearPedTasks(playerPed)
        else
            QBCore.Functions.Notify("Failed!", "error")
            ClearPedTasks(playerPed)
        end
    end, function() -- Cancel
        StopAnimTask(playerPed, animDict, anim, 1.0)
        QBCore.Functions.Notify("Failed!", "error")
        ClearPedTasks(playerPed)
    end)
end)

RegisterNetEvent('craft:suspension3')
AddEventHandler("craft:suspension3", function()
    QBCore.Functions.Progressbar("craft_suspension3", "Building Suspension...", 24000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        anim = "machinic_loop_mechandplayer",
        flags = 18,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(3,9)
        if success then
            StopAnimTask(playerPed, animDict, anim, 1.0)
            TriggerServerEvent("craft:suspension3")
            ClearPedTasks(playerPed)
        else
            QBCore.Functions.Notify("Failed!", "error")
            ClearPedTasks(playerPed)
        end
    end, function() -- Cancel
        StopAnimTask(playerPed, animDict, anim, 1.0)
        QBCore.Functions.Notify("Failed!", "error")
        ClearPedTasks(playerPed)
    end)
end)

RegisterNetEvent('craft:suspension4')
AddEventHandler("craft:suspension4", function()
    QBCore.Functions.Progressbar("craft_suspension4", "Building Suspension...", 24000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        anim = "machinic_loop_mechandplayer",
        flags = 18,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(3,9)
        if success then
            StopAnimTask(playerPed, animDict, anim, 1.0)
            TriggerServerEvent("craft:suspension4")
            ClearPedTasks(playerPed)
        else
            QBCore.Functions.Notify("Failed!", "error")
            ClearPedTasks(playerPed)
        end
    end, function() -- Cancel
        StopAnimTask(playerPed, animDict, anim, 1.0)
        QBCore.Functions.Notify("Failed!", "error")
        ClearPedTasks(playerPed)
    end)
end)

-- TURBO
RegisterNetEvent('craft:turbo0')
AddEventHandler("craft:turbo0", function()
    QBCore.Functions.Progressbar("craft_turbo0", "Building Turbo...", 18000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        anim = "machinic_loop_mechandplayer",
        flags = 18,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(3,9)
        if success then
            StopAnimTask(playerPed, animDict, anim, 1.0)
            TriggerServerEvent("craft:turbo0")
            ClearPedTasks(playerPed)
        else
            QBCore.Functions.Notify("Failed!", "error")
            ClearPedTasks(playerPed)
        end
    end, function() -- Cancel
        StopAnimTask(playerPed, animDict, anim, 1.0)
        QBCore.Functions.Notify("Failed!", "error")
        ClearPedTasks(playerPed)
    end)
end)

RegisterNetEvent('craft:turbo1')
AddEventHandler("craft:turbo1", function()
    QBCore.Functions.Progressbar("craft_turbo1", "Building Turbo...", 18000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        anim = "machinic_loop_mechandplayer",
        flags = 18,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(3,9)
        if success then
            StopAnimTask(playerPed, animDict, anim, 1.0)
            TriggerServerEvent("craft:turbo1")
            ClearPedTasks(playerPed)
        else
            QBCore.Functions.Notify("Failed!", "error")
            ClearPedTasks(playerPed)
        end
    end, function() -- Cancel
        StopAnimTask(playerPed, animDict, anim, 1.0)
        QBCore.Functions.Notify("Failed!", "error")
        ClearPedTasks(playerPed)
    end)
end)

-- WINDOW TINTING (TEST)
RegisterNetEvent('craft:windowtint0')
AddEventHandler("craft:windowtint0", function()
    QBCore.Functions.Progressbar("craft_windowtint0", "Setting Window Tint...", 18500, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        anim = "machinic_loop_mechandplayer",
        flags = 18,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(3,9)
        if success then
            StopAnimTask(playerPed, animDict, anim, 1.0)
            TriggerServerEvent("craft:windowtint0")
            ClearPedTasks(playerPed)
        else
            QBCore.Functions.Notify("Failed!", "error")
            ClearPedTasks(playerPed)
        end
    end, function() -- Cancel
        StopAnimTask(playerPed, animDict, anim, 1.0)
        QBCore.Functions.Notify("Failed!", "error")
        ClearPedTasks(playerPed)
    end)
end)

RegisterNetEvent('craft:harness')
AddEventHandler("craft:harness", function()
    QBCore.Functions.Progressbar("craft_harness", "Building Harness Kit...", 17500, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        anim = "machinic_loop_mechandplayer",
        flags = 18,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(3,9)
        if success then
            StopAnimTask(playerPed, animDict, anim, 1.0)
            TriggerServerEvent("craft:harness")
            ClearPedTasks(playerPed)
        else
            QBCore.Functions.Notify("Failed!", "error")
            ClearPedTasks(playerPed)
        end
    end, function() -- Cancel
        StopAnimTask(playerPed, animDict, anim, 1.0)
        QBCore.Functions.Notify("Failed!", "error")
        ClearPedTasks(playerPed)
    end)
end)

RegisterNetEvent('craft:repairkit')
AddEventHandler("craft:repairkit", function()
    QBCore.Functions.Progressbar("craft_repairkit", "Grabbing Tools...", 16000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        anim = "machinic_loop_mechandplayer",
        flags = 18,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(3,9)
        if success then
            StopAnimTask(playerPed, animDict, anim, 1.0)
            TriggerServerEvent("craft:repairkit")
            ClearPedTasks(playerPed)
        else
            QBCore.Functions.Notify("Failed!", "error")
            ClearPedTasks(playerPed)
        end
    end, function() -- Cancel
        StopAnimTask(playerPed, animDict, anim, 1.0)
        QBCore.Functions.Notify("Failed!", "error")
        ClearPedTasks(playerPed)
    end)
end)

RegisterNetEvent('craft:advlockpick')
AddEventHandler("craft:advlockpick", function()
    QBCore.Functions.Progressbar("craft_advlockpick", "Making Lockpick Kit...", 15000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        anim = "machinic_loop_mechandplayer",
        flags = 18,
    }, {}, {}, function() 
        local playerPed = PlayerPedId()
        local success = exports['qb-lock']:StartLockPickCircle(3,9)
        if success then
            StopAnimTask(playerPed, animDict, anim, 1.0)
            TriggerServerEvent("craft:advlockpick")
            ClearPedTasks(playerPed)
        else
            QBCore.Functions.Notify("Failed!", "error")
            ClearPedTasks(playerPed)
        end
    end, function() -- Cancel
        StopAnimTask(playerPed, animDict, anim, 1.0)
        QBCore.Functions.Notify("Failed!", "error")
        ClearPedTasks(playerPed)
    end)
end)

------------------------------
------PARTS INSTALLATION------
------------------------------

------ENGINE------
------------------
RegisterNetEvent('qb-mechanicparts:E0')
AddEventHandler('qb-mechanicparts:E0', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
--     local trunkpos = false
    engine = GetVehicleMod(vehicle, 11)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                  if engine ~= -1 then 
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
-- 			    trunkpos = true
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                                QBCore.Functions.Progressbar("Gas_Engine", "Installing Engine Mod...", 35000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 11, -1, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "engine0", 1)
                                    --QBCore.Functions.RemoveItem('engine0')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["engine0"], "remove")
                                    QBCore.Functions.Notify("Stock Engine Successfully installed", "success")
                                end)
-- 				if trunkpos then
-- 					SetVehicleDoorShut(vehicle, 5, false)
-- 				else
-- 					SetVehicleDoorShut(vehicle, 4, false)
-- 				end
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Stock Engine already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)
RegisterNetEvent('qb-mechanicparts:E1')
AddEventHandler('qb-mechanicparts:E1', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    engine = GetVehicleMod(vehicle, 11)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if engine ~= 0 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Gas_Engine", "Installing Engine Mod...", 35000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 11, 0, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "engine1", 1)
                                    --QBCore.Functions.RemoveItem('engine1')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["engine1"], "remove")
                                    QBCore.Functions.Notify("Engine Upgrade B Successfully installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Engine Upgrade B already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:E2')
AddEventHandler('qb-mechanicparts:E2', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    engine = GetVehicleMod(vehicle, 11)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if engine ~= 1 then 
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Gas_Engine", "Installing Engine Mod...", 35000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 11, 1, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "engine2", 1)
                                    --QBCore.Functions.RemoveItem('engine2')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["engine2"], "remove")
                                    QBCore.Functions.Notify("Engine Upgrade C Successfully installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Engine Upgrade C already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:E3')
AddEventHandler('qb-mechanicparts:E3', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    engine = GetVehicleMod(vehicle, 11)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if engine ~= 2 then 
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Gas_Engine", "Installing Engine Mod...", 35000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 11, 2, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "engine3", 1)
                                    --QBCore.Functions.RemoveItem('engine3')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["engine3"], "remove")
                                    QBCore.Functions.Notify("Engine Upgrade D Successfully installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Engine Upgrade D already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)


RegisterNetEvent('qb-mechanicparts:E4')
AddEventHandler('qb-mechanicparts:E4', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    engine = GetVehicleMod(vehicle, 11)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if engine ~= 3 then 
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Gas_Engine", "Installing Engine Mod...", 35000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 11, 3, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "engine4", 1)
                                    --QBCore.Functions.RemoveItem('engine4')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["engine4"], "remove")
                                    QBCore.Functions.Notify("Engine Upgrade S Successfully installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Engine Upgrade S already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

--brakes
RegisterNetEvent('qb-mechanicparts:B0')
AddEventHandler('qb-mechanicparts:B0', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    brake = GetVehicleMod(vehicle, 12)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if brake ~= -1 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Brakes", "Installing Stock Brakes...", 28500, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 12, -1, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "brake0", 1)
                                    --QBCore.Functions.RemoveItem('brake0')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["brake0"], "remove")
                                    QBCore.Functions.Notify("Stock Brakes Successfully installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Stock Brakes already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:B1')
AddEventHandler('qb-mechanicparts:B1', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    brake = GetVehicleMod(vehicle, 12)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if brake ~= 0 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Brakes", "Installing Brakes...", 18500, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 12, 0, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "brake1", 1)
                                    --QBCore.Functions.RemoveItem('brake1')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["brake1"], "remove")
                                    QBCore.Functions.Notify("Brake Upgrade B Successfully installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Brakes Upgrade B already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:B2')
AddEventHandler('qb-mechanicparts:B2', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    brake = GetVehicleMod(vehicle, 12)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if brake ~= 1 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Brakes", "Installing Brakes...", 18500, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 12, 1, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "brake2", 1)
                                    --QBCore.Functions.RemoveItem('brake2')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["brake2"], "remove")
                                    QBCore.Functions.Notify("Brakes Upgrade C Successfully installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Brakes Upgrade C already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:B3')
AddEventHandler('qb-mechanicparts:B3', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    brake = GetVehicleMod(vehicle, 12)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if brake ~= 2 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Brakes", "Installing Brakes...", 18500, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 12, 2, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "brake3", 1)
                                    --QBCore.Functions.RemoveItem('brake3') 
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["brake3"], "remove")
                                    QBCore.Functions.Notify("Brakes Upgrade S Successfully installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Brakes Upgrade S already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

-- --Transmission
RegisterNetEvent('qb-mechanicparts:T0')
AddEventHandler('qb-mechanicparts:T0', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    transmission = GetVehicleMod(vehicle, 13)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if transmission ~= -1 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Transmission", "Installing Stock Transmission...", 21250, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 13, -1, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "transmission0", 1)
                                    --QBCore.Functions.RemoveItem('transmission0')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["transmission0"], "remove")
                                    QBCore.Functions.Notify("Stock Transmission Successfully installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Stock Transmission already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:T1')
AddEventHandler('qb-mechanicparts:T1', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    transmission = GetVehicleMod(vehicle, 13)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if transmission ~= 0 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Transmission", "Installing Transmission...", 21250, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 13, 0, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "transmission1", 1)
                                    --QBCore.Functions.RemoveItem('transmission1')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["transmission1"], "remove")
                                    QBCore.Functions.Notify("Transmission Upgrade B Successfully installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Transmission Upgrade B already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:T2')
AddEventHandler('qb-mechanicparts:T2', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    transmission = GetVehicleMod(vehicle, 13)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if transmission ~= 1 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Transmission", "Installing Transmission...", 21250, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 13, 1, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "transmission2", 1)
                                    --QBCore.Functions.RemoveItem('transmission2')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["transmission2"], "remove")
                                    QBCore.Functions.Notify("Transmission Upgrade C Successfully installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Transmission Upgrade C already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:T3')
AddEventHandler('qb-mechanicparts:T3', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    transmission = GetVehicleMod(vehicle, 13)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if transmission ~= 2 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Transmission", "Installing Transmission...", 21250, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 13, 2, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "transmission3", 1)
                                    --QBCore.Functions.RemoveItem('transmission3')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["transmission3"], "remove")
                                    QBCore.Functions.Notify("Transmission Upgrade S Successfully installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Transmission Upgrade S already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

-- --Suspension
RegisterNetEvent('qb-mechanicparts:S0')
AddEventHandler('qb-mechanicparts:S0', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    suspension = GetVehicleMod(vehicle, 15)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if suspension ~= -1 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Suspension", "Installing Stock Suspension...", 20000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 15, -1, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "suspension0", 1)
                                    --QBCore.Functions.RemoveItem('suspension0')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["suspension0"], "remove")
                                    QBCore.Functions.Notify("Stock Suspension Successfully installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Stock Suspension already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:S1')
AddEventHandler('qb-mechanicparts:S1', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    suspension = GetVehicleMod(vehicle, 15)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if suspension ~= 0 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Suspension", "Installing Suspension...", 20000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 15, 0, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "suspension1", 1)
                                    --QBCore.Functions.RemoveItem('suspension1')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["suspension1"], "remove")
                                    QBCore.Functions.Notify("Suspension Upgrade B Successfully installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Suspension Upgrade B already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:S2')
AddEventHandler('qb-mechanicparts:S2', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    suspension = GetVehicleMod(vehicle, 15)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if suspension ~= 1 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Suspension", "Installing Suspension...", 20000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 15, 1, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "suspension2", 1)
                                    --QBCore.Functions.RemoveItem('suspension2')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["suspension2"], "remove")
                                    QBCore.Functions.Notify("Suspension Upgrade C Successfully installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Suspension Upgrade C already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:S3')
AddEventHandler('qb-mechanicparts:S3', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    suspension = GetVehicleMod(vehicle, 15)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if suspension ~= 2 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Suspension", "Installing Suspension...", 20000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 15, 2, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "suspension3", 1)
                                    --QBCore.Functions.RemoveItem('suspension3')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["suspension3"], "remove")
                                    QBCore.Functions.Notify("Suspension Upgrade D Successfully installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Suspension Upgrade D already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:S4')
AddEventHandler('qb-mechanicparts:S4', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    suspension = GetVehicleMod(vehicle, 15)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if suspension ~= 3 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Suspension", "Installing Suspension...", 20000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 15, 3, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "suspension4", 1)
                                    --QBCore.Functions.RemoveItem('suspension4')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["suspension4"], "remove")
                                    QBCore.Functions.Notify("Suspension Upgrade S Successfully installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Suspension Upgrade S already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

-- --Suspension
RegisterNetEvent('qb-mechanicparts:Turbo0')
AddEventHandler('qb-mechanicparts:Turbo0', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    turbo = IsToggleModOn(vehicle, 18)
    print(turbo)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if turbo == 1 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Turbo", "Removing Turbo...", 19250, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    ToggleVehicleMod(vehicle, 18, false)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "turbo0", 1)
                                    --QBCore.Functions.RemoveItem('turbo0')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["turbo0"], "remove")
                                    QBCore.Functions.Notify("Turbo Successfully removed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Turbo Already Removed", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:Turbo1')
AddEventHandler('qb-mechanicparts:Turbo1', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    turbo = IsToggleModOn(vehicle, 18)
    print(turbo)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if turbo == false then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Turbo", "Installing Turbo...", 19500, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    ToggleVehicleMod(vehicle, 18, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "turbo1", 1)
                                    --QBCore.Functions.RemoveItem('turbo1')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["turbo1"], "remove")
                                    QBCore.Functions.Notify("Turbo Successfully installed", "success")
                                    

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Turbo already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

--WINDOW TINT (TESTING)
RegisterNetEvent('qb-mechanicparts:WT0')
AddEventHandler('qb-mechanicparts:WT0', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    tint = GetVehicleMod(vehicle, 46)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if tint ~= 0 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Tint", "Removing Window Tint...", 15000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleWindowTint(vehicle, 0)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "windowtint0", 1)
                                    --QBCore.Functions.RemoveItem('windowtint0')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["windowtint0"], "remove")
                                    QBCore.Functions.Notify("Stock Tint Successfully installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Stock Tint already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:WT1')
AddEventHandler('qb-mechanicparts:WT1', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    tint = GetVehicleMod(vehicle, 46)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if tint ~= 1 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Tint", "Installing Window Tint...", 16500, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleWindowTint(vehicle, 1)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "windowtint1", 1)
                                    --QBCore.Functions.RemoveItem('windowtint1')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["windowtint1"], "remove")
                                    QBCore.Functions.Notify("Stage 1 Tint Successfully installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Stage 1 Tint already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:WT2')
AddEventHandler('qb-mechanicparts:WT2', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    tint = GetVehicleMod(vehicle, 46)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if tint ~= 2 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Tint", "Installing Window Tint...", 16500, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleWindowTint(vehicle, 2)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "windowtint2", 1)
                                    --QBCore.Functions.RemoveItem('windowtint2')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["windowtint2"], "remove")
                                    QBCore.Functions.Notify("Stage 2 Tint Successfully installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Stage 2 Tint already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)


RegisterNetEvent('qb-mechanicparts:WT3')
AddEventHandler('qb-mechanicparts:WT3', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    tint = GetVehicleMod(vehicle, 46)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if tint ~= 3 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("Tint", "Installing Window Tint...", 16500, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleWindowTint(vehicle, 3)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "windowtint3", 1)
                                    --QBCore.Functions.RemoveItem('windowtint3')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["windowtint3"], "remove")
                                    QBCore.Functions.Notify("Stage 3 Tint Successfully installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("Stage 3 Tint already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)


RegisterNetEvent('qb-mechanicparts:HLS')  
AddEventHandler('qb-mechanicparts:HLS', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    headlight = GetVehicleMod(vehicle, 22)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if headlight ~= 3 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("headlight", "Installing Headlights...", 15000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    ToggleVehicleMod(vehicle, 22, true) -- toggle xenon
                                    SetVehicleHeadlightsColour(vehicle, 255)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "stock", 1)
                                    --QBCore.Functions.RemoveItem('stock')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["stock"], "remove")
                                    QBCore.Functions.Notify("Headlights installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("This colour is already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:HL0')  
AddEventHandler('qb-mechanicparts:HL0', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    headlight = GetVehicleMod(vehicle, 22)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if headlight ~= 3 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("headlight", "Installing Headlights...", 15000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    ToggleVehicleMod(vehicle, 22, true) -- toggle xenon
                                    SetVehicleHeadlightsColour(vehicle, 0)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "white", 1)
                                    --QBCore.Functions.RemoveItem('white')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["white"], "remove")
                                    QBCore.Functions.Notify("Headlights installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("This colour is already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:HL1')  
AddEventHandler('qb-mechanicparts:HL1', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    headlight = GetVehicleMod(vehicle, 22)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if headlight ~= 3 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("headlight", "Installing Headlights...", 15000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    ToggleVehicleMod(vehicle, 22, true) -- toggle xenon
                                    SetVehicleHeadlightsColour(vehicle, 1)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "blue", 1)
                                    --QBCore.Functions.RemoveItem('blue')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["blue"], "remove")
                                    QBCore.Functions.Notify("Headlights installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("This colour is already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:HL2')  
AddEventHandler('qb-mechanicparts:HL2', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    headlight = GetVehicleMod(vehicle, 22)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if headlight ~= 3 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("headlight", "Installing Headlights...", 15000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    ToggleVehicleMod(vehicle, 22, true) -- toggle xenon
                                    SetVehicleHeadlightsColour(vehicle, 2)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "electricblue", 1)
                                    --QBCore.Functions.RemoveItem('electricblue')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["electricblue"], "remove")
                                    QBCore.Functions.Notify("Headlights installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("This colour is already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:HL3')  
AddEventHandler('qb-mechanicparts:HL3', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    headlight = GetVehicleMod(vehicle, 22)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if headlight ~= 3 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("headlight", "Installing Headlights...", 15000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    ToggleVehicleMod(vehicle, 22, true) -- toggle xenon
                                    SetVehicleHeadlightsColour(vehicle, 3)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "mintgreen", 1)
                                    --QBCore.Functions.RemoveItem('mintgreen')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["mintgreen"], "remove")
                                    QBCore.Functions.Notify("Headlights installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("This colour is already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:HL4')  
AddEventHandler('qb-mechanicparts:HL4', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    headlight = GetVehicleMod(vehicle, 22)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if headlight ~= 3 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("headlight", "Installing Headlights...", 15000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    ToggleVehicleMod(vehicle, 22, true) -- toggle xenon
                                    SetVehicleHeadlightsColour(vehicle, 4)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "limegreen", 1)
                                    --QBCore.Functions.RemoveItem('limegreen')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["limegreen"], "remove")
                                    QBCore.Functions.Notify("Headlights installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("This colour is already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:HL5')  
AddEventHandler('qb-mechanicparts:HL5', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    headlight = GetVehicleMod(vehicle, 22)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if headlight ~= 3 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("headlight", "Installing Headlights...", 15000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    ToggleVehicleMod(vehicle, 22, true) -- toggle xenon
                                    SetVehicleHeadlightsColour(vehicle, 5)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "yellow", 1)
                                    --QBCore.Functions.RemoveItem('yellow')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["yellow"], "remove")
                                    QBCore.Functions.Notify("Headlights installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("This colour is already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:HL6')  
AddEventHandler('qb-mechanicparts:HL6', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    headlight = GetVehicleMod(vehicle, 22)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if headlight ~= 3 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("headlight", "Installing Headlights...", 15000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    ToggleVehicleMod(vehicle, 22, true) -- toggle xenon
                                    SetVehicleHeadlightsColour(vehicle, 6)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "goldenshower", 1)
                                    --QBCore.Functions.RemoveItem('goldenshower')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["goldenshower"], "remove")
                                    QBCore.Functions.Notify("Headlights installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("This colour is already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:HL7')  
AddEventHandler('qb-mechanicparts:HL7', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    headlight = GetVehicleMod(vehicle, 22)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if headlight ~= 3 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("headlight", "Installing Headlights...", 15000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    ToggleVehicleMod(vehicle, 22, true) -- toggle xenon
                                    SetVehicleHeadlightsColour(vehicle, 7)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "orange", 1)
                                    --QBCore.Functions.RemoveItem('orange')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["orange"], "remove")
                                    QBCore.Functions.Notify("Headlights installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("This colour is already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:HL8')  
AddEventHandler('qb-mechanicparts:HL8', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    headlight = GetVehicleMod(vehicle, 22)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if headlight ~= 3 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("headlight", "Installing Headlights...", 15000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    ToggleVehicleMod(vehicle, 22, true) -- toggle xenon
                                    SetVehicleHeadlightsColour(vehicle, 8)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "red", 1)
                                    --QBCore.Functions.RemoveItem('red')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["red"], "remove")
                                    QBCore.Functions.Notify("Headlights installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("This colour is already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:HL9')  
AddEventHandler('qb-mechanicparts:HL9', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    headlight = GetVehicleMod(vehicle, 22)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if headlight ~= 3 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("headlight", "Installing Headlights...", 15000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    ToggleVehicleMod(vehicle, 22, true) -- toggle xenon
                                    SetVehicleHeadlightsColour(vehicle, 9)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "ponypink", 1)
                                    --QBCore.Functions.RemoveItem('ponypink')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["ponypink"], "remove")
                                    QBCore.Functions.Notify("Headlights installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("This colour is already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:HL10')  
AddEventHandler('qb-mechanicparts:HL10', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    headlight = GetVehicleMod(vehicle, 22)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if headlight ~= 3 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("headlight", "Installing Headlights...", 15000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    ToggleVehicleMod(vehicle, 22, true) -- toggle xenon
                                    SetVehicleHeadlightsColour(vehicle, 10)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "hotpink", 1)
                                    --QBCore.Functions.RemoveItem('hotpink')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["hotpink"], "remove")
                                    QBCore.Functions.Notify("Headlights installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("This colour is already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:HL11')  
AddEventHandler('qb-mechanicparts:HL11', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    headlight = GetVehicleMod(vehicle, 22)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if headlight ~= 3 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("headlight", "Installing Headlights...", 15000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    ToggleVehicleMod(vehicle, 22, true) -- toggle xenon
                                    SetVehicleHeadlightsColour(vehicle, 11)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "purple", 1)
                                    --QBCore.Functions.RemoveItem('purple')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["purple"], "remove")
                                    QBCore.Functions.Notify("Headlights installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("This colour is already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:HL12')  
AddEventHandler('qb-mechanicparts:HL12', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    headlight = GetVehicleMod(vehicle, 22)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if headlight ~= 3 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("headlight", "Installing Headlights...", 15000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    ToggleVehicleMod(vehicle, 22, true) -- toggle xenon
                                    SetVehicleHeadlightsColour(vehicle, 12)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "blacklight", 1)
                                    --QBCore.Functions.RemoveItem('blacklight')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["blacklight"], "remove")
                                    QBCore.Functions.Notify("Headlights installed", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("This colour is already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:Spoiler0')
AddEventHandler('qb-mechanicparts:Spoiler0', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
--     local trunkpos = false
    spoiler = GetVehicleMod(veh, 0)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                  if spoiler ~= -1 then 
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
-- 			    trunkpos = true
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                                QBCore.Functions.Progressbar("spoiler", "Attaching Spoiler...", 10000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 0, -1, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "spoiler0", 1)
                                    --QBCore.Functions.RemoveItem('spoiler0')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["spoiler0"], "remove")
                                    QBCore.Functions.Notify("Spoiler successfully attached.", "success")
                                end)
-- 				if trunkpos then
-- 					SetVehicleDoorShut(vehicle, 5, false)
-- 				else
-- 					SetVehicleDoorShut(vehicle, 4, false)
-- 				end
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("That spoiler is already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)
RegisterNetEvent('qb-mechanicparts:Spoiler1')
AddEventHandler('qb-mechanicparts:Spoiler1', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    spoiler = GetVehicleMod(veh, 0)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if spoiler ~= 0 then
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("spoiler", "Attaching Spoiler...", 10000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 0, 0, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "spoiler1", 1)
                                    --QBCore.Functions.RemoveItem('spoiler1')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["spoiler1"], "remove")
                                    QBCore.Functions.Notify("Spoiler successfully attached.", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("That spoiler is already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:Spoiler2')
AddEventHandler('qb-mechanicparts:Spoiler2', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    spoiler = GetVehicleMod(veh, 0)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if spoiler ~= 1 then 
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("spoiler", "Attaching Spoiler...", 10000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 0, 1, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "spoiler2", 1)
                                    --QBCore.Functions.RemoveItem('spoiler2')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["spoiler2"], "remove")
                                    QBCore.Functions.Notify("Spoiler successfully attached.", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("That spoiler is already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

RegisterNetEvent('qb-mechanicparts:Spoiler3')
AddEventHandler('qb-mechanicparts:Spoiler3', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    spoiler = GetVehicleMod(veh, 0)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if spoiler ~= 2 then 
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("spoiler", "Attaching Spoiler...", 10000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 0, 2, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "spoiler3", 1)
                                    --QBCore.Functions.RemoveItem('spoiler3')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["spoiler3"], "remove")
                                    QBCore.Functions.Notify("Spoiler successfully attached.", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("That spoiler is already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)


RegisterNetEvent('qb-mechanicparts:Spoiler4')
AddEventHandler('qb-mechanicparts:Spoiler4', function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    spoiler = GetVehicleMod(veh, 0)
        if PlayerJob.name == Config.Job or 'hayesauto' then
            if onDuty then
                if spoiler ~= 3 then 
                    if vehicle ~= nil and vehicle ~= 0 then
                        if (IsBackEngine(GetEntityModel(vehicle))) then
                            SetVehicleDoorOpen(vehicle, 5, false, false)
                        else
                            SetVehicleDoorOpen(vehicle, 4, false, false)
                        end
                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local vehpos = GetEntityCoords(vehicle)
                        if #(pos - vehpos) < 4.0 and not IsPedInAnyVehicle(ped) then
                            local drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                            if (IsBackEngine(GetEntityModel(vehicle))) then
                                drawpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                            end
                            if #(pos - drawpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                            
                                QBCore.Functions.Progressbar("spoiler", "Attaching Spoiler...", 10000, false, true, {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {
                                    animDict = "mini@repair",
                                    anim = "fixing_a_player",
                                    flags = 9,
                                }, {}, {}, function() -- Done
                                    ClearPedTasksImmediately(PlayerPedId())
                                    SetVehicleModKit(vehicle, 0)
                                    SetVehicleMod(vehicle, 0, 3, true)
                                    local vehicle = QBCore.Functions.GetVehicleProperties(vehicle)
                                    saveVehicle()  
                                    TriggerServerEvent("qb-smallresources:server:RemoveItem", "spoiler4", 1)
                                    --QBCore.Functions.RemoveItem('spoiler4')
                                    TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["spoiler4"], "remove")
                                    QBCore.Functions.Notify("Spoiler successfully attached.", "success")

                                end)
                            end
                        end
                    end
                else
                    QBCore.Functions.Notify("That spoiler is already installed...", "error")
                end
            else
                QBCore.Functions.Notify("You need to be on duty!", "error")
            end
        else
            QBCore.Functions.Notify("You are not allowed to complete this action", "error")
        end
end)

-------------------------------------------------------
------QB MENU PARTS CRAFTING WITH RECIPES DETAILS------
-------------------------------------------------------

---------- Nitrous Station
RegisterNetEvent('craft:nitroustation', function()
    exports['qb-menu']:openMenu({
        {
            header = "Nitrous Station",
            txt = "",
            isMenuHeader = true,
        },
        {
            header = "Refilling Nitrous",
            txt = "Refilling Empty Nitrous Bottle",
            params = {
                event = "craft:fillnitrous",
            }
        },
        {
            header = "Crafting Nitrous",
            txt = "5x Metalscrap | 5x Iron",
            params = {
                event = "craft:nitrous",
            }
        },
        {
            header = "Close Menu",
            txt = "",
            params = {
                event = "qb-menu:closeMenu",
            }
        },
    })
end)

---------- CRAFTING MENU
RegisterNetEvent('craft:mechanicparts', function()
    exports['qb-menu']:openMenu({
        {
            header = "Parts Menu",
            txt = "",
            isMenuHeader = true,
        },
        {
            header = "Engine Upgrades",
            txt = " View engine upgrades for vehicles ",
            params = {
                event = "craft:engines",
                args = {
                    number = 2,
                }
            }
        },
        {
            header = "Brake Modifications",
            txt = " View brake modifications for vehicles ",
            params = {
                event = "craft:brakes",
                args = {
                    number = 3,
                }
            }
        },
        {
            header = "Transmission Modifications",
            txt = " View transmission modifications for vehicles ",
            params = {
                event = "craft:transmissions",
                args = {
                    number = 4,
                }
            }
        },
        {
            header = "Suspension Upgrades",
            txt = " View suspension upgrades for vehicles ",
            params = {
                event = "craft:suspensions",
                args = {
                    number = 5,
                }
            }
        },
        {
            header = "Turbos",
            txt = " View turbo options for vehicles ",
            params = {
                event = "craft:turbos",
                args = {
                    number = 6,
                }
            }
        },
        {
            header = "Tools & Equipment",
            txt = " View Ivans Customs shop tool options ",
            params = {
                event = "craft:repairkit1",
                args = {
                    number = 7,
                }
            }
        },
        {
            header = "Close Menu",
            txt = "",
            params = {
                event = "qb-menu:closeMenu",
                args = {
                    number = 8,
                }
            }
        },
    })
end)

---------- ENGINE MENU
RegisterNetEvent('craft:engines', function()
    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "Engine Modifications",
            txt = "",
            isMenuHeader = true
        },
        {
            id = 2,
            header = "Stock Engine",
            txt = " 3x Metalscrap | 2x Rubber | 1x Iron | 2x Plastic ",
            params = {
                event = "craft:engine0",
            }
        },
        {
            id = 3,
            header = "Engine Upgrade B",
            txt = " 15x Metalscrap | 8x Rubber | 12x Iron | 10x Plastic ",
            params = {
                event = "craft:engine1",
            }
        },
        {
            id = 4,
            header = "Engine Upgrade C",
            txt = " 30x Metalscrap | 16x Rubber | 24x Iron | 20x Plastic ",
            params = {
                event = "craft:engine2",
            }
        },
        {
            id = 5,
            header = "Engine Upgrade D",
            txt = " 45x Metalscrap | 24x Rubber | 36x Iron | 30x Plastic ",
            params = {
                event = "craft:engine3",
            }
        },
        {
            id = 6,
            header = "Engine Upgrade S",
            txt = " 60x Metalscrap | 32x Rubber | 40x Plastic | 50x Aluminum | 48x Iron ",
            params = {
                event = "craft:engine4",
            }
        },
        {
            id = 7,
            header = "Main Menu",
            txt = "Back to main menu",
            params = {
                event = "craft:mechanicparts",
            }
        },
    })
end)

---------- BRAKES MENU
RegisterNetEvent('craft:brakes', function()
    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "Brake Modifications",
            txt = "",
            isMenuHeader = true
        },
        {
            id = 2,
            header = "Stock Brakes",
            txt = "5x MetalScrap | 5x Rubber | 5x Iron ",
            params = {
                event = "craft:brake0",
            }
        },
        {
            id = 3,
            header = "Brake Upgrade B",
            txt = "10x Rubber | 10x Iron | 7x Metalscrap",
            params = {
                event = "craft:brake1",
            }
        },
        {
            id = 4,
            header = "Brake Upgrade C",
            txt = "20x Rubber | 20x Iron | 14x Metalscrap",
            params = {
                event = "craft:brake2",
            }
        },
        {
            id = 5,
            header = "Brake Upgrade S",
            txt = "30x Rubber | 40x Iron | 21x Metalscrap",
            params = {
                event = "craft:brake3",
            }
        },
        {
            id = 6,
            header = "Main Menu",
            txt = "Back to main menu",
            params = {
                event = "craft:mechanicparts",
            }
        },
    })
end)

---------- TRANSMISSION MENU
RegisterNetEvent('craft:transmissions', function()
    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "Transmission Modifications",
            txt = "",
            isMenuHeader = true
        },
        {
            id = 2,
            header = "Stock Transmission",
            txt = " 5x MetalScrap | 4x Plastic | 3x Iron | 5x Steel ",
            params = {
                event = "craft:transmission0",
            }
        },
        {
            id = 3,
            header = "Transmission Upgrade B",
            txt = " 10x MetalScrap | 8x Plastic | 6x Iron | 10x Steel | 5x Rubber | 5x Aluminum ",
            params = {
                event = "craft:transmission1",
            }
        },
        {
            id = 4,
            header = "Transmission Upgrade C",
            txt = " 15x MetalScrap | 12x Plastic | 9x Iron | 15x Steel | 10x Rubber | 10x Aluminum ",
            params = {
                event = "craft:transmission2",
            }
        },
        {
            id = 5,
            header = "Transmission Upgrade S",
            txt = " 20x MetalScrap | 16x Plastic | 12x Iron | 20x Steel | 15x Rubber | 15x Aluminum ",
            params = {
                event = "craft:transmission3",
            }
        },
        {
            id = 6,
            header = "Main Menu",
            txt = "Back to main menu",
            params = {
                event = "craft:mechanicparts",
            }
        },
    })
end)

---------- SUSPENSION MENU
RegisterNetEvent('craft:suspensions', function()
    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "Suspension Modifications",
            txt = "",
            isMenuHeader = true
        },
        {
            id = 2,
            header = "Stock Suspension",
            txt = " 3x MetalScrap | 3x Plastic | 3x Iron | 3x Steel ",
            params = {
                event = "craft:suspension0",
            }
        },
        {
            id = 3,
            header = "Suspension Upgrade B",
            txt = " 6x MetalScrap | 4x Rubber | 6x Iron | 4x Plastic | 5x Aluminum | 8x Steel ",
            params = {
                event = "craft:suspension1",
            }
        },
        {
            id = 4,
            header = "Suspension Upgrade C",
            txt = " 12x MetalScrap | 8x Rubber | 12x Iron | 8x Plastic | 10x Aluminum | 16x Steel ",
            params = {
                event = "craft:suspension2",
            }
        },
        {
            id = 5,
            header = "Suspension Upgrade D",
            txt = " 18x MetalScrap | 12x Rubber | 18x Iron | 12x Plastic | 15x Aluminum | 24x Steel ",
            params = {
                event = "craft:suspension3",
            }
        },
        {
            id = 6,
            header = "Suspension Upgrade S",
            txt = " 24x MetalScrap | 16x Rubber | 24x Iron | 16x Plastic | 20x Aluminum | 32x Steel ",
            params = {
                event = "craft:suspension4",
            }
        },
        {
            id = 7,
            header = "Main Menu",
            txt = "Back to main menu",
            params = {
                event = "craft:mechanicparts",
            }
        },
    })
end)

---------- TURBO MENU
RegisterNetEvent('craft:turbos', function()
    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "Turbos",
            txt = "",
            isMenuHeader = true
        },
        {
            id = 2,
            header = "Stock (N/A)",
            txt = "3x Rubber | 2x Iron | 2x Metalscrap",
            params = {
                event = "craft:turbo0",
            }
        },
        {
            id = 3,
            header = "Turbo",
            txt = "110x MetalScrap | 40x Rubber | 90x Iron",
            params = {
                event = "craft:turbo1",
            }
        },
        {
            id = 4,
            header = "Main Menu",
            txt = "Back to main menu",
            params = {
                event = "craft:mechanicparts",
            }
        },
    })
end)

---------- TOOLS MENU
RegisterNetEvent('craft:repairkit1', function()
    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "Tools & Equipment",
            txt = "",
            isMenuHeader = true
        },
        {
            id = 2,
            header = "Repair Kit",
            txt = " x5 Glass | x5 Rubber | x5  Iron | x5 Plastic ",
            params = {
                event = "craft:repairkit",
            }
        },
        {
            id = 3,
            header = "Advanced Lockpick",
            txt = " 3x Rubber | 10x Iron | 4x Plastic ",
            params = {
                event = "craft:advlockpick",
            }
        },
        {
            id = 4,
            header = "Harness Kit",
            txt = " 3x Rubber | 5x Iron | 8x Plastic | 20x Cloth ",
            params = {
                event = "craft:harness",
            }
        },
        {
            id = 5,
            header = "Main Menu",
            txt = "Back to main menu",
            params = {
                event = "craft:mechanicparts",
            }
        },
    })
end)


-------------------------------------------------
------QB MENU MOD CHECKS AND VEHICLE HEALTH------
-------------------------------------------------

RegisterNetEvent('craft:vehmenu', function()
    local ped = PlayerPedId()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local plate = QBCore.Functions.GetPlate(vehicle)

    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "Vehicle: " .. plate,
            icon = "fas fa-car",
            txt = "",
            isMenuHeader = true
        },
        {
            id = 2,
            header = "Vehicle Status",
            txt = "View vehicle health and status",
            icon = "fas fa-signal",
            params = {
                event = "craft:vehstatus",
            }
        },
        {
            id = 3,
            header = "Vehicle Modifications",
            txt = "View vehicles modifications and upgrades",
            icon = "fab fa-searchengin",
            params = {
                event = "craft:vehmods",
            }
        },
        {
            id = 4,
            header = "Close Menu",
            txt = "",
            icon = "fas fa-x",
            params = {
                event = "qb-menu:client:closeMenu",
            }
        },
    })
end)

-- VEHICLE MODS (DON'T MESS WITH THESE NUMBERS!)
RegisterNetEvent('craft:vehmods', function()
    local ped = PlayerPedId()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local plate = QBCore.Functions.GetPlate(vehicle)
    local statusList = exports['qb-mechanicjob']:GetVehicleStatusList(plate)
    local fuel = exports['qb-fuel']:GetFuel(vehicle)
    local turbo = "N/A"
    if IsToggleModOn(vehicle, 18) == 1 then
        turbo = "Turbo"
    end

    local engine = "Stock"
    local engineMod = GetVehicleMod(vehicle, 11)
    if engineMod > -1 then
        if engineMod == -1 then
            engine = "Stock"
        elseif engineMod == 0 then    
            engine = "Stage 1 Upgrade"
        elseif engineMod == 1 then
            engine = "Stage 2 Upgrade"
        elseif engineMod == 2 then
            engine = "Stage 3 Upgrade"
        elseif engineMod == 3 then
            engine = "Stage 4 Upgrade"
        end
    end

    local brakes = "Stock"
    local brakesMod = GetVehicleMod(vehicle, 12)
    if brakesMod > -1 then
        if brakesMod == -1 then
            brakes = "Stock"
        elseif brakesMod == 0 then
            brakes = "Stage 1 Upgrade"    
        elseif brakesMod == 1 then
            brakes = "Stage 2 Upgrade"
        elseif brakesMod == 2 then
            brakes = "Stage 3 Upgrade"
        end  
    end

    local transmission = "Stock"
    local transMod = GetVehicleMod(vehicle, 13)
    if transMod > 0 then
        if transMod == 0 then
            transmission = "Stock"
        elseif transMod == 0 then    
            transmission = "Stage 1 Upgrade"
        elseif transMod == 1 then
            transmission = "Stage 2 Upgrade"
        elseif transMod == 2 then
            transmission = "Stage 3 Upgrade"
        end   
    end

    local suspension = "Stock"
    local susMod = GetVehicleMod(vehicle, 15)
    if susMod > -1 then
        if susMod == -1 then
            suspension = "Stock"
        elseif susMod == 0 then
            suspension = "Stage 1 Upgrade"    
        elseif susMod == 1 then
            suspension = "Stage 2 Upgrade"
        elseif susMod == 2 then
            suspension = "Stage 3 Upgrade"
        elseif susMod == 3 then
            suspension = "Stage 4 Upgrade"
        end 
    end

    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "Vehicle: " .. plate,
            icon = "fas fa-car",
            txt = "",
            isMenuHeader = true
        },
        {
            id = 2,
            header = "Engine: ".. engine,
            icon = "fas fa-car-battery",
            txt = "",
            isMenuHeader = true
        },
        {
            id = 3,
            header = "Transmission: ".. transmission,
            icon = "fas fa-truck-monster",
            txt = "",
            isMenuHeader = true
        },
        {
            id = 4,
            header = "Suspension: ".. suspension,
            icon = "fas fa-power-off",
            txt = "",
            isMenuHeader = true
        },
        {
            id = 5,
            header = "Brakes: ".. brakes,
            icon = "fas fa-ban",
            txt = "",
            isMenuHeader = true
        },
        {
            id = 6,
            header = "Turbo: ".. turbo,
            icon = "fas fa-poop",
            txt = "",
            isMenuHeader = true
        },
        {
            id = 7,
            header = "Back",
            txt = "Back to main menu",
            icon = "fa-solid fa-rotate-left",
            params = {
                event = "craft:vehmenu",
            }
        },
        {
            id = 8,
            header = "Close Menu",
            txt = "",
            icon = "fas fa-x",
            params = {
                event = "qb-menu:client:closeMenu",
            }
        },
    })
end)

-- VEHICLE HEALTH/STATUS
RegisterNetEvent('craft:vehstatus', function()

    local statusList = exports['qb-mechanicjob']:GetVehicleStatusList(plate)
    fuel = exports['qb-fuel']:GetFuel(vehicle)
    vehicle = QBCore.Functions.GetClosestVehicle()
    plate = GetVehicleNumberPlateText(vehicle)
    engineHealth = GetVehicleEngineHealth(vehicle)
    vehTemp = GetVehicleEngineTemperature(vehicle)
    bodyHealth = GetVehicleBodyHealth(vehicle)
    fuelHealth = exports['qb-fuel']:GetFuel(vehicle)
    tankHealth = GetVehiclePetrolTankHealth(vehicle)

    exports['qb-menu']:openMenu({
        {
            id = 1,
            header = "Vehicle: " .. plate,
            icon = "fas fa-car",
            txt = "",
            isMenuHeader = true
        },
        {
            id = 2,
            header = "Engine Health",
            isMenuHeader = true,
            icon = "fas fa-car-battery",
            txt = "Status: " .. math.ceil(engineHealth / 10) .. "% / 100.0%",
        },
        {
            id = 3,
            header = "Body Condition",
            isMenuHeader = true,
            icon = "fas fa-car-burst",
            txt = "Status: " .. math.ceil(bodyHealth / 10) .. "% / 100.0%",
        },
        {
            id = 4,
            header = "Fuel Level",
            isMenuHeader = true,
            icon = "fas fa-gas-pump",
            txt = "Status: " .. math.ceil(fuelHealth) .. ".0% / 100.0%",
        },
        {
            id = 5,
            header = "Engine Temperature",
            isMenuHeader = true,
            icon = "fas fa-temperature-low",
            txt = "Status: " .. math.ceil(vehTemp) .. "° C",
        },
        {
            id = 6,
            header = "Back",
            txt = "Back to main menu",
            icon = "fa-solid fa-rotate-left",
            params = {
                event = "craft:vehmenu",
            }
        },
        {
            id = 7,
            header = "Close Menu",
            txt = "",
            icon = "fas fa-x",
            params = {
                event = "qb-menu:client:closeMenu",
            }
        },
    })
end)

------ TARGET SYSTEM---------
CreateThread(function()
    --- Parts Station
    exports["qb-target"]:AddBoxZone("tunerparts", vector3(136.7, -3051.41, 7.04), 1, 1, {
        name = "tunerparts",
        heading = 0,
        debugPoly = false,
        minZ = 3.44,
        maxZ = 7.44,
    }, {
        options = {
            {
                type = "client",
                event = "craft:mechanicparts", 
                icon = "fas fa-wrench",
                label = "Tuner Parts",
                job = "tuner",
                canInteract = function()
                if not onDuty then
                    return false
                else
                    return true
                end
            end,
            },
        },
        distance = 2.5
    })

    -- Nitrous Station
    exports["qb-target"]:AddBoxZone("nitrousstation", vector3(137.51, -3051.36, 7.04), 0.6, 0.65, {
        name = "nitrousstation",
        heading = 0,
        debugPoly = false,
        minZ = 6.04,
        maxZ = 7.19
    }, {
        options = {
            {
                type = "client",
                event = "craft:nitroustation", 
                icon = "fas fa-wine-bottle",
                label = "Nitrous Station",
                job = "tuner",
                canInteract = function()
                if not onDuty then
                    return false
                else
                    return true
                end
            end,
            },
        },
        distance = 2.5
    })
end)