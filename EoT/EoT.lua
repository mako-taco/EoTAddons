SLASH_EOT1 = "/eot";
SlashCmdList["EOT"] = function (message)
  local parsed = EOT_ParseCommand(message)
  if parsed[1] == nil then
    EOT_Log("/eot")
    EOT_Log("  roster - creates a copyable list of the current raid members")
    EOT_Log("  donations - accepts donations. only works near a mailbox")
  elseif parsed[1] == "roster" then
    EOT_CopyRoster()
  elseif parsed[1] == "donations" then
    EOT_Log("Not yet implemented.")
  else
    EOT_Error("No such command:", parsed[1])
  end
end

EOT_Log("AddOn loaded. Type /eot for help.")
