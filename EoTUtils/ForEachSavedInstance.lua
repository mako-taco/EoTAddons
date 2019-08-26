function EOT_ForEachSavedInstance(Fn)
  local numSavedInstances = GetNumSavedInstances()
  for i = 1, numSavedInstances do
    local instance, raidId = GetSavedInstanceInfo(i)
    if Fn(instance, raidId) then
      return
    end
  end
end
