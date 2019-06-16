function EOT_ResGroup()
    EOT_ForEachGroupMember(
        function (name)
            EOT_RunCommand("revive", name)
            EOT_RunCommand("reset", "stats", name)
        end
    )
end
