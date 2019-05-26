function EOT_GroupUp()
    EOT_ForEachGroupMember(
        function (name)
            EOT_RunCommand("namego", name)
        end
    )
end
