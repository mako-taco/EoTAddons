EOT_CopyBoxFrame = nil

function EOT_CopyBox(text, selectAll)
  f, _, _ = GameFontNormal:GetFont()
  if EOT_CopyBoxFrame == nil then
    -- Adds parent frame where we will add raid roster
    EOT_CopyBoxFrame = CreateFrame("Frame", nil, UIParent)
    EOT_CopyBoxFrame:SetWidth(300)
    EOT_CopyBoxFrame:SetHeight(500)
    EOT_CopyBoxFrame:SetFrameStrata("DIALOG")
    EOT_CopyBoxFrame:EnableMouse(true)
    EOT_CopyBoxFrame:SetBackdrop({
      bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", tile = true, tileSize = 16,
      edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16,
      insets = {left = 4, right = 4, top = 4, bottom = 4},
      })
    EOT_CopyBoxFrame:SetBackdropBorderColor(.5, .5, .5)
    EOT_CopyBoxFrame:SetBackdropColor(0,0,0)
    EOT_CopyBoxFrame:SetPoint("CENTER", 0, 0)

    -- Adds title to top left of the frame
    EOT_CopyBoxFrame.title = EOT_CopyBoxFrame:CreateFontString("Status", "LOW", "GameFontNormal")
    EOT_CopyBoxFrame.title:SetFontObject(GameFontWhite)
    EOT_CopyBoxFrame.title:SetPoint("TOPLEFT", EOT_CopyBoxFrame, "TOPLEFT", 8, -8)
    EOT_CopyBoxFrame.title:SetJustifyH("LEFT")
    EOT_CopyBoxFrame.title:SetFont(f, 10)
    EOT_CopyBoxFrame.title:SetText("Current Raid Roster")

    -- Adds edit box to copy and paste the current raid roster
    roster = CreateFrame("EditBox", nil, EOT_CopyBoxFrame)
    roster:SetFontObject(GameFontWhite)
    roster:SetPoint("TOPLEFT", EOT_CopyBoxFrame, "TOPLEFT", 8, -40)
    roster:SetJustifyH("LEFT")
    roster:SetFont(f, 10)
    roster:SetHeight(500)
    roster:SetMultiLine(true)
    roster:SetWidth(300)
    roster:EnableMouse(true)
    roster:SetAutoFocus(true)
    roster:SetScript("OnEscapePressed", function()
      this:ClearFocus()
      close:GetParent():Hide()
    end)

    -- Adds scrollbar to raid roster edit box
    roster_scroll = CreateFrame("ScrollFrame", nil, EOT_CopyBoxFrame)
    roster_scroll:SetPoint("TOPLEFT", EOT_CopyBoxFrame, "TOPLEFT", 14, -25)
    roster_scroll:SetPoint("BOTTOMRIGHT", EOT_CopyBoxFrame, "BOTTOMRIGHT", -14, 12)
    roster_scroll:SetScrollChild(roster)

    -- Adds button to top right of frame to click and close the window
    close = CreateFrame("Button", nil, EOT_CopyBoxFrame)
    close:SetPoint("TOPRIGHT", -7, -7)
    close:SetHeight(10)
    close:SetWidth(10)
    close:SetText('X')
    close.texture = close:CreateTexture(nil)
    close.texture:SetTexture(1,1,1,1)
    close.texture:ClearAllPoints()
    close.texture:SetAllPoints(close)
    close.texture:SetVertexColor(1,.25,.25,1)
    close:SetText('X')
    close:SetTextColor(.2,1,.8,1)
    close:SetScript("OnClick", function()
      close:GetParent():Hide()
    end)
  end

  roster:SetText(text)
  if selectAll then
    roster:HighlightText()
  end
  EOT_CopyBoxFrame:Show()
end