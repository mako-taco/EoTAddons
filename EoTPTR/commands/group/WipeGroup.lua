function EOT_WipeGroup()
  EOT_ForEachGroupMember(
    function (name)
      EOT_RunCommand("namedie", name)
    end
  )
end