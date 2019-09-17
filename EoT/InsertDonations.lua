function EOT_InsertDonations()
  -- Iterate over all mail items
  for currentInboxIndex = 1, GetInboxNumItems() do
    local donationSender, donationDate, donationDescription, donationItemValue
    local _, _, sender, subject, money, CODAmount, daysLeft,
          hasItem, wasRead = GetInboxHeaderInfo(currentInboxIndex)

    -- Make sure mail item is unread and not COD, add subject line parsing here later
    if(wasRead == false and CODAmount == 0) then
      -- Log current date and mail sender
      donationSender = sender
      donationDate = date("%m/%d/%Y")

      -- If the donation has at least one item, parse that first
      if hasItem then
        -- Iterate over all attached items of mail item
        for currentAttachIndex = 1, ATTACHMENTS_MAX_RECEIVE do
          local name, itemID, texture, count = GetInboxItem(currentInboxIndex, currentAttachIndex)
          if name then
            local donationItemValue = tonumber(TSM_API.GetCustomPriceValue("dbmarket", "i:" .. itemID)) * count

            local donation = {
              Sender = donationSender,
              Date = donationDate, 
              Description = count .. "x" .. name,
              ItemValue = donationItemValue
            }

            -- Insert gold donation info into DB
            table.insert(EpochToolsDB.Donations, donation)

            -- TODO: Actually take donated items
            -- TakeInboxItem(currentInboxIndex, currentAttachIndex)
          end
        end
      end

      -- If the donation has money attached, parse that next
      if money > 0 then
        -- All money is stored as copper, so convert to gold
        local gold = money * 0.0001  
        local donation =  {
          Sender = donationSender,
          Date = donationDate, 
          Description = gold .. "g",
          ItemValue = gold
        }

        -- Insert gold donation info into DB
        table.insert(EpochToolsDB.Donations, donation)
        
        -- TODO: Actually take donated money
        -- TakeInboxMoney(currentInboxIndex)
      end
    end
  end
end
