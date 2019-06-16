function EOT_BuffGroup()
  EOT_ForEachGroupMember(
    function (name, class)
      BuffName(name, class)
    end
  )
end

local function BuffName(name, class)
  DoBuffs(
    name,
    EOT_GetAuras(
      level, 
      class,
      false
    )
  )
end

local function DoBuffs(name, buffs)
  for k,v in pairs(buffs) do
    EOT_RunCommand("nameaura", v, name)
  end
end