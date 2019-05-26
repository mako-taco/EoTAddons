function EOT_ParseCommand(message)
  local commandList = {}
	for command in string.gfind(message, "[^ ]+") do
		table.insert(commandList, string.lower(command))
  end
  return commandList
end