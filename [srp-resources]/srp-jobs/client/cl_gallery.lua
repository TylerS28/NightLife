RegisterNetEvent('gallery-menu')
AddEventHandler('gallery-menu', function()
    local isEmployed = exports["srp-business"]:IsEmployedAt("gallery")
    if isEmployed then
        local AGGem = {
            {
                title = "Mined Items",
                icon = "hard-hat"
            },
            {
                title = "Sell Diamond Gem",
                description = "D",
                icon = "gem",
                action = 'gallery_diamond',
            },
            {
                title = "Sell Aquamarine Gem",
                description = "A",
                icon = "gem",
                action = 'gallery_aquamarine',
            },
            {
                title = "Sell Jade Gem",
                description = "J",
                icon = "gem",
                action = 'gallery_jade',
            },
            {
                title = "Sell Citrine Gem",
                description = "C",
                icon = "gem",
                action = 'gallery_citrine',
            },
            {
                title = "Sell Garnet Gem",
                description = "G",
                icon = "gem",
                action = 'gallery_garnet',
            },
            {
                title = "Sell Opal Gem",
                description = "O",
                icon = "gem",
                action = 'gallery_opal',
            },
            {
                title = "Sell Ruby",
                description = "Ruby",
                icon = "gem",
                action = 'gallery_ruby',
            },
            {
                title = "Sell Starry Night",
                description = "Starry Night",
                icon = "paint-roller",
                action = 'gallery_night',
            },
            {
                title = "Sell Art",
                description = "Art",
                icon = "gem",
                action = 'gallery_art',
            },
            {
                title = "Sell Golden Coin",
                description = "Coin",
                icon = "coins",
                action = 'gallery_coin',
            },
            {
                title = "Sell Valuable Goods",
                description = "VG",
                icon = "coins",
                action = 'gallery_vg',
            },
            {
                title = "Sell Gold Bars",
                description = "GB",
                icon = "coins",
                action = 'gallery_gb',
            },
            {
                title = "Sell Rolex Watch",
                description = "RW",
                icon = "clock",
                action = 'gallery_rw',
            },
            {
                title = "Sell 8ct Chains",
                description = "8ct",
                icon = "link",
                action = 'gallery_8ct',
            },
        }
        exports["srp-interface"]:showContextMenu(AGGem)
    end
end)

RegisterInterfaceCallback('gallery_diamond', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('srp-jobs:gellery_sell_diamonds')
end)

RegisterInterfaceCallback('gallery_aquamarine', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('srp-jobs:gellery_sell_aquamarine')
end)

RegisterInterfaceCallback('gallery_jade', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('srp-jobs:gellery_sell_jade')
end)

RegisterInterfaceCallback('gallery_citrine', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('srp-jobs:gellery_sell_citrine')
end)

RegisterInterfaceCallback('gallery_garnet', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('srp-jobs:gellery_sell_garnet')
end)

RegisterInterfaceCallback('gallery_opal', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('srp-jobs:gellery_sell_opal')
end)

RegisterInterfaceCallback('gallery_ruby', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('srp-jobs:gellery_sell_ruby')
end)

RegisterInterfaceCallback('gallery_night', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('srp-jobs:gellery_sell_night')
end)

RegisterInterfaceCallback('gallery_art', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('srp-jobs:gellery_sell_stolen_art')
end)

RegisterInterfaceCallback('gallery_coin', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('srp-jobs:gallery_sell_gold_coins')
end)

RegisterInterfaceCallback('gallery_vg', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('srp-jobs:gallery_sell_val_goods')
end)

RegisterInterfaceCallback('gallery_gb', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('srp-jobs:gallery_sell_gold_bars')
end)

RegisterInterfaceCallback('gallery_rw', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('srp-jobs:gallery_sell_rolex_watch')
end)

RegisterInterfaceCallback('gallery_8ct', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('srp-jobs:gallery_sell_8ct_chains')
end)

 --Sales

 --Mining Gem

RegisterNetEvent('srp-jobs:gellery_sell_diamonds')
AddEventHandler('srp-jobs:gellery_sell_diamonds', function()
    exports['srp-interface']:openApplication('textbox', {
        callbackUrl = 'srp-jobs:galleryGem',
        key = 1,
        items = {
          {
            icon = "gem",
            label = "How Many Gems.",
            name = "pGemAmount",
          },
        },
        show = true,
      })
end)

RegisterInterfaceCallback('srp-jobs:galleryGem', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
        local GemAmount = data.values.pGemAmount
        if exports['srp-inventory']:hasEnoughOfItem('mineddiamond', GemAmount) then
        FreezeEntityPosition(PlayerPedId(), true)
         local finished = exports['srp-taskbar']:taskBar(2000*GemAmount, 'Selling Diamond Gems')
         if finished == 100 then
            if exports['srp-inventory']:hasEnoughOfItem('mineddiamond', GemAmount) then
                TriggerEvent('inventory:removeItem', 'mineddiamond', GemAmount)
                TriggerServerEvent('srp-financials:business_money', 200*GemAmount, 'gallery', 'add') 
                FreezeEntityPosition(PlayerPedId(), false)
            end
         else
             FreezeEntityPosition(PlayerPedId(), false)
             TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
         end
    end
end)

 --Mining Stone

RegisterNetEvent('srp-jobs:gellery_sell_aquamarine')
AddEventHandler('srp-jobs:gellery_sell_aquamarine', function()
    exports['srp-interface']:openApplication('textbox', {
        callbackUrl = 'srp-jobs:galleryStone',
        key = 1,
        items = {
          {
            icon = "gem",
            label = "How Many Stones.",
            name = "pAquaAmount",
          },
        },
        show = true,
      })
end)

RegisterInterfaceCallback('srp-jobs:galleryStone', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local pAquaAmt = data.values.pAquaAmount

    if exports['srp-inventory']:hasEnoughOfItem('minedaquamarine', pAquaAmt) then
        FreezeEntityPosition(PlayerPedId(), true)
         local finished = exports['srp-taskbar']:taskBar(250*pAquaAmt, 'Selling Aquamarine')
         if finished == 100 then
            if exports['srp-inventory']:hasEnoughOfItem('minedaquamarine', pAquaAmt) then
                TriggerEvent('inventory:removeItem', 'minedaquamarine', pAquaAmt)
                TriggerServerEvent('srp-financials:business_money', 555*pAquaAmt, 'gallery', 'add')
                FreezeEntityPosition(PlayerPedId(), false)
            end
         else
             FreezeEntityPosition(PlayerPedId(), false)
             TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
         end
    end
end)

 --Mining Jade

RegisterNetEvent('srp-jobs:gellery_sell_jade')
AddEventHandler('srp-jobs:gellery_sell_jade', function()
    exports['srp-interface']:openApplication('textbox', {
        callbackUrl = 'srp-jobs:galleryJade',
        key = 1,
        items = {
          {
            icon = "gem",
            label = "How Many Jade\'s.",
            name = "pJadeAmount",
          },
        },
        show = true,
      })
end)

RegisterInterfaceCallback('srp-jobs:galleryJade', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local pJadeAmt = data.values.pJadeAmount

    if exports['srp-inventory']:hasEnoughOfItem('minedjade', pJadeAmt) then
        FreezeEntityPosition(PlayerPedId(), true)
         local finished = exports['srp-taskbar']:taskBar(2000*pJadeAmt, 'Selling Mined Jade')
         if finished == 100 then
            if exports['srp-inventory']:hasEnoughOfItem('minedjade', pJadeAmt) then
                TriggerEvent('inventory:removeItem', 'minedjade', pJadeAmt)
                TriggerServerEvent('srp-financials:business_money', 877*pJadeAmt, 'gallery', 'add') 
                FreezeEntityPosition(PlayerPedId(), false)
            end
         else
             FreezeEntityPosition(PlayerPedId(), false)
             TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
         end
    end
end)

 --Mining Citrine

RegisterNetEvent('srp-jobs:gellery_sell_citrine')
AddEventHandler('srp-jobs:gellery_sell_citrine', function()
    exports['srp-interface']:openApplication('textbox', {
        callbackUrl = 'srp-jobs:galleryCitrine',
        key = 1,
        items = {
          {
            icon = "gem",
            label = "How Many Citrine.",
            name = "pCitrineAmount",
          },
        },
        show = true,
      })
end)

RegisterInterfaceCallback('srp-jobs:galleryCitrine', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local pCitrineAmt = data.values.pCitrineAmount
    if exports['srp-inventory']:hasEnoughOfItem('minedcitrine', pCitrineAmt) then
        FreezeEntityPosition(PlayerPedId(), true)
         local finished = exports['srp-taskbar']:taskBar(2500*pCitrineAmt, 'Selling Citrine')
         if finished == 100 then
            if exports['srp-inventory']:hasEnoughOfItem('minedcitrine', pCitrineAmt) then
                TriggerEvent('inventory:removeItem', 'minedcitrine', pCitrineAmt)
                TriggerServerEvent('srp-financials:business_money', 1925*pCitrineAmt, 'gallery', 'add') 
                FreezeEntityPosition(PlayerPedId(), false)
            end
         else
             FreezeEntityPosition(PlayerPedId(), false)
             TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
         end
    end
end)

 --Mining Garnet

RegisterNetEvent('srp-jobs:gellery_sell_garnet')
AddEventHandler('srp-jobs:gellery_sell_garnet', function()
    exports['srp-interface']:openApplication('textbox', {
        callbackUrl = 'srp-jobs:galleryGarnet',
        key = 1,
        items = {
          {
            icon = "gem",
            label = "How Many Garnet.",
            name = "pGarnetAmount",
          },
        },
        show = true,
      })
end)

RegisterInterfaceCallback('srp-jobs:galleryGarnet', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local pGarnetAmt = data.values.pGarnetAmount
        if exports['srp-inventory']:hasEnoughOfItem('minedgarnet', pGarnetAmt) then
        FreezeEntityPosition(PlayerPedId(), true)
         local finished = exports['srp-taskbar']:taskBar(2000*pGarnetAmt, 'Selling Garnet')
         if finished == 100 then
            if exports['srp-inventory']:hasEnoughOfItem('minedgarnet', pGarnetAmt) then
                TriggerEvent('inventory:removeItem', 'minedgarnet', pGarnetAmt)
                TriggerServerEvent('srp-financials:business_money', 1650*pGarnetAmt, 'gallery', 'add') 
                FreezeEntityPosition(PlayerPedId(), false)
             else
                 FreezeEntityPosition(PlayerPedId(), false)
                 TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
             end
        end
    end
end)

-- Mining Opal

RegisterNetEvent('srp-jobs:gellery_sell_opal')
AddEventHandler('srp-jobs:gellery_sell_opal', function()
    exports['srp-interface']:openApplication('textbox', {
        callbackUrl = 'srp-jobs:galleryOpal',
        key = 1,
        items = {
          {
            icon = "gem",
            label = "How Many Opal.",
            name = "pOpalAmount",
          },
        },
        show = true,
      })
end)

RegisterInterfaceCallback('srp-jobs:galleryOpal', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local pOpalAmt = data.values.pOpalAmount
        if exports['srp-inventory']:hasEnoughOfItem('minedopal', pOpalAmt) then
        FreezeEntityPosition(PlayerPedId(), true)
        local finished = exports['srp-taskbar']:taskBar(2000*pOpalAmt, 'Selling Opal')
        if finished == 100 then
            if exports['srp-inventory']:hasEnoughOfItem('minedopal', pOpalAmt) then
                TriggerEvent('inventory:removeItem', 'minedopal', pOpalAmt)
                TriggerServerEvent('srp-financials:business_money', 580*pOpalAmt, 'gallery', 'add') 
                FreezeEntityPosition(PlayerPedId(), false)
            end
        else
            FreezeEntityPosition(PlayerPedId(), false)
            TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
        end
    end
end)

 --Stolen Art

RegisterNetEvent('srp-jobs:gellery_sell_stolen_art')
AddEventHandler('srp-jobs:gellery_sell_stolen_art', function()
    exports['srp-interface']:openApplication('textbox', {
        callbackUrl = 'srp-jobs:galleryArt',
        key = 1,
        items = {
          {
            icon = "gem",
            label = "How Many Art Pieces.",
            name = "pArtAmount",
          },
        },
        show = true,
      })
end)

RegisterInterfaceCallback('srp-jobs:galleryArt', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local pArtAmt = data.values.pArtAmount
        if exports['srp-inventory']:hasEnoughOfItem('stolenart', pArtAmt) then
        FreezeEntityPosition(PlayerPedId(), true)
         local finished = exports['srp-taskbar']:taskBar(2000*pArtAmt, 'Selling Art Pieces')
         if finished == 100 then
            if exports['srp-inventory']:hasEnoughOfItem('stolenart', pArtAmt) then
                TriggerEvent('inventory:removeItem', 'stolenart', pArtAmt)
                TriggerServerEvent('srp-financials:business_money', 1500*pArtAmt, 'gallery', 'add') 
                FreezeEntityPosition(PlayerPedId(), false)
            end
         else
             FreezeEntityPosition(PlayerPedId(), false)
             TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
         end
    end
end)

 --Golden Coins

RegisterNetEvent('srp-jobs:gallery_sell_gold_coins')
AddEventHandler('srp-jobs:gallery_sell_gold_coins', function()
    exports['srp-interface']:openApplication('textbox', {
        callbackUrl = 'srp-jobs:galleryGoldcoin',
        key = 1,
        items = {
          {
            icon = "gem",
            label = "How Many Gold Coin\'s.",
            name = "pGoldCoinAmount",
          },
        },
        show = true,
      })
end)

RegisterInterfaceCallback('srp-jobs:galleryGoldcoin', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local pGoldCointAmt = data.values.pGoldCoinAmount
        if exports['srp-inventory']:hasEnoughOfItem('goldcoin', pGoldCointAmt) then
        FreezeEntityPosition(PlayerPedId(), true)
         local finished = exports['srp-taskbar']:taskBar(2000*pGoldCointAmt, 'Selling Golden Coins')
         if finished == 100 then
            if exports['srp-inventory']:hasEnoughOfItem('goldcoin', pGoldCointAmt) then
                TriggerEvent('inventory:removeItem', 'goldcoin', pGoldCointAmt)
                TriggerServerEvent('srp-financials:business_money', 85*pGoldCointAmt, 'gallery', 'add') 
                FreezeEntityPosition(PlayerPedId(), false)
            end
         else
             FreezeEntityPosition(PlayerPedId(), false)
             TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
         end
    end
end)

 --Valuable Goods

RegisterNetEvent('srp-jobs:gallery_sell_val_goods')
AddEventHandler('srp-jobs:gallery_sell_val_goods', function()
    exports['srp-interface']:openApplication('textbox', {
        callbackUrl = 'srp-jobs:galleryVG',
        key = 1,
        items = {
          {
            icon = "gem",
            label = "How Many Valuable Good\'s.",
            name = "pVGAmount",
          },
        },
        show = true,
      })
end)

RegisterInterfaceCallback('srp-jobs:galleryVG', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local pVGAmt = data.values.pVGAmount
        if exports['srp-inventory']:hasEnoughOfItem('valuablegoods', pVGAmt) then
        FreezeEntityPosition(PlayerPedId(), true)
         local finished = exports['srp-taskbar']:taskBar(2000*pVGAmt, 'Selling Valuable Goods')
         if finished == 100 then
            if exports['srp-inventory']:hasEnoughOfItem('valuablegoods', pVGAmt) then
                TriggerEvent('inventory:removeItem', 'valuablegoods', pVGAmt)
                TriggerServerEvent('srp-financials:business_money', 352*pVGAmt, 'gallery', 'add') 
                FreezeEntityPosition(PlayerPedId(), false)
             else
                 FreezeEntityPosition(PlayerPedId(), false)
                 TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
             end
        end
    end 
end)

 --Golden Bars

RegisterNetEvent('srp-jobs:gallery_sell_gold_bars')
AddEventHandler('srp-jobs:gallery_sell_gold_bars', function()
    exports['srp-interface']:openApplication('textbox', {
        callbackUrl = 'srp-jobs:galleryGoldBar',
        key = 1,
        items = {
          {
            icon = "gem",
            label = "How Many Gold Bar\'s.",
            name = "pGoldAmount",
          },
        },
        show = true,
      })
end)

RegisterInterfaceCallback('srp-jobs:galleryGoldBar', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local pGoldAmt = data.values.pGoldAmount
    if exports['srp-inventory']:hasEnoughOfItem('goldbar', pGoldAmt) then
        FreezeEntityPosition(PlayerPedId(), true)
         local finished = exports['srp-taskbar']:taskBar(2000*pGoldAmt, 'Selling Valuable Goods')
         if finished == 100 then
            if exports['srp-inventory']:hasEnoughOfItem('goldbar', pGoldAmt) then
                TriggerEvent('inventory:removeItem', 'goldbar', pGoldAmt)
                TriggerServerEvent('srp-financials:business_money', 2000*pGoldAmt, 'gallery', 'add') 
                FreezeEntityPosition(PlayerPedId(), false)
             else
                 FreezeEntityPosition(PlayerPedId(), false)
                 TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
             end
        end
    end
end)

 --Rolex Watch

RegisterNetEvent('srp-jobs:gallery_sell_rolex_watch')
AddEventHandler('srp-jobs:gallery_sell_rolex_watch', function()
    exports['srp-interface']:openApplication('textbox', {
        callbackUrl = 'srp-jobs:galleryRolexWatch',
        key = 1,
        items = {
          {
            icon = "gem",
            label = "How Many Rolex Watch\'s.",
            name = "pRolexAmount",
          },
        },
        show = true,
      })
end)

RegisterInterfaceCallback('srp-jobs:galleryRolexWatch', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local pRolexAmt = data.values.pRolexAmount
    if exports['srp-inventory']:hasEnoughOfItem('rolexwatch', pRolexAmt) then
        FreezeEntityPosition(PlayerPedId(), true)
         local finished = exports['srp-taskbar']:taskBar(2000*pRolexAmt, 'Selling Rolex Watche\'s')
         if finished == 100 then
            if exports['srp-inventory']:hasEnoughOfItem('rolexwatch', pRolexAmt) then
                TriggerEvent('inventory:removeItem', 'rolexwatch', pRolexAmt)
                TriggerServerEvent('srp-financials:business_money', 114*pRolexAmt, 'gallery', 'add') 
                FreezeEntityPosition(PlayerPedId(), false)
            end
         else
             FreezeEntityPosition(PlayerPedId(), false)
             TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
         end
    end
end)

 --8CT Chains

RegisterNetEvent('srp-jobs:gallery_sell_8ct_chains')
AddEventHandler('srp-jobs:gallery_sell_8ct_chains', function()
    exports['srp-interface']:openApplication('textbox', {
        callbackUrl = 'srp-jobs:gallery8Ct',
        key = 1,
        items = {
          {
            icon = "gem",
            label = "How Many 8 CT Chain\'s.",
            name = "p8ctAmount",
          },
        },
        show = true,
      })
end)

RegisterInterfaceCallback('srp-jobs:gallery8Ct', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local p8CTAmt = data.values.p8ctAmount
    if exports['srp-inventory']:hasEnoughOfItem('stolen8ctchain', p8CTAmt) then
        FreezeEntityPosition(PlayerPedId(), true)
         local finished = exports['srp-taskbar']:taskBar(2000*p8CTAmt, 'Selling Ruby\'s')
         if finished == 100 then
            if exports['srp-inventory']:hasEnoughOfItem('stolen8ctchain', p8CTAmt) then
                TriggerEvent('inventory:removeItem', 'stolen8ctchain', p8CTAmt)
                TriggerServerEvent('srp-financials:business_money', 25*p8CTAmt, 'gallery', 'add') 
                FreezeEntityPosition(PlayerPedId(), false)
            end
         else
             FreezeEntityPosition(PlayerPedId(), false)
             TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
         end
    end
end)

 --Ruby

 --Mining Ruby

RegisterNetEvent('srp-jobs:gellery_sell_ruby')
AddEventHandler('srp-jobs:gellery_sell_ruby', function()
    exports['srp-interface']:openApplication('textbox', {
        callbackUrl = 'srp-jobs:galleryRuby',
        key = 1,
        items = {
          {
            icon = "gem",
            label = "How Many Ruby\'s.",
            name = "pRubyAmount",
          },
        },
        show = true,
      })
end)

RegisterInterfaceCallback('srp-jobs:galleryRuby', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local pRubyAmt = data.values.pRubyAmount
    if exports['srp-inventory']:hasEnoughOfItem('miningruby', pRubyAmt) then
        FreezeEntityPosition(PlayerPedId(), true)
         local finished = exports['srp-taskbar']:taskBar(2000*pRubyAmt, 'Selling Ruby\'s')
         if finished == 100 then
            if exports['srp-inventory']:hasEnoughOfItem('miningruby', pRubyAmt) then
                TriggerEvent('inventory:removeItem', 'miningruby', pRubyAmt)
                TriggerServerEvent('srp-financials:business_money', 100*pRubyAmt, 'gallery', 'add') 
                FreezeEntityPosition(PlayerPedId(), false)
            end
         else
             FreezeEntityPosition(PlayerPedId(), false)
             TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
         end
    end
end)

 --Starry Night

RegisterNetEvent('srp-jobs:gellery_sell_night')
AddEventHandler('srp-jobs:gellery_sell_night', function()
    exports['srp-interface']:openApplication('textbox', {
        callbackUrl = 'srp-jobs:galleryNight',
        key = 1,
        items = {
          {
            icon = "gem",
            label = "How Many Starry Night\'s.",
            name = "pStarryAmount",
          },
        },
        show = true,
      })
end)

RegisterInterfaceCallback('srp-jobs:galleryNight', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    local pStarryAmt = data.values.pStarryAmount 
    if exports['srp-inventory']:hasEnoughOfItem('starrynight', pStarryAmt) then
        FreezeEntityPosition(PlayerPedId(), true)
         local finished = exports['srp-taskbar']:taskBar(2000*pStarryAmt, 'Selling Starry Night')
         if finished == 100 then
            if exports['srp-inventory']:hasEnoughOfItem('starrynight', pStarryAmt) then
                TriggerEvent('inventory:removeItem', 'starrynight', pStarryAmt)
                TriggerServerEvent('srp-financials:business_money', 550*pStarryAmt, 'gallery', 'add') 
                FreezeEntityPosition(PlayerPedId(), false)
             else
                 FreezeEntityPosition(PlayerPedId(), false)
                 TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
             end
        end
    end
end)

 --// Eye // 

exports["srp-polytarget"]:AddBoxZone("artgallerysell", vector3(-466.86, 46.12, 46.23), 1, 1, {
    heading=43,
})

exports["srp-interact"]:AddPeekEntryByPolyTarget("artgallerysell", {
    {
        event = "gallery-menu",
        id = "pTable3322233",
        icon = "circle",
        label = "Sell Gems",
        parameters = {},
    }
}, {
    distance = { radius = 2.5 },
});