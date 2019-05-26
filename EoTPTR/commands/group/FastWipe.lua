function EOT_FastWipe()
    EOT_ForEachGroupMember(
        function (name)
            for i = 1, 3 do
                EOT_RunCommand("aura", "26053", name)
            end
            EOT_RunCommand("aura", "5024", name)
        end
    )
end