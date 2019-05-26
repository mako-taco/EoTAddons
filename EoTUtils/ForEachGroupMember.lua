-- Iterates over group members and calls a function for each one.
--
-- Fn:  A function to run for each group member. This function will be passed two
--      arguments, the unit's name and the unit's englishClass. If the function 
--      returns `true`, iteration will stop.
function EOT_ForEachGroupMember(Fn)
    local prefix = UnitInRaid("player") ~= nil and "raid" or "party"
    local numGroupMembers = UnitInRaid("player") ~= nil and 40 or 5

    Fn(UnitName("player"), UnitClass("player"))

    for i = 1, numGroupMembers do
        local unit = prefix .. i
        local name = UnitName(unit)
        if name ~= nil and name ~= UnitName("player") then
            result = Fn(name, UnitClass(unit))
            if result == true then return end
        end
    end
end
