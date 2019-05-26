local eventlist = {
	"CHAT_MSG_SPELL_SELF_DAMAGE",
}

local function GetPatternsForPhysical(spell)
  return {
    filter = "^Your (" .. spell .. ") ",
    success = "^Your " .. spell .. " .+its .+ for %d+\.",
  }
end

local function GetPatternsForSpell(spell)
  return {
    resist = "^Your (" .. spell .. ") was resisted by ",
  }
end

local physicalPatterns = {
  kick = GetPatternsForPhysical("Kick"),
  mockingBlow = GetPatternsForPhysical("Mocking Blow"),
  shieldBash = GetPatternsForPhysical("Shield Bash"),
  pummel = GetPatternsForPhysical("Pummel"),
  blind = GetPatternsForPhysical("Blind"),
  kidneyShot = GetPatternsForPhysical("Kidney Shot"),
  cheapShot = GetPatternsForPhysical("Cheap Shot"),
}

local spellPatterns = {
  taunt = GetPatternsForSpell("Taunt"),
  growl = GetPatternsForSpell("Growl"),
}

local function GetMsgForPhysical(msg)
  for k,v in pairs(physicalPatterns) do
    local match, _, abillity = string.find(msg, v.filter)
    if match then
      if string.find(msg, v.success) then
        return abillity .. " hit!"
      else
        return abillity .. " missed!"
      end
    end
  end
  return nil
end

local function GetMsgForSpell(msg)
  for k,v in pairs(spellPatterns) do
    local match, _, abillity = string.find(msg, v.resist)
    if match then
      return abillity .. " resisted by %t!"
    end
  end
  return nil
end

local function HandleCombatEvent(event, msg)
  EOT_Log("Got combat event.")
  EOT_Log("  msg: " .. tostring(msg))
  local announcement = GetMsgForPhysical(msg) or GetMsgForSpell(msg)
  if announcement then 
    EOT_Say(announcement)
  end
end

EOT_Log("EoTAnnounce is on.")
local frame = CreateFrame("Frame")
frame:SetScript('OnEvent', function () HandleCombatEvent(event, arg1) end)
for _, event in pairs(eventlist) do
  frame:RegisterEvent(event)
end
