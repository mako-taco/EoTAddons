SLASH_PTR1 = "/ptr";
SlashCmdList["PTR"] = function (message)
  local parsed = EOT_ParseCommand(message)

  if parsed[1] == nil then
    EOT_Log("/ptr")
    EOT_Log("  buff - Buff the current target. Hold ctrl for offspec")
    EOT_Log("  wipe - Wipe your group quickly")
    EOT_Log("  res - Revive/reset health/mana of your group")
    EOT_Log("  gather - Ports your entire group to you")
    EOT_Log("  raidbuff - Buffs the entire group")
    EOT_Log("  phase - Unlearns skills from later phases")
  elseif parsed[1] == "buff" then
    if parsed[2] == nil then
      EOT_Log("/ptr buff")
      EOT_Log("  0 - Castable buffs only")
      EOT_Log("  1 - Trash consumes")
      EOT_Log("  2 - Boss consumes")
      EOT_Log("  3 - Boss consumes + flasks")
    else
      EOT_BuffTarget(tonumber(parsed[2]))
    end
  elseif parsed[1] == "raidbuff" then
    if parsed[2] == nil then
      EOT_Log("/ptr raidbuff")
      EOT_Log("  0 - Castable buffs only")
      EOT_Log("  1 - Trash consumes")
      EOT_Log("  2 - Boss consumes")
      EOT_Log("  3 - Boss consumes + flasks")
    else
      EOT_BuffGroup(tonumber(parsed[2]))
    end
  elseif parsed[1] == "wipe" then
    EOT_WipeGroup() 
  elseif parsed[1] == "res" then
    EOT_ResGroup()
  elseif parsed[1] == "gather" then
    EOT_GatherGroup()
  elseif parsed[1] == "repair" then
    EOT_RepairGroup()
  elseif parsed[1] == "phase" then
    EOT_SetPhaseTarget(tonumber(parsed[2]))
  end
end

EOT_Log("AddOn loaded. Type /ptr for help.")