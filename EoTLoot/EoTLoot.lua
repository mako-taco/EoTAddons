--[[
  TODO
  - UI indicating if recording is happening while in raid / how many are recording
  - Periodic check of raid members for attendance
    - Raid member activity?
  - Track loot
  - Periodically save?
  - Input a schedule to record raids
]]

EOT_Loot = {
  raids = {}
}

--

function EOT_GetRosterAttendanceSlice()
  local zoneText =  GetRealZoneText()
  local raidId = GetCurrentRaidId()
  
  if EOT_Loot.raids[raidId] == nil then
    EOT_Loot.raids[raidId] = {}
  end
  
  local lootRaid = EOT_Loot.raids[raidId]

  EOT_ForEachGroupMember(function (name)
    if lootRaid[name] == nil then
      lootRaid[name] = 0
    end

    lootRaid[name] = lootRaid[name] + 1
  end)
end

local function GetCurrentRaidId()
  SetMapToCurrentZone()  
end

local function 