local function DoBuffs(name, buffs)
  for k,v in pairs(buffs) do
    EOT_RunCommand("nameaura", v, name)
  end
end

local function BuffName(level, name, class)
  DoBuffs(
    name,
    EOT_GetBuffs(
      level, 
      class,
      false
    )
  )
end

function EOT_BuffGroup(level)
  EOT_ForEachGroupMember(
    function (name, class)
      BuffName(level, name, class)
    end
  )
end

function EOT_AuraGroup(aura)
  EOT_ForEachGroupMember(
    function (name)
      DoBuffs(name, {aura = aura})
    end
  )
end