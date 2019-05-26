function EOT_RunCommand(cmd, ...)
    local runString = "." .. cmd .. " " .. table.concat(arg, " ")
    if SendChatMessage ~= nil then
        SendChatMessage(runString, "WHISPER", nil, UnitName("player"))
    else
        print(runString)
    end
end
