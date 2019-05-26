function EOT_Error(msg)
  DEFAULT_CHAT_FRAME:AddMessage("|cffff0000EoTPTR Error: " .. msg)
end

function EOT_Log(msg)
  DEFAULT_CHAT_FRAME:AddMessage("|cff00ffffEoTPTR: " .. msg)
end

function EOT_Say(msg)
  SendChatMessage(msg, "SAY", nil, nil)
end