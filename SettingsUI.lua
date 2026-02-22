local addonName, TRP3_UnitFrames = ...;
local L = TRP3_UnitFrames.L;

local trpTarget = TRP3_UnitFrames.trpTarget;
local trpPlayer = TRP3_UnitFrames.trpPlayer;

local function BuildDummyFrames(panel, playerOffX, playerOffY, targetOffX, targetOffY, playerRepName, playerRepTextName, targetRepName, targetRepTextName)

	panel.dummyFramePlayer = CreateFrame("Frame", nil, panel)
	panel.dummyFramePlayer:SetPoint("TOPLEFT", panel, "TOPLEFT", playerOffX, playerOffY)
	panel.dummyFramePlayer:SetSize(198, 71)
	panel.dummyFramePlayer.tex = panel.dummyFramePlayer:CreateTexture(nil, "ARTWORK", nil, 1)
	panel.dummyFramePlayer.tex:SetAllPoints(panel.dummyFramePlayer)
	panel.dummyFramePlayer.tex:SetAtlas("UI-HUD-UnitFrame-Player-PortraitOn")
	panel.dummyFramePlayer.tex:SetTexCoord(0, 1, 0, 1)

	panel.dummyFrameTarget = CreateFrame("Frame", nil, panel)
	panel.dummyFrameTarget:SetPoint("TOPLEFT", panel, "TOPLEFT", targetOffX, targetOffY)
	panel.dummyFrameTarget:SetSize(198, 71)
	panel.dummyFrameTarget.tex = panel.dummyFrameTarget:CreateTexture(nil, "ARTWORK", nil, 1)
	panel.dummyFrameTarget.tex:SetAllPoints(panel.dummyFrameTarget)
	panel.dummyFrameTarget.tex:SetAtlas("UI-HUD-UnitFrame-Target-PortraitOn")
	panel.dummyFrameTarget.tex:SetTexCoord(0, 1, 0, 1)

	panel.Pf = CreateFrame("Frame", nil, panel)
	panel.Pf:ClearAllPoints()
	panel.Pf:SetPoint("TOPLEFT", panel.dummyFramePlayer, "TOPLEFT", 5, -3)
	panel.Pf:SetSize(64, 64)

	panel.Pf.tex = panel.Pf:CreateTexture()
	panel.Pf.tex:SetAllPoints(panel.Pf)
	panel.Pf.mask = panel.Pf:CreateMaskTexture()
	panel.Pf.mask:SetAllPoints(panel.Pf.tex)
	panel.Pf.mask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
	panel.Pf.tex:AddMaskTexture(panel.Pf.mask)
	SetPortraitTexture(panel.Pf.tex, "player")

	panel.Tf = CreateFrame("Frame", nil, panel)
	panel.Tf:ClearAllPoints()
	panel.Tf:SetPoint("TOPLEFT", panel.dummyFrameTarget, "TOPLEFT", 128, -2)
	panel.Tf:SetSize(64, 64)

	panel.Tf.tex = panel.Tf:CreateTexture()
	panel.Tf.tex:SetAllPoints(panel.Tf)
	panel.Tf.mask = panel.Tf:CreateMaskTexture()
	panel.Tf.mask:SetAllPoints(panel.Tf.tex)
	panel.Tf.mask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
	panel.Tf.tex:AddMaskTexture(panel.Tf.mask)
	SetPortraitTexture(panel.Tf.tex, "player")

	function panel.OnShow()
		SetPortraitTexture(panel.Pf.tex, "player")
		SetPortraitTexture(panel.Tf.tex, "player")
	end
	panel.Tf:SetScript("OnShow", panel.OnShow)

	panel.Pf.TitleText = panel.Pf:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	panel.Pf.TitleText:SetFont(panel.Pf.TitleText:GetFont(), 12)
	panel.Pf.TitleText:SetTextColor(1, 1, 1, 1)
	panel.Pf.TitleText:SetPoint("BOTTOM", panel.Pf, "BOTTOM", 0, -25)
	panel.Pf.TitleText:SetText(PLAYER)

	panel.Tf.TitleText = panel.Tf:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	panel.Tf.TitleText:SetFont(panel.Tf.TitleText:GetFont(), 12)
	panel.Tf.TitleText:SetTextColor(1, 1, 1, 1)
	panel.Tf.TitleText:SetPoint("BOTTOM", panel.Tf, "BOTTOM", 0, -25)
	panel.Tf.TitleText:SetText(TARGET)

	panel.Pf.radioTopLeft = CreateFrame("CheckButton", nil, panel.Pf, "UIRadioButtonTemplate")
	panel.Pf.radioTop = CreateFrame("CheckButton", nil, panel.Pf, "UIRadioButtonTemplate")
	panel.Pf.radioTopRight = CreateFrame("CheckButton", nil, panel.Pf, "UIRadioButtonTemplate")
	panel.Pf.radioLeft = CreateFrame("CheckButton", nil, panel.Pf, "UIRadioButtonTemplate")
	panel.Pf.radioCenter = CreateFrame("CheckButton", nil, panel.Pf, "UIRadioButtonTemplate")
	panel.Pf.radioRight = CreateFrame("CheckButton", nil, panel.Pf, "UIRadioButtonTemplate")
	panel.Pf.radioBottomLeft = CreateFrame("CheckButton", nil, panel.Pf, "UIRadioButtonTemplate")
	panel.Pf.radioBottom = CreateFrame("CheckButton", nil, panel.Pf, "UIRadioButtonTemplate")
	panel.Pf.radioBottomRight = CreateFrame("CheckButton", nil, panel.Pf, "UIRadioButtonTemplate")

	panel.Pf.radioTopLeft:SetChecked(false)
	panel.Pf.radioTop:SetChecked(false)
	panel.Pf.radioTopRight:SetChecked(false)
	panel.Pf.radioLeft:SetChecked(false)
	panel.Pf.radioCenter:SetChecked(false)
	panel.Pf.radioRight:SetChecked(false)
	panel.Pf.radioBottomLeft:SetChecked(false)
	panel.Pf.radioBottom:SetChecked(false)
	panel.Pf.radioBottomRight:SetChecked(true)

	panel.Pf.radioTopLeft:SetPoint("CENTER", panel.Pf, "TOPLEFT", 0, 0)
	panel.Pf.radioTop:SetPoint("CENTER", panel.Pf, "TOP", 0, 0)
	panel.Pf.radioTopRight:SetPoint("CENTER", panel.Pf, "TOPRIGHT", 0, 0)
	panel.Pf.radioLeft:SetPoint("CENTER", panel.Pf, "LEFT", 0, 0)
	panel.Pf.radioCenter:SetPoint("CENTER", panel.Pf, "CENTER", 0, 0)
	panel.Pf.radioRight:SetPoint("CENTER", panel.Pf, "RIGHT", 0, 0)
	panel.Pf.radioBottomLeft:SetPoint("CENTER", panel.Pf, "BOTTOMLEFT", 0, 0)
	panel.Pf.radioBottom:SetPoint("CENTER", panel.Pf, "BOTTOM", 0, 0)
	panel.Pf.radioBottomRight:SetPoint("CENTER", panel.Pf, "BOTTOMRIGHT", 0, 0)

	panel.Pf.allRadios = {
		panel.Pf.radioTopLeft,		panel.Pf.radioTop,		panel.Pf.radioTopRight,
		panel.Pf.radioLeft,			panel.Pf.radioCenter,	panel.Pf.radioRight,
		panel.Pf.radioBottomLeft,	panel.Pf.radioBottom,	panel.Pf.radioBottomRight,
	};

	function panel.Pf.createOnRadioClicked(location)
		return function(self)
			PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
			TRP3_UF_DB.Player.relativePoint = location
			for _, radio in ipairs(panel.Pf.allRadios) do
				radio:SetChecked(radio == self)
			end
			if trpPlayer.SetPos then trpPlayer.SetPos() end
		end
	end

	panel.Pf.radioTopLeft:SetScript("OnClick", panel.Pf.createOnRadioClicked("TOPLEFT"))
	panel.Pf.radioTop:SetScript("OnClick", panel.Pf.createOnRadioClicked("TOP"))
	panel.Pf.radioTopRight:SetScript("OnClick", panel.Pf.createOnRadioClicked("TOPRIGHT"))
	panel.Pf.radioLeft:SetScript("OnClick", panel.Pf.createOnRadioClicked("LEFT"))
	panel.Pf.radioCenter:SetScript("OnClick", panel.Pf.createOnRadioClicked("CENTER"))
	panel.Pf.radioRight:SetScript("OnClick", panel.Pf.createOnRadioClicked("RIGHT"))
	panel.Pf.radioBottomLeft:SetScript("OnClick", panel.Pf.createOnRadioClicked("BOTTOMLEFT"))
	panel.Pf.radioBottom:SetScript("OnClick", panel.Pf.createOnRadioClicked("BOTTOM"))
	panel.Pf.radioBottomRight:SetScript("OnClick", panel.Pf.createOnRadioClicked("BOTTOMRIGHT"))

	panel.Tf.radioTopLeft = CreateFrame("CheckButton", nil, panel.Tf, "UIRadioButtonTemplate")
	panel.Tf.radioTop = CreateFrame("CheckButton", nil, panel.Tf, "UIRadioButtonTemplate")
	panel.Tf.radioTopRight = CreateFrame("CheckButton", nil, panel.Tf, "UIRadioButtonTemplate")
	panel.Tf.radioLeft = CreateFrame("CheckButton", nil, panel.Tf, "UIRadioButtonTemplate")
	panel.Tf.radioCenter = CreateFrame("CheckButton", nil, panel.Tf, "UIRadioButtonTemplate")
	panel.Tf.radioRight = CreateFrame("CheckButton", nil, panel.Tf, "UIRadioButtonTemplate")
	panel.Tf.radioBottomLeft = CreateFrame("CheckButton", nil, panel.Tf, "UIRadioButtonTemplate")
	panel.Tf.radioBottom = CreateFrame("CheckButton", nil, panel.Tf, "UIRadioButtonTemplate")
	panel.Tf.radioBottomRight = CreateFrame("CheckButton", nil, panel.Tf, "UIRadioButtonTemplate")

	panel.Tf.radioTopLeft:SetChecked(false)
	panel.Tf.radioTop:SetChecked(false)
	panel.Tf.radioTopRight:SetChecked(false)
	panel.Tf.radioLeft:SetChecked(false)
	panel.Tf.radioCenter:SetChecked(false)
	panel.Tf.radioRight:SetChecked(false)
	panel.Tf.radioBottomLeft:SetChecked(true)
	panel.Tf.radioBottom:SetChecked(false)
	panel.Tf.radioBottomRight:SetChecked(false)

	panel.Tf.radioTopLeft:SetPoint("CENTER", panel.Tf, "TOPLEFT", 0, 0)
	panel.Tf.radioTop:SetPoint("CENTER", panel.Tf, "TOP", 0, 0)
	panel.Tf.radioTopRight:SetPoint("CENTER", panel.Tf, "TOPRIGHT", 0, 0)
	panel.Tf.radioLeft:SetPoint("CENTER", panel.Tf, "LEFT", 0, 0)
	panel.Tf.radioCenter:SetPoint("CENTER", panel.Tf, "CENTER", 0, 0)
	panel.Tf.radioRight:SetPoint("CENTER", panel.Tf, "RIGHT", 0, 0)
	panel.Tf.radioBottomLeft:SetPoint("CENTER", panel.Tf, "BOTTOMLEFT", 0, 0)
	panel.Tf.radioBottom:SetPoint("CENTER", panel.Tf, "BOTTOM", 0, 0)
	panel.Tf.radioBottomRight:SetPoint("CENTER", panel.Tf, "BOTTOMRIGHT", 0, 0)

	panel.Tf.allRadios = {
		panel.Tf.radioTopLeft,		panel.Tf.radioTop,		panel.Tf.radioTopRight,
		panel.Tf.radioLeft,			panel.Tf.radioCenter,	panel.Tf.radioRight,
		panel.Tf.radioBottomLeft,	panel.Tf.radioBottom,	panel.Tf.radioBottomRight,
	}

	function panel.Tf.createOnRadioClicked(location)
		return function(self)
			PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
			TRP3_UF_DB.Target.relativePoint = location
			for _, radio in ipairs(panel.Tf.allRadios) do
				radio:SetChecked(radio == self)
			end
			if trpTarget.SetPos then trpTarget.SetPos() end
		end
	end

	panel.Tf.radioTopLeft:SetScript("OnClick", panel.Tf.createOnRadioClicked("TOPLEFT"))
	panel.Tf.radioTop:SetScript("OnClick", panel.Tf.createOnRadioClicked("TOP"))
	panel.Tf.radioTopRight:SetScript("OnClick", panel.Tf.createOnRadioClicked("TOPRIGHT"))
	panel.Tf.radioLeft:SetScript("OnClick", panel.Tf.createOnRadioClicked("LEFT"))
	panel.Tf.radioCenter:SetScript("OnClick", panel.Tf.createOnRadioClicked("CENTER"))
	panel.Tf.radioRight:SetScript("OnClick", panel.Tf.createOnRadioClicked("RIGHT"))
	panel.Tf.radioBottomLeft:SetScript("OnClick", panel.Tf.createOnRadioClicked("BOTTOMLEFT"))
	panel.Tf.radioBottom:SetScript("OnClick", panel.Tf.createOnRadioClicked("BOTTOM"))
	panel.Tf.radioBottomRight:SetScript("OnClick", panel.Tf.createOnRadioClicked("BOTTOMRIGHT"))

	panel.PColor = CreateFrame("Frame", nil, panel.dummyFramePlayer)
	panel.PColor:SetPoint("TOPLEFT", panel.dummyFramePlayer, "TOPLEFT", 58, -11)
	panel.PColor:SetSize(135, 18)
	panel.PColor.tex = panel.PColor:CreateTexture(playerRepName, "ARTWORK", nil, 1)
	panel.PColor.tex:SetAllPoints(panel.PColor)
	panel.PColor.tex:SetAtlas("UI-HUD-UnitFrame-Target-PortraitOn-Type")
	panel.PColor.tex:SetTexCoord(1, 0, 0, 1)
	panel.PColor.Name = panel.PColor:CreateFontString(playerRepTextName, "OVERLAY", "GameFontNormal")
	panel.PColor.Name:SetFont(panel.PColor.Name:GetFont(), 12)
	panel.PColor.Name:SetTextColor(1, 1, 1, 1)
	panel.PColor.Name:SetPoint("TOP", panel.PColor, "TOP", 0, 0)
	panel.PColor.Name:SetText(PLAYER)

	panel.TColor = CreateFrame("Frame", nil, panel.dummyFrameTarget)
	panel.TColor:SetPoint("TOPRIGHT", panel.dummyFrameTarget, "TOPRIGHT", -60, -10)
	panel.TColor:SetSize(135, 18)
	panel.TColor.tex = panel.TColor:CreateTexture(targetRepName, "ARTWORK", nil, 1)
	panel.TColor.tex:SetAllPoints(panel.TColor)
	panel.TColor.tex:SetAtlas("UI-HUD-UnitFrame-Target-PortraitOn-Type")
	panel.TColor.Name = panel.TColor:CreateFontString(targetRepTextName, "OVERLAY", "GameFontNormal")
	panel.TColor.Name:SetFont(panel.TColor.Name:GetFont(), 12)
	panel.TColor.Name:SetTextColor(1, 1, 1, 1)
	panel.TColor.Name:SetPoint("TOP", panel.TColor, "TOP", 0, 0)
	panel.TColor.Name:SetText(TARGET)
end


function TRP3_UnitFrames.InitializeSettingsUI()
	local TRP3_UFPanel = CreateFrame("Frame");
	TRP3_UFPanel.name = C_AddOns.GetAddOnMetadata("totalRP3_UnitFrames", "Title")
	TRP3_UnitFrames.TRP3_UFPanel = TRP3_UFPanel

	local VERSION_TEXT = string.format(TRP3_API.loc.CREDITS_VERSION_TEXT, C_AddOns.GetAddOnMetadata("totalRP3_UnitFrames", "Version"));

	TRP3_UFPanel.Headline = TRP3_UFPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal");
	TRP3_UFPanel.Headline:SetFont(TRP3_UFPanel.Headline:GetFont(), 23);
	TRP3_UFPanel.Headline:SetTextColor(1, .73, 0, 1);
	TRP3_UFPanel.Headline:SetPoint("TOPLEFT", TRP3_UFPanel, "TOPLEFT", 12, -12);
	TRP3_UFPanel.Headline:SetText(L["TitleColored"]);

	TRP3_UFPanel.Version = TRP3_UFPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal");
	TRP3_UFPanel.Version:SetFont(TRP3_UFPanel.Version:GetFont(), 12);
	TRP3_UFPanel.Version:SetTextColor(1, 1, 1, 1);
	TRP3_UFPanel.Version:SetPoint("TOPLEFT", TRP3_UFPanel, "TOPLEFT", 400, -21);
	TRP3_UFPanel.Version:SetText(VERSION_TEXT);

	TRP3_UFPanel.menuNew = {
		[1] = {
			ThemeName = L["Dragons"],
			Data = {
				[1] = { styleName = ITEM_QUALITY3_DESC,						fileName = "rare", },
				[2] = { styleName = ELITE,									fileName = "elite", },
				[3] = { styleName = ITEM_QUALITY3_DESC .. " " .. ELITE,		fileName = "rare-elite", },
				[4] = { styleName = BOSS,									fileName = "boss", },
			},
		},
		[2] = { ThemeName = L["Hearthstone"], ThemeDesc = L["ComingSoon"], Data = nil, },
		[3] = C_AddOns.IsAddOnLoaded("Narcissus") and {
			ThemeName = L["Narcissus"],
			Data = {
				[1] = { styleName = "Default",				fileName = "NarciHexagonBorder", },
				[2] = { styleName = "Artifact",				fileName = "NarciHexagonBorder-Artifact", },
				[3] = { styleName = "Azerite",				fileName = "NarciHexagonBorder-Azerite", },
				[4] = { styleName = "Black",				fileName = "NarciHexagonBorder-Black", },
				[5] = { styleName = "Black Dragon",			fileName = "NarciHexagonBorder-BlackDragon", },
				[6] = { styleName = ITEM_QUALITY6_DESC,		fileName = "NarciHexagonBorder-Epic", },
				[7] = { styleName = "Heart",				fileName = "NarciHexagonBorder-Heart", },
				[8] = { styleName = "Heirloom",				fileName = "NarciHexagonBorder-Heirloom", },
				[9] = { styleName = ITEM_QUALITY5_DESC,		fileName = "NarciHexagonBorder-Legendary", },
				[10] = { styleName = "N'Zoth",				fileName = "NarciHexagonBorder-NZoth", },
				[11] = { styleName = ITEM_QUALITY3_DESC,	fileName = "NarciHexagonBorder-Rare", },
				[12] = { styleName = "Special",				fileName = "NarciHexagonBorder-Special", },
				[13] = { styleName = ITEM_QUALITY2_DESC, 	fileName = "NarciHexagonBorder-Uncommon", },
				[14] = { styleName = "Void",				fileName = "NarciHexagonBorder-Void", },
			},
		} or { ThemeName = L["Narcissus"], ThemeDesc = L["NotDetected"], Data = nil, },
		[4] = {
			ThemeName = L["LGBQT+"],
			Data = {
				[1] = { styleName = L["Agender"],				fileName = "agender", },
				[2] = { styleName = L["Asexual"],				fileName = "asexual", },
				[3] = { styleName = L["Aromantic Asexual"],		fileName = "aroace", },
				[4] = { styleName = L["Bisexual"],				fileName = "bisexual", },
				[5] = { styleName = L["Non-Binary"],			fileName = "enby", },
				[6] = { styleName = L["Gay Male"],				fileName = "gaym", },
				[7] = { styleName = L["Genderfluid"],			fileName = "genderfluid", },
				[8] = { styleName = L["Genderqueer"],			fileName = "genderqueer", },
				[9] = { styleName = L["Lesbian"],				fileName = "lesbian", },
				[10] = { styleName = L["Transgender"],			fileName = "transgender", },
				[11] = { styleName = L["Pansexual"],			fileName = "pansexual", },
				[12] = { styleName = L["Rainbow"],				fileName = "rainbow", },
				[13] = { styleName = L["RainbowPhilly"],		fileName = "rainbowphilly", },
				[14] = { styleName = L["RainbowGilBaker"],		fileName = "rainbowgilbaker", },
				[15] = { styleName = L["RainbowProgress"],		fileName = "rainbowprogress", },
			},
		},
	};

	local TRP3_UFScrollFrame = CreateFrame("ScrollFrame", nil, TRP3_UFPanel, "ScrollFrameTemplate")
	TRP3_UFScrollFrame:SetPoint("TOPLEFT", 3, -4)
	TRP3_UFScrollFrame:SetPoint("BOTTOMRIGHT", -27, 4)

	TRP3_UFPanel.scrollChild = CreateFrame("Frame")
	TRP3_UFScrollFrame:SetScrollChild(TRP3_UFPanel.scrollChild)
	TRP3_UFPanel.scrollChild:SetWidth(SettingsPanel:GetWidth() - 18)
	TRP3_UFPanel.scrollChild:SetHeight(1)

	BuildDummyFrames(TRP3_UFPanel.scrollChild,5, -53, 350, -53, "TRP3_UFRepDummyPlayer", "TRP3_UFRepTextDummyPlayer", "TRP3_UFRepDummyTarget", "TRP3_UFRepTextDummyTarget")

	TRP3_UFPanel.scrollChild.VisibilityText = TRP3_UFPanel.scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal");
	TRP3_UFPanel.scrollChild.VisibilityText:SetFont(TRP3_UFPanel.scrollChild.VisibilityText:GetFont(), 15);
	TRP3_UFPanel.scrollChild.VisibilityText:SetPoint("TOPLEFT", 5, -53 * 3.7);
	TRP3_UFPanel.scrollChild.VisibilityText:SetText(L["Visibility"]);

	TRP3_UFPanel.scrollChild.PShowCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild, "UICheckButtonTemplate");
	TRP3_UFPanel.scrollChild.PShowCheckbox:SetPoint("TOPLEFT", 5, -53 * 4);
	TRP3_UFPanel.scrollChild.PShowCheckbox.Text:SetText(L["ShowButtonPlayer"]);
	TRP3_UFPanel.scrollChild.PShowCheckbox:SetScript("OnClick", function(self)
		TRP3_UF_DB.Player.show = self:GetChecked()
		if trpPlayer.SetVisible then trpPlayer.SetVisible() end
		TRP3_UnitFrames.CheckSettings();
	end);

	TRP3_UFPanel.scrollChild.TShowCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild, "UICheckButtonTemplate");
	TRP3_UFPanel.scrollChild.TShowCheckbox:SetPoint("TOPLEFT", 5, -53 * 4.5);
	TRP3_UFPanel.scrollChild.TShowCheckbox.Text:SetText(L["ShowButtonTarget"]);
	TRP3_UFPanel.scrollChild.TShowCheckbox:SetScript("OnClick", function(self)
		TRP3_UF_DB.Target.show = self:GetChecked()
		if trpPlayer.SetVisible then trpPlayer.SetVisible() end
		TRP3_UnitFrames.CheckSettings();
	end);

	TRP3_UFPanel.scrollChild.PortShowCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild, "UICheckButtonTemplate");
	TRP3_UFPanel.scrollChild.PortShowCheckbox:SetPoint("TOPLEFT", 5, -53 * 5);
	TRP3_UFPanel.scrollChild.PortShowCheckbox.Text:SetText(L["ShowBorderFrame"]);
	TRP3_UFPanel.scrollChild.PortShowCheckbox:SetScript("OnClick", function(self)
		TRP3_UF_DB.Border.show = self:GetChecked()
		TRP3_UFPanel.scrollChild.PortraitButton:SetEnabled(TRP3_UF_DB.Border.show)
		local pdf = TRP3_UnitFrames.PlayerDragonFrame
		if pdf then
			if TRP3_UF_DB.Border.show then pdf:Show() else pdf:Hide() end
		end
		if trpPlayer.SetAsPortrait then trpPlayer.SetAsPortrait() end
		TRP3_UnitFrames.CheckSettings();
	end);

	TRP3_UFPanel.scrollChild.StatusHideCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild, "UICheckButtonTemplate");
	TRP3_UFPanel.scrollChild.StatusHideCheckbox:SetPoint("TOPLEFT", 5, -53 * 5.5);
	TRP3_UFPanel.scrollChild.StatusHideCheckbox.Text:SetText(L["HideRestedGlow"]);
	TRP3_UFPanel.scrollChild.StatusHideCheckbox:SetScript("OnClick", function(self)
		TRP3_UF_DB.Border.status = self:GetChecked()
		if self:GetChecked() then
			PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture:Hide()
		else
			PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture:Show()
		end
		TRP3_UnitFrames.CheckSettings();
	end);

	TRP3_UFPanel.scrollChild.TargetSizeSlider = CreateFrame("Slider", nil, TRP3_UFPanel.scrollChild, "OptionsSliderTemplate");
	TRP3_UFPanel.scrollChild.TargetSizeSlider:SetWidth(250); TRP3_UFPanel.scrollChild.TargetSizeSlider:SetHeight(15);
	TRP3_UFPanel.scrollChild.TargetSizeSlider:SetMinMaxValues(0.5, 15); TRP3_UFPanel.scrollChild.TargetSizeSlider:SetValueStep(.5); TRP3_UFPanel.scrollChild.TargetSizeSlider:SetObeyStepOnDrag(true)
	TRP3_UFPanel.scrollChild.TargetSizeSlider:SetPoint("TOPLEFT", TRP3_UFPanel.scrollChild, "TOPLEFT", 5, -53 * 6.75);
	TRP3_UFPanel.scrollChild.TargetSizeSlider.Low:SetText("0.5"); TRP3_UFPanel.scrollChild.TargetSizeSlider.High:SetText("15");
	TRP3_UFPanel.scrollChild.TargetSizeSlider.Text:SetText(L["ButtonSizeTarget"]);
	TRP3_UFPanel.scrollChild.TargetSizeSlider:SetScript("OnValueChanged", function(self)
		TRP3_UF_DB.Target.scale = self:GetValue()
		if trpTarget.button then trpTarget.button:SetScale(TRP3_UF_DB.Target.scale) end
		TRP3_UnitFrames.CheckSettings();
	end)

	TRP3_UFPanel.scrollChild.TargetPosSlider = CreateFrame("Slider", nil, TRP3_UFPanel.scrollChild, "OptionsSliderTemplate");
	TRP3_UFPanel.scrollChild.TargetPosSlider:SetWidth(250); TRP3_UFPanel.scrollChild.TargetPosSlider:SetHeight(15);
	TRP3_UFPanel.scrollChild.TargetPosSlider:SetMinMaxValues(-15, 15); TRP3_UFPanel.scrollChild.TargetPosSlider:SetValueStep(.5); TRP3_UFPanel.scrollChild.TargetPosSlider:SetObeyStepOnDrag(true)
	TRP3_UFPanel.scrollChild.TargetPosSlider:SetPoint("TOPLEFT", TRP3_UFPanel.scrollChild, "TOPLEFT", 5, -53 * 7.5);
	TRP3_UFPanel.scrollChild.TargetPosSlider.Low:SetText("-15"); TRP3_UFPanel.scrollChild.TargetPosSlider.High:SetText("15");
	TRP3_UFPanel.scrollChild.TargetPosSlider.Text:SetText(L["ButtonPosTarget"]);
	TRP3_UFPanel.scrollChild.TargetPosSlider:SetScript("OnValueChanged", function(self)
		TRP3_UF_DB.Target.position = self:GetValue()
		if trpTarget.SetPos then trpTarget.SetPos() end
		TRP3_UnitFrames.CheckSettings();
	end)

	TRP3_UFPanel.scrollChild.PlayerSizeSlider = CreateFrame("Slider", nil, TRP3_UFPanel.scrollChild, "OptionsSliderTemplate");
	TRP3_UFPanel.scrollChild.PlayerSizeSlider:SetWidth(250); TRP3_UFPanel.scrollChild.PlayerSizeSlider:SetHeight(15);
	TRP3_UFPanel.scrollChild.PlayerSizeSlider:SetMinMaxValues(0.5, 15); TRP3_UFPanel.scrollChild.PlayerSizeSlider:SetValueStep(.5); TRP3_UFPanel.scrollChild.PlayerSizeSlider:SetObeyStepOnDrag(true)
	TRP3_UFPanel.scrollChild.PlayerSizeSlider:SetPoint("TOPLEFT", TRP3_UFPanel.scrollChild, "TOPLEFT", 5, -53 * 8.25);
	TRP3_UFPanel.scrollChild.PlayerSizeSlider.Low:SetText("0.5"); TRP3_UFPanel.scrollChild.PlayerSizeSlider.High:SetText("15");
	TRP3_UFPanel.scrollChild.PlayerSizeSlider.Text:SetText(L["ButtonSizePlayer"]);
	TRP3_UFPanel.scrollChild.PlayerSizeSlider:SetScript("OnValueChanged", function(self)
		TRP3_UF_DB.Player.scale = self:GetValue()
		if trpPlayer.button then trpPlayer.button:SetScale(TRP3_UF_DB.Player.scale) end
		TRP3_UnitFrames.CheckSettings();
	end)

	TRP3_UFPanel.scrollChild.PlayerPosSlider = CreateFrame("Slider", nil, TRP3_UFPanel.scrollChild, "OptionsSliderTemplate");
	TRP3_UFPanel.scrollChild.PlayerPosSlider:SetWidth(250); TRP3_UFPanel.scrollChild.PlayerPosSlider:SetHeight(15);
	TRP3_UFPanel.scrollChild.PlayerPosSlider:SetMinMaxValues(-15, 15); TRP3_UFPanel.scrollChild.PlayerPosSlider:SetValueStep(.5); TRP3_UFPanel.scrollChild.PlayerPosSlider:SetObeyStepOnDrag(true)
	TRP3_UFPanel.scrollChild.PlayerPosSlider:SetPoint("TOPLEFT", TRP3_UFPanel.scrollChild, "TOPLEFT", 5, -53 * 9);
	TRP3_UFPanel.scrollChild.PlayerPosSlider.Low:SetText("-15"); TRP3_UFPanel.scrollChild.PlayerPosSlider.High:SetText("15");
	TRP3_UFPanel.scrollChild.PlayerPosSlider.Text:SetText(L["ButtonPosPlayer"]);
	TRP3_UFPanel.scrollChild.PlayerPosSlider:SetScript("OnValueChanged", function(self)
		TRP3_UF_DB.Player.position = self:GetValue()
		if trpPlayer.SetPos then trpPlayer.SetPos() end
		TRP3_UnitFrames.CheckSettings();
	end)

	TRP3_UFPanel.scrollChild.ColorsText = TRP3_UFPanel.scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal");
	TRP3_UFPanel.scrollChild.ColorsText:SetFont(TRP3_UFPanel.scrollChild.ColorsText:GetFont(), 15);
	TRP3_UFPanel.scrollChild.ColorsText:SetPoint("TOPLEFT", 300, -53 * 3.7);
	TRP3_UFPanel.scrollChild.ColorsText:SetText(COLORS);

	TRP3_UFPanel.scrollChild.ColorsTarText = TRP3_UFPanel.scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal");
	TRP3_UFPanel.scrollChild.ColorsTarText:SetPoint("TOPLEFT", 300, -53 * 4.2);
	TRP3_UFPanel.scrollChild.ColorsTarText:SetText(HUD_EDIT_MODE_TARGET_FRAME_LABEL);

	TRP3_UFPanel.scrollChild.ColorsPlayerText = TRP3_UFPanel.scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal");
	TRP3_UFPanel.scrollChild.ColorsPlayerText:SetPoint("TOPLEFT", 300, -53 * 6.7);
	TRP3_UFPanel.scrollChild.ColorsPlayerText:SetText(HUD_EDIT_MODE_PLAYER_FRAME_LABEL);

	TRP3_UFPanel.scrollChild.TargetTextColorCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild, "UICheckButtonTemplate");
	TRP3_UFPanel.scrollChild.TargetTextColorCheckbox:SetPoint("TOPLEFT", 300, -53 * 4.5);
	TRP3_UFPanel.scrollChild.TargetTextColorCheckbox.Text:SetText(L["OverwriteTextCol"])
	TRP3_UFPanel.scrollChild.TargetTextColorCheckbox:SetScript("OnClick", function(self)
		TRP3_UF_DB.Target.colorTextCustom = self:GetChecked()
		if trpPlayer.UpdateInfo then trpPlayer.UpdateInfo() end
		if trpTarget.UpdateInfo then trpTarget.UpdateInfo() end
		TRP3_UnitFrames.CheckSettings();
	end);

	TRP3_UFPanel.scrollChild.TargetBackColorCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild, "UICheckButtonTemplate");
	TRP3_UFPanel.scrollChild.TargetBackColorCheckbox:SetPoint("TOPLEFT", 300, -53 * 5);
	TRP3_UFPanel.scrollChild.TargetBackColorCheckbox.Text:SetText(L["OverwriteBackCol"])
	TRP3_UFPanel.scrollChild.TargetBackColorCheckbox:SetScript("OnClick", function(self)
		TRP3_UF_DB.Target.colorBackCustom = self:GetChecked()
		if trpPlayer.UpdateInfo then trpPlayer.UpdateInfo() end
		if trpTarget.UpdateInfo then trpTarget.UpdateInfo() end
		TRP3_UnitFrames.CheckSettings();
	end);

	TRP3_UFPanel.scrollChild.TargetClassTextColorCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild, "UICheckButtonTemplate");
	TRP3_UFPanel.scrollChild.TargetClassTextColorCheckbox:SetPoint("TOPLEFT", 300, -53 * 5.5);
	TRP3_UFPanel.scrollChild.TargetClassTextColorCheckbox.Text:SetText(L["BlizzTextCol"])
	TRP3_UFPanel.scrollChild.TargetClassTextColorCheckbox:SetScript("OnClick", function(self)
		TRP3_UF_DB.Target.colorTextClass = self:GetChecked()
		if trpPlayer.UpdateInfo then trpPlayer.UpdateInfo() end
		if trpTarget.UpdateInfo then trpTarget.UpdateInfo() end
		TRP3_UnitFrames.CheckSettings();
	end);

	TRP3_UFPanel.scrollChild.TargetClassBackColorCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild, "UICheckButtonTemplate");
	TRP3_UFPanel.scrollChild.TargetClassBackColorCheckbox:SetPoint("TOPLEFT", 300, -53 * 6);
	TRP3_UFPanel.scrollChild.TargetClassBackColorCheckbox.Text:SetText(L["BlizzBackCol"])
	TRP3_UFPanel.scrollChild.TargetClassBackColorCheckbox:SetScript("OnClick", function(self)
		TRP3_UF_DB.Target.colorBackClass = self:GetChecked()
		if trpPlayer.UpdateInfo then trpPlayer.UpdateInfo() end
		if trpTarget.UpdateInfo then trpTarget.UpdateInfo() end
		TRP3_UnitFrames.CheckSettings();
	end);

	TRP3_UFPanel.scrollChild.PlayerTextColorCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild, "UICheckButtonTemplate");
	TRP3_UFPanel.scrollChild.PlayerTextColorCheckbox:SetPoint("TOPLEFT", 300, -53 * 7);
	TRP3_UFPanel.scrollChild.PlayerTextColorCheckbox.Text:SetText(L["OverwriteTextCol"])
	TRP3_UFPanel.scrollChild.PlayerTextColorCheckbox:SetScript("OnClick", function(self)
		TRP3_UF_DB.Player.colorTextCustom = self:GetChecked()
		if trpPlayer.UpdateInfo then trpPlayer.UpdateInfo() end
		if trpTarget.UpdateInfo then trpTarget.UpdateInfo() end
		TRP3_UnitFrames.CheckSettings();
	end);

	TRP3_UFPanel.scrollChild.PlayerBackColorCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild, "UICheckButtonTemplate");
	TRP3_UFPanel.scrollChild.PlayerBackColorCheckbox:SetPoint("TOPLEFT", 300, -53 * 7.5);
	TRP3_UFPanel.scrollChild.PlayerBackColorCheckbox.Text:SetText(L["OverwriteBackCol"])
	TRP3_UFPanel.scrollChild.PlayerBackColorCheckbox:SetScript("OnClick", function(self)
		TRP3_UF_DB.Player.colorBackCustom = self:GetChecked()
		if trpPlayer.UpdateInfo then trpPlayer.UpdateInfo() end
		if trpTarget.UpdateInfo then trpTarget.UpdateInfo() end
		TRP3_UnitFrames.CheckSettings();
	end);

	TRP3_UFPanel.scrollChild.PlayerClassTextColorCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild, "UICheckButtonTemplate");
	TRP3_UFPanel.scrollChild.PlayerClassTextColorCheckbox:SetPoint("TOPLEFT", 300, -53 * 8);
	TRP3_UFPanel.scrollChild.PlayerClassTextColorCheckbox.Text:SetText(L["BlizzTextCol"])
	TRP3_UFPanel.scrollChild.PlayerClassTextColorCheckbox:SetScript("OnClick", function(self)
		TRP3_UF_DB.Player.colorTextClass = self:GetChecked()
		if trpPlayer.UpdateInfo then trpPlayer.UpdateInfo() end
		if trpTarget.UpdateInfo then trpTarget.UpdateInfo() end
		TRP3_UnitFrames.CheckSettings();
	end);

	TRP3_UFPanel.scrollChild.PlayerClassBackColorCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild, "UICheckButtonTemplate");
	TRP3_UFPanel.scrollChild.PlayerClassBackColorCheckbox:SetPoint("TOPLEFT", 300, -53 * 8.5);
	TRP3_UFPanel.scrollChild.PlayerClassBackColorCheckbox.Text:SetText(L["BlizzBackCol"])
	TRP3_UFPanel.scrollChild.PlayerClassBackColorCheckbox:SetScript("OnClick", function(self)
		TRP3_UF_DB.Player.colorBackClass = self:GetChecked()
		if trpPlayer.UpdateInfo then trpPlayer.UpdateInfo() end
		if trpTarget.UpdateInfo then trpTarget.UpdateInfo() end
		TRP3_UnitFrames.CheckSettings();
	end);

	TRP3_UFPanel.scrollChild.NPCOptionsCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild, "UICheckButtonTemplate");
	TRP3_UFPanel.scrollChild.NPCOptionsCheckbox:SetPoint("TOPLEFT", 300, -53 * 9.5);
	TRP3_UFPanel.scrollChild.NPCOptionsCheckbox.Text:SetText(L["ApplyToNPCs"])
	TRP3_UFPanel.scrollChild.NPCOptionsCheckbox:SetScript("OnClick", function(self)
		TRP3_UF_DB.Setting.NPCs = self:GetChecked()
		if trpTarget.UpdateInfo then trpTarget.UpdateInfo() end
		TRP3_UnitFrames.CheckSettings();
	end);

	TRP3_UFPanel.scrollChild.UseTRP3NameCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild, "UICheckButtonTemplate");
	TRP3_UFPanel.scrollChild.UseTRP3NameCheckbox:SetPoint("TOPLEFT", 300, -53 * 10);
	TRP3_UFPanel.scrollChild.UseTRP3NameCheckbox.Text:SetText(L["TRP3CustomName"])
	TRP3_UFPanel.scrollChild.UseTRP3NameCheckbox:SetScript("OnClick", function(self)
		TRP3_UF_DB.Setting.UseTRPName = self:GetChecked()
		TRP3_UFPanel.scrollChild.FullNamePCheckbox:SetEnabled(TRP3_UF_DB.Setting.UseTRPName)
		TRP3_UFPanel.scrollChild.FullNameTCheckbox:SetEnabled(TRP3_UF_DB.Setting.UseTRPName)
		if trpPlayer.UpdateInfo then trpPlayer.UpdateInfo() end
		if trpTarget.UpdateInfo then trpTarget.UpdateInfo() end
		TRP3_UnitFrames.CheckSettings();
	end);

	TRP3_UFPanel.scrollChild.FullNamePCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild, "UICheckButtonTemplate");
	TRP3_UFPanel.scrollChild.FullNamePCheckbox:SetPoint("TOPLEFT", 300, -53 * 10.5);
	TRP3_UFPanel.scrollChild.FullNamePCheckbox.Text:SetText(L["FullNamePlayer"])
	TRP3_UFPanel.scrollChild.FullNamePCheckbox:SetScript("OnClick", function(self)
		TRP3_UF_DB.Setting.FullNamePlayer = self:GetChecked()
		if trpPlayer.UpdateInfo then trpPlayer.UpdateInfo() end
		if trpTarget.UpdateInfo then trpTarget.UpdateInfo() end
		TRP3_UnitFrames.CheckSettings();
	end);

	TRP3_UFPanel.scrollChild.FullNameTCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild, "UICheckButtonTemplate");
	TRP3_UFPanel.scrollChild.FullNameTCheckbox:SetPoint("TOPLEFT", 300, -53 * 11);
	TRP3_UFPanel.scrollChild.FullNameTCheckbox.Text:SetText(L["FullNameTarget"])
	TRP3_UFPanel.scrollChild.FullNameTCheckbox:SetScript("OnClick", function(self)
		TRP3_UF_DB.Setting.FullNameTarget = self:GetChecked()
		if trpPlayer.UpdateInfo then trpPlayer.UpdateInfo() end
		if trpTarget.UpdateInfo then trpTarget.UpdateInfo() end
		TRP3_UnitFrames.CheckSettings();
	end);

	TRP3_UFPanel.scrollChild.TarCustomTextColButton = CreateFrame("Button", nil, TRP3_UFPanel.scrollChild, "SharedGoldRedButtonSmallTemplate")
	TRP3_UFPanel.scrollChild.TarCustomTextColButton:SetPoint("TOPLEFT", 150 * 3.3, -53 * 4.6);
	TRP3_UFPanel.scrollChild.TarCustomTextColButton:SetSize(120, 26);
	TRP3_UFPanel.scrollChild.TarCustomTextColButton:SetText(COLOR_PICKER)
	TRP3_UFPanel.scrollChild.TarCustomTextColButton:SetScript("OnClick", function() TRP3_UnitFrames.ShowColorPicker(TRP3_UF_DB.Target.colorText); end)

	TRP3_UFPanel.scrollChild.TarCustomBackColButton = CreateFrame("Button", nil, TRP3_UFPanel.scrollChild, "SharedGoldRedButtonSmallTemplate")
	TRP3_UFPanel.scrollChild.TarCustomBackColButton:SetPoint("TOPLEFT", 150 * 3.3, -53 * 5.1);
	TRP3_UFPanel.scrollChild.TarCustomBackColButton:SetSize(120, 26);
	TRP3_UFPanel.scrollChild.TarCustomBackColButton:SetText(COLOR_PICKER)
	TRP3_UFPanel.scrollChild.TarCustomBackColButton:SetScript("OnClick", function() TRP3_UnitFrames.ShowColorPicker(TRP3_UF_DB.Target.colorBack); end)

	TRP3_UFPanel.scrollChild.PlayerCustomTextColButton = CreateFrame("Button", nil, TRP3_UFPanel.scrollChild, "SharedGoldRedButtonSmallTemplate")
	TRP3_UFPanel.scrollChild.PlayerCustomTextColButton:SetPoint("TOPLEFT", 150 * 3.3, -53 * 7.1);
	TRP3_UFPanel.scrollChild.PlayerCustomTextColButton:SetSize(120, 26);
	TRP3_UFPanel.scrollChild.PlayerCustomTextColButton:SetText(COLOR_PICKER)
	TRP3_UFPanel.scrollChild.PlayerCustomTextColButton:SetScript("OnClick", function() TRP3_UnitFrames.ShowColorPicker(TRP3_UF_DB.Player.colorText); end)

	TRP3_UFPanel.scrollChild.PlayerCustomBackColButton = CreateFrame("Button", nil, TRP3_UFPanel.scrollChild, "SharedGoldRedButtonSmallTemplate")
	TRP3_UFPanel.scrollChild.PlayerCustomBackColButton:SetPoint("TOPLEFT", 150 * 3.3, -53 * 7.6);
	TRP3_UFPanel.scrollChild.PlayerCustomBackColButton:SetSize(120, 26);
	TRP3_UFPanel.scrollChild.PlayerCustomBackColButton:SetText(COLOR_PICKER)
	TRP3_UFPanel.scrollChild.PlayerCustomBackColButton:SetScript("OnClick", function() TRP3_UnitFrames.ShowColorPicker(TRP3_UF_DB.Player.colorBack); end)

	TRP3_UFPanel.scrollChild.PortraitButton = CreateFrame("DropdownButton", nil, TRP3_UFPanel.scrollChild, "WowStyle1DropdownTemplate")
	TRP3_UFPanel.scrollChild.PortraitButton:SetDefaultText(L["PlayerPortrait"])
	TRP3_UFPanel.scrollChild.PortraitButton:SetPoint("TOPLEFT", 150, -53 * 5.1);
	TRP3_UFPanel.scrollChild.PortraitButton:SetSize(120, 26);
	TRP3_UFPanel.scrollChild.PortraitButton:SetupMenu(function(dropdown, rootDescription)
		for _, menu in ipairs(TRP3_UFPanel.menuNew) do
			local elementDescription = rootDescription:CreateButton(menu.ThemeName)
			if menu.Data then
				for k, v in ipairs(menu.Data) do
					elementDescription:CreateButton(v.styleName, function()
						TRP3_UF_DB.Border.style = v.fileName
						if trpPlayer.SetAsPortrait then trpPlayer.SetAsPortrait() end
					end)
				end
			else
				elementDescription:SetEnabled(false)
				elementDescription:SetTooltip(function(tooltip, elementDesc)
					GameTooltip_SetTitle(tooltip, MenuUtil.GetElementText(elementDesc));
					GameTooltip_AddErrorLine(tooltip, menu.ThemeDesc);
				end);
			end
		end
	end)


	--DUPLICATE OF THE SETTINGS PANEL, BUT FOR TRP3 WINDOW. WILL BE REMOVING THIS SOME DAY
	-- (spoiler alert, we did not, in fact, end up removing this)

	local TRP3_UFSettingsFrame = CreateFrame("ScrollFrame", "TRP3_UFSettingsFrame", UIParent, "ScrollFrameTemplate")
	TRP3_UFSettingsFrame:ClearAllPoints()
	TRP3_UFSettingsFrame:Hide()
	TRP3_UFSettingsFrame.Backdrop = CreateFrame("Frame", nil, TRP3_UFSettingsFrame, "InsetFrameTemplate")
	TRP3_UFSettingsFrame.Backdrop:SetAllPoints(TRP3_UFSettingsFrame)

	TRP3_UFPanel.TRP3_scrollChild = CreateFrame("Frame")
	TRP3_UFSettingsFrame:SetScrollChild(TRP3_UFPanel.TRP3_scrollChild)
	TRP3_UFPanel.TRP3_scrollChild:SetWidth(SettingsPanel:GetWidth() - 18)
	TRP3_UFPanel.TRP3_scrollChild:SetHeight(1)

	TRP3_UFPanel.TRP3_scrollChild.TopTitle = TRP3_UFPanel.TRP3_scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal");
	TRP3_UFPanel.TRP3_scrollChild.TopTitle:SetFont(TRP3_UFPanel.TRP3_scrollChild.TopTitle:GetFont(), 20);
	TRP3_UFPanel.TRP3_scrollChild.TopTitle:SetPoint("TOPLEFT", TRP3_UFPanel.TRP3_scrollChild, "TOPLEFT", 50, -25);
	TRP3_UFPanel.TRP3_scrollChild.TopTitle:SetText(TRP3_API.utils.Oldgodify(L["Title"]));

	BuildDummyFrames(TRP3_UFPanel.TRP3_scrollChild, 15, -53, 325, -53, "TRP3_UFSettingsRepDummyPlayer", "TRP3_UFSettingsRepTextDummyPlayer", "TRP3_UFSettingsRepDummyTarget", "TRP3_UFSettingsRepTextDummyTarget")

	TRP3_UFPanel.TRP3_scrollChild.VisibilityText = TRP3_UFPanel.TRP3_scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal");
	TRP3_UFPanel.TRP3_scrollChild.VisibilityText:SetFont(TRP3_UFPanel.TRP3_scrollChild.VisibilityText:GetFont(), 15);
	TRP3_UFPanel.TRP3_scrollChild.VisibilityText:SetPoint("TOPLEFT", 5, -53 * 3.7);
	TRP3_UFPanel.TRP3_scrollChild.VisibilityText:SetText(L["Visibility"]);

	TRP3_UFPanel.TRP3_scrollChild.PShowCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild, "UICheckButtonTemplate");
	TRP3_UFPanel.TRP3_scrollChild.PShowCheckbox:SetPoint("TOPLEFT", 5, -53 * 4);
	TRP3_UFPanel.TRP3_scrollChild.PShowCheckbox.Text:SetText(L["ShowButtonPlayer"]);
	TRP3_UFPanel.TRP3_scrollChild.PShowCheckbox:SetScript("OnClick", function(self)
		TRP3_UF_DB.Player.show = self:GetChecked()
		if trpPlayer.SetVisible then trpPlayer.SetVisible() end
		TRP3_UnitFrames.CheckSettings();
	end);

	TRP3_UFPanel.TRP3_scrollChild.TShowCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild, "UICheckButtonTemplate");
	TRP3_UFPanel.TRP3_scrollChild.TShowCheckbox:SetPoint("TOPLEFT", 5, -53 * 4.5);
	TRP3_UFPanel.TRP3_scrollChild.TShowCheckbox.Text:SetText(L["ShowButtonTarget"]);
	TRP3_UFPanel.TRP3_scrollChild.TShowCheckbox:SetScript("OnClick", function(self)
		TRP3_UF_DB.Target.show = self:GetChecked()
		if trpPlayer.SetVisible then trpPlayer.SetVisible() end
		TRP3_UnitFrames.CheckSettings();
	end);

	TRP3_UFPanel.TRP3_scrollChild.PortShowCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild, "UICheckButtonTemplate");
	TRP3_UFPanel.TRP3_scrollChild.PortShowCheckbox:SetPoint("TOPLEFT", 5, -53 * 5);
	TRP3_UFPanel.TRP3_scrollChild.PortShowCheckbox.Text:SetText(L["ShowBorderFrame"]);
	TRP3_UFPanel.TRP3_scrollChild.PortShowCheckbox:SetScript("OnClick", function(self)
		TRP3_UF_DB.Border.show = self:GetChecked()
		TRP3_UFPanel.TRP3_scrollChild.PortraitButton:SetEnabled(TRP3_UF_DB.Border.show)
		local pdf = TRP3_UnitFrames.PlayerDragonFrame
		if pdf then
			if TRP3_UF_DB.Border.show then pdf:Show() else pdf:Hide() end
		end
		if trpPlayer.SetAsPortrait then trpPlayer.SetAsPortrait() end
		TRP3_UnitFrames.CheckSettings();
	end);

	TRP3_UFPanel.TRP3_scrollChild.StatusHideCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild, "UICheckButtonTemplate");
	TRP3_UFPanel.TRP3_scrollChild.StatusHideCheckbox:SetPoint("TOPLEFT", 5, -53 * 6.0);
	TRP3_UFPanel.TRP3_scrollChild.StatusHideCheckbox.Text:SetText(L["HideRestedGlow"]);
	TRP3_UFPanel.TRP3_scrollChild.StatusHideCheckbox:SetScript("OnClick", function(self)
		TRP3_UF_DB.Border.status = self:GetChecked()
		if self:GetChecked() then
			PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture:Hide()
		else
			PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture:Show()
		end
		TRP3_UnitFrames.CheckSettings();
	end);

	TRP3_UFPanel.TRP3_scrollChild.TargetSizeSlider = CreateFrame("Slider", nil, TRP3_UFPanel.TRP3_scrollChild, "OptionsSliderTemplate");
	TRP3_UFPanel.TRP3_scrollChild.TargetSizeSlider:SetWidth(250); TRP3_UFPanel.TRP3_scrollChild.TargetSizeSlider:SetHeight(15);
	TRP3_UFPanel.TRP3_scrollChild.TargetSizeSlider:SetMinMaxValues(0.5, 15); TRP3_UFPanel.TRP3_scrollChild.TargetSizeSlider:SetValueStep(.5); TRP3_UFPanel.TRP3_scrollChild.TargetSizeSlider:SetObeyStepOnDrag(true)
	TRP3_UFPanel.TRP3_scrollChild.TargetSizeSlider:SetPoint("TOPLEFT", TRP3_UFPanel.TRP3_scrollChild, "TOPLEFT", 10, -53 * 6.75);
	TRP3_UFPanel.TRP3_scrollChild.TargetSizeSlider.Low:SetText("0.5"); TRP3_UFPanel.TRP3_scrollChild.TargetSizeSlider.High:SetText("15");
	TRP3_UFPanel.TRP3_scrollChild.TargetSizeSlider.Text:SetText(L["ButtonSizeTarget"]);
	TRP3_UFPanel.TRP3_scrollChild.TargetSizeSlider:SetScript("OnValueChanged", function(self)
		TRP3_UF_DB.Target.scale = self:GetValue()
		if trpTarget.button then trpTarget.button:SetScale(TRP3_UF_DB.Target.scale) end
		TRP3_UnitFrames.CheckSettings();
	end)

	TRP3_UFPanel.TRP3_scrollChild.TargetPosSlider = CreateFrame("Slider", nil, TRP3_UFPanel.TRP3_scrollChild, "OptionsSliderTemplate");
	TRP3_UFPanel.TRP3_scrollChild.TargetPosSlider:SetWidth(250); TRP3_UFPanel.TRP3_scrollChild.TargetPosSlider:SetHeight(15);
	TRP3_UFPanel.TRP3_scrollChild.TargetPosSlider:SetMinMaxValues(-15, 15); TRP3_UFPanel.TRP3_scrollChild.TargetPosSlider:SetValueStep(.5); TRP3_UFPanel.TRP3_scrollChild.TargetPosSlider:SetObeyStepOnDrag(true)
	TRP3_UFPanel.TRP3_scrollChild.TargetPosSlider:SetPoint("TOPLEFT", TRP3_UFPanel.TRP3_scrollChild, "TOPLEFT", 10, -53 * 7.5);
	TRP3_UFPanel.TRP3_scrollChild.TargetPosSlider.Low:SetText("-15"); TRP3_UFPanel.TRP3_scrollChild.TargetPosSlider.High:SetText("15");
	TRP3_UFPanel.TRP3_scrollChild.TargetPosSlider.Text:SetText(L["ButtonPosTarget"]);
	TRP3_UFPanel.TRP3_scrollChild.TargetPosSlider:SetScript("OnValueChanged", function(self)
		TRP3_UF_DB.Target.position = self:GetValue()
		if trpTarget.SetPos then trpTarget.SetPos() end
		TRP3_UnitFrames.CheckSettings();
	end)

	TRP3_UFPanel.TRP3_scrollChild.PlayerSizeSlider = CreateFrame("Slider", nil, TRP3_UFPanel.TRP3_scrollChild, "OptionsSliderTemplate");
	TRP3_UFPanel.TRP3_scrollChild.PlayerSizeSlider:SetWidth(250); TRP3_UFPanel.TRP3_scrollChild.PlayerSizeSlider:SetHeight(15);
	TRP3_UFPanel.TRP3_scrollChild.PlayerSizeSlider:SetMinMaxValues(0.5, 15); TRP3_UFPanel.TRP3_scrollChild.PlayerSizeSlider:SetValueStep(.5); TRP3_UFPanel.TRP3_scrollChild.PlayerSizeSlider:SetObeyStepOnDrag(true)
	TRP3_UFPanel.TRP3_scrollChild.PlayerSizeSlider:SetPoint("TOPLEFT", TRP3_UFPanel.TRP3_scrollChild, "TOPLEFT", 10, -53 * 8.25);
	TRP3_UFPanel.TRP3_scrollChild.PlayerSizeSlider.Low:SetText("0.5"); TRP3_UFPanel.TRP3_scrollChild.PlayerSizeSlider.High:SetText("15");
	TRP3_UFPanel.TRP3_scrollChild.PlayerSizeSlider.Text:SetText(L["ButtonSizePlayer"]);
	TRP3_UFPanel.TRP3_scrollChild.PlayerSizeSlider:SetScript("OnValueChanged", function(self)
		TRP3_UF_DB.Player.scale = self:GetValue()
		if trpPlayer.button then trpPlayer.button:SetScale(TRP3_UF_DB.Player.scale) end
		TRP3_UnitFrames.CheckSettings();
	end)

	TRP3_UFPanel.TRP3_scrollChild.PlayerPosSlider = CreateFrame("Slider", nil, TRP3_UFPanel.TRP3_scrollChild, "OptionsSliderTemplate");
	TRP3_UFPanel.TRP3_scrollChild.PlayerPosSlider:SetWidth(250); TRP3_UFPanel.TRP3_scrollChild.PlayerPosSlider:SetHeight(15);
	TRP3_UFPanel.TRP3_scrollChild.PlayerPosSlider:SetMinMaxValues(-15, 15); TRP3_UFPanel.TRP3_scrollChild.PlayerPosSlider:SetValueStep(.5); TRP3_UFPanel.TRP3_scrollChild.PlayerPosSlider:SetObeyStepOnDrag(true)
	TRP3_UFPanel.TRP3_scrollChild.PlayerPosSlider:SetPoint("TOPLEFT", TRP3_UFPanel.TRP3_scrollChild, "TOPLEFT", 10, -53 * 9);
	TRP3_UFPanel.TRP3_scrollChild.PlayerPosSlider.Low:SetText("-15"); TRP3_UFPanel.TRP3_scrollChild.PlayerPosSlider.High:SetText("15");
	TRP3_UFPanel.TRP3_scrollChild.PlayerPosSlider.Text:SetText(L["ButtonPosPlayer"]);
	TRP3_UFPanel.TRP3_scrollChild.PlayerPosSlider:SetScript("OnValueChanged", function(self)
		TRP3_UF_DB.Player.position = self:GetValue()
		if trpPlayer.SetPos then trpPlayer.SetPos() end
		TRP3_UnitFrames.CheckSettings();
	end)

	TRP3_UFPanel.TRP3_scrollChild.ColorsText = TRP3_UFPanel.TRP3_scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal");
	TRP3_UFPanel.TRP3_scrollChild.ColorsText:SetFont(TRP3_UFPanel.TRP3_scrollChild.ColorsText:GetFont(), 15);
	TRP3_UFPanel.TRP3_scrollChild.ColorsText:SetPoint("TOPLEFT", 300, -53 * 3.7);
	TRP3_UFPanel.TRP3_scrollChild.ColorsText:SetText(COLORS);

	TRP3_UFPanel.TRP3_scrollChild.ColorsTarText = TRP3_UFPanel.TRP3_scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal");
	TRP3_UFPanel.TRP3_scrollChild.ColorsTarText:SetPoint("TOPLEFT", 300, -53 * 4.2);
	TRP3_UFPanel.TRP3_scrollChild.ColorsTarText:SetText(HUD_EDIT_MODE_TARGET_FRAME_LABEL);

	TRP3_UFPanel.TRP3_scrollChild.ColorsPlayerText = TRP3_UFPanel.TRP3_scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal");
	TRP3_UFPanel.TRP3_scrollChild.ColorsPlayerText:SetPoint("TOPLEFT", 300, -53 * 7.7);
	TRP3_UFPanel.TRP3_scrollChild.ColorsPlayerText:SetText(HUD_EDIT_MODE_PLAYER_FRAME_LABEL);

	TRP3_UFPanel.TRP3_scrollChild.TargetTextColorCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild, "UICheckButtonTemplate");
	TRP3_UFPanel.TRP3_scrollChild.TargetTextColorCheckbox:SetPoint("TOPLEFT", 300, -53 * 4.5);
	TRP3_UFPanel.TRP3_scrollChild.TargetTextColorCheckbox.Text:SetText(L["OverwriteTextCol"])
	TRP3_UFPanel.TRP3_scrollChild.TargetTextColorCheckbox:SetScript("OnClick", function(self)
		TRP3_UF_DB.Target.colorTextCustom = self:GetChecked()
		if trpPlayer.UpdateInfo then trpPlayer.UpdateInfo() end
		if trpTarget.UpdateInfo then trpTarget.UpdateInfo() end
		TRP3_UnitFrames.CheckSettings();
	end);

	TRP3_UFPanel.TRP3_scrollChild.TargetBackColorCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild, "UICheckButtonTemplate");
	TRP3_UFPanel.TRP3_scrollChild.TargetBackColorCheckbox:SetPoint("TOPLEFT", 300, -53 * 5.5);
	TRP3_UFPanel.TRP3_scrollChild.TargetBackColorCheckbox.Text:SetText(L["OverwriteBackCol"])
	TRP3_UFPanel.TRP3_scrollChild.TargetBackColorCheckbox:SetScript("OnClick", function(self)
		TRP3_UF_DB.Target.colorBackCustom = self:GetChecked()
		if trpPlayer.UpdateInfo then trpPlayer.UpdateInfo() end
		if trpTarget.UpdateInfo then trpTarget.UpdateInfo() end
		TRP3_UnitFrames.CheckSettings();
	end);

	TRP3_UFPanel.TRP3_scrollChild.TargetClassTextColorCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild, "UICheckButtonTemplate");
	TRP3_UFPanel.TRP3_scrollChild.TargetClassTextColorCheckbox:SetPoint("TOPLEFT", 300, -53 * 6.5);
	TRP3_UFPanel.TRP3_scrollChild.TargetClassTextColorCheckbox.Text:SetText(L["BlizzTextCol"])
	TRP3_UFPanel.TRP3_scrollChild.TargetClassTextColorCheckbox:SetScript("OnClick", function(self)
		TRP3_UF_DB.Target.colorTextClass = self:GetChecked()
		if trpPlayer.UpdateInfo then trpPlayer.UpdateInfo() end
		if trpTarget.UpdateInfo then trpTarget.UpdateInfo() end
		TRP3_UnitFrames.CheckSettings();
	end);

	TRP3_UFPanel.TRP3_scrollChild.TargetClassBackColorCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild, "UICheckButtonTemplate");
	TRP3_UFPanel.TRP3_scrollChild.TargetClassBackColorCheckbox:SetPoint("TOPLEFT", 300, -53 * 7);
	TRP3_UFPanel.TRP3_scrollChild.TargetClassBackColorCheckbox.Text:SetText(L["BlizzBackCol"])
	TRP3_UFPanel.TRP3_scrollChild.TargetClassBackColorCheckbox:SetScript("OnClick", function(self)
		TRP3_UF_DB.Target.colorBackClass = self:GetChecked()
		if trpPlayer.UpdateInfo then trpPlayer.UpdateInfo() end
		if trpTarget.UpdateInfo then trpTarget.UpdateInfo() end
		TRP3_UnitFrames.CheckSettings();
	end);

	TRP3_UFPanel.TRP3_scrollChild.PlayerTextColorCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild, "UICheckButtonTemplate");
	TRP3_UFPanel.TRP3_scrollChild.PlayerTextColorCheckbox:SetPoint("TOPLEFT", 300, -53 * 8);
	TRP3_UFPanel.TRP3_scrollChild.PlayerTextColorCheckbox.Text:SetText(L["OverwriteTextCol"])
	TRP3_UFPanel.TRP3_scrollChild.PlayerTextColorCheckbox:SetScript("OnClick", function(self)
		TRP3_UF_DB.Player.colorTextCustom = self:GetChecked()
		if trpPlayer.UpdateInfo then trpPlayer.UpdateInfo() end
		if trpTarget.UpdateInfo then trpTarget.UpdateInfo() end
		TRP3_UnitFrames.CheckSettings();
	end);

	TRP3_UFPanel.TRP3_scrollChild.PlayerBackColorCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild, "UICheckButtonTemplate");
	TRP3_UFPanel.TRP3_scrollChild.PlayerBackColorCheckbox:SetPoint("TOPLEFT", 300, -53 * 9);
	TRP3_UFPanel.TRP3_scrollChild.PlayerBackColorCheckbox.Text:SetText(L["OverwriteBackCol"])
	TRP3_UFPanel.TRP3_scrollChild.PlayerBackColorCheckbox:SetScript("OnClick", function(self)
		TRP3_UF_DB.Player.colorBackCustom = self:GetChecked()
		if trpPlayer.UpdateInfo then trpPlayer.UpdateInfo() end
		if trpTarget.UpdateInfo then trpTarget.UpdateInfo() end
		TRP3_UnitFrames.CheckSettings();
	end);

	TRP3_UFPanel.TRP3_scrollChild.PlayerClassTextColorCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild, "UICheckButtonTemplate");
	TRP3_UFPanel.TRP3_scrollChild.PlayerClassTextColorCheckbox:SetPoint("TOPLEFT", 300, -53 * 10);
	TRP3_UFPanel.TRP3_scrollChild.PlayerClassTextColorCheckbox.Text:SetText(L["BlizzTextCol"])
	TRP3_UFPanel.TRP3_scrollChild.PlayerClassTextColorCheckbox:SetScript("OnClick", function(self)
		TRP3_UF_DB.Player.colorTextClass = self:GetChecked()
		if trpPlayer.UpdateInfo then trpPlayer.UpdateInfo() end
		if trpTarget.UpdateInfo then trpTarget.UpdateInfo() end
		TRP3_UnitFrames.CheckSettings();
	end);

	TRP3_UFPanel.TRP3_scrollChild.PlayerClassBackColorCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild, "UICheckButtonTemplate");
	TRP3_UFPanel.TRP3_scrollChild.PlayerClassBackColorCheckbox:SetPoint("TOPLEFT", 300, -53 * 10.5);
	TRP3_UFPanel.TRP3_scrollChild.PlayerClassBackColorCheckbox.Text:SetText(L["BlizzBackCol"])
	TRP3_UFPanel.TRP3_scrollChild.PlayerClassBackColorCheckbox:SetScript("OnClick", function(self)
		TRP3_UF_DB.Player.colorBackClass = self:GetChecked()
		if trpPlayer.UpdateInfo then trpPlayer.UpdateInfo() end
		if trpTarget.UpdateInfo then trpTarget.UpdateInfo() end
		TRP3_UnitFrames.CheckSettings();
	end);

	TRP3_UFPanel.TRP3_scrollChild.NPCOptionsCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild, "UICheckButtonTemplate");
	TRP3_UFPanel.TRP3_scrollChild.NPCOptionsCheckbox:SetPoint("TOPLEFT", 300, -53 * 11.5);
	TRP3_UFPanel.TRP3_scrollChild.NPCOptionsCheckbox.Text:SetText(L["ApplyToNPCs"])
	TRP3_UFPanel.TRP3_scrollChild.NPCOptionsCheckbox:SetScript("OnClick", function(self)
		TRP3_UF_DB.Setting.NPCs = self:GetChecked()
		if trpTarget.UpdateInfo then trpTarget.UpdateInfo() end
		TRP3_UnitFrames.CheckSettings();
	end);

	TRP3_UFPanel.TRP3_scrollChild.UseTRP3NameCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild, "UICheckButtonTemplate");
	TRP3_UFPanel.TRP3_scrollChild.UseTRP3NameCheckbox:SetPoint("TOPLEFT", 300, -53 * 12);
	TRP3_UFPanel.TRP3_scrollChild.UseTRP3NameCheckbox.Text:SetText(L["TRP3CustomName"])
	TRP3_UFPanel.TRP3_scrollChild.UseTRP3NameCheckbox:SetScript("OnClick", function(self)
		TRP3_UF_DB.Setting.UseTRPName = self:GetChecked()
		TRP3_UFPanel.TRP3_scrollChild.FullNamePCheckbox:SetEnabled(TRP3_UF_DB.Setting.UseTRPName)
		TRP3_UFPanel.TRP3_scrollChild.FullNameTCheckbox:SetEnabled(TRP3_UF_DB.Setting.UseTRPName)
		if trpPlayer.UpdateInfo then trpPlayer.UpdateInfo() end
		if trpTarget.UpdateInfo then trpTarget.UpdateInfo() end
		TRP3_UnitFrames.CheckSettings();
	end);

	TRP3_UFPanel.TRP3_scrollChild.FullNamePCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild, "UICheckButtonTemplate");
	TRP3_UFPanel.TRP3_scrollChild.FullNamePCheckbox:SetPoint("TOPLEFT", 300, -53 * 12.5);
	TRP3_UFPanel.TRP3_scrollChild.FullNamePCheckbox.Text:SetText(L["FullNamePlayer"])
	TRP3_UFPanel.TRP3_scrollChild.FullNamePCheckbox:SetScript("OnClick", function(self)
		TRP3_UF_DB.Setting.FullNamePlayer = self:GetChecked()
		if trpPlayer.UpdateInfo then trpPlayer.UpdateInfo() end
		if trpTarget.UpdateInfo then trpTarget.UpdateInfo() end
		TRP3_UnitFrames.CheckSettings();
	end);

	TRP3_UFPanel.TRP3_scrollChild.FullNameTCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild, "UICheckButtonTemplate");
	TRP3_UFPanel.TRP3_scrollChild.FullNameTCheckbox:SetPoint("TOPLEFT", 300, -53 * 13);
	TRP3_UFPanel.TRP3_scrollChild.FullNameTCheckbox.Text:SetText(L["FullNameTarget"])
	TRP3_UFPanel.TRP3_scrollChild.FullNameTCheckbox:SetScript("OnClick", function(self)
		TRP3_UF_DB.Setting.FullNameTarget = self:GetChecked()
		if trpPlayer.UpdateInfo then trpPlayer.UpdateInfo() end
		if trpTarget.UpdateInfo then trpTarget.UpdateInfo() end
		TRP3_UnitFrames.CheckSettings();
	end);

	TRP3_UFPanel.TRP3_scrollChild.TarCustomTextColButton = CreateFrame("Button", nil, TRP3_UFPanel.TRP3_scrollChild, "SharedGoldRedButtonSmallTemplate")
	TRP3_UFPanel.TRP3_scrollChild.TarCustomTextColButton:SetPoint("TOPLEFT", 305, -53 * 5.1);
	TRP3_UFPanel.TRP3_scrollChild.TarCustomTextColButton:SetSize(120, 26);
	TRP3_UFPanel.TRP3_scrollChild.TarCustomTextColButton:SetText(COLOR_PICKER)
	TRP3_UFPanel.TRP3_scrollChild.TarCustomTextColButton:SetScript("OnClick", function() TRP3_UnitFrames.ShowColorPicker(TRP3_UF_DB.Target.colorText); end)

	TRP3_UFPanel.TRP3_scrollChild.TarCustomBackColButton = CreateFrame("Button", nil, TRP3_UFPanel.TRP3_scrollChild, "SharedGoldRedButtonSmallTemplate")
	TRP3_UFPanel.TRP3_scrollChild.TarCustomBackColButton:SetPoint("TOPLEFT", 305, -53 * 6.1);
	TRP3_UFPanel.TRP3_scrollChild.TarCustomBackColButton:SetSize(120, 26);
	TRP3_UFPanel.TRP3_scrollChild.TarCustomBackColButton:SetText(COLOR_PICKER)
	TRP3_UFPanel.TRP3_scrollChild.TarCustomBackColButton:SetScript("OnClick", function() TRP3_UnitFrames.ShowColorPicker(TRP3_UF_DB.Target.colorBack); end)

	TRP3_UFPanel.TRP3_scrollChild.PlayerCustomTextColButton = CreateFrame("Button", nil, TRP3_UFPanel.TRP3_scrollChild, "SharedGoldRedButtonSmallTemplate")
	TRP3_UFPanel.TRP3_scrollChild.PlayerCustomTextColButton:SetPoint("TOPLEFT", 305, -53 * 8.6);
	TRP3_UFPanel.TRP3_scrollChild.PlayerCustomTextColButton:SetSize(120, 26);
	TRP3_UFPanel.TRP3_scrollChild.PlayerCustomTextColButton:SetText(COLOR_PICKER)
	TRP3_UFPanel.TRP3_scrollChild.PlayerCustomTextColButton:SetScript("OnClick", function() TRP3_UnitFrames.ShowColorPicker(TRP3_UF_DB.Player.colorText); end)

	TRP3_UFPanel.TRP3_scrollChild.PlayerCustomBackColButton = CreateFrame("Button", nil, TRP3_UFPanel.TRP3_scrollChild, "SharedGoldRedButtonSmallTemplate")
	TRP3_UFPanel.TRP3_scrollChild.PlayerCustomBackColButton:SetPoint("TOPLEFT", 305, -53 * 9.6);
	TRP3_UFPanel.TRP3_scrollChild.PlayerCustomBackColButton:SetSize(120, 26);
	TRP3_UFPanel.TRP3_scrollChild.PlayerCustomBackColButton:SetText(COLOR_PICKER)
	TRP3_UFPanel.TRP3_scrollChild.PlayerCustomBackColButton:SetScript("OnClick", function() TRP3_UnitFrames.ShowColorPicker(TRP3_UF_DB.Player.colorBack); end)

	TRP3_UFPanel.TRP3_scrollChild.PortraitButton = CreateFrame("DropdownButton", nil, TRP3_UFPanel.TRP3_scrollChild, "WowStyle1DropdownTemplate")
	TRP3_UFPanel.TRP3_scrollChild.PortraitButton:SetDefaultText(L["PlayerPortrait"])
	TRP3_UFPanel.TRP3_scrollChild.PortraitButton:SetPoint("TOPLEFT", 10, -53 * 5.5);
	TRP3_UFPanel.TRP3_scrollChild.PortraitButton:SetSize(120, 26);
	TRP3_UFPanel.TRP3_scrollChild.PortraitButton:SetupMenu(function(dropdown, rootDescription)
		for _, menu in ipairs(TRP3_UFPanel.menuNew) do
			local elementDescription = rootDescription:CreateButton(menu.ThemeName)
			if menu.Data then
				for k, v in ipairs(menu.Data) do
					elementDescription:CreateButton(v.styleName, function()
						TRP3_UF_DB.Border.style = v.fileName
						if trpPlayer.SetAsPortrait then trpPlayer.SetAsPortrait() end
					end)
				end
			else
				elementDescription:SetEnabled(false)
				elementDescription:SetTooltip(function(tooltip, elementDesc)
					GameTooltip_SetTitle(tooltip, MenuUtil.GetElementText(elementDesc));
					GameTooltip_AddErrorLine(tooltip, menu.ThemeDesc);
				end);
			end
		end
	end)


	function TRP3_UnitFrames.CheckSettings() -- this is definitely being yeeted later
		TRP3_UFPanel.scrollChild.PShowCheckbox:SetChecked(TRP3_UF_DB.Player.show);
		TRP3_UFPanel.scrollChild.TShowCheckbox:SetChecked(TRP3_UF_DB.Target.show);
		TRP3_UFPanel.scrollChild.TargetTextColorCheckbox:SetChecked(TRP3_UF_DB.Target.colorTextCustom);
		TRP3_UFPanel.scrollChild.TargetBackColorCheckbox:SetChecked(TRP3_UF_DB.Target.colorBackCustom);
		TRP3_UFPanel.scrollChild.TargetClassTextColorCheckbox:SetChecked(TRP3_UF_DB.Target.colorTextClass);
		TRP3_UFPanel.scrollChild.TargetClassBackColorCheckbox:SetChecked(TRP3_UF_DB.Target.colorBackClass);
		TRP3_UFPanel.scrollChild.TarCustomTextColButton:SetEnabled(TRP3_UF_DB.Target.colorTextCustom);
		TRP3_UFPanel.scrollChild.TarCustomBackColButton:SetEnabled(TRP3_UF_DB.Target.colorBackCustom);
		TRP3_UFPanel.scrollChild.PlayerTextColorCheckbox:SetChecked(TRP3_UF_DB.Player.colorTextCustom);
		TRP3_UFPanel.scrollChild.PlayerBackColorCheckbox:SetChecked(TRP3_UF_DB.Player.colorBackCustom);
		TRP3_UFPanel.scrollChild.PlayerClassTextColorCheckbox:SetChecked(TRP3_UF_DB.Player.colorTextClass);
		TRP3_UFPanel.scrollChild.PlayerClassBackColorCheckbox:SetChecked(TRP3_UF_DB.Player.colorBackClass);
		TRP3_UFPanel.scrollChild.PlayerCustomTextColButton:SetEnabled(TRP3_UF_DB.Player.colorTextCustom);
		TRP3_UFPanel.scrollChild.PlayerCustomBackColButton:SetEnabled(TRP3_UF_DB.Player.colorBackCustom);
		TRP3_UFPanel.scrollChild.NPCOptionsCheckbox:SetChecked(TRP3_UF_DB.Setting.NPCs);
		TRP3_UFPanel.scrollChild.UseTRP3NameCheckbox:SetChecked(TRP3_UF_DB.Setting.UseTRPName);
		TRP3_UFPanel.scrollChild.FullNamePCheckbox:SetChecked(TRP3_UF_DB.Setting.FullNamePlayer);
		TRP3_UFPanel.scrollChild.FullNameTCheckbox:SetChecked(TRP3_UF_DB.Setting.FullNameTarget);
		TRP3_UFPanel.scrollChild.FullNamePCheckbox:SetEnabled(TRP3_UF_DB.Setting.UseTRPName);
		TRP3_UFPanel.scrollChild.FullNameTCheckbox:SetEnabled(TRP3_UF_DB.Setting.UseTRPName);
		TRP3_UFPanel.scrollChild.PlayerPosSlider:SetValue(TRP3_UF_DB.Player.position)
		TRP3_UFPanel.scrollChild.TargetPosSlider:SetValue(TRP3_UF_DB.Target.position)
		TRP3_UFPanel.scrollChild.PlayerSizeSlider:SetValue(TRP3_UF_DB.Player.scale)
		TRP3_UFPanel.scrollChild.TargetSizeSlider:SetValue(TRP3_UF_DB.Target.scale)
		TRP3_UFPanel.scrollChild.PortShowCheckbox:SetChecked(TRP3_UF_DB.Border.show);
		TRP3_UFPanel.scrollChild.PortraitButton:SetEnabled(TRP3_UF_DB.Border.show);
		TRP3_UFPanel.scrollChild.StatusHideCheckbox:SetChecked(TRP3_UF_DB.Border.status)

		TRP3_UFPanel.TRP3_scrollChild.PShowCheckbox:SetChecked(TRP3_UF_DB.Player.show);
		TRP3_UFPanel.TRP3_scrollChild.TShowCheckbox:SetChecked(TRP3_UF_DB.Target.show);
		TRP3_UFPanel.TRP3_scrollChild.TargetTextColorCheckbox:SetChecked(TRP3_UF_DB.Target.colorTextCustom);
		TRP3_UFPanel.TRP3_scrollChild.TargetBackColorCheckbox:SetChecked(TRP3_UF_DB.Target.colorBackCustom);
		TRP3_UFPanel.TRP3_scrollChild.TargetClassTextColorCheckbox:SetChecked(TRP3_UF_DB.Target.colorTextClass);
		TRP3_UFPanel.TRP3_scrollChild.TargetClassBackColorCheckbox:SetChecked(TRP3_UF_DB.Target.colorBackClass);
		TRP3_UFPanel.TRP3_scrollChild.TarCustomTextColButton:SetEnabled(TRP3_UF_DB.Target.colorTextCustom);
		TRP3_UFPanel.TRP3_scrollChild.TarCustomBackColButton:SetEnabled(TRP3_UF_DB.Target.colorBackCustom);
		TRP3_UFPanel.TRP3_scrollChild.PlayerTextColorCheckbox:SetChecked(TRP3_UF_DB.Player.colorTextCustom);
		TRP3_UFPanel.TRP3_scrollChild.PlayerBackColorCheckbox:SetChecked(TRP3_UF_DB.Player.colorBackCustom);
		TRP3_UFPanel.TRP3_scrollChild.PlayerClassTextColorCheckbox:SetChecked(TRP3_UF_DB.Player.colorTextClass);
		TRP3_UFPanel.TRP3_scrollChild.PlayerClassBackColorCheckbox:SetChecked(TRP3_UF_DB.Player.colorBackClass);
		TRP3_UFPanel.TRP3_scrollChild.PlayerCustomTextColButton:SetEnabled(TRP3_UF_DB.Player.colorTextCustom);
		TRP3_UFPanel.TRP3_scrollChild.PlayerCustomBackColButton:SetEnabled(TRP3_UF_DB.Player.colorBackCustom);
		TRP3_UFPanel.TRP3_scrollChild.NPCOptionsCheckbox:SetChecked(TRP3_UF_DB.Setting.NPCs);
		TRP3_UFPanel.TRP3_scrollChild.UseTRP3NameCheckbox:SetChecked(TRP3_UF_DB.Setting.UseTRPName);
		TRP3_UFPanel.TRP3_scrollChild.FullNamePCheckbox:SetChecked(TRP3_UF_DB.Setting.FullNamePlayer);
		TRP3_UFPanel.TRP3_scrollChild.FullNameTCheckbox:SetChecked(TRP3_UF_DB.Setting.FullNameTarget);
		TRP3_UFPanel.TRP3_scrollChild.FullNamePCheckbox:SetEnabled(TRP3_UF_DB.Setting.UseTRPName);
		TRP3_UFPanel.TRP3_scrollChild.FullNameTCheckbox:SetEnabled(TRP3_UF_DB.Setting.UseTRPName);
		TRP3_UFPanel.TRP3_scrollChild.PlayerPosSlider:SetValue(TRP3_UF_DB.Player.position);
		TRP3_UFPanel.TRP3_scrollChild.TargetPosSlider:SetValue(TRP3_UF_DB.Target.position);
		TRP3_UFPanel.TRP3_scrollChild.PlayerSizeSlider:SetValue(TRP3_UF_DB.Player.scale);
		TRP3_UFPanel.TRP3_scrollChild.TargetSizeSlider:SetValue(TRP3_UF_DB.Target.scale);
		TRP3_UFPanel.TRP3_scrollChild.PortShowCheckbox:SetChecked(TRP3_UF_DB.Border.show);
		TRP3_UFPanel.TRP3_scrollChild.PortraitButton:SetEnabled(TRP3_UF_DB.Border.show);
		TRP3_UFPanel.TRP3_scrollChild.StatusHideCheckbox:SetChecked(TRP3_UF_DB.Border.status);
	end

	local category, layout = Settings.RegisterCanvasLayoutCategory(TRP3_UFPanel, TRP3_UFPanel.name, TRP3_UFPanel.name);
	category.ID = TRP3_UFPanel.name;
	Settings.RegisterAddOnCategory(category)
end