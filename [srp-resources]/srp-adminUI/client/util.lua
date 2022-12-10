function getJsonDataFromAdminBans()
    local imDoneNow = RPC.execute("srp-adminUI:getRecentBans")
    return imDoneNow
  end
  
  exports('getJsonDataFromAdminBans',getJsonDataFromAdminBans)
  