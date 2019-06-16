-- level: 0-3, indicating how buff you wanna get (0 lowest, 3 highest)
-- targetClass: "WARRIOR", "MAGE", etc
-- offspec: passed through to GetRoleForClass
function EOT_GetBuffs(level, targetClass, offspec)
  local role = EOT_GetRoleForClass(
      targetClass,
      offspec
  )

  local allBuffs = EOT_MergeTables({}, EOT_Auras.buffs)
  
  if role == nil then
      EOT_Error("No reasonable offspec for " .. targetClass)
      return allBuffs
  end
  
  local possibleAuras = EOT_ClassRoleAuras[targetClass][role]

  if possibleAuras == nil then
      EOT_Error("No auras found for " .. targetClass .. " - " .. role)
      return allBuffs
  end

  local levels = {
      possibleAuras.trash, 
      possibleAuras.boss, 
      possibleAuras.flasked
  }

  for i=1,level + 1 do
      allBuffs = EOT_MergeITables(allBuffs, levels[i])
  end
  
  return allBuffs
end
