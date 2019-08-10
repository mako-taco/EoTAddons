EpochTools.db = EpochTools:NewModule("DB")

function EpochTools.db:SetDefaults()
  EpochToolsDB = {
    Donations = { }, 
    Prices = { } 
  }

  -- Set Spreadsheet Headers
  local donation =  {
    Sender = "Sender",
    Date = "Date", 
    Description = "Description",
    ItemValue = "Value"
  }

  -- Set Minor Health Potion for testing
  local price = {
    ItemID = 118,
    ItemValue = "30"
  }
  
  table.insert(EpochToolsDB.Donations, donation)
  table.insert(EpochToolsDB.Prices, price)
end
