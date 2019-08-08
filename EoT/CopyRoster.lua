function EOT_CopyRoster()
  -- Iterate over raid roster and concatenate to raidRoster string
  local raidRoster = ""

  EOT_ForEachGroupMember(
    function (name)
      raidRoster = raidRoster .. name .. "\n"
    end
  )

  -- Set editBox text to raidRoster string
  EOT_CopyBox(raidRoster, true)
end
