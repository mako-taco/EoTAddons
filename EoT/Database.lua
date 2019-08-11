EpochTools.db = EpochTools:NewModule("DB")

function EpochTools.db:SetDefaults()
  EpochToolsDB = {
    Donations = { }, 
    Prices = { }, 
    char = {
      altDel = false,
      ctrlRet = true,
      shiftTake = true,
      takeAll = true,
      inboxUI = true,
      takeStackable = true,
      sortField = 1,
    },
    profile = {
      disableTooltips = false,
      scale = 1.0, 
      font = "Friz Quadrata TT",
      fontSize = 12
    },
  }

  -- Set Spreadsheet Headers
  local donation =  {
    Sender = "Sender",
    Date = "Date", 
    Description = "Description",
    ItemValue = "Value"
  }

  -- Set Elixir of the Mongoose for testing
  local price = {
    id = 13452,
    name = "Elixir of the Mongoose",
    gold = 2.5,
    date = 1565256633
  }
  
  table.insert(EpochToolsDB.Donations, donation)
  table.insert(EpochToolsDB.Prices, price)
end
