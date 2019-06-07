SLASH_PTR1 = "/ptr";
SlashCmdList["PTR"] = function (message)
  local parsed = EOT_ParseCommand(message)

  if parsed[1] == nil then
    EOT_Log("/ptr")
    EOT_Log("  buff - Buff the current target. Hold ctrl for offspec")
    EOT_Log("  wipe - Wipe your group quickly")
    EOT_Log("  res - Revive/reset health/mana of your group")
    EOT_Log("  gather - Ports your entire group to you")
  elseif parsed[1] == "buff" then
    if parsed[2] == nil then
      EOT_Log("/ptr buff")
      EOT_Log("  0 - Castable buffs only")
      EOT_Log("  1 - Trash consumes")
      EOT_Log("  2 - Boss consumes")
      EOT_Log("  3 - Boss consumes + flasks")
    else
      EOT_Log("Buffing @ level " .. parsed[2])
      EOT_BuffCurrentTarget(tonumber(parsed[2]))
    end
  elseif parsed[1] == "wipe" then
    EOT_FastWipe() 
  elseif parsed[1] == "res" then
    EOT_FullRes()
  elseif parsed[1] == "gather" then
    EOT_GroupUp()
  elseif parsed[1] == "phase" then
    EOT_Log("Setting phase for player to " .. parsed[2])
    EOT_SetPhase(tonumber(parsed[2]))
  end
end

EOT_Log("AddOn loaded. Type /ptr for help.")