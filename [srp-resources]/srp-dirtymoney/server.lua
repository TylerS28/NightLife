RegisterServerEvent("srp-dirtymoney:attemptDirtyMoneyDrops")
AddEventHandler("srp-dirtymoney:attemptDirtyMoneyDrops", function()
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local DirtyMoney = user:getDirtyMoney()

	if DirtyMoney > 500 then
		TriggerClientEvent("srp-dirtymoney:attemptDirtyMoneyDrops",source)
		DirtyMoney = DirtyMoney - 500
		user:alterDirtyMoney(DirtyMoney)

		TriggerClientEvent('UPV',src,500)
	else
		TriggerClientEvent("DoLongHudText",source,"You need $500 in Marked Bills.",2)
	end

end)

RegisterServerEvent("srp-dirtymoney:alterDirtyMoney")
AddEventHandler("srp-dirtymoney:alterDirtyMoney", function(reason, amount)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	local DirtyMoney = user:getDirtyMoney()

	if reason == "ItemDrop" then
		TriggerClientEvent("srp-dirtymoney:attemptDirtyMoneyDrops",source)
		DirtyMoney = DirtyMoney - amount
		user:alterDirtyMoney(DirtyMoney)

		TriggerClientEvent('UPV',src,amount)
	else
		DirtyMoney = DirtyMoney + amount
		user:alterDirtyMoney(DirtyMoney)
	end

end)

RegisterServerEvent("srp-dirtymoney:moneyPickup")
AddEventHandler("srp-dirtymoney:moneyPickup", function(amount)
	local src = source
	local user = exports["srp-fw"]:getModule("Player"):GetUser(src)
	user:addMoney((amount))
end)