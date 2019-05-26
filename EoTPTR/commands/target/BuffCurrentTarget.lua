-- level: 0-3, indicating how buff you wanna get (0 lowest, 3 highest)
-- targetClass: "WARRIOR", "MAGE", etc
-- offspec: passed through to GetRoleForClass
local function GetAuras(level, targetClass, offspec)
    local role = EOT_GetRoleForClass(
        targetClass,
        offspec
    )

    
    
    local allBuffs = EOT_MergeTables({}, EOT_Auras.buffs)
    
    if role == nil then
        EOT_Error("No reasonable offspec for " .. targetClass)
        return allBuffs
    end
    
    local possibleAuras = EOT_ClassRoleAuras[targetClass][role]

    if possibleAuras == nil then
        EOT_Error("No auras found for " .. targetClass .. " - " .. role)
        return allBuffs
    end

    local levels = {
        EOT_Auras.buffs,
        possibleAuras.trash, 
        possibleAuras.boss, 
        possibleAuras.flasked
    }

    for i=1,min(level + 1, table.getn(levels)) do
        allBuffs = EOT_MergeTables(allBuffs, levels[i])
    end
    
    return allBuffs
end

local function DoBuffs(buffs)
    for k,v in pairs(buffs) do
        EOT_RunCommand("aura", v)
    end
end

function EOT_BuffCurrentTarget(level)
    local _, targetClass = UnitClass("target")
    if targetClass == nil then
        _, targetClass = UnitClass("player")
    end
    
    EOT_RunCommand("repair")

    DoBuffs(
        GetAuras(
            level, 
            targetClass,
            IsShiftKeyDown()
        )
    )
end