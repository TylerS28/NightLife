Config = Config or {}




--[[ WEBHOOKS ]]--
Config.ScreenshotWebhook = ""

Config.EmploymentWebhook = ""

Config.TwatWebhook = ""

Config.MessageWebhook = ""

Config.YellowPageWebhook = ""

Config.DocumentsWebhook = ""

Config.WenmoWebhook = ""

Config.MilkRoadWebhook = ""

Config.ThePMWebhook = ""

--[[ OTHER ]]--

Config.PuppetMasterCID = ""



--[[ FUNCTIONS ]]--
showTextUI = function(text)
    exports['srp-interface']:showInteraction(text)    
end

hideTextUI = function()
    exports['srp-interface']:hideInteraction()
end