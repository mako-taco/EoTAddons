function EOT_GetRoleForClass(englishClass, offspec)
    local mainspec = not offspec
    if mainspec then
        if englishClass == "WARRIOR" then 
            return "DPS"
        elseif englishClass == "MAGE" then
            return "CDPS"
        elseif englishClass == "HUNTER" then
            return "DPS"
        elseif englishClass == "WARLOCK" then
            return "CDPS"    
        elseif englishClass == "ROGUE" then
            return "DPS"
        elseif englishClass == "DRUID" then
            return "HEALS"
        elseif englishClass == "SHAMAN" then
            return "HEALS"
        elseif englishClass == "PRIEST" then
            return "HEALS"        
        end
    end
    -- offspec
    if englishClass == "WARRIOR" then 
        return "TANK"
    elseif englishClass == "DRUID" then
        return "TANK"
    elseif englishClass == "SHAMAN" then
        return "CDPS"
    elseif englishClass == "PRIEST" then
        return "CDPS"        
    end
    
    return nil
end
