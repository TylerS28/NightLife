RegisterInterfaceCallback("srp-ui:createBusiness", function(data, cb)
  local success, message = RPC.execute("CreateBusiness", data)
  cb({ data = {}, meta = { ok = success, message = message } })
end)

RegisterInterfaceCallback("srp-ui:getBusinessTypes", function(data, cb)
  local success, message = RPC.execute("GetBusinessTypes")
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

RegisterInterfaceCallback("srp-ui:getBusinesses", function(data, cb)
  local success, message = RPC.execute("GetBusinesses")
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

RegisterInterfaceCallback("srp-ui:getEmploymentInformation", function(data, cb)
  local success, message = RPC.execute("GetEmploymentInformation", data)
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

RegisterInterfaceCallback("srp-ui:getBusinessEmployees", function(data, cb)
  local success, message = RPC.execute("GetBusinessEmployees", data)
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

RegisterInterfaceCallback("srp-ui:getBusinessRoles", function(data, cb)
  local success, message = RPC.execute("GetBusinessRoles", data)
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

RegisterInterfaceCallback("srp-ui:createBusinessRole", function(data, cb)
  local success, message = RPC.execute("CreateBusinessRole", data)
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

RegisterInterfaceCallback("srp-ui:changeBusinessRole", function(data, cb)
  local success, message = RPC.execute("ChangeBusinessRole", data)
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

RegisterInterfaceCallback("srp-ui:hireBusinessEmployee", function(data, cb)
  local success, message = RPC.execute("HireBusinessEmployee", data)
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

RegisterInterfaceCallback("srp-ui:removeBusinessEmployee", function(data, cb)
  local success, message = RPC.execute("RemoveBusinessEmployee", data)
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

RegisterInterfaceCallback("srp-ui:businessPayEmployee", function(data, cb)
  local success, message = RPC.execute("BusinessPayEmployee", data)
  cb({ data = message or {}, meta = { ok = success, message = message or "Unknown Error; check account balance" } })
end)

RegisterInterfaceCallback("srp-ui:businessPayExternal", function(data, cb)
  local success, message = RPC.execute("BusinessPayExternal", data)
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

RegisterInterfaceCallback("srp-ui:businessChargeExternal", function(data, cb)
  RPC.execute("ChargeExternal", data)
  cb({ data = {}, meta = { ok = true, message = '' } })
end)
RegisterInterfaceCallback("srp-ui:businessChargeAccept", function(data, cb)
  local success, message = RPC.execute("BusinessChargeAccept", data)
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

--[[ RegisterNetEvent("business:chargeAcceptPrompt")
AddEventHandler("business:chargeAcceptPrompt", function(data)
  SendUIMessage({
    source = "srp-nui",
    app = "phone",
    data = {
      action = "charge-accept",
      data = data,
    },
  })
end) ]]
