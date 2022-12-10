AddEventHandler("explosionEvent", function(sender, ev)
    TriggerClientEvent('srp-vaultrob:lower:vaultdoor', sender)
end)