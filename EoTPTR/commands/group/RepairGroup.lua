function EOT_RepairGroup()
  EOT_ForEachGroupMember(
    function (name)
      EOT_RunCommand("repair", name)
    end
  )
end
