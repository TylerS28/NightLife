
MenuData = {
  apartment_check = {
    {
      title = "Apartment",
      description = "Forclose Apartment",
      key = "judge",
      children = {
          { title = "Yes", action = "srp-apartments:handler", key = { forclose = true} },
          { title = "No", action = "srp-apartments:handler", key = { forclose = false } },
      }
    }
  }
}
