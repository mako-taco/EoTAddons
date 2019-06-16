function EOT_GatherGroup()
  EOT_ForEachGroupMember(
    function (name)
      EOT_RunCommand("namego", name)
    end
  )
end
