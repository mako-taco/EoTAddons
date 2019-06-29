function EOT_GodGroup(toggle)
  EOT_ForEachGroupMember(
    function (name)
      EOT_RunCommand("god", toggle, name)
    end
  )
end
