EpochTools = LibStub("AceAddon-3.0"):NewAddon("EpochTools", "AceHook-3.0")

local mod = EpochTools
local eot = EpochTools

local QTIP   = LibStub("LibQTip-1.0")
local abacus = LibStub("LibAbacus-3.0")
local font, _, _ = CreateFont("EpochToolsInboxFont")
local fmt = string.format
local markTable = {}
local inboxCash = 0
local invFull = false

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
      openParsingFrame()
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
      openParsingFrame()
    end
  end

  frame:SetScript("OnEvent", OnEvent)

  -- TODO: Only set DB defaults in OnEnable() after we finish testing
  -- EpochTools.db:SetDefaults()

  EOT_Log("AddOn loaded. Type /eot for help.")
end

function EpochTools:OnEnable()
  if not EpochToolsDB then
    EpochTools.db:SetDefaults()
    EOT_Log("Epoch Tools database has been initialized.")
  end
end

function _addColspanCell(tooltip, text, colspan, func, arg, y)
   y = y or tooltip:AddLine()
   tooltip:SetCell(y, 1, text, tooltip:GetFont(), "LEFT", colspan)
   if func then
      tooltip:SetLineScript(y, "OnMouseUp", func, true)
   else
      tooltip:SetLineScript(y, "OnMouseUp", nil)
   end
   return y
end

function openParsingFrame()
  local tooltip = mod.inboxGUI
  if not tooltip then
    tooltip = QTIP:Acquire("EpochToolsInboxGUI")
    if tooltip.SetScrollStep then
      tooltip:SetScrollStep(100)
    end
    tooltip:EnableMouse(true)
    tooltip:SetScript("OnDragStart", tooltip.StartMoving)
    tooltip:SetScript("OnDragStop", function() tooltip.moved = true tooltip:StopMovingOrSizing() end)
    tooltip:RegisterForDrag("LeftButton")
    tooltip:SetMovable(true)
    tooltip:SetColumnLayout(7, "LEFT", "LEFT", "CENTER", "CENTER", "CENTER", "CENTER", "CENTER")
    EpochTools.inboxGUI = tooltip
    startPage = 0
  else
    tooltip:Clear()      
  end

  _createOrAttachSearchBar(tooltip)
  tooltip:SetFont(font)

  local markedColor = function(str, col)
    return color(str, col == mod.db.char.sortField and "ffff7f" or "ffd200")
  end
   
  _addHeaderAndNavigation(tooltip, 0)

  tooltip:AddLine(" ")

  local cells = mod.cells or {}
  wipe(cells)
  mod.cells = cells

  _addColspanCell(tooltip, color("Open Next", "ffd200"), 7, mod.OpenNextMailItem, mod)
  _addColspanCell(tooltip, color("Placeholder", "ffd200"), 7, mod.RefreshInboxGUI, mod)

  tooltip:SetFrameStrata("FULLSCREEN")
  -- set max height to be 80% of the screen height
  mod:AdjustSizeAndPosition(tooltip)

  tooltip:Show()
end

function color(text, color)
   return fmt("|cff%s%s|r", color, text or "")
end

function mod:RefreshInboxGUI(resetMoved)
  return
end


function mod:AdjustSizeAndPosition(tooltip)
   local scale = 1.0

   tooltip:SetScale(scale)
   if not tooltip.moved then
      -- this is needed to get the correct height for some reason.
      tooltip:ClearAllPoints()
      tooltip:SetPoint("TOP", UIParent, "TOP", 0, 0)
   end
   local barHeight = mod._toolbar:GetHeight()*scale
   local uiHeight = UIParent:GetHeight()
   tooltip:UpdateScrolling((uiHeight-barHeight+10)/scale)

   -- Only adjust point if user hasn't moved manually. This puts it lined up with the mail window
   -- or in the middle of the screen it's too large to fit from the top of the mail window and down
   if not tooltip.moved then
      local tipHeight = tooltip:GetHeight() * scale
      tooltip:ClearAllPoints()
      -- Calculate a good offset
      local offx = math.min((uiHeight - tipHeight - barHeight)/2, uiHeight + 12 - MailFrame:GetTop()*MailFrame:GetScale())+barHeight
      -- local offx = 0
      tooltip:SetPoint("TOPLEFT", UIParent, "TOPLEFT", MailFrame:GetRight()*MailFrame:GetScale()/scale, -offx/scale)
      -- tooltip:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 20, -20)
   end
end

function _openHelpTooltip(parentFrame, header, text)
  return
end


-- This adds the header info, and next prev buttons if needed
function _addHeaderAndNavigation(tooltip, totalRows, firstRow, lastRow)
  mod._toolbar.itemText:SetText(fmt("Inbox Items (%d mails, %s)", GetInboxNumItems(), abacus:FormatMoneyShort(1000)))
   
  mod.buttons.next:Disable()
  mod.buttons.prev:Disable()
   
   local sel = function(str, col)
      return color(str, col == 1 and "ffff7f" or "ffffff")
   end
   y = tooltip:AddLine("", sel("Placeholder columns", 1), sel("Qty.", 2), sel("Returnable", 3), sel("Sender", 4), sel("TTL", 5), sel("Mail #", 6))
   local setSortFieldFunc = function(obj, field)
      if 1 == field then
        mod.db.char.sortReversed = not mod.db.char.sortReversed and true or nil
      else
        mod.db.char.sortReversed = nil
        mod.db.char.sortField = field
      end
      self:RefreshInboxGUI()
   end
   for i = 1,6 do 
      tooltip:SetCellScript(y, i+1, "OnMouseUp", setSortFieldFunc, i)
   end
   tooltip:AddSeparator(2)
end

local function _addTooltipToFrame(frame, header, text)
   frame:SetScript("OnEnter", function(self) _openHelpTooltip(self, header, text) end)
   frame:SetScript("OnLeave", _closeHelpTooltip)
end

local function _createButton(title, parent, onclick, anchorTo, xoffset, tooltipHeader, tooltipText)
  local buttons = mod.buttons or {}
  mod.buttons = buttons
   
  local button = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
  button:SetText(title)
  button:SetWidth(80)
  button:SetHeight(20)
  button:SetScript("OnClick", onclick)
  buttons[title] = button
  button:SetPoint("RIGHT", anchorTo, "LEFT", xoffset, 0)
  _addTooltipToFrame(button, tooltipHeader, tooltipText)
  return button
end

function mod:OpenNextMailItem()
  local currentText = ""
  local donationSender, donationDate, donationDescription, donationItemValue
  local _, _, sender, subject, money, CODAmount, daysLeft,
        hasItem, wasRead = GetInboxHeaderInfo(1)
  local donation = {}

  -- Make sure mail item is unread and not COD, add subject line parsing here later
  -- if(wasRead == false and CODAmount == 0) then
  if(CODAmount == 0) then
    -- Log current date and mail sender
    donationSender = sender
    donationDate = date("%m/%d/%Y")

    -- If the donation has at least one item, parse that first
    if money > 0 then
      -- All money is stored as copper, so convert to gold
      local gold = money * 0.0001  
      moneyDonation =  {
        Sender = donationSender,
        Date = donationDate, 
        Description = gold .. "g",
        ItemValue = gold
      }

      -- Insert gold donation info into DB
      table.insert(EpochToolsDB.Donations, moneyDonation)
      currentText = EpochTools._donationContent:GetText()
      EpochTools._donationContent:SetText(
        currentText .. "\n"
        .. moneyDonation.Sender .. "\t"
        .. moneyDonation.Date .. "\t"
        .. moneyDonation.Description .. "\t"
        .. moneyDonation.ItemValue
      )

      TakeInboxMoney(1)
    else
      if hasItem then
        -- Iterate over all attached items of mail item
        local name, itemID, texture, count, currentAttachIndex

        for index = 1, ATTACHMENTS_MAX_RECEIVE do
          if not currentAttachIndex then
            name, itemID, texture, count = GetInboxItem(1, index)
            -- EOT_Log(index)
            if name then
              currentAttachIndex = index
            end
          end
        end

        if name then
          local donationItemValue = "N/A"
          
          -- TODO: Look up item value from Prices DB 
          -- for index, values in ipairs(EpochToolsDB.Prices) do 
          --   if values.itemID == itemID then
          --     donationItemValue = values.itemValue
          --   end
          -- end

          itemDonation = {
            Sender = donationSender,
            Date = donationDate, 
            Description = count .. "x" .. name,
            ItemValue = donationItemValue
          }

          -- Insert item donation info into DB
          table.insert(EpochToolsDB.Donations, itemDonation)
          currentText = EpochTools._donationContent:GetText()
          EpochTools._donationContent:SetText(
            currentText .. "\n"
            .. itemDonation.Sender .. "\t"
            .. itemDonation.Date .. "\t"
            .. itemDonation.Description .. "\t"
            .. itemDonation.ItemValue
          )

          TakeInboxItem(1, currentAttachIndex)
        end
      else
        TakeInboxTextItem(1)
      end
    end
  end
end

function mod:HideInboxGUI()
   mod:SmartCancelTimer('BMI_takeAll')
   mod:SmartCancelTimer('BMI_TakeNextItem')
   mod:SmartCancelTimer('BMI_RefreshInboxGUI')
   
   if mod._toolbar then
      mod._toolbar:Hide()
      mod._toolbar:SetParent(nil)
   end

   local tooltip = mod.inboxGUI
   if tooltip then
      mod.inboxGUI = nil
      tooltip:EnableMouse(false)
      tooltip:SetScript("OnDragStart", nil)
      tooltip:SetScript("OnDragStop", nil)
      tooltip:SetMovable(false)
      tooltip:RegisterForDrag()
      tooltip:SetFrameStrata("TOOLTIP")
      tooltip.moved = nil
      tooltip:SetScale(GameTooltip:GetScale())
      QTIP:Release(tooltip)
   end
   mod._wantGui = nil
end

function mod:SmartCancelTimer(name)
   mod.timers = mod.timers or {}
   if mod.timers[name] then
      mod:CancelTimer(mod.timers[name], true)
      mod.timers[name] = nil
   end
end

function _createOrAttachSearchBar(tooltip)
  local toolbar = mod._toolbar
  if not toolbar then
    toolbar = CreateFrame("Frame", nil, UIParent)
    toolbar:SetHeight(49)

    if donationFrame == nil then
      donationFrame = CreateFrame("Frame", nil, UIParent)
      donationFrame:SetHeight(300)

      donationContent = CreateFrame("EditBox", nil, donationFrame)
      donationContent:SetFontObject(GameFontWhite)
      donationContent:SetPoint("TOPLEFT", donationFrame, "TOPLEFT", 8, -8)
      donationContent:SetJustifyH("LEFT")
      donationContent:SetHeight(300)
      donationContent:SetMultiLine(true)
      donationContent:SetWidth(300)
      donationContent:EnableMouse(true)
      donationContent:SetAutoFocus(false)
      donationContent:SetText("Sender\tDate\tDescription\tValue")
      donationContent:SetScript("OnEscapePressed", donationContent.ClearFocus)
    end

    local closeButton =  CreateFrame("Button", "BulkMailInboxToolbarCloseButton", toolbar, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", toolbar, "TOPRIGHT", 0, 0)
    closeButton:SetScript("OnClick", function() mod:HideInboxGUI() end)
    _addTooltipToFrame(closeButton, "Close", "Close the window and stop taking items from the inbox.")
    
    local nextButton = CreateFrame("Button", nil, toolbar)
    nextButton:SetNormalTexture([[Interface\Buttons\UI-SpellbookIcon-NextPage-Up]])
    nextButton:SetPushedTexture([[Interface\Buttons\UI-SpellbookIcon-NextPage-Down]])
    nextButton:SetDisabledTexture([[Interface\Buttons\UI-SpellbookIcon-NextPage-Disabled]])
    nextButton:SetHighlightTexture([[Interface\Buttons\UI-Common-MouseHilight]], "ADD")
    nextButton:SetPoint("TOP", closeButton, "BOTTOM", 0, 9)
    nextButton:SetScript("OnClick", function() startPage = startPage + 1 mod:ShowInboxGUI() end)
    nextButton:SetWidth(25)
    nextButton:SetHeight(25)
    _addTooltipToFrame(nextButton, "Next Page", "Go to the next page of items.")
    
    local prevButton = CreateFrame("Button", nil, toolbar)
    prevButton:SetNormalTexture([[Interface\Buttons\UI-SpellbookIcon-PrevPage-Up]])
    prevButton:SetPushedTexture([[Interface\Buttons\UI-SpellbookIcon-PrevPage-Down]])
    prevButton:SetDisabledTexture([[Interface\Buttons\UI-SpellbookIcon-PrevPage-Disabled]])
    prevButton:SetHighlightTexture([[Interface\Buttons\UI-Common-MouseHilight]], "ADD")
    prevButton:SetPoint("RIGHT", nextButton, "LEFT", 0, 0)
    prevButton:SetScript("OnClick", function() startPage = startPage - 1 mod:ShowInboxGUI() end)
    prevButton:SetWidth(25)
    prevButton:SetHeight(25)
    _addTooltipToFrame(prevButton, "Previous Page", "Go to the previous page of items.")
    
    local pageText = toolbar:CreateFontString(nil, nil, "GameFontNormalSmall")
    pageText:SetTextColor(1,210/255.0,0,1)
    pageText:SetPoint("RIGHT", prevButton, "LEFT", 0, 0)
    toolbar.pageText = pageText

    local itemText = toolbar:CreateFontString(nil, nil, "GameFontNormalSmall")
    itemText:SetTextColor(1,210/255.0,0,1)
    itemText:SetPoint("TOPRIGHT", pageText, "TOPLEFT", 0, 0)
    itemText:SetPoint("BOTTOMRIGHT", pageText, "BOTTOMLEFT", 0, 0)
    itemText:SetPoint("LEFT", toolbar, "LEFT", 5, 0)
    itemText:SetJustifyH("LEFT")
    toolbar.itemText = itemText
    
    button = _createButton("Placeholder", toolbar, function() wipe(markTable) mod:RefreshInboxGUI() end, closeButton, -2,
         "Clear Selected", "Clear the list of selected items.")

    mod.buttons.prev = prevButton
    mod.buttons.next = nextButton
    mod.buttons.close = closebuttons

    local spinner = toolbar:CreateFontString(nil, nil, "GameFontNormal")
    spinner:SetTextColor(1,210/255.0,0,1)
    spinner:SetText("")
    spinner:SetPoint("TOPLEFT", text, "BOTTOMLEFT", 0, -10)
    spinner:SetJustifyH("RIGHT")
    toolbar.spinner = spinner

    local cancelButton =  CreateFrame("Button", "BulkMailInboxToolbarCancelButton", toolbar, "UIPanelCloseButton")
    cancelButton:SetPoint("RIGHT", spinner, "LEFT", 0, 0)
    cancelButton:SetScript("OnClick", function(self) takeAllInProgress = nil end)
    _addTooltipToFrame(cancelButton, "Cancel", "Cancel taking items from the inbox.")
    EpochTools.buttons.Cancel = cancelButton
    
    local titleText = toolbar:CreateFontString(toolbar, nil, "GameTooltipHeaderText")
    titleText:SetTextColor(1,210/255.0,0,1)
    titleText:SetText("Donation Parser")
    titleText:SetPoint("TOPLEFT", toolbar, "TOPLEFT", 8, -5)
    toolbar.titleText = titleText
    
    local backdrop = GameTooltip:GetBackdrop()
    
    toolbar:SetBackdrop(backdrop)
    donationFrame:SetBackdrop(backdrop)
 
    if backdrop then
      toolbar:SetBackdropColor(GameTooltip:GetBackdropColor())
      toolbar:SetBackdropBorderColor(GameTooltip:GetBackdropBorderColor())

      donationFrame:SetBackdropColor(GameTooltip:GetBackdropColor())
      donationFrame:SetBackdropBorderColor(GameTooltip:GetBackdropBorderColor())
    end

    toolbar:EnableMouse(true)
    toolbar:RegisterForDrag("LeftButton")
    toolbar:SetMovable(true)
    EpochTools._toolbar = toolbar

    donationContent:EnableMouse(true)
    donationContent:RegisterForDrag("LeftButton")
    donationContent:SetMovable(true)
    EpochTools._donationContent = donationContent
  end

  toolbar:SetScript("OnDragStart", function() tooltip:StartMoving() end)
  toolbar:SetScript("OnDragStop", function() tooltip.moved = true tooltip:StopMovingOrSizing() end)
 
  toolbar:ClearAllPoints()
  toolbar:SetParent(tooltip)
 
  toolbar:SetPoint("BOTTOMLEFT", tooltip, "TOPLEFT", 0, -4)
  toolbar:SetPoint("BOTTOMRIGHT", tooltip, "TOPRIGHT", 0, -4)

  donationFrame:ClearAllPoints()
  donationFrame:SetParent(tooltip)
  donationFrame:SetPoint("BOTTOMLEFT", toolbar, "TOPLEFT", 0, -427)
  donationFrame:SetPoint("BOTTOMRIGHT", toolbar, "TOPRIGHT", 0, -427)
  donationFrame:Show()

  toolbar:Show()
end


function EpochTools:TakeInboxMoney(...)
  -- TODO: Add logic here later
end

function EpochTools:AutoLootMailItem(...)
  -- TODO: Add logic here later
end
