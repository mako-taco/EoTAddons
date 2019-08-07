function EOT_PrintGroup()
  f, _, _ = GameFontNormal:GetFont()

  if EoTPTR.frames.main == nil then
    -- Adds parent frame where we will add raid roster
    EoTPTR.frames.main = CreateFrame("Frame", "EOT_PrintGroupFrame", UIParent)
    EoTPTR.frames.main:SetWidth(300)
    EoTPTR.frames.main:SetHeight(500)
    EoTPTR.frames.main:SetFrameStrata("DIALOG")
    EoTPTR.frames.main:EnableMouse(true)
    EoTPTR.frames.main:SetBackdrop({
      bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", tile = true, tileSize = 16,
      edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16,
      insets = {left = 4, right = 4, top = 4, bottom = 4},
      })
    EoTPTR.frames.main:SetBackdropBorderColor(.5, .5, .5)
    EoTPTR.frames.main:SetBackdropColor(0,0,0)
    EoTPTR.frames.main:SetPoint("CENTER", 0, 0)

    -- Adds title to top left of the frame
    EoTPTR.frames.main.title = EoTPTR.frames.main:CreateFontString("Status", "LOW", "GameFontNormal")
    EoTPTR.frames.main.title:SetFontObject(GameFontWhite)
    EoTPTR.frames.main.title:SetPoint("TOPLEFT", EoTPTR.frames.main, "TOPLEFT", 8, -8)
    EoTPTR.frames.main.title:SetJustifyH("LEFT")
    EoTPTR.frames.main.title:SetFont(f, 10)
    EoTPTR.frames.main.title:SetText("Current Raid Roster")

    -- Adds edit box to copy and paste the current raid roster
    EoTPTR.frames.roster = CreateFrame("EditBox", nil, EoTPTR.frames.main)
    EoTPTR.frames.roster:SetFontObject(GameFontWhite)
    EoTPTR.frames.roster:SetPoint("TOPLEFT", EoTPTR.frames.main, "TOPLEFT", 8, -40)
    EoTPTR.frames.roster:SetJustifyH("LEFT")
    EoTPTR.frames.roster:SetFont(f, 10)
    EoTPTR.frames.roster:SetHeight(500)
    EoTPTR.frames.roster:SetMultiLine(true)
    EoTPTR.frames.roster:SetWidth(300)
    EoTPTR.frames.roster:EnableMouse(true)
    EoTPTR.frames.roster:SetAutoFocus(true)
    EoTPTR.frames.roster:SetScript("OnEscapePressed", function()
      this:ClearFocus()
      EoTPTR.frames.close:GetParent():Hide()
    end)

    -- Adds scrollbar to raid roster edit box
    EoTPTR.frames.roster_scroll = CreateFrame("ScrollFrame", nil, EoTPTR.frames.main)
    -- local scrollframe = CreateFrame("ScrollFrame", nil, frame)
    -- EoTPTR.frames.roster_scroll:SetWidth(300)
    EoTPTR.frames.roster_scroll:SetPoint("TOPLEFT", EoTPTR.frames.main, "TOPLEFT", 14, -25)
    EoTPTR.frames.roster_scroll:SetPoint("BOTTOMRIGHT", EoTPTR.frames.main, "BOTTOMRIGHT", -14, 12)
    
    EoTPTR.frames.roster_scroll:SetScrollChild(EoTPTR.frames.roster)
    -- EoTPTR.frames.roster.scrollframe = EoTPTR.frames.roster_scroll

    -- Adds button to top right of frame to click and close the window
    EoTPTR.frames.close = CreateFrame("Button", "pfQuestionDialogClose", EoTPTR.frames.main)
    EoTPTR.frames.close:SetPoint("TOPRIGHT", -7, -7)
    EoTPTR.frames.close:SetHeight(10)
    EoTPTR.frames.close:SetWidth(10)
    EoTPTR.frames.close:SetText('X')
    EoTPTR.frames.close.texture = EoTPTR.frames.close:CreateTexture("pfQuestionDialogCloseTex")
    EoTPTR.frames.close.texture:SetTexture(1,1,1,1)
    EoTPTR.frames.close.texture:ClearAllPoints()
    EoTPTR.frames.close.texture:SetAllPoints(EoTPTR.frames.close)
    EoTPTR.frames.close.texture:SetVertexColor(1,.25,.25,1)
    EoTPTR.frames.close:SetText('X')
    EoTPTR.frames.close:SetTextColor(.2,1,.8,1)
    EoTPTR.frames.close:SetScript("OnClick", function()
      EoTPTR.frames.close:GetParent():Hide()
    end)
  else
    EoTPTR.frames.main:Show()
  end

  -- Iterate over raid roster and concatenate to raidRoster string
  local raidRoster = ""

  EOT_ForEachGroupMember(
    function (name)
      raidRoster = raidRoster .. name .. "\n"
    end
  )

  -- Set editBox text to raidRoster string
  EoTPTR.frames.roster:SetText(raidRoster)
end
