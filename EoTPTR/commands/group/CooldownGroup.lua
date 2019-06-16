function EOT_CooldownGroup(spellId)
  EOT_ForEachGroupMember(
    function (name, class)
      EOT_RunCommand("cooldown", spellId, name)
    end
  )
end
