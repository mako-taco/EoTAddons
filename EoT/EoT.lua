EpochTools = LibStub("AceAddon-3.0"):NewAddon("EpochTools", "AceHook-3.0")

function EpochTools:OnInitialize()
  SLASH_EOT1 = "/eot";
  SlashCmdList["EOT"] = function (message)
    local parsed = EOT_ParseCommand(message)
    if parsed[1] == nil then
      EOT_Log("/eot")
      EOT_Log("  roster - creates a copyable list of the current raid members")
      EOT_Log("  donations - creates a copyable list of donations")
      EOT_Log("  parse - parses donations after you open your mailbox")
    elseif parsed[1] == "roster" then
      EOT_CopyRoster()
    elseif parsed[1] == "donations" then
      EOT_CopyDonations()
    elseif parsed[1] == "parse" then
      EOT_InsertDonations()
    else
      EOT_Error("No such command:", parsed[1])
    end
  end

  -- TODO: Possibly track when mail items have been looted here
  -- self:SecureHook("TakeInboxMoney")
  -- self:SecureHook("AutoLootMailItem")

  --  Automatically parse all mail items on mailbox open
  local frame = CreateFrame("Frame")
  frame:RegisterEvent("MAIL_INBOX_UPDATE")

  local function OnEvent(s, event, ...)
    if event == "MAIL_INBOX_UPDATE" then
      EOT_InsertDonations()
    end
  end

  frame:SetScript("OnEvent", OnEvent)

  -- TODO: Only set DB defaults in OnEnable() after we finish testing
  EpochTools.db:SetDefaults()

  EOT_Log("AddOn loaded. Type /eot for help.")
end

function EpochTools:OnEnable()
  if not EpochToolsDB then
    EpochTools.db:SetDefaults()
    EOT_Log("Epoch Tools database has been initialized.")
  end
end

function EpochTools:TakeInboxMoney(...)
  -- TODO: Add logic here later
end

function EpochTools:AutoLootMailItem(...)
  -- TODO: Add logic here later
end
