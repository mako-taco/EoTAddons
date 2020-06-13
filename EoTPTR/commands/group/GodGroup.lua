function EOT_GodGroup(toggle)
  EOT_ForEachGroupMember(
    function (name)
      EOT_RunCommand("cheat god", toggle, name)
    end
  )
end
