function EOT_CopyDonations()
  local donationText = ""

  -- Iterate over all donations currently in the DB
  for index, values in ipairs(EpochToolsDB.Donations) do
    if values.Sender then
      donationText = donationText .. values.Sender .. "\t" .. values.Date .. "\t" .. values.Description .. "\t" .. values.ItemValue .. "\n"
    end
  end

  -- Set editBox text to list of current donations
  EOT_CopyBox(donationText, true)
end
