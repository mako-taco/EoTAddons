local function DoBuffs(buffs)
    for k,v in pairs(buffs) do
        EOT_RunCommand("aura", v)
    end
end

function EOT_BuffTarget(level)
    local _, targetClass = UnitClass("target")
    if targetClass == nil then
        _, targetClass = UnitClass("player")
    end
    
    DoBuffs(
        EOT_GetBuffs(
            level, 
            targetClass,
            IsControlKeyDown()
        )
    )
end
