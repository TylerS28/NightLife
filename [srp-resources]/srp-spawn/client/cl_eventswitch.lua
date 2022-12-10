pRan = false

function Login.playerLoaded() end

function Login.characterLoaded()
  -- Main events leave alone 
  TriggerEvent("srp-fw:playerSpawned")
  TriggerEvent("playerSpawned")
  TriggerServerEvent('character:loadspawns')
  TriggerEvent("srp-fw:initialSpawnModelLoaded")
  -- Main events leave alone 

  -- Everything that should trigger on character load 
  TriggerServerEvent('checkTypes')
  TriggerServerEvent('isVip')
  TriggerEvent("fx:clear")
  TriggerServerEvent("raid_clothes:retrieve_tats")
  TriggerEvent('srp-bankrobbery:client:CreateTrollysEvent')
  TriggerServerEvent("currentconvictions")
  TriggerServerEvent("Evidence:checkDna")
  TriggerEvent("banking:viewBalance")
  TriggerServerEvent('srp-doors:requestlatest')
  TriggerServerEvent("item:UpdateItemWeight")
  TriggerServerEvent("ReturnHouseKeys")
  TriggerServerEvent("requestOffices")
  Wait(500)
  TriggerServerEvent("police:getAnimData")
  TriggerServerEvent("server:currentpasses")
  TriggerEvent("srp-hud:SetValues", exports['isPed']:isPed('cid'))
  TriggerServerEvent("police:getEmoteData")
  TriggerServerEvent("police:SetMeta")
  TriggerServerEvent('srp-scoreboard:AddPlayer')
  TriggerServerEvent("srp-fw:PolyZoneUpdate")
  TriggerEvent("srp-housing:loadHousingClient")
  TriggerEvent("srp-admin/client/loadMenu")
  TriggerServerEvent("srp-housing:getGarages")
  TriggerServerEvent("srp-phone:getAbdulTaxies")
  TriggerServerEvent("retreive:jail",exports["isPed"]:isPed("cid"))
  TriggerServerEvent("srp-phone:checkForNonDocumentedLicenses", exports['isPed']:isPed("cid"))
  -- TriggerServerEvent("weapon:general:check")
  -- Anything that might need to wait for the client to get information, do it here.
  TriggerServerEvent("login:get:keys")

  --Sync Whiteboards
  TriggerServerEvent("SpawnEventsServer")

  --Meth shit
  TriggerServerEvent('srp-methtable:spawnInitialized')

  
  -- // New Clothing Menu // --
  --TriggerServerEvent("srp_clothing:retrieve_tats")
  --TriggerServerEvent('srp_clothing:get_character_current')
  --TriggerServerEvent('srp_clothing:get_character_face')

  TriggerServerEvent("srp-weapons:getAmmo")
  Wait(4000)
  TriggerServerEvent("bank:getLogs")
  TriggerEvent('srp-hud:EnableHud', true)
end

RegisterNetEvent('srp-spawn:spawnCharacter')
AddEventHandler('srp-spawn:spawnCharacter', function()

  if not pRan then
    pRan = true
    isNear = false
    TriggerServerEvent('srp-fw:sv:player_control')
    TriggerServerEvent('srp-fw:sv:player_settings')
    TriggerEvent("spawning", false)
    TriggerEvent("attachWeapons")
    TriggerServerEvent("request-dropped-items")
    TriggerServerEvent("server-request-update", exports["isPed"]:isPed("cid"))

    if Spawn.isNew then
        Wait(1000)

        TriggerEvent('srp-hud:ChangeThirst', 95)
        TriggerEvent('srp-hud:ChangeHunger', 95)
        TriggerEvent('srp-hud:SaveValues')
        TriggerServerEvent('srp-spawn:initBoosting')
        -- TriggerServerEvent('srp-spawn:licenses')

        -- commands to make sure player is alive and full food/water/health/no injuries
        local src = GetPlayerServerId(PlayerId())
        TriggerServerEvent("reviveGranted", src)
        TriggerEvent("Hospital:HealInjuries", src, true)
        TriggerServerEvent("ems:healplayer", src)
        TriggerEvent("heal", src)
        TriggerEvent("status:needs:restore", src) 

        TriggerServerEvent("srp-spawn:newPlayerFullySpawned")
      end
  end
  SetPedMaxHealth(PlayerPedId(), 200)
  runGameplay()
  Spawn.isNew = false
end)