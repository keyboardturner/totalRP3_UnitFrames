local _, L = ...
--CHAT_MSG_ADDON
--PLAYER_TARGET_CHANGED
--UNIT_TARGET -- probably not this one
--TRP3_GlanceBarSlot1
--TargetFrame

--TRP3_API.loc.TF_OPEN_CHARACTER -- "show character page" tooltip
--TRP3_API.loc.CL_OPEN_PROFILE -- "Open profile"
--TRP3_API.loc.UNIT_POPUPS_OPEN_PROFILE -- "Open Profile"
--TRP3_API.loc.BINDING_NAME_TRP3_OPEN_TARGET_PROFILE -- "Open target profile"


--TargetFrame.TargetFrameContent.TargetFrameContentContextual

------------------------------------------------------------------------------------------------------------------
--TRP3_UF_DB

local defaultsTable = {
	Target = {show = true, position = 1, point = "CENTER", relativePoint = "BOTTOMLEFT", scale = 1.5,
		colorText = {r = 1, g = 1, b = 1, custom = false, class = true,},
		colorBack = {r = 0, g = 0, b = 0, a = 1, custom = true, class = false,},
	},
	Player = {show = true, position = 1, point = "CENTER", relativePoint = "BOTTOMRIGHT", scale = 1.5,
		colorText = {r = 1, g = 1, b = 1, custom = false, class = true,},
		colorBack = {r = 0, g = 0, b = 0, a = 1, custom = true, class = false,},
	},

	Border = {show = false, style = "rare-elite",
		color = {r = 1, g = 1, b = 1, a = 1, custom = false, class = false,},
		status = false,
	},

	Setting = {locked = true, charSpecific = false, NPCs = false, FullNamePlayer = true, FullNameTarget = true, UseTRPName = true},

	CurrNotifier = {show = true,
		Border = {r = 1, g = 1, b = 1, a = 1, custom = true, class = false, style = "Interface\\Tooltips\\UI-Tooltip-Background", size = 8,},
		Backdrop = {r = 0, g = 0, b = 0, a = .7, custom = true, class = false, style = "Interface\\Tooltips\\UI-Tooltip-Border", size = 8, tile = false, inset = 3,},
		Text = {r = 1, g = 1, b = 1, custom = false, class = false,},
		Position = {x = 0, y = 0, width = 300, height = 100, scale = 1,},
	},
};

--if TRP3_UF_DB.Setting.charSpecific == true then
--TRP3_CharDB stuff
--

------------------------------------------------------------------------------------------------------------------

local function ShowColorPicker(r, g, b, a, changedCallback)
	ColorPickerFrame.hasOpacity, ColorPickerFrame.opacity = (a ~= nil), a;
	ColorPickerFrame.previousValues = {r,g,b,a};
	ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = changedCallback, changedCallback, changedCallback;
	ColorPickerFrame:SetColorRGB(r,g,b);
	ColorPickerFrame:Hide(); -- Need to run the OnShow handler.
	ColorPickerFrame:Show();
end

local r, g, b, a = 1, 1, 1, 1

local function round(number, decimals)
	return (("%%.%df"):format(decimals)):format(number)
end


local function TargetTextColor(restore)
	local newR, newG, newB, newA; -- I forgot what to do with the alpha value but it's needed to not swap RGB values
	if restore then
	 -- The user bailed, we extract the old color from the table created by ShowColorPicker.
		newR, newG, newB, newA = unpack(restore);
	else
	 -- Something changed
		newA, newR, newG, newB = OpacitySliderFrame:GetValue(), ColorPickerFrame:GetColorRGB();
	end
	 -- Update our internal storage.
	r, g, b, a = newR, newG, newB, newA
	 -- And update any UI elements that use this color...
	TRP3_UF_DB.Target.colorText.r, TRP3_UF_DB.Target.colorText.g, TRP3_UF_DB.Target.colorText.b = newR, newG, newB;
	TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetTextColor(TRP3_UF_DB.Target.colorText.r, TRP3_UF_DB.Target.colorText.g, TRP3_UF_DB.Target.colorText.b)
	TRP3_UFRepTextDummyTarget:SetTextColor(TRP3_UF_DB.Target.colorText.r,TRP3_UF_DB.Target.colorText.g,TRP3_UF_DB.Target.colorText.b)
	TRP3_UFSettingsRepTextDummyTarget:SetTextColor(TRP3_UF_DB.Target.colorText.r,TRP3_UF_DB.Target.colorText.g,TRP3_UF_DB.Target.colorText.b)
end


local function TargetBackdropColor(restore)
	local newR, newG, newB, newA; -- I forgot what to do with the alpha value but it's needed to not swap RGB values
	if restore then
	 -- The user bailed, we extract the old color from the table created by ShowColorPicker.
		newR, newG, newB, newA = unpack(restore);
	else
	 -- Something changed
		newA, newR, newG, newB = OpacitySliderFrame:GetValue(), ColorPickerFrame:GetColorRGB();
	end
	 -- Update our internal storage.
	r, g, b, a = newR, newG, newB, newA
	 -- And update any UI elements that use this color...
	TRP3_UF_DB.Target.colorBack.r, TRP3_UF_DB.Target.colorBack.g, TRP3_UF_DB.Target.colorBack.b, TRP3_UF_DB.Target.colorBack.a = newR, newG, newB, newA;
	TargetFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:SetVertexColor(TRP3_UF_DB.Target.colorBack.r, TRP3_UF_DB.Target.colorBack.g, TRP3_UF_DB.Target.colorBack.b, TRP3_UF_DB.Target.colorBack.a)
	TRP3_UFRepDummyTarget:SetVertexColor(TRP3_UF_DB.Target.colorBack.r,TRP3_UF_DB.Target.colorBack.g,TRP3_UF_DB.Target.colorBack.b,TRP3_UF_DB.Target.colorBack.a)
	TRP3_UFSettingsRepDummyTarget:SetVertexColor(TRP3_UF_DB.Target.colorBack.r,TRP3_UF_DB.Target.colorBack.g,TRP3_UF_DB.Target.colorBack.b,TRP3_UF_DB.Target.colorBack.a)
end


local function PlayerTextColor(restore)
	local newR, newG, newB, newA; -- I forgot what to do with the alpha value but it's needed to not swap RGB values
	if restore then
	 -- The user bailed, we extract the old color from the table created by ShowColorPicker.
		newR, newG, newB, newA = unpack(restore);
	else
	 -- Something changed
		newA, newR, newG, newB = OpacitySliderFrame:GetValue(), ColorPickerFrame:GetColorRGB();
	end
	 -- Update our internal storage.
	r, g, b, a = newR, newG, newB, newA
	 -- And update any UI elements that use this color...
	TRP3_UF_DB.Player.colorText.r, TRP3_UF_DB.Player.colorText.g, TRP3_UF_DB.Player.colorText.b = newR, newG, newB;
	PlayerName:SetTextColor(TRP3_UF_DB.Player.colorText.r, TRP3_UF_DB.Player.colorText.g, TRP3_UF_DB.Player.colorText.b)
	TRP3_UFRepTextDummyPlayer:SetTextColor(TRP3_UF_DB.Player.colorText.r,TRP3_UF_DB.Player.colorText.g,TRP3_UF_DB.Player.colorText.b)
	TRP3_UFSettingsRepTextDummyPlayer:SetTextColor(TRP3_UF_DB.Player.colorText.r,TRP3_UF_DB.Player.colorText.g,TRP3_UF_DB.Player.colorText.b)
end


local function PlayerBackdropColor(restore)
	local newR, newG, newB, newA; -- I forgot what to do with the alpha value but it's needed to not swap RGB values
	
	if restore then
	 -- The user bailed, we extract the old color from the table created by ShowColorPicker.
		newR, newG, newB, newA = unpack(restore);
	else
	 -- Something changed
		newA, newR, newG, newB = OpacitySliderFrame:GetValue(), ColorPickerFrame:GetColorRGB();
	end
	 -- Update our internal storage.
	r, g, b, a = newR, newG, newB, newA
	 -- And update any UI elements that use this color...
	TRP3_UF_DB.Player.colorBack.r, TRP3_UF_DB.Player.colorBack.g, TRP3_UF_DB.Player.colorBack.b, TRP3_UF_DB.Player.colorBack.a = newR, newG, newB, newA;
	PlayerFrameReputationColor:SetVertexColor(TRP3_UF_DB.Player.colorBack.r, TRP3_UF_DB.Player.colorBack.g, TRP3_UF_DB.Player.colorBack.b, TRP3_UF_DB.Player.colorBack.a)
	TRP3_UFRepDummyPlayer:SetVertexColor(TRP3_UF_DB.Player.colorBack.r,TRP3_UF_DB.Player.colorBack.g,TRP3_UF_DB.Player.colorBack.b,TRP3_UF_DB.Player.colorBack.a)
	TRP3_UFSettingsRepDummyPlayer:SetVertexColor(TRP3_UF_DB.Player.colorBack.r,TRP3_UF_DB.Player.colorBack.g,TRP3_UF_DB.Player.colorBack.b,TRP3_UF_DB.Player.colorBack.a)
end

--PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture:Hide() -- make this into an option to hide the "rested glow" or even change color
--PLAYER_REGEN_DISABLED -- trigger upon this event

------------------------------------------------------------------------------------------------------------------

--set up the art border portrait frame

local PlayerDragonFrame = CreateFrame("Frame", nil, PlayerFrame)
PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
PlayerDragonFrame:SetSize(99, 81);
PlayerDragonFrame.tex = PlayerDragonFrame:CreateTexture(nil, "ARTWORK", nil, 0)
PlayerDragonFrame.tex:SetAllPoints(PlayerDragonFrame)
PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\uiunitframeboss2x")
PlayerDragonFrame.tex:SetTexCoord(1, 0, 0, 1)
PlayerDragonFrame.tex:SetVertexColor(1,1,1)
PlayerDragonFrame.mask = PlayerDragonFrame:CreateMaskTexture()
PlayerDragonFrame.mask:SetAllPoints(PlayerDragonFrame.tex)
PlayerDragonFrame.mask:SetTexture(nil)

--[[
--Work in Progress feature - Additional player frame artwork
local PlayerContainerPortrait = CreateFrame("Frame", nil, PlayerFrame)
PlayerContainerPortrait:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -2,-3)
PlayerContainerPortrait:SetSize(256, 128);
PlayerContainerPortrait:SetFrameStrata("BACKGROUND")
PlayerContainerPortrait.tex = PlayerContainerPortrait:CreateTexture(nil, "ARTWORK", nil, 0)
PlayerContainerPortrait.tex:SetAllPoints(PlayerContainerPortrait)
PlayerContainerPortrait.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\playerframe_DK2x2.png")
PlayerContainerPortrait.tex:SetTexCoord(0, 1, 0, 1)
PlayerContainerPortrait.tex:SetVertexColor(1,1,1)

--RuneFrame:SetPoint("TOP", PlayerFrame, 45,-70) -- the DK Rune Frame is going to need adjustments
--DruidComboPointBarFrame:SetPoint("TOP", PlayerFrame, 33,-68)

--PlayerContainerPortrait.mask = PlayerContainerPortrait:CreateMaskTexture()
--PlayerContainerPortrait.mask:SetAllPoints(PlayerContainerPortrait.tex)
--PlayerContainerPortrait.mask:SetTexture(nil)
--]]

------------------------------------------------------------------------------------------------------------------

local trpTarget, trpPlayer
trpTarget = CreateFrame("Frame")
trpPlayer = CreateFrame("Frame")

local VERSION_TEXT = string.format(TRP3_API.loc.CREDITS_VERSION_TEXT, GetAddOnMetadata("totalRP3_UnitFrames", "Version"));
local TRP3_UFPanel = CreateFrame("Frame");

TRP3_UFPanel.name = GetAddOnMetadata("totalRP3_UnitFrames", "Title")

TRP3_UFPanel.Headline = TRP3_UFPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal");
TRP3_UFPanel.Headline:SetFont(TRP3_UFPanel.Headline:GetFont(), 23);
TRP3_UFPanel.Headline:SetTextColor(1,.73,0,1);
TRP3_UFPanel.Headline:ClearAllPoints();
TRP3_UFPanel.Headline:SetPoint("TOPLEFT", TRP3_UFPanel, "TOPLEFT",12,-12);
TRP3_UFPanel.Headline:SetText(L["TitleColored"]);

TRP3_UFPanel.Version = TRP3_UFPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal");
TRP3_UFPanel.Version:SetFont(TRP3_UFPanel.Version:GetFont(), 12);
TRP3_UFPanel.Version:SetTextColor(1,1,1,1);
TRP3_UFPanel.Version:ClearAllPoints();
TRP3_UFPanel.Version:SetPoint("TOPLEFT", TRP3_UFPanel, "TOPLEFT",400,-21);
TRP3_UFPanel.Version:SetText(VERSION_TEXT);


local TRP3_UFScrollFrame = CreateFrame("ScrollFrame", nil, TRP3_UFPanel, "ScrollFrameTemplate")
TRP3_UFScrollFrame:SetPoint("TOPLEFT", 3, -4)
TRP3_UFScrollFrame:SetPoint("BOTTOMRIGHT", -27, 4)

TRP3_UFPanel.scrollChild = CreateFrame("Frame")
TRP3_UFScrollFrame:SetScrollChild(TRP3_UFPanel.scrollChild)
TRP3_UFPanel.scrollChild:SetWidth(SettingsPanel:GetWidth()-18)
TRP3_UFPanel.scrollChild:SetHeight(1)


------------------------------------------------------------------------------------------------------------------
--position presets
TRP3_UFPanel.scrollChild.dummyFramePlayer = CreateFrame("Frame", nil, TRP3_UFPanel.scrollChild)
TRP3_UFPanel.scrollChild.dummyFramePlayer:SetPoint("TOPLEFT", TRP3_UFPanel.scrollChild, "TOPLEFT", 5, -53)
TRP3_UFPanel.scrollChild.dummyFramePlayer:SetSize(198, 71)
TRP3_UFPanel.scrollChild.dummyFramePlayer.tex = TRP3_UFPanel.scrollChild.dummyFramePlayer:CreateTexture(nil, "ARTWORK", nil, 1)
TRP3_UFPanel.scrollChild.dummyFramePlayer.tex:SetAllPoints(TRP3_UFPanel.scrollChild.dummyFramePlayer)
TRP3_UFPanel.scrollChild.dummyFramePlayer.tex:SetAtlas("UI-HUD-UnitFrame-Player-PortraitOn")
TRP3_UFPanel.scrollChild.dummyFramePlayer.tex:SetTexCoord(0, 1, 0, 1)

TRP3_UFPanel.scrollChild.dummyFrameTarget = CreateFrame("Frame", nil, TRP3_UFPanel.scrollChild)
TRP3_UFPanel.scrollChild.dummyFrameTarget:SetPoint("TOPLEFT", TRP3_UFPanel.scrollChild, "TOPLEFT", 350, -53)
TRP3_UFPanel.scrollChild.dummyFrameTarget:SetSize(198, 71)
TRP3_UFPanel.scrollChild.dummyFrameTarget.tex = TRP3_UFPanel.scrollChild.dummyFrameTarget:CreateTexture(nil, "ARTWORK", nil, 1)
TRP3_UFPanel.scrollChild.dummyFrameTarget.tex:SetAllPoints(TRP3_UFPanel.scrollChild.dummyFrameTarget)
TRP3_UFPanel.scrollChild.dummyFrameTarget.tex:SetAtlas("UI-HUD-UnitFrame-Target-PortraitOn")
TRP3_UFPanel.scrollChild.dummyFrameTarget.tex:SetTexCoord(0, 1, 0, 1)


TRP3_UFPanel.scrollChild.Pf = CreateFrame("Frame", nil, TRP3_UFPanel.scrollChild)
TRP3_UFPanel.scrollChild.Pf:ClearAllPoints();
TRP3_UFPanel.scrollChild.Pf:SetPoint("TOPLEFT", TRP3_UFPanel.scrollChild.dummyFramePlayer, "TOPLEFT", 5,-3);
TRP3_UFPanel.scrollChild.Pf:SetSize(64, 64)

TRP3_UFPanel.scrollChild.Pf.tex = TRP3_UFPanel.scrollChild.Pf:CreateTexture()
TRP3_UFPanel.scrollChild.Pf.tex:SetAllPoints(TRP3_UFPanel.scrollChild.Pf)
SetPortraitTexture(TRP3_UFPanel.scrollChild.Pf.tex, "player")

TRP3_UFPanel.scrollChild.Tf = CreateFrame("Frame", nil, TRP3_UFPanel.scrollChild)
TRP3_UFPanel.scrollChild.Tf:ClearAllPoints();
TRP3_UFPanel.scrollChild.Tf:SetPoint("TOPLEFT", TRP3_UFPanel.scrollChild.dummyFrameTarget, "TOPLEFT", 128, -2);
TRP3_UFPanel.scrollChild.Tf:SetSize(64, 64)

TRP3_UFPanel.scrollChild.Tf.tex = TRP3_UFPanel.scrollChild.Tf:CreateTexture()
TRP3_UFPanel.scrollChild.Tf.tex:SetAllPoints(TRP3_UFPanel.scrollChild.Tf)
SetPortraitTexture(TRP3_UFPanel.scrollChild.Tf.tex, "player")

function TRP3_UFPanel.scrollChild.OnShow()
	SetPortraitTexture(TRP3_UFPanel.scrollChild.Pf.tex, "player")
	SetPortraitTexture(TRP3_UFPanel.scrollChild.Tf.tex, "player")
end

TRP3_UFPanel.scrollChild.Tf:SetScript("OnShow",TRP3_UFPanel.scrollChild.OnShow);

TRP3_UFPanel.scrollChild.Pf.radioTopLeft = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild.Pf, "UIRadioButtonTemplate")
TRP3_UFPanel.scrollChild.Pf.radioTop = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild.Pf, "UIRadioButtonTemplate")
TRP3_UFPanel.scrollChild.Pf.radioTopRight = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild.Pf, "UIRadioButtonTemplate")
TRP3_UFPanel.scrollChild.Pf.radioLeft = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild.Pf, "UIRadioButtonTemplate")
TRP3_UFPanel.scrollChild.Pf.radioCenter = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild.Pf, "UIRadioButtonTemplate")
TRP3_UFPanel.scrollChild.Pf.radioRight = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild.Pf, "UIRadioButtonTemplate")
TRP3_UFPanel.scrollChild.Pf.radioBottomLeft = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild.Pf, "UIRadioButtonTemplate")
TRP3_UFPanel.scrollChild.Pf.radioBottom = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild.Pf, "UIRadioButtonTemplate")
TRP3_UFPanel.scrollChild.Pf.radioBottomRight = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild.Pf, "UIRadioButtonTemplate")

TRP3_UFPanel.scrollChild.Pf.radioTopLeft:SetChecked(false)
TRP3_UFPanel.scrollChild.Pf.radioTop:SetChecked(false)
TRP3_UFPanel.scrollChild.Pf.radioTopRight:SetChecked(false)
TRP3_UFPanel.scrollChild.Pf.radioLeft:SetChecked(false)
TRP3_UFPanel.scrollChild.Pf.radioCenter:SetChecked(false)
TRP3_UFPanel.scrollChild.Pf.radioRight:SetChecked(false)
TRP3_UFPanel.scrollChild.Pf.radioBottomLeft:SetChecked(false)
TRP3_UFPanel.scrollChild.Pf.radioBottom:SetChecked(false)
TRP3_UFPanel.scrollChild.Pf.radioBottomRight:SetChecked(true)

TRP3_UFPanel.scrollChild.Pf.radioTopLeft:SetPoint("CENTER", TRP3_UFPanel.scrollChild.Pf, "TOPLEFT", 0, 0)
TRP3_UFPanel.scrollChild.Pf.radioTop:SetPoint("CENTER", TRP3_UFPanel.scrollChild.Pf, "TOP", 0, 0)
TRP3_UFPanel.scrollChild.Pf.radioTopRight:SetPoint("CENTER", TRP3_UFPanel.scrollChild.Pf, "TOPRIGHT", 0, 0)
TRP3_UFPanel.scrollChild.Pf.radioLeft:SetPoint("CENTER", TRP3_UFPanel.scrollChild.Pf, "LEFT", 0, 0)
TRP3_UFPanel.scrollChild.Pf.radioCenter:SetPoint("CENTER", TRP3_UFPanel.scrollChild.Pf, "CENTER", 0, 0)
TRP3_UFPanel.scrollChild.Pf.radioRight:SetPoint("CENTER", TRP3_UFPanel.scrollChild.Pf, "RIGHT", 0, 0)
TRP3_UFPanel.scrollChild.Pf.radioBottomLeft:SetPoint("CENTER", TRP3_UFPanel.scrollChild.Pf, "BOTTOMLEFT", 0, 0)
TRP3_UFPanel.scrollChild.Pf.radioBottom:SetPoint("CENTER", TRP3_UFPanel.scrollChild.Pf, "BOTTOM", 0, 0)
TRP3_UFPanel.scrollChild.Pf.radioBottomRight:SetPoint("CENTER", TRP3_UFPanel.scrollChild.Pf, "BOTTOMRIGHT", 0, 0)

TRP3_UFPanel.scrollChild.Pf.TitleText = TRP3_UFPanel.scrollChild.Pf:CreateFontString(nil, "OVERLAY", "GameFontNormal");
TRP3_UFPanel.scrollChild.Pf.TitleText:SetFont(TRP3_UFPanel.scrollChild.Pf.TitleText:GetFont(), 12);
TRP3_UFPanel.scrollChild.Pf.TitleText:SetTextColor(1,1,1,1);
TRP3_UFPanel.scrollChild.Pf.TitleText:ClearAllPoints();
TRP3_UFPanel.scrollChild.Pf.TitleText:SetPoint("BOTTOM", TRP3_UFPanel.scrollChild.Pf, "BOTTOM",0,-25);
TRP3_UFPanel.scrollChild.Pf.TitleText:SetText(PLAYER);

TRP3_UFPanel.scrollChild.Pf.allRadios = {
	TRP3_UFPanel.scrollChild.Pf.radioTopLeft,
	TRP3_UFPanel.scrollChild.Pf.radioTop,
	TRP3_UFPanel.scrollChild.Pf.radioTopRight,
	TRP3_UFPanel.scrollChild.Pf.radioLeft,
	TRP3_UFPanel.scrollChild.Pf.radioCenter,
	TRP3_UFPanel.scrollChild.Pf.radioRight,
	TRP3_UFPanel.scrollChild.Pf.radioBottomLeft,
	TRP3_UFPanel.scrollChild.Pf.radioBottom,
	TRP3_UFPanel.scrollChild.Pf.radioBottomRight
};

function TRP3_UFPanel.scrollChild.Pf.createOnRadioClicked(location)
	local function onRadioClicked(self, a, b, c)
		local checked = self:GetChecked()
		PlaySound(PlaySoundKitID and "igMainMenuOptionCheckBoxOn" or SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		TRP3_UF_DB.Player.relativePoint = location

		local anyChecked = false
		for _, radio in ipairs(TRP3_UFPanel.scrollChild.Pf.allRadios) do
			if radio ~= self then
				anyChecked = radio:GetChecked() or anyChecked
				radio:SetChecked(false)
			end
		end
		if not anyChecked then
			self:SetChecked(true)
		end
		trpPlayer.SetPos()
	end
	return onRadioClicked
end

TRP3_UFPanel.scrollChild.Pf.radioTopLeft:SetScript("OnClick", TRP3_UFPanel.scrollChild.Pf.createOnRadioClicked("TOPLEFT"))
TRP3_UFPanel.scrollChild.Pf.radioTop:SetScript("OnClick", TRP3_UFPanel.scrollChild.Pf.createOnRadioClicked("TOP"))
TRP3_UFPanel.scrollChild.Pf.radioTopRight:SetScript("OnClick", TRP3_UFPanel.scrollChild.Pf.createOnRadioClicked("TOPRIGHT"))
TRP3_UFPanel.scrollChild.Pf.radioLeft:SetScript("OnClick", TRP3_UFPanel.scrollChild.Pf.createOnRadioClicked("LEFT"))
TRP3_UFPanel.scrollChild.Pf.radioCenter:SetScript("OnClick", TRP3_UFPanel.scrollChild.Pf.createOnRadioClicked("CENTER"))
TRP3_UFPanel.scrollChild.Pf.radioRight:SetScript("OnClick", TRP3_UFPanel.scrollChild.Pf.createOnRadioClicked("RIGHT"))
TRP3_UFPanel.scrollChild.Pf.radioBottomLeft:SetScript("OnClick", TRP3_UFPanel.scrollChild.Pf.createOnRadioClicked("BOTTOMLEFT"))
TRP3_UFPanel.scrollChild.Pf.radioBottom:SetScript("OnClick", TRP3_UFPanel.scrollChild.Pf.createOnRadioClicked("BOTTOM"))
TRP3_UFPanel.scrollChild.Pf.radioBottomRight:SetScript("OnClick", TRP3_UFPanel.scrollChild.Pf.createOnRadioClicked("BOTTOMRIGHT"))

TRP3_UFPanel.scrollChild.Tf.radioTopLeft = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild.Tf, "UIRadioButtonTemplate")
TRP3_UFPanel.scrollChild.Tf.radioTop = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild.Tf, "UIRadioButtonTemplate")
TRP3_UFPanel.scrollChild.Tf.radioTopRight = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild.Tf, "UIRadioButtonTemplate")
TRP3_UFPanel.scrollChild.Tf.radioLeft = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild.Tf, "UIRadioButtonTemplate")
TRP3_UFPanel.scrollChild.Tf.radioCenter = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild.Tf, "UIRadioButtonTemplate")
TRP3_UFPanel.scrollChild.Tf.radioRight = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild.Tf, "UIRadioButtonTemplate")
TRP3_UFPanel.scrollChild.Tf.radioBottomLeft = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild.Tf, "UIRadioButtonTemplate")
TRP3_UFPanel.scrollChild.Tf.radioBottom = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild.Tf, "UIRadioButtonTemplate")
TRP3_UFPanel.scrollChild.Tf.radioBottomRight = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild.Tf, "UIRadioButtonTemplate")

TRP3_UFPanel.scrollChild.Tf.radioTopLeft:SetChecked(false)
TRP3_UFPanel.scrollChild.Tf.radioTop:SetChecked(false)
TRP3_UFPanel.scrollChild.Tf.radioTopRight:SetChecked(false)
TRP3_UFPanel.scrollChild.Tf.radioLeft:SetChecked(false)
TRP3_UFPanel.scrollChild.Tf.radioCenter:SetChecked(false)
TRP3_UFPanel.scrollChild.Tf.radioRight:SetChecked(false)
TRP3_UFPanel.scrollChild.Tf.radioBottomLeft:SetChecked(true)
TRP3_UFPanel.scrollChild.Tf.radioBottom:SetChecked(false)
TRP3_UFPanel.scrollChild.Tf.radioBottomRight:SetChecked(false)

TRP3_UFPanel.scrollChild.Tf.radioTopLeft:SetPoint("CENTER", TRP3_UFPanel.scrollChild.Tf, "TOPLEFT", 0, 0)
TRP3_UFPanel.scrollChild.Tf.radioTop:SetPoint("CENTER", TRP3_UFPanel.scrollChild.Tf, "TOP", 0, 0)
TRP3_UFPanel.scrollChild.Tf.radioTopRight:SetPoint("CENTER", TRP3_UFPanel.scrollChild.Tf, "TOPRIGHT", 0, 0)
TRP3_UFPanel.scrollChild.Tf.radioLeft:SetPoint("CENTER", TRP3_UFPanel.scrollChild.Tf, "LEFT", 0, 0)
TRP3_UFPanel.scrollChild.Tf.radioCenter:SetPoint("CENTER", TRP3_UFPanel.scrollChild.Tf, "CENTER", 0, 0)
TRP3_UFPanel.scrollChild.Tf.radioRight:SetPoint("CENTER", TRP3_UFPanel.scrollChild.Tf, "RIGHT", 0, 0)
TRP3_UFPanel.scrollChild.Tf.radioBottomLeft:SetPoint("CENTER", TRP3_UFPanel.scrollChild.Tf, "BOTTOMLEFT", 0, 0)
TRP3_UFPanel.scrollChild.Tf.radioBottom:SetPoint("CENTER", TRP3_UFPanel.scrollChild.Tf, "BOTTOM", 0, 0)
TRP3_UFPanel.scrollChild.Tf.radioBottomRight:SetPoint("CENTER", TRP3_UFPanel.scrollChild.Tf, "BOTTOMRIGHT", 0, 0)

TRP3_UFPanel.scrollChild.Tf.TitleText = TRP3_UFPanel.scrollChild.Tf:CreateFontString(nil, "OVERLAY", "GameFontNormal");
TRP3_UFPanel.scrollChild.Tf.TitleText:SetFont(TRP3_UFPanel.scrollChild.Tf.TitleText:GetFont(), 12);
TRP3_UFPanel.scrollChild.Tf.TitleText:SetTextColor(1,1,1,1);
TRP3_UFPanel.scrollChild.Tf.TitleText:ClearAllPoints();
TRP3_UFPanel.scrollChild.Tf.TitleText:SetPoint("BOTTOM", TRP3_UFPanel.scrollChild.Tf, "BOTTOM",0,-25);
TRP3_UFPanel.scrollChild.Tf.TitleText:SetText(TARGET);

TRP3_UFPanel.scrollChild.Tf.allRadios = {
	TRP3_UFPanel.scrollChild.Tf.radioTopLeft,
	TRP3_UFPanel.scrollChild.Tf.radioTop,
	TRP3_UFPanel.scrollChild.Tf.radioTopRight,
	TRP3_UFPanel.scrollChild.Tf.radioLeft,
	TRP3_UFPanel.scrollChild.Tf.radioCenter,
	TRP3_UFPanel.scrollChild.Tf.radioRight,
	TRP3_UFPanel.scrollChild.Tf.radioBottomLeft,
	TRP3_UFPanel.scrollChild.Tf.radioBottom,
	TRP3_UFPanel.scrollChild.Tf.radioBottomRight
}

function TRP3_UFPanel.scrollChild.Tf.createOnRadioClicked(location)
	local function onRadioClicked(self, a, b, c)
		local checked = self:GetChecked()
		PlaySound(PlaySoundKitID and "igMainMenuOptionCheckBoxOn" or SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		TRP3_UF_DB.Target.relativePoint = location

		local anyChecked = false
		for _, radio in ipairs(TRP3_UFPanel.scrollChild.Tf.allRadios) do
			if radio ~= self then
				anyChecked = radio:GetChecked() or anyChecked
				radio:SetChecked(false)
			end
		end
		if not anyChecked then
			self:SetChecked(true)
		end
		trpTarget.SetPos()
	end
	return onRadioClicked
end

TRP3_UFPanel.scrollChild.Tf.radioTopLeft:SetScript("OnClick", TRP3_UFPanel.scrollChild.Tf.createOnRadioClicked("TOPLEFT"))
TRP3_UFPanel.scrollChild.Tf.radioTop:SetScript("OnClick", TRP3_UFPanel.scrollChild.Tf.createOnRadioClicked("TOP"))
TRP3_UFPanel.scrollChild.Tf.radioTopRight:SetScript("OnClick", TRP3_UFPanel.scrollChild.Tf.createOnRadioClicked("TOPRIGHT"))
TRP3_UFPanel.scrollChild.Tf.radioLeft:SetScript("OnClick", TRP3_UFPanel.scrollChild.Tf.createOnRadioClicked("LEFT"))
TRP3_UFPanel.scrollChild.Tf.radioCenter:SetScript("OnClick", TRP3_UFPanel.scrollChild.Tf.createOnRadioClicked("CENTER"))
TRP3_UFPanel.scrollChild.Tf.radioRight:SetScript("OnClick", TRP3_UFPanel.scrollChild.Tf.createOnRadioClicked("RIGHT"))
TRP3_UFPanel.scrollChild.Tf.radioBottomLeft:SetScript("OnClick", TRP3_UFPanel.scrollChild.Tf.createOnRadioClicked("BOTTOMLEFT"))
TRP3_UFPanel.scrollChild.Tf.radioBottom:SetScript("OnClick", TRP3_UFPanel.scrollChild.Tf.createOnRadioClicked("BOTTOM"))
TRP3_UFPanel.scrollChild.Tf.radioBottomRight:SetScript("OnClick", TRP3_UFPanel.scrollChild.Tf.createOnRadioClicked("BOTTOMRIGHT"))

------------------------------------------------------------------------------------------------------------------

TRP3_UFPanel.scrollChild.PColor = CreateFrame("Frame", nil, TRP3_UFPanel.scrollChild.dummyFramePlayer)
TRP3_UFPanel.scrollChild.PColor:SetPoint("TOPLEFT", TRP3_UFPanel.scrollChild.dummyFramePlayer, "TOPLEFT", 58, -11)
TRP3_UFPanel.scrollChild.PColor:SetWidth(135)
TRP3_UFPanel.scrollChild.PColor:SetHeight(18)
TRP3_UFPanel.scrollChild.PColor.tex = TRP3_UFPanel.scrollChild.PColor:CreateTexture("TRP3_UFRepDummyPlayer", "ARTWORK", nil, 1)
TRP3_UFPanel.scrollChild.PColor.tex:SetAllPoints(TRP3_UFPanel.scrollChild.PColor)
TRP3_UFPanel.scrollChild.PColor.tex:SetAtlas("UI-HUD-UnitFrame-Target-PortraitOn-Type")
TRP3_UFPanel.scrollChild.PColor.tex:SetTexCoord(1, 0, 0, 1)

TRP3_UFPanel.scrollChild.PColor.Name = TRP3_UFPanel.scrollChild.PColor:CreateFontString("TRP3_UFRepTextDummyPlayer", "OVERLAY", "GameFontNormal");
TRP3_UFPanel.scrollChild.PColor.Name:SetFont(TRP3_UFPanel.scrollChild.PColor.Name:GetFont(), 12);
TRP3_UFPanel.scrollChild.PColor.Name:SetTextColor(1,1,1,1);
TRP3_UFPanel.scrollChild.PColor.Name:ClearAllPoints();
TRP3_UFPanel.scrollChild.PColor.Name:SetPoint("TOP", TRP3_UFPanel.scrollChild.PColor, "TOP",0,0);
TRP3_UFPanel.scrollChild.PColor.Name:SetText(PLAYER);


TRP3_UFPanel.scrollChild.TColor = CreateFrame("Frame", nil, TRP3_UFPanel.scrollChild.dummyFrameTarget)
TRP3_UFPanel.scrollChild.TColor:SetPoint("TOPRIGHT", TRP3_UFPanel.scrollChild.dummyFrameTarget, "TOPRIGHT", -60, -10)
TRP3_UFPanel.scrollChild.TColor:SetWidth(135)
TRP3_UFPanel.scrollChild.TColor:SetHeight(18)
TRP3_UFPanel.scrollChild.TColor.tex = TRP3_UFPanel.scrollChild.TColor:CreateTexture("TRP3_UFRepDummyTarget", "ARTWORK", nil, 1)
TRP3_UFPanel.scrollChild.TColor.tex:SetAllPoints(TRP3_UFPanel.scrollChild.TColor)
TRP3_UFPanel.scrollChild.TColor.tex:SetAtlas("UI-HUD-UnitFrame-Target-PortraitOn-Type")

TRP3_UFPanel.scrollChild.TColor.Name = TRP3_UFPanel.scrollChild.TColor:CreateFontString("TRP3_UFRepTextDummyTarget", "OVERLAY", "GameFontNormal");
TRP3_UFPanel.scrollChild.TColor.Name:SetFont(TRP3_UFPanel.scrollChild.TColor.Name:GetFont(), 12);
TRP3_UFPanel.scrollChild.TColor.Name:SetTextColor(1,1,1,1);
TRP3_UFPanel.scrollChild.TColor.Name:ClearAllPoints();
TRP3_UFPanel.scrollChild.TColor.Name:SetPoint("TOP", TRP3_UFPanel.scrollChild.TColor, "TOP",0,0);
TRP3_UFPanel.scrollChild.TColor.Name:SetText(TARGET);


function TRP3_UFPanel.CheckSettings()
	--Check all the buttons
	TRP3_UFPanel.scrollChild.PShowCheckbox:SetChecked(TRP3_UF_DB.Player.show);
	TRP3_UFPanel.scrollChild.TShowCheckbox:SetChecked(TRP3_UF_DB.Target.show);

	TRP3_UFPanel.TRP3_scrollChild.PShowCheckbox:SetChecked(TRP3_UF_DB.Player.show);
	TRP3_UFPanel.TRP3_scrollChild.TShowCheckbox:SetChecked(TRP3_UF_DB.Target.show);

	--color checkboxes
	TRP3_UFPanel.scrollChild.TargetTextColorCheckbox:SetChecked(TRP3_UF_DB.Target.colorText.custom);
	TRP3_UFPanel.scrollChild.TargetBackColorCheckbox:SetChecked(TRP3_UF_DB.Target.colorBack.custom);
	TRP3_UFPanel.scrollChild.TargetClassTextColorCheckbox:SetChecked(TRP3_UF_DB.Target.colorText.class);
	TRP3_UFPanel.scrollChild.TargetClassBackColorCheckbox:SetChecked(TRP3_UF_DB.Target.colorBack.class);

	TRP3_UFPanel.TRP3_scrollChild.TargetTextColorCheckbox:SetChecked(TRP3_UF_DB.Target.colorText.custom);
	TRP3_UFPanel.TRP3_scrollChild.TargetBackColorCheckbox:SetChecked(TRP3_UF_DB.Target.colorBack.custom);
	TRP3_UFPanel.TRP3_scrollChild.TargetClassTextColorCheckbox:SetChecked(TRP3_UF_DB.Target.colorText.class);
	TRP3_UFPanel.TRP3_scrollChild.TargetClassBackColorCheckbox:SetChecked(TRP3_UF_DB.Target.colorBack.class);

	TRP3_UFPanel.scrollChild.TarCustomTextColButton:SetEnabled(TRP3_UF_DB.Target.colorText.custom);
	TRP3_UFPanel.scrollChild.TarCustomBackColButton:SetEnabled(TRP3_UF_DB.Target.colorBack.custom);

	TRP3_UFPanel.TRP3_scrollChild.TarCustomTextColButton:SetEnabled(TRP3_UF_DB.Target.colorText.custom);
	TRP3_UFPanel.TRP3_scrollChild.TarCustomBackColButton:SetEnabled(TRP3_UF_DB.Target.colorBack.custom);

	TRP3_UFPanel.scrollChild.PlayerTextColorCheckbox:SetChecked(TRP3_UF_DB.Player.colorText.custom);
	TRP3_UFPanel.scrollChild.PlayerBackColorCheckbox:SetChecked(TRP3_UF_DB.Player.colorBack.custom);
	TRP3_UFPanel.scrollChild.PlayerClassTextColorCheckbox:SetChecked(TRP3_UF_DB.Player.colorText.class);
	TRP3_UFPanel.scrollChild.PlayerClassBackColorCheckbox:SetChecked(TRP3_UF_DB.Player.colorBack.class);

	TRP3_UFPanel.TRP3_scrollChild.PlayerTextColorCheckbox:SetChecked(TRP3_UF_DB.Player.colorText.custom);
	TRP3_UFPanel.TRP3_scrollChild.PlayerBackColorCheckbox:SetChecked(TRP3_UF_DB.Player.colorBack.custom);
	TRP3_UFPanel.TRP3_scrollChild.PlayerClassTextColorCheckbox:SetChecked(TRP3_UF_DB.Player.colorText.class);
	TRP3_UFPanel.TRP3_scrollChild.PlayerClassBackColorCheckbox:SetChecked(TRP3_UF_DB.Player.colorBack.class);

	TRP3_UFPanel.scrollChild.PlayerCustomTextColButton:SetEnabled(TRP3_UF_DB.Player.colorText.custom);
	TRP3_UFPanel.scrollChild.PlayerCustomBackColButton:SetEnabled(TRP3_UF_DB.Player.colorBack.custom);

	TRP3_UFPanel.TRP3_scrollChild.PlayerCustomTextColButton:SetEnabled(TRP3_UF_DB.Player.colorText.custom);
	TRP3_UFPanel.TRP3_scrollChild.PlayerCustomBackColButton:SetEnabled(TRP3_UF_DB.Player.colorBack.custom);

	TRP3_UFPanel.scrollChild.NPCOptionsCheckbox:SetChecked(TRP3_UF_DB.Setting.NPCs);
	TRP3_UFPanel.scrollChild.UseTRP3NameCheckbox:SetChecked(TRP3_UF_DB.Setting.UseTRPName);
	TRP3_UFPanel.scrollChild.FullNamePCheckbox:SetChecked(TRP3_UF_DB.Setting.FullNamePlayer);
	TRP3_UFPanel.scrollChild.FullNameTCheckbox:SetChecked(TRP3_UF_DB.Setting.FullNameTarget);

	TRP3_UFPanel.TRP3_scrollChild.NPCOptionsCheckbox:SetChecked(TRP3_UF_DB.Setting.NPCs);
	TRP3_UFPanel.TRP3_scrollChild.UseTRP3NameCheckbox:SetChecked(TRP3_UF_DB.Setting.UseTRPName);
	TRP3_UFPanel.TRP3_scrollChild.FullNamePCheckbox:SetChecked(TRP3_UF_DB.Setting.FullNamePlayer);
	TRP3_UFPanel.TRP3_scrollChild.FullNameTCheckbox:SetChecked(TRP3_UF_DB.Setting.FullNameTarget);


	TRP3_UFPanel.scrollChild.FullNamePCheckbox:SetEnabled(TRP3_UF_DB.Setting.UseTRPName);
	TRP3_UFPanel.scrollChild.FullNameTCheckbox:SetEnabled(TRP3_UF_DB.Setting.UseTRPName);

	TRP3_UFPanel.TRP3_scrollChild.FullNamePCheckbox:SetEnabled(TRP3_UF_DB.Setting.UseTRPName);
	TRP3_UFPanel.TRP3_scrollChild.FullNameTCheckbox:SetEnabled(TRP3_UF_DB.Setting.UseTRPName);


	--sliders
	TRP3_UFPanel.scrollChild.PlayerPosSlider:SetValue(TRP3_UF_DB.Player.position)
	TRP3_UFPanel.scrollChild.TargetPosSlider:SetValue(TRP3_UF_DB.Target.position)

	TRP3_UFPanel.TRP3_scrollChild.PlayerPosSlider:SetValue(TRP3_UF_DB.Player.position)
	TRP3_UFPanel.TRP3_scrollChild.TargetPosSlider:SetValue(TRP3_UF_DB.Target.position)

	TRP3_UFPanel.scrollChild.PlayerSizeSlider:SetValue(TRP3_UF_DB.Player.scale)
	TRP3_UFPanel.scrollChild.TargetSizeSlider:SetValue(TRP3_UF_DB.Target.scale)

	TRP3_UFPanel.TRP3_scrollChild.PlayerSizeSlider:SetValue(TRP3_UF_DB.Player.scale)
	TRP3_UFPanel.TRP3_scrollChild.TargetSizeSlider:SetValue(TRP3_UF_DB.Target.scale)

	TRP3_UFPanel.scrollChild.PortShowCheckbox:SetChecked(TRP3_UF_DB.Border.show);
	TRP3_UFPanel.scrollChild.PortraitButton:SetEnabled(TRP3_UF_DB.Border.show);

	TRP3_UFPanel.TRP3_scrollChild.PortShowCheckbox:SetChecked(TRP3_UF_DB.Border.show);
	TRP3_UFPanel.TRP3_scrollChild.PortraitButton:SetEnabled(TRP3_UF_DB.Border.show);

	--status / rested texture visibility

	TRP3_UFPanel.scrollChild.StatusHideCheckbox:SetChecked(TRP3_UF_DB.Border.status)

	TRP3_UFPanel.TRP3_scrollChild.StatusHideCheckbox:SetChecked(TRP3_UF_DB.Border.status)

end


------------------------------------------------------------------------------------------------------------------

TRP3_UFPanel.scrollChild.VisibilityText = TRP3_UFPanel.scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal");
TRP3_UFPanel.scrollChild.VisibilityText:SetFont(TRP3_UFPanel.scrollChild.VisibilityText:GetFont(), 15);
TRP3_UFPanel.scrollChild.VisibilityText:SetTextColor(1,1,1,1);
TRP3_UFPanel.scrollChild.VisibilityText:ClearAllPoints();
TRP3_UFPanel.scrollChild.VisibilityText:SetPoint("TOPLEFT", 5, -53*3.7);
TRP3_UFPanel.scrollChild.VisibilityText:SetText(L["Visibility"]);


TRP3_UFPanel.scrollChild.PShowCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild, "UICheckButtonTemplate"); -- SettingsCheckBoxTemplate
TRP3_UFPanel.scrollChild.PShowCheckbox:ClearAllPoints();
TRP3_UFPanel.scrollChild.PShowCheckbox:SetPoint("TOPLEFT", 5, -53*4);
TRP3_UFPanel.scrollChild.PShowCheckbox.Text:SetText(L["ShowButtonPlayer"]);

TRP3_UFPanel.scrollChild.PShowCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.scrollChild.PShowCheckbox:GetChecked() then
		TRP3_UF_DB.Player.show = true;
		trpPlayer.SetVisible();
		TRP3_UFPanel.CheckSettings();
	else
		TRP3_UF_DB.Player.show = false;
		trpPlayer.SetVisible();
		TRP3_UFPanel.CheckSettings();
	end
end);


TRP3_UFPanel.scrollChild.TShowCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild, "UICheckButtonTemplate");
TRP3_UFPanel.scrollChild.TShowCheckbox:ClearAllPoints();
TRP3_UFPanel.scrollChild.TShowCheckbox:SetPoint("TOPLEFT", 5, -53*4.5);
TRP3_UFPanel.scrollChild.TShowCheckbox.Text:SetText(L["ShowButtonTarget"]);

TRP3_UFPanel.scrollChild.TShowCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.scrollChild.TShowCheckbox:GetChecked() then
		TRP3_UF_DB.Target.show = true;
		trpPlayer.SetVisible();
		TRP3_UFPanel.CheckSettings();
	else
		TRP3_UF_DB.Target.show = false;
		trpPlayer.SetVisible();
		TRP3_UFPanel.CheckSettings();
	end
end);


TRP3_UFPanel.scrollChild.PortShowCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild, "UICheckButtonTemplate");
TRP3_UFPanel.scrollChild.PortShowCheckbox:ClearAllPoints();
TRP3_UFPanel.scrollChild.PortShowCheckbox:SetPoint("TOPLEFT", 5, -53*5);
TRP3_UFPanel.scrollChild.PortShowCheckbox.Text:SetText(L["ShowBorderFrame"]);

TRP3_UFPanel.scrollChild.PortShowCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.scrollChild.PortShowCheckbox:GetChecked() then
		TRP3_UF_DB.Border.show = true;
		TRP3_UFPanel.scrollChild.PortraitButton:SetEnabled(TRP3_UF_DB.Border.show);
		PlayerDragonFrame:Show();
		TRP3_UFPanel.CheckSettings();
	else
		TRP3_UF_DB.Border.show = false;
		TRP3_UFPanel.scrollChild.PortraitButton:SetEnabled(TRP3_UF_DB.Border.show);
		PlayerDragonFrame:Hide();
		TRP3_UFPanel.CheckSettings();
	end
end);


TRP3_UFPanel.scrollChild.StatusHideCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild, "UICheckButtonTemplate");
TRP3_UFPanel.scrollChild.StatusHideCheckbox:ClearAllPoints();
TRP3_UFPanel.scrollChild.StatusHideCheckbox:SetPoint("TOPLEFT", 5, -53*5.5);
TRP3_UFPanel.scrollChild.StatusHideCheckbox.Text:SetText(L["HideRestedGlow"]);

TRP3_UFPanel.scrollChild.StatusHideCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.scrollChild.StatusHideCheckbox:GetChecked() then
		TRP3_UF_DB.Border.status = true;
		PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture:Hide();
		TRP3_UFPanel.CheckSettings();
	else
		TRP3_UF_DB.Border.status = false;
		PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture:Show();
		TRP3_UFPanel.CheckSettings();
	end
end);

------------------------------------------------------------------------------------------------------------------

TRP3_UFPanel.scrollChild.TargetSizeSlider = CreateFrame("Slider", nil, TRP3_UFPanel.scrollChild, "OptionsSliderTemplate");
TRP3_UFPanel.scrollChild.TargetSizeSlider:SetWidth(250);
TRP3_UFPanel.scrollChild.TargetSizeSlider:SetHeight(15);
TRP3_UFPanel.scrollChild.TargetSizeSlider:SetMinMaxValues(0.5,15);
TRP3_UFPanel.scrollChild.TargetSizeSlider:SetValueStep(.5);
TRP3_UFPanel.scrollChild.TargetSizeSlider:SetObeyStepOnDrag(true)
TRP3_UFPanel.scrollChild.TargetSizeSlider:ClearAllPoints();
TRP3_UFPanel.scrollChild.TargetSizeSlider:SetPoint("TOPLEFT", TRP3_UFPanel.scrollChild, "TOPLEFT", 5, -53*6.75);
TRP3_UFPanel.scrollChild.TargetSizeSlider.Low:SetText("0.5");
TRP3_UFPanel.scrollChild.TargetSizeSlider.High:SetText("15");
TRP3_UFPanel.scrollChild.TargetSizeSlider.Text:SetText(L["ButtonSizeTarget"]);
TRP3_UFPanel.scrollChild.TargetSizeSlider:SetScript("OnValueChanged", function()
	local scaleValue = TRP3_UFPanel.scrollChild.TargetSizeSlider:GetValue();
	TRP3_UF_DB.Target.scale = scaleValue;
	trpTarget.button:SetScale(TRP3_UF_DB.Target.scale);
	TRP3_UFPanel.CheckSettings();
end)


TRP3_UFPanel.scrollChild.TargetPosSlider = CreateFrame("Slider", nil, TRP3_UFPanel.scrollChild, "OptionsSliderTemplate");
TRP3_UFPanel.scrollChild.TargetPosSlider:SetWidth(250);
TRP3_UFPanel.scrollChild.TargetPosSlider:SetHeight(15);
TRP3_UFPanel.scrollChild.TargetPosSlider:SetMinMaxValues(-15,15);
TRP3_UFPanel.scrollChild.TargetPosSlider:SetValueStep(.5);
TRP3_UFPanel.scrollChild.TargetPosSlider:SetObeyStepOnDrag(true)
TRP3_UFPanel.scrollChild.TargetPosSlider:ClearAllPoints();
TRP3_UFPanel.scrollChild.TargetPosSlider:SetPoint("TOPLEFT", TRP3_UFPanel.scrollChild, "TOPLEFT", 5, -53*7.5);
TRP3_UFPanel.scrollChild.TargetPosSlider.Low:SetText("-15");
TRP3_UFPanel.scrollChild.TargetPosSlider.High:SetText("15");
TRP3_UFPanel.scrollChild.TargetPosSlider.Text:SetText(L["ButtonPosTarget"]);
TRP3_UFPanel.scrollChild.TargetPosSlider:SetScript("OnValueChanged", function()
	local scaleValue = TRP3_UFPanel.scrollChild.TargetPosSlider:GetValue();
	TRP3_UF_DB.Target.position = scaleValue;
	trpTarget.SetPos();
	TRP3_UFPanel.CheckSettings();
end)


TRP3_UFPanel.scrollChild.PlayerSizeSlider = CreateFrame("Slider", nil, TRP3_UFPanel.scrollChild, "OptionsSliderTemplate");
TRP3_UFPanel.scrollChild.PlayerSizeSlider:SetWidth(250);
TRP3_UFPanel.scrollChild.PlayerSizeSlider:SetHeight(15);
TRP3_UFPanel.scrollChild.PlayerSizeSlider:SetMinMaxValues(0.5,15);
TRP3_UFPanel.scrollChild.PlayerSizeSlider:SetValueStep(.5);
TRP3_UFPanel.scrollChild.PlayerSizeSlider:SetObeyStepOnDrag(true)
TRP3_UFPanel.scrollChild.PlayerSizeSlider:ClearAllPoints();
TRP3_UFPanel.scrollChild.PlayerSizeSlider:SetPoint("TOPLEFT", TRP3_UFPanel.scrollChild, "TOPLEFT", 5, -53*8.25);
TRP3_UFPanel.scrollChild.PlayerSizeSlider.Low:SetText("0.5");
TRP3_UFPanel.scrollChild.PlayerSizeSlider.High:SetText("15");
TRP3_UFPanel.scrollChild.PlayerSizeSlider.Text:SetText(L["ButtonSizePlayer"]);
TRP3_UFPanel.scrollChild.PlayerSizeSlider:SetScript("OnValueChanged", function()
	local scaleValue = TRP3_UFPanel.scrollChild.PlayerSizeSlider:GetValue();
	TRP3_UF_DB.Player.scale = scaleValue;
	trpPlayer.button:SetScale(TRP3_UF_DB.Player.scale);
	TRP3_UFPanel.CheckSettings();
end)


TRP3_UFPanel.scrollChild.PlayerPosSlider = CreateFrame("Slider", nil, TRP3_UFPanel.scrollChild, "OptionsSliderTemplate");
TRP3_UFPanel.scrollChild.PlayerPosSlider:SetWidth(250);
TRP3_UFPanel.scrollChild.PlayerPosSlider:SetHeight(15);
TRP3_UFPanel.scrollChild.PlayerPosSlider:SetMinMaxValues(-15,15);
TRP3_UFPanel.scrollChild.PlayerPosSlider:SetValueStep(.5);
TRP3_UFPanel.scrollChild.PlayerPosSlider:SetObeyStepOnDrag(true)
TRP3_UFPanel.scrollChild.PlayerPosSlider:ClearAllPoints();
TRP3_UFPanel.scrollChild.PlayerPosSlider:SetPoint("TOPLEFT", TRP3_UFPanel.scrollChild, "TOPLEFT", 5, -53*9);
TRP3_UFPanel.scrollChild.PlayerPosSlider.Low:SetText("-15");
TRP3_UFPanel.scrollChild.PlayerPosSlider.High:SetText("15");
TRP3_UFPanel.scrollChild.PlayerPosSlider.Text:SetText(L["ButtonPosPlayer"]);
TRP3_UFPanel.scrollChild.PlayerPosSlider:SetScript("OnValueChanged", function()
	local scaleValue = TRP3_UFPanel.scrollChild.PlayerPosSlider:GetValue();
	TRP3_UF_DB.Player.position = scaleValue;
	trpPlayer.SetPos();
	TRP3_UFPanel.CheckSettings();
end)

------------------------------------------------------------------------------------------------------------------

TRP3_UFPanel.scrollChild.ColorsText = TRP3_UFPanel.scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal");
TRP3_UFPanel.scrollChild.ColorsText:SetFont(TRP3_UFPanel.scrollChild.ColorsText:GetFont(), 15);
TRP3_UFPanel.scrollChild.ColorsText:SetTextColor(1,1,1,1);
TRP3_UFPanel.scrollChild.ColorsText:ClearAllPoints();
TRP3_UFPanel.scrollChild.ColorsText:SetPoint("TOPLEFT", 300, -53*3.7);
TRP3_UFPanel.scrollChild.ColorsText:SetText(COLORS);

TRP3_UFPanel.scrollChild.ColorsTarText = TRP3_UFPanel.scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal");
TRP3_UFPanel.scrollChild.ColorsTarText:SetFont(TRP3_UFPanel.scrollChild.ColorsTarText:GetFont(), 12);
TRP3_UFPanel.scrollChild.ColorsTarText:SetTextColor(1,1,1,1);
TRP3_UFPanel.scrollChild.ColorsTarText:ClearAllPoints();
TRP3_UFPanel.scrollChild.ColorsTarText:SetPoint("TOPLEFT", 300, -53*4.2);
TRP3_UFPanel.scrollChild.ColorsTarText:SetText(HUD_EDIT_MODE_TARGET_FRAME_LABEL);

TRP3_UFPanel.scrollChild.ColorsPlayerText = TRP3_UFPanel.scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal");
TRP3_UFPanel.scrollChild.ColorsPlayerText:SetFont(TRP3_UFPanel.scrollChild.ColorsPlayerText:GetFont(), 12);
TRP3_UFPanel.scrollChild.ColorsPlayerText:SetTextColor(1,1,1,1);
TRP3_UFPanel.scrollChild.ColorsPlayerText:ClearAllPoints();
TRP3_UFPanel.scrollChild.ColorsPlayerText:SetPoint("TOPLEFT", 300, -53*6.7);
TRP3_UFPanel.scrollChild.ColorsPlayerText:SetText(HUD_EDIT_MODE_PLAYER_FRAME_LABEL);

TRP3_UFPanel.scrollChild.NPCOptions = TRP3_UFPanel.scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal");
TRP3_UFPanel.scrollChild.NPCOptions:SetFont(TRP3_UFPanel.scrollChild.NPCOptions:GetFont(), 12);
TRP3_UFPanel.scrollChild.NPCOptions:SetTextColor(1,1,1,1);
TRP3_UFPanel.scrollChild.NPCOptions:ClearAllPoints();
TRP3_UFPanel.scrollChild.NPCOptions:SetPoint("TOPLEFT", 300, -53*9.2);
TRP3_UFPanel.scrollChild.NPCOptions:SetText(UNIT_NAME_NPC);


TRP3_UFPanel.scrollChild.TargetTextColorCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild, "UICheckButtonTemplate");
TRP3_UFPanel.scrollChild.TargetTextColorCheckbox:ClearAllPoints();
TRP3_UFPanel.scrollChild.TargetTextColorCheckbox:SetPoint("TOPLEFT", 300, -53*4.5);
TRP3_UFPanel.scrollChild.TargetTextColorCheckbox.Text:SetText(L["OverwriteTextCol"])

TRP3_UFPanel.scrollChild.TargetTextColorCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.scrollChild.TargetTextColorCheckbox:GetChecked() then
		TRP3_UF_DB.Target.colorText.custom = true;
	else
		TRP3_UF_DB.Target.colorText.custom = false;
	end
	TRP3_UFPanel.scrollChild.TarCustomTextColButton:SetEnabled(TRP3_UF_DB.Target.colorText.custom);
	trpPlayer.UpdateInfo();
	trpTarget.UpdateInfo();
	TRP3_UFPanel.CheckSettings();
end);


TRP3_UFPanel.scrollChild.TargetBackColorCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild, "UICheckButtonTemplate");
TRP3_UFPanel.scrollChild.TargetBackColorCheckbox:ClearAllPoints();
TRP3_UFPanel.scrollChild.TargetBackColorCheckbox:SetPoint("TOPLEFT", 300, -53*5);
TRP3_UFPanel.scrollChild.TargetBackColorCheckbox.Text:SetText(L["OverwriteBackCol"])

TRP3_UFPanel.scrollChild.TargetBackColorCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.scrollChild.TargetBackColorCheckbox:GetChecked() then
		TRP3_UF_DB.Target.colorBack.custom = true;
	else
		TRP3_UF_DB.Target.colorBack.custom = false;
	end
	TRP3_UFPanel.scrollChild.TarCustomBackColButton:SetEnabled(TRP3_UF_DB.Target.colorBack.custom);
	trpPlayer.UpdateInfo();
	trpTarget.UpdateInfo();
	TRP3_UFPanel.CheckSettings();
end);


TRP3_UFPanel.scrollChild.TargetClassTextColorCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild, "UICheckButtonTemplate");
TRP3_UFPanel.scrollChild.TargetClassTextColorCheckbox:ClearAllPoints();
TRP3_UFPanel.scrollChild.TargetClassTextColorCheckbox:SetPoint("TOPLEFT", 300, -53*5.5);
TRP3_UFPanel.scrollChild.TargetClassTextColorCheckbox.Text:SetText(L["BlizzTextCol"])

TRP3_UFPanel.scrollChild.TargetClassTextColorCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.scrollChild.TargetClassTextColorCheckbox:GetChecked() then
		TRP3_UF_DB.Target.colorText.class = true;
	else
		TRP3_UF_DB.Target.colorText.class = false;
	end
	trpPlayer.UpdateInfo();
	trpTarget.UpdateInfo();
	TRP3_UFPanel.CheckSettings();
end);


TRP3_UFPanel.scrollChild.TargetClassBackColorCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild, "UICheckButtonTemplate");
TRP3_UFPanel.scrollChild.TargetClassBackColorCheckbox:ClearAllPoints();
TRP3_UFPanel.scrollChild.TargetClassBackColorCheckbox:SetPoint("TOPLEFT", 300, -53*6);
TRP3_UFPanel.scrollChild.TargetClassBackColorCheckbox.Text:SetText(L["BlizzBackCol"])

TRP3_UFPanel.scrollChild.TargetClassBackColorCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.scrollChild.TargetClassBackColorCheckbox:GetChecked() then
		TRP3_UF_DB.Target.colorBack.class = true;
	else
		TRP3_UF_DB.Target.colorBack.class = false;
	end
	trpPlayer.UpdateInfo();
	trpTarget.UpdateInfo();
	TRP3_UFPanel.CheckSettings();
end);


--player
TRP3_UFPanel.scrollChild.PlayerTextColorCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild, "UICheckButtonTemplate");
TRP3_UFPanel.scrollChild.PlayerTextColorCheckbox:ClearAllPoints();
TRP3_UFPanel.scrollChild.PlayerTextColorCheckbox:SetPoint("TOPLEFT", 300, -53*7);
TRP3_UFPanel.scrollChild.PlayerTextColorCheckbox.Text:SetText(L["OverwriteTextCol"])

TRP3_UFPanel.scrollChild.PlayerTextColorCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.scrollChild.PlayerTextColorCheckbox:GetChecked() then
		TRP3_UF_DB.Player.colorText.custom = true;
	else
		TRP3_UF_DB.Player.colorText.custom = false;
	end
	TRP3_UFPanel.scrollChild.PlayerCustomTextColButton:SetEnabled(TRP3_UF_DB.Player.colorText.custom);
	trpPlayer.UpdateInfo();
	trpTarget.UpdateInfo();
	TRP3_UFPanel.CheckSettings();
end);


TRP3_UFPanel.scrollChild.PlayerBackColorCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild, "UICheckButtonTemplate");
TRP3_UFPanel.scrollChild.PlayerBackColorCheckbox:ClearAllPoints();
TRP3_UFPanel.scrollChild.PlayerBackColorCheckbox:SetPoint("TOPLEFT", 300, -53*7.5);
TRP3_UFPanel.scrollChild.PlayerBackColorCheckbox.Text:SetText(L["OverwriteBackCol"])

TRP3_UFPanel.scrollChild.PlayerBackColorCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.scrollChild.PlayerBackColorCheckbox:GetChecked() then
		TRP3_UF_DB.Player.colorBack.custom = true;
	else
		TRP3_UF_DB.Player.colorBack.custom = false;
	end
	TRP3_UFPanel.scrollChild.PlayerCustomBackColButton:SetEnabled(TRP3_UF_DB.Player.colorBack.custom);
	trpPlayer.UpdateInfo();
	trpTarget.UpdateInfo();
	TRP3_UFPanel.CheckSettings();
end);


TRP3_UFPanel.scrollChild.PlayerClassTextColorCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild, "UICheckButtonTemplate");
TRP3_UFPanel.scrollChild.PlayerClassTextColorCheckbox:ClearAllPoints();
TRP3_UFPanel.scrollChild.PlayerClassTextColorCheckbox:SetPoint("TOPLEFT", 300, -53*8);
TRP3_UFPanel.scrollChild.PlayerClassTextColorCheckbox.Text:SetText(L["BlizzTextCol"])

TRP3_UFPanel.scrollChild.PlayerClassTextColorCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.scrollChild.PlayerClassTextColorCheckbox:GetChecked() then
		TRP3_UF_DB.Player.colorText.class = true;
	else
		TRP3_UF_DB.Player.colorText.class = false;
	end
	trpPlayer.UpdateInfo();
	trpTarget.UpdateInfo();
	TRP3_UFPanel.CheckSettings();
end);


TRP3_UFPanel.scrollChild.PlayerClassBackColorCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild, "UICheckButtonTemplate");
TRP3_UFPanel.scrollChild.PlayerClassBackColorCheckbox:ClearAllPoints();
TRP3_UFPanel.scrollChild.PlayerClassBackColorCheckbox:SetPoint("TOPLEFT", 300, -53*8.5);
TRP3_UFPanel.scrollChild.PlayerClassBackColorCheckbox.Text:SetText(L["BlizzBackCol"])

TRP3_UFPanel.scrollChild.PlayerClassBackColorCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.scrollChild.PlayerClassBackColorCheckbox:GetChecked() then
		TRP3_UF_DB.Player.colorBack.class = true;
	else
		TRP3_UF_DB.Player.colorBack.class = false;
	end
	trpPlayer.UpdateInfo();
	trpTarget.UpdateInfo();
	TRP3_UFPanel.CheckSettings();
end);


--other
TRP3_UFPanel.scrollChild.NPCOptionsCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild, "UICheckButtonTemplate");
TRP3_UFPanel.scrollChild.NPCOptionsCheckbox:ClearAllPoints();
TRP3_UFPanel.scrollChild.NPCOptionsCheckbox:SetPoint("TOPLEFT", 300, -53*9.5);
TRP3_UFPanel.scrollChild.NPCOptionsCheckbox.Text:SetText(L["ApplyToNPCs"])

TRP3_UFPanel.scrollChild.NPCOptionsCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.scrollChild.NPCOptionsCheckbox:GetChecked() then
		TRP3_UF_DB.Setting.NPCs = true;
	else
		TRP3_UF_DB.Setting.NPCs = false;
	end
	trpTarget.UpdateInfo();
	TRP3_UFPanel.CheckSettings();
end);

--toggle full names

TRP3_UFPanel.scrollChild.UseTRP3NameCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild, "UICheckButtonTemplate");
TRP3_UFPanel.scrollChild.UseTRP3NameCheckbox:ClearAllPoints();
TRP3_UFPanel.scrollChild.UseTRP3NameCheckbox:SetPoint("TOPLEFT", 300, -53*10);
TRP3_UFPanel.scrollChild.UseTRP3NameCheckbox.Text:SetText(L["TRP3CustomName"])

TRP3_UFPanel.scrollChild.UseTRP3NameCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.scrollChild.UseTRP3NameCheckbox:GetChecked() then
		TRP3_UF_DB.Setting.UseTRPName = true;
	else
		TRP3_UF_DB.Setting.UseTRPName = false;
	end
	TRP3_UFPanel.scrollChild.FullNamePCheckbox:SetEnabled(TRP3_UF_DB.Setting.UseTRPName)
	TRP3_UFPanel.scrollChild.FullNameTCheckbox:SetEnabled(TRP3_UF_DB.Setting.UseTRPName)
	trpPlayer.UpdateInfo();
	trpTarget.UpdateInfo();
	TRP3_UFPanel.CheckSettings();
end);

TRP3_UFPanel.scrollChild.FullNamePCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild, "UICheckButtonTemplate");
TRP3_UFPanel.scrollChild.FullNamePCheckbox:ClearAllPoints();
TRP3_UFPanel.scrollChild.FullNamePCheckbox:SetPoint("TOPLEFT", 300, -53*10.5);
TRP3_UFPanel.scrollChild.FullNamePCheckbox.Text:SetText(L["FullNamePlayer"])

TRP3_UFPanel.scrollChild.FullNamePCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.scrollChild.FullNamePCheckbox:GetChecked() then
		TRP3_UF_DB.Setting.FullNamePlayer = true;
	else
		TRP3_UF_DB.Setting.FullNamePlayer = false;
	end
	trpPlayer.UpdateInfo();
	trpTarget.UpdateInfo();
	TRP3_UFPanel.CheckSettings();
end);

TRP3_UFPanel.scrollChild.FullNameTCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.scrollChild, "UICheckButtonTemplate");
TRP3_UFPanel.scrollChild.FullNameTCheckbox:ClearAllPoints();
TRP3_UFPanel.scrollChild.FullNameTCheckbox:SetPoint("TOPLEFT", 300, -53*11);
TRP3_UFPanel.scrollChild.FullNameTCheckbox.Text:SetText(L["FullNameTarget"])

TRP3_UFPanel.scrollChild.FullNameTCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.scrollChild.FullNameTCheckbox:GetChecked() then
		TRP3_UF_DB.Setting.FullNameTarget = true;
	else
		TRP3_UF_DB.Setting.FullNameTarget = false;
	end
	trpPlayer.UpdateInfo();
	trpTarget.UpdateInfo();
	TRP3_UFPanel.CheckSettings();
end);



------------------------------------------------------------------------------------------------------------------


--setting up our "atlas member" list
function PlayerDragonFrame.TextureStuff()
	if TRP3_UF_DB.Border.show ~= true then
		PlayerDragonFrame:Hide()
		return
	end
	if TRP3_UF_DB.Border.style == "rare" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\uiunitframeboss2x")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", 8, -10)
		PlayerDragonFrame:SetSize(80, 79);
		PlayerDragonFrame.tex:SetTexCoord(0.314453125, 0.001953125, 0.322265625, 0.630859375) -- rare
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "rare-elite" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\uiunitframeboss2x")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(0.77734375, 0.390625, 0.001953125, 0.318359375) -- rare-elite
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "elite" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\uiunitframeboss2x")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", 8, -10)
		PlayerDragonFrame:SetSize(80, 79);
		PlayerDragonFrame.tex:SetTexCoord(0.3125, 0.001953125, 0.634765625, 0.947265625) -- elite
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "boss" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\uiunitframeboss2x")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(0.388671875, 0.001953125, 0.001953125, 0.318359375) -- boss
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end

	--LGBTQ+
	if TRP3_UF_DB.Border.style == "agender" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_agender")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(.051, .437, .215, .845) -- lgbtq+ player
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "asexual" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_asexual")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(.051, .437, .215, .845) -- lgbtq+ player
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "aroace" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_aroace")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(.051, .437, .215, .845) -- lgbtq+ player
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "bisexual" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_BiS")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(.051, .437, .215, .845) -- lgbtq+ player
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "enby" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_enby")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(.051, .437, .215, .845) -- lgbtq+ player
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "gaym" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_gayM")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(.051, .437, .215, .845) -- lgbtq+ player
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "genderfluid" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_genderfluid")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(.051, .437, .215, .845) -- lgbtq+ player
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "genderqueer" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_genderqueer")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(.051, .437, .215, .845) -- lgbtq+ player
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "lesbian" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_lesbian")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(.051, .437, .215, .845) -- lgbtq+ player
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "transgender" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_trans")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(.051, .437, .215, .845) -- lgbtq+ player
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "pansexual" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_pansexual")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(.051, .437, .215, .845) -- lgbtq+ player
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "rainbow" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_rainbow")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(.051, .437, .215, .845) -- lgbtq+ player
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "rainbowphilly" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_philly")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(.051, .437, .215, .845) -- lgbtq+ player
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "rainbowgilbaker" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_gilbertbaker")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(.051, .437, .215, .845) -- lgbtq+ player
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "rainbowprogress" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_progress")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(.051, .437, .215, .845) -- lgbtq+ player
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end


	--Narcissus
	if TRP3_UF_DB.Border.style == "NarciHexagonBorder" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder.tga")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -8)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(-.26, .93, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonBorder-Artifact" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Artifact.tga")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -8)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(-.26, .93, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonBorder-Azerite" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Azerite.tga")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -8)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(-.26, .93, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonBorder-Black" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Black.tga")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -8)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(-.26, .93, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonBorder-BlackDragon" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-BlackDragon.tga")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -8)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(-.26, .93, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonBorder-Epic" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Epic.tga")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -8)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(-.26, .93, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonBorder-Heart" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Heart.tga")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -8)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(-.26, .93, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonBorder-Heirloom" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Heirloom.tga")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -8)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(-.26, .93, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonBorder-Legendary" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Legendary.tga")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -8)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(-.26, .93, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonBorder-NZoth" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-NZoth.tga")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -8)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(-.26, .93, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonBorder-Rare" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Rare.tga")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -8)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(-.26, .93, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonBorder-Special" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Special.tga")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -8)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(-.26, .93, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonBorder-Uncommon" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Uncommon.tga")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -8)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(-.26, .93, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonBorder-Void" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Void.tga")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -8)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(-.26, .93, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end


	if TRP3_UF_DB.Border.style == "NarciHexagonDarkBorder-Artifact" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\JPG\\Artifact.jpg")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -27, 30)
		PlayerDragonFrame:SetSize(160, 160);
		PlayerDragonFrame.tex:SetTexCoord(0, 1, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:AddMaskTexture(PlayerDragonFrame.mask)
		PlayerDragonFrame.mask:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\Mask\\RegularHeavy.tga")
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonDarkBorder-Azerite" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\JPG\\Azerite.jpg")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -27, 30)
		PlayerDragonFrame:SetSize(160, 160);
		PlayerDragonFrame.tex:SetTexCoord(0, 1, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:AddMaskTexture(PlayerDragonFrame.mask)
		PlayerDragonFrame.mask:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\Mask\\RegularHeavy.tga")
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonDarkBorder-Black" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\JPG\\Black.jpg")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -27, 30)
		PlayerDragonFrame:SetSize(160, 160);
		PlayerDragonFrame.tex:SetTexCoord(0, 1, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:AddMaskTexture(PlayerDragonFrame.mask)
		PlayerDragonFrame.mask:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\Mask\\RegularHeavy.tga")
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonDarkBorder-BlackDragon" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\JPG\\BlackDragon.jpg")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -27, 30)
		PlayerDragonFrame:SetSize(160, 160);
		PlayerDragonFrame.tex:SetTexCoord(0, 1, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:AddMaskTexture(PlayerDragonFrame.mask)
		PlayerDragonFrame.mask:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\Mask\\RegularHeavy.tga")
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonDarkBorder-Dragonflight" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\JPG\\Dragonflight.jpg")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -27, 30)
		PlayerDragonFrame:SetSize(160, 160);
		PlayerDragonFrame.tex:SetTexCoord(0, 1, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:AddMaskTexture(PlayerDragonFrame.mask)
		PlayerDragonFrame.mask:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\Mask\\Dragonflight.tga")
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonDarkBorder-Epic" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\JPG\\Epic.jpg")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -27, 30)
		PlayerDragonFrame:SetSize(160, 160);
		PlayerDragonFrame.tex:SetTexCoord(0, 1, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:AddMaskTexture(PlayerDragonFrame.mask)
		PlayerDragonFrame.mask:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\Mask\\RegularHeavy.tga")
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonDarkBorder-Heart" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\JPG\\Heart.jpg")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -27, 30)
		PlayerDragonFrame:SetSize(160, 160);
		PlayerDragonFrame.tex:SetTexCoord(0, 1, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:AddMaskTexture(PlayerDragonFrame.mask)
		PlayerDragonFrame.mask:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\Mask\\Heart.tga")
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonDarkBorder-Heirloom" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\JPG\\Heirloom.jpg")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -27, 30)
		PlayerDragonFrame:SetSize(160, 160);
		PlayerDragonFrame.tex:SetTexCoord(0, 1, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:AddMaskTexture(PlayerDragonFrame.mask)
		PlayerDragonFrame.mask:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\Mask\\RegularHeavy.tga")
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonDarkBorder-Legendary" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\JPG\\Legendary.jpg")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -27, 30)
		PlayerDragonFrame:SetSize(160, 160);
		PlayerDragonFrame.tex:SetTexCoord(0, 1, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:AddMaskTexture(PlayerDragonFrame.mask)
		PlayerDragonFrame.mask:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\Mask\\RegularHeavy.tga")
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonDarkBorder-Progenitor" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\JPG\\Progenitor.jpg")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -27, 30)
		PlayerDragonFrame:SetSize(160, 160);
		PlayerDragonFrame.tex:SetTexCoord(0, 1, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:AddMaskTexture(PlayerDragonFrame.mask)
		PlayerDragonFrame.mask:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\Mask\\Progenitor.tga")
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonDarkBorder-Rare" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\JPG\\Rare.jpg")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -27, 30)
		PlayerDragonFrame:SetSize(160, 160);
		PlayerDragonFrame.tex:SetTexCoord(0, 1, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:AddMaskTexture(PlayerDragonFrame.mask)
		PlayerDragonFrame.mask:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\Mask\\RegularHeavy.tga")
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonDarkBorder-Runeforge" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\JPG\\Runeforge.jpg")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -27, 30)
		PlayerDragonFrame:SetSize(160, 160);
		PlayerDragonFrame.tex:SetTexCoord(0, 1, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:AddMaskTexture(PlayerDragonFrame.mask)
		PlayerDragonFrame.mask:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\Mask\\Runeforge.tga")
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonDarkBorder-Shield" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\JPG\\Shield.jpg")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -27, 30)
		PlayerDragonFrame:SetSize(160, 160);
		PlayerDragonFrame.tex:SetTexCoord(0, 1, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:AddMaskTexture(PlayerDragonFrame.mask)
		PlayerDragonFrame.mask:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\Mask\\RegularHeavy.tga")
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonDarkBorder-Uncommon" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\JPG\\Uncommon.jpg")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -27, 30)
		PlayerDragonFrame:SetSize(160, 160);
		PlayerDragonFrame.tex:SetTexCoord(0, 1, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:AddMaskTexture(PlayerDragonFrame.mask)
		PlayerDragonFrame.mask:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\Mask\\RegularHeavy.tga")
	end

end

PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
PlayerDragonFrame:SetSize(99, 81);
PlayerDragonFrame.tex:SetTexCoord(0.77734375, 0.390625, 0.001953125, 0.318359375) -- rare elite


------------------------------------------------------------------------------------------------------------------



TRP3_UFPanel.menu = {
	{ text = L["SelectOption"], isTitle = true},
	{ text = L["Dragons"], hasArrow = true,
		menuList = {
			{ text = ITEM_QUALITY3_DESC, func = function() TRP3_UF_DB.Border.style = "rare"; PlayerDragonFrame.TextureStuff(); end },
			{ text = ELITE, func = function() TRP3_UF_DB.Border.style = "elite"; PlayerDragonFrame.TextureStuff(); end },
			{ text = ITEM_QUALITY3_DESC .. " " .. ELITE, func = function() TRP3_UF_DB.Border.style = "rare-elite"; PlayerDragonFrame.TextureStuff(); end },
			{ text = BOSS, func = function() TRP3_UF_DB.Border.style = "boss"; PlayerDragonFrame.TextureStuff(); end },
		},
	},
	{ text = L["Hearthstone"], hasArrow = true,
		menuList = {
			{ text = L["ComingSoon"], isTitle = true},
		},
	},
	{ text = L["Narcissus"], hasArrow = true,
		menuList = {
			{ text = L["ComingSoon"], isTitle = true},
		},
	},
	{ text = L["LGBQT+"], hasArrow = true,
		menuList = {
			{ text = L["Agender"], func = function() TRP3_UF_DB.Border.style = "agender"; PlayerDragonFrame.TextureStuff(); end },
			{ text = L["Asexual"], func = function() TRP3_UF_DB.Border.style = "asexual"; PlayerDragonFrame.TextureStuff(); end },
			{ text = L["Aromantic Asexual"], func = function() TRP3_UF_DB.Border.style = "aroace"; PlayerDragonFrame.TextureStuff(); end },
			{ text = L["Bisexual"], func = function() TRP3_UF_DB.Border.style = "bisexual"; PlayerDragonFrame.TextureStuff(); end },
			{ text = L["Non-Binary"], func = function() TRP3_UF_DB.Border.style = "enby"; PlayerDragonFrame.TextureStuff(); end },
			{ text = L["Gay Male"], func = function() TRP3_UF_DB.Border.style = "gaym"; PlayerDragonFrame.TextureStuff(); end },
			{ text = L["Genderfluid"], func = function() TRP3_UF_DB.Border.style = "genderfluid"; PlayerDragonFrame.TextureStuff(); end },
			{ text = L["Genderqueer"], func = function() TRP3_UF_DB.Border.style = "genderqueer"; PlayerDragonFrame.TextureStuff(); end },
			{ text = L["Lesbian"], func = function() TRP3_UF_DB.Border.style = "lesbian"; PlayerDragonFrame.TextureStuff(); end },
			{ text = L["Transgender"], func = function() TRP3_UF_DB.Border.style = "transgender"; PlayerDragonFrame.TextureStuff(); end },
			{ text = L["Pansexual"], func = function() TRP3_UF_DB.Border.style = "pansexual"; PlayerDragonFrame.TextureStuff(); end },
			{ text = L["Rainbow"], func = function() TRP3_UF_DB.Border.style = "rainbow"; PlayerDragonFrame.TextureStuff(); end },
			{ text = L["RainbowPhilly"], func = function() TRP3_UF_DB.Border.style = "rainbowphilly"; PlayerDragonFrame.TextureStuff(); end },
			{ text = L["RainbowGilBaker"], func = function() TRP3_UF_DB.Border.style = "rainbowgilbaker"; PlayerDragonFrame.TextureStuff(); end },
			{ text = L["RainbowProgress"], func = function() TRP3_UF_DB.Border.style = "rainbowprogress"; PlayerDragonFrame.TextureStuff(); end },
		},
	},
};



TRP3_UFPanel.scrollChild.menuFrame = CreateFrame("Frame", "TRP3PlayerPortraitMenuFrame", TRP3_UFPanel.scrollChild, "UIDropDownMenuTemplate")

TRP3_UFPanel.scrollChild.PortraitButton = CreateFrame("Button", nil, TRP3_UFPanel.scrollChild, "SharedGoldRedButtonSmallTemplate")
TRP3_UFPanel.scrollChild.PortraitButton:SetPoint("TOPLEFT", 150, -53*5.1);
TRP3_UFPanel.scrollChild.PortraitButton:SetSize(120, 26);
TRP3_UFPanel.scrollChild.PortraitButton:SetText(L["PlayerPortrait"])
TRP3_UFPanel.scrollChild.PortraitButton:SetScript("OnClick", function() EasyMenu(TRP3_UFPanel.menu, TRP3_UFPanel.scrollChild.menuFrame, TRP3_UFPanel.scrollChild.PortraitButton, 0 , 0, "MENU", 10) end)

------------------------------------------------------------------------------------------------------------------

TRP3_UFPanel.scrollChild.TarCustomTextColButton = CreateFrame("Button", nil, TRP3_UFPanel.scrollChild, "SharedGoldRedButtonSmallTemplate")
TRP3_UFPanel.scrollChild.TarCustomTextColButton:SetPoint("TOPLEFT", 150*3.3, -53*4.6);
TRP3_UFPanel.scrollChild.TarCustomTextColButton:SetSize(120, 26);
TRP3_UFPanel.scrollChild.TarCustomTextColButton:SetText(COLOR_PICKER)
TRP3_UFPanel.scrollChild.TarCustomTextColButton:SetScript("OnClick", function() ShowColorPicker(TRP3_UF_DB.Target.colorText.r, TRP3_UF_DB.Target.colorText.g, TRP3_UF_DB.Target.colorText.b, nil, TargetTextColor); end)


TRP3_UFPanel.scrollChild.TarCustomBackColButton = CreateFrame("Button", nil, TRP3_UFPanel.scrollChild, "SharedGoldRedButtonSmallTemplate")
TRP3_UFPanel.scrollChild.TarCustomBackColButton:SetPoint("TOPLEFT", 150*3.3, -53*5.1);
TRP3_UFPanel.scrollChild.TarCustomBackColButton:SetSize(120, 26);
TRP3_UFPanel.scrollChild.TarCustomBackColButton:SetText(COLOR_PICKER)
TRP3_UFPanel.scrollChild.TarCustomBackColButton:SetScript("OnClick", function() ShowColorPicker(TRP3_UF_DB.Target.colorBack.r, TRP3_UF_DB.Target.colorBack.g, TRP3_UF_DB.Target.colorBack.b, TRP3_UF_DB.Target.colorBack.a, TargetBackdropColor); end)

TRP3_UFPanel.scrollChild.PlayerCustomTextColButton = CreateFrame("Button", nil, TRP3_UFPanel.scrollChild, "SharedGoldRedButtonSmallTemplate")
TRP3_UFPanel.scrollChild.PlayerCustomTextColButton:SetPoint("TOPLEFT", 150*3.3, -53*7.1);
TRP3_UFPanel.scrollChild.PlayerCustomTextColButton:SetSize(120, 26);
TRP3_UFPanel.scrollChild.PlayerCustomTextColButton:SetText(COLOR_PICKER)
TRP3_UFPanel.scrollChild.PlayerCustomTextColButton:SetScript("OnClick", function() ShowColorPicker(TRP3_UF_DB.Player.colorText.r, TRP3_UF_DB.Player.colorText.g, TRP3_UF_DB.Player.colorText.b, nil, PlayerTextColor); end)

TRP3_UFPanel.scrollChild.PlayerCustomBackColButton = CreateFrame("Button", nil, TRP3_UFPanel.scrollChild, "SharedGoldRedButtonSmallTemplate")
TRP3_UFPanel.scrollChild.PlayerCustomBackColButton:SetPoint("TOPLEFT", 150*3.3, -53*7.6);
TRP3_UFPanel.scrollChild.PlayerCustomBackColButton:SetSize(120, 26);
TRP3_UFPanel.scrollChild.PlayerCustomBackColButton:SetText(COLOR_PICKER)
TRP3_UFPanel.scrollChild.PlayerCustomBackColButton:SetScript("OnClick", function() ShowColorPicker(TRP3_UF_DB.Player.colorBack.r, TRP3_UF_DB.Player.colorBack.g, TRP3_UF_DB.Player.colorBack.b, TRP3_UF_DB.Player.colorBack.a, PlayerBackdropColor); end)

------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------


--
--DUPLICATE OF THE SETTINGS PANEL, BUT FOR TRP3 WINDOW. WILL BE REMOVING THIS SOME DAY

local TRP3_UFSettingsFrame = CreateFrame("ScrollFrame", nil, UIParent, "ScrollFrameTemplate")
TRP3_UFSettingsFrame:SetPoint("TOPLEFT", 3, -4)
TRP3_UFSettingsFrame:SetPoint("BOTTOMRIGHT", -27, 4)
TRP3_UFSettingsFrame:ClearAllPoints();
TRP3_UFSettingsFrame.Backdrop = CreateFrame("Frame", nil, TRP3_UFSettingsFrame, "InsetFrameTemplate")
TRP3_UFSettingsFrame.Backdrop:SetAllPoints(TRP3_UFSettingsFrame)

TRP3_UFPanel.TRP3_scrollChild = CreateFrame("Frame")
TRP3_UFSettingsFrame:SetScrollChild(TRP3_UFPanel.TRP3_scrollChild)
TRP3_UFPanel.TRP3_scrollChild:SetWidth(SettingsPanel:GetWidth()-18)
TRP3_UFPanel.TRP3_scrollChild:SetHeight(1)


------------------------------------------------------------------------------------------------------------------
--position presets
TRP3_UFPanel.TRP3_scrollChild.dummyFramePlayer = CreateFrame("Frame", nil, TRP3_UFPanel.TRP3_scrollChild)
TRP3_UFPanel.TRP3_scrollChild.dummyFramePlayer:SetPoint("TOPLEFT", TRP3_UFPanel.TRP3_scrollChild, "TOPLEFT", 15, -53)
TRP3_UFPanel.TRP3_scrollChild.dummyFramePlayer:SetSize(198, 71)
TRP3_UFPanel.TRP3_scrollChild.dummyFramePlayer.tex = TRP3_UFPanel.TRP3_scrollChild.dummyFramePlayer:CreateTexture(nil, "ARTWORK", nil, 1)
TRP3_UFPanel.TRP3_scrollChild.dummyFramePlayer.tex:SetAllPoints(TRP3_UFPanel.TRP3_scrollChild.dummyFramePlayer)
TRP3_UFPanel.TRP3_scrollChild.dummyFramePlayer.tex:SetAtlas("UI-HUD-UnitFrame-Player-PortraitOn")
TRP3_UFPanel.TRP3_scrollChild.dummyFramePlayer.tex:SetTexCoord(0, 1, 0, 1)

TRP3_UFPanel.TRP3_scrollChild.dummyFrameTarget = CreateFrame("Frame", nil, TRP3_UFPanel.TRP3_scrollChild)
TRP3_UFPanel.TRP3_scrollChild.dummyFrameTarget:SetPoint("TOPLEFT", TRP3_UFPanel.TRP3_scrollChild, "TOPLEFT", 325, -53)
TRP3_UFPanel.TRP3_scrollChild.dummyFrameTarget:SetSize(198, 71)
TRP3_UFPanel.TRP3_scrollChild.dummyFrameTarget.tex = TRP3_UFPanel.TRP3_scrollChild.dummyFrameTarget:CreateTexture(nil, "ARTWORK", nil, 1)
TRP3_UFPanel.TRP3_scrollChild.dummyFrameTarget.tex:SetAllPoints(TRP3_UFPanel.TRP3_scrollChild.dummyFrameTarget)
TRP3_UFPanel.TRP3_scrollChild.dummyFrameTarget.tex:SetAtlas("UI-HUD-UnitFrame-Target-PortraitOn")
TRP3_UFPanel.TRP3_scrollChild.dummyFrameTarget.tex:SetTexCoord(0, 1, 0, 1)


TRP3_UFPanel.TRP3_scrollChild.Pf = CreateFrame("Frame", nil, TRP3_UFPanel.TRP3_scrollChild)
TRP3_UFPanel.TRP3_scrollChild.Pf:ClearAllPoints();
TRP3_UFPanel.TRP3_scrollChild.Pf:SetPoint("TOPLEFT", TRP3_UFPanel.TRP3_scrollChild.dummyFramePlayer, "TOPLEFT", 5,-3);
TRP3_UFPanel.TRP3_scrollChild.Pf:SetSize(64, 64)

TRP3_UFPanel.TRP3_scrollChild.Pf.tex = TRP3_UFPanel.TRP3_scrollChild.Pf:CreateTexture()
TRP3_UFPanel.TRP3_scrollChild.Pf.tex:SetAllPoints(TRP3_UFPanel.TRP3_scrollChild.Pf)
SetPortraitTexture(TRP3_UFPanel.TRP3_scrollChild.Pf.tex, "player")

TRP3_UFPanel.TRP3_scrollChild.Tf = CreateFrame("Frame", nil, TRP3_UFPanel.TRP3_scrollChild)
TRP3_UFPanel.TRP3_scrollChild.Tf:ClearAllPoints();
TRP3_UFPanel.TRP3_scrollChild.Tf:SetPoint("TOPLEFT", TRP3_UFPanel.TRP3_scrollChild.dummyFrameTarget, "TOPLEFT", 128, -2);
TRP3_UFPanel.TRP3_scrollChild.Tf:SetSize(64, 64)

TRP3_UFPanel.TRP3_scrollChild.Tf.tex = TRP3_UFPanel.TRP3_scrollChild.Tf:CreateTexture()
TRP3_UFPanel.TRP3_scrollChild.Tf.tex:SetAllPoints(TRP3_UFPanel.TRP3_scrollChild.Tf)
SetPortraitTexture(TRP3_UFPanel.TRP3_scrollChild.Tf.tex, "player")

function TRP3_UFPanel.TRP3_scrollChild.OnShow()
	SetPortraitTexture(TRP3_UFPanel.TRP3_scrollChild.Pf.tex, "player")
	SetPortraitTexture(TRP3_UFPanel.TRP3_scrollChild.Tf.tex, "player")
end

TRP3_UFPanel.TRP3_scrollChild.Tf:SetScript("OnShow",TRP3_UFPanel.TRP3_scrollChild.OnShow);

TRP3_UFPanel.TRP3_scrollChild.Pf.radioTopLeft = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild.Pf, "UIRadioButtonTemplate")
TRP3_UFPanel.TRP3_scrollChild.Pf.radioTop = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild.Pf, "UIRadioButtonTemplate")
TRP3_UFPanel.TRP3_scrollChild.Pf.radioTopRight = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild.Pf, "UIRadioButtonTemplate")
TRP3_UFPanel.TRP3_scrollChild.Pf.radioLeft = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild.Pf, "UIRadioButtonTemplate")
TRP3_UFPanel.TRP3_scrollChild.Pf.radioCenter = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild.Pf, "UIRadioButtonTemplate")
TRP3_UFPanel.TRP3_scrollChild.Pf.radioRight = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild.Pf, "UIRadioButtonTemplate")
TRP3_UFPanel.TRP3_scrollChild.Pf.radioBottomLeft = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild.Pf, "UIRadioButtonTemplate")
TRP3_UFPanel.TRP3_scrollChild.Pf.radioBottom = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild.Pf, "UIRadioButtonTemplate")
TRP3_UFPanel.TRP3_scrollChild.Pf.radioBottomRight = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild.Pf, "UIRadioButtonTemplate")

TRP3_UFPanel.TRP3_scrollChild.Pf.radioTopLeft:SetChecked(false)
TRP3_UFPanel.TRP3_scrollChild.Pf.radioTop:SetChecked(false)
TRP3_UFPanel.TRP3_scrollChild.Pf.radioTopRight:SetChecked(false)
TRP3_UFPanel.TRP3_scrollChild.Pf.radioLeft:SetChecked(false)
TRP3_UFPanel.TRP3_scrollChild.Pf.radioCenter:SetChecked(false)
TRP3_UFPanel.TRP3_scrollChild.Pf.radioRight:SetChecked(false)
TRP3_UFPanel.TRP3_scrollChild.Pf.radioBottomLeft:SetChecked(false)
TRP3_UFPanel.TRP3_scrollChild.Pf.radioBottom:SetChecked(false)
TRP3_UFPanel.TRP3_scrollChild.Pf.radioBottomRight:SetChecked(true)

TRP3_UFPanel.TRP3_scrollChild.Pf.radioTopLeft:SetPoint("CENTER", TRP3_UFPanel.TRP3_scrollChild.Pf, "TOPLEFT", 0, 0)
TRP3_UFPanel.TRP3_scrollChild.Pf.radioTop:SetPoint("CENTER", TRP3_UFPanel.TRP3_scrollChild.Pf, "TOP", 0, 0)
TRP3_UFPanel.TRP3_scrollChild.Pf.radioTopRight:SetPoint("CENTER", TRP3_UFPanel.TRP3_scrollChild.Pf, "TOPRIGHT", 0, 0)
TRP3_UFPanel.TRP3_scrollChild.Pf.radioLeft:SetPoint("CENTER", TRP3_UFPanel.TRP3_scrollChild.Pf, "LEFT", 0, 0)
TRP3_UFPanel.TRP3_scrollChild.Pf.radioCenter:SetPoint("CENTER", TRP3_UFPanel.TRP3_scrollChild.Pf, "CENTER", 0, 0)
TRP3_UFPanel.TRP3_scrollChild.Pf.radioRight:SetPoint("CENTER", TRP3_UFPanel.TRP3_scrollChild.Pf, "RIGHT", 0, 0)
TRP3_UFPanel.TRP3_scrollChild.Pf.radioBottomLeft:SetPoint("CENTER", TRP3_UFPanel.TRP3_scrollChild.Pf, "BOTTOMLEFT", 0, 0)
TRP3_UFPanel.TRP3_scrollChild.Pf.radioBottom:SetPoint("CENTER", TRP3_UFPanel.TRP3_scrollChild.Pf, "BOTTOM", 0, 0)
TRP3_UFPanel.TRP3_scrollChild.Pf.radioBottomRight:SetPoint("CENTER", TRP3_UFPanel.TRP3_scrollChild.Pf, "BOTTOMRIGHT", 0, 0)

TRP3_UFPanel.TRP3_scrollChild.Pf.TitleText = TRP3_UFPanel.TRP3_scrollChild.Pf:CreateFontString(nil, "OVERLAY", "GameFontNormal");
TRP3_UFPanel.TRP3_scrollChild.Pf.TitleText:SetFont(TRP3_UFPanel.TRP3_scrollChild.Pf.TitleText:GetFont(), 12);
TRP3_UFPanel.TRP3_scrollChild.Pf.TitleText:SetTextColor(1,1,1,1);
TRP3_UFPanel.TRP3_scrollChild.Pf.TitleText:ClearAllPoints();
TRP3_UFPanel.TRP3_scrollChild.Pf.TitleText:SetPoint("BOTTOM", TRP3_UFPanel.TRP3_scrollChild.Pf, "BOTTOM",0,-25);
TRP3_UFPanel.TRP3_scrollChild.Pf.TitleText:SetText(PLAYER);

TRP3_UFPanel.TRP3_scrollChild.TopTitle = TRP3_UFPanel.TRP3_scrollChild.Pf:CreateFontString(nil, "OVERLAY", "GameFontNormal");
TRP3_UFPanel.TRP3_scrollChild.TopTitle:SetFont(TRP3_UFPanel.TRP3_scrollChild.TopTitle:GetFont(), 20);
TRP3_UFPanel.TRP3_scrollChild.TopTitle:SetTextColor(1,1,1,1);
TRP3_UFPanel.TRP3_scrollChild.TopTitle:ClearAllPoints();
TRP3_UFPanel.TRP3_scrollChild.TopTitle:SetPoint("TOPLEFT", TRP3_UFPanel.TRP3_scrollChild, "TOPLEFT",50,-25);
TRP3_UFPanel.TRP3_scrollChild.TopTitle:SetText(TRP3_API.utils.Oldgodify(L["Title"]));

TRP3_UFPanel.TRP3_scrollChild.Pf.allRadios = {
	TRP3_UFPanel.TRP3_scrollChild.Pf.radioTopLeft,
	TRP3_UFPanel.TRP3_scrollChild.Pf.radioTop,
	TRP3_UFPanel.TRP3_scrollChild.Pf.radioTopRight,
	TRP3_UFPanel.TRP3_scrollChild.Pf.radioLeft,
	TRP3_UFPanel.TRP3_scrollChild.Pf.radioCenter,
	TRP3_UFPanel.TRP3_scrollChild.Pf.radioRight,
	TRP3_UFPanel.TRP3_scrollChild.Pf.radioBottomLeft,
	TRP3_UFPanel.TRP3_scrollChild.Pf.radioBottom,
	TRP3_UFPanel.TRP3_scrollChild.Pf.radioBottomRight
};

function TRP3_UFPanel.TRP3_scrollChild.Pf.createOnRadioClicked(location)
	local function onRadioClicked(self, a, b, c)
		local checked = self:GetChecked()
		PlaySound(PlaySoundKitID and "igMainMenuOptionCheckBoxOn" or SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		TRP3_UF_DB.Player.relativePoint = location

		local anyChecked = false
		for _, radio in ipairs(TRP3_UFPanel.TRP3_scrollChild.Pf.allRadios) do
			if radio ~= self then
				anyChecked = radio:GetChecked() or anyChecked
				radio:SetChecked(false)
			end
		end
		if not anyChecked then
			self:SetChecked(true)
		end
		trpPlayer.SetPos()
	end
	return onRadioClicked
end

TRP3_UFPanel.TRP3_scrollChild.Pf.radioTopLeft:SetScript("OnClick", TRP3_UFPanel.TRP3_scrollChild.Pf.createOnRadioClicked("TOPLEFT"))
TRP3_UFPanel.TRP3_scrollChild.Pf.radioTop:SetScript("OnClick", TRP3_UFPanel.TRP3_scrollChild.Pf.createOnRadioClicked("TOP"))
TRP3_UFPanel.TRP3_scrollChild.Pf.radioTopRight:SetScript("OnClick", TRP3_UFPanel.TRP3_scrollChild.Pf.createOnRadioClicked("TOPRIGHT"))
TRP3_UFPanel.TRP3_scrollChild.Pf.radioLeft:SetScript("OnClick", TRP3_UFPanel.TRP3_scrollChild.Pf.createOnRadioClicked("LEFT"))
TRP3_UFPanel.TRP3_scrollChild.Pf.radioCenter:SetScript("OnClick", TRP3_UFPanel.TRP3_scrollChild.Pf.createOnRadioClicked("CENTER"))
TRP3_UFPanel.TRP3_scrollChild.Pf.radioRight:SetScript("OnClick", TRP3_UFPanel.TRP3_scrollChild.Pf.createOnRadioClicked("RIGHT"))
TRP3_UFPanel.TRP3_scrollChild.Pf.radioBottomLeft:SetScript("OnClick", TRP3_UFPanel.TRP3_scrollChild.Pf.createOnRadioClicked("BOTTOMLEFT"))
TRP3_UFPanel.TRP3_scrollChild.Pf.radioBottom:SetScript("OnClick", TRP3_UFPanel.TRP3_scrollChild.Pf.createOnRadioClicked("BOTTOM"))
TRP3_UFPanel.TRP3_scrollChild.Pf.radioBottomRight:SetScript("OnClick", TRP3_UFPanel.TRP3_scrollChild.Pf.createOnRadioClicked("BOTTOMRIGHT"))

TRP3_UFPanel.TRP3_scrollChild.Tf.radioTopLeft = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild.Tf, "UIRadioButtonTemplate")
TRP3_UFPanel.TRP3_scrollChild.Tf.radioTop = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild.Tf, "UIRadioButtonTemplate")
TRP3_UFPanel.TRP3_scrollChild.Tf.radioTopRight = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild.Tf, "UIRadioButtonTemplate")
TRP3_UFPanel.TRP3_scrollChild.Tf.radioLeft = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild.Tf, "UIRadioButtonTemplate")
TRP3_UFPanel.TRP3_scrollChild.Tf.radioCenter = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild.Tf, "UIRadioButtonTemplate")
TRP3_UFPanel.TRP3_scrollChild.Tf.radioRight = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild.Tf, "UIRadioButtonTemplate")
TRP3_UFPanel.TRP3_scrollChild.Tf.radioBottomLeft = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild.Tf, "UIRadioButtonTemplate")
TRP3_UFPanel.TRP3_scrollChild.Tf.radioBottom = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild.Tf, "UIRadioButtonTemplate")
TRP3_UFPanel.TRP3_scrollChild.Tf.radioBottomRight = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild.Tf, "UIRadioButtonTemplate")

TRP3_UFPanel.TRP3_scrollChild.Tf.radioTopLeft:SetChecked(false)
TRP3_UFPanel.TRP3_scrollChild.Tf.radioTop:SetChecked(false)
TRP3_UFPanel.TRP3_scrollChild.Tf.radioTopRight:SetChecked(false)
TRP3_UFPanel.TRP3_scrollChild.Tf.radioLeft:SetChecked(false)
TRP3_UFPanel.TRP3_scrollChild.Tf.radioCenter:SetChecked(false)
TRP3_UFPanel.TRP3_scrollChild.Tf.radioRight:SetChecked(false)
TRP3_UFPanel.TRP3_scrollChild.Tf.radioBottomLeft:SetChecked(true)
TRP3_UFPanel.TRP3_scrollChild.Tf.radioBottom:SetChecked(false)
TRP3_UFPanel.TRP3_scrollChild.Tf.radioBottomRight:SetChecked(false)

TRP3_UFPanel.TRP3_scrollChild.Tf.radioTopLeft:SetPoint("CENTER", TRP3_UFPanel.TRP3_scrollChild.Tf, "TOPLEFT", 0, 0)
TRP3_UFPanel.TRP3_scrollChild.Tf.radioTop:SetPoint("CENTER", TRP3_UFPanel.TRP3_scrollChild.Tf, "TOP", 0, 0)
TRP3_UFPanel.TRP3_scrollChild.Tf.radioTopRight:SetPoint("CENTER", TRP3_UFPanel.TRP3_scrollChild.Tf, "TOPRIGHT", 0, 0)
TRP3_UFPanel.TRP3_scrollChild.Tf.radioLeft:SetPoint("CENTER", TRP3_UFPanel.TRP3_scrollChild.Tf, "LEFT", 0, 0)
TRP3_UFPanel.TRP3_scrollChild.Tf.radioCenter:SetPoint("CENTER", TRP3_UFPanel.TRP3_scrollChild.Tf, "CENTER", 0, 0)
TRP3_UFPanel.TRP3_scrollChild.Tf.radioRight:SetPoint("CENTER", TRP3_UFPanel.TRP3_scrollChild.Tf, "RIGHT", 0, 0)
TRP3_UFPanel.TRP3_scrollChild.Tf.radioBottomLeft:SetPoint("CENTER", TRP3_UFPanel.TRP3_scrollChild.Tf, "BOTTOMLEFT", 0, 0)
TRP3_UFPanel.TRP3_scrollChild.Tf.radioBottom:SetPoint("CENTER", TRP3_UFPanel.TRP3_scrollChild.Tf, "BOTTOM", 0, 0)
TRP3_UFPanel.TRP3_scrollChild.Tf.radioBottomRight:SetPoint("CENTER", TRP3_UFPanel.TRP3_scrollChild.Tf, "BOTTOMRIGHT", 0, 0)

TRP3_UFPanel.TRP3_scrollChild.Tf.TitleText = TRP3_UFPanel.TRP3_scrollChild.Tf:CreateFontString(nil, "OVERLAY", "GameFontNormal");
TRP3_UFPanel.TRP3_scrollChild.Tf.TitleText:SetFont(TRP3_UFPanel.TRP3_scrollChild.Tf.TitleText:GetFont(), 12);
TRP3_UFPanel.TRP3_scrollChild.Tf.TitleText:SetTextColor(1,1,1,1);
TRP3_UFPanel.TRP3_scrollChild.Tf.TitleText:ClearAllPoints();
TRP3_UFPanel.TRP3_scrollChild.Tf.TitleText:SetPoint("BOTTOM", TRP3_UFPanel.TRP3_scrollChild.Tf, "BOTTOM",0,-25);
TRP3_UFPanel.TRP3_scrollChild.Tf.TitleText:SetText(TARGET);

TRP3_UFPanel.TRP3_scrollChild.Tf.allRadios = {
	TRP3_UFPanel.TRP3_scrollChild.Tf.radioTopLeft,
	TRP3_UFPanel.TRP3_scrollChild.Tf.radioTop,
	TRP3_UFPanel.TRP3_scrollChild.Tf.radioTopRight,
	TRP3_UFPanel.TRP3_scrollChild.Tf.radioLeft,
	TRP3_UFPanel.TRP3_scrollChild.Tf.radioCenter,
	TRP3_UFPanel.TRP3_scrollChild.Tf.radioRight,
	TRP3_UFPanel.TRP3_scrollChild.Tf.radioBottomLeft,
	TRP3_UFPanel.TRP3_scrollChild.Tf.radioBottom,
	TRP3_UFPanel.TRP3_scrollChild.Tf.radioBottomRight
}

function TRP3_UFPanel.TRP3_scrollChild.Tf.createOnRadioClicked(location)
	local function onRadioClicked(self, a, b, c)
		local checked = self:GetChecked()
		PlaySound(PlaySoundKitID and "igMainMenuOptionCheckBoxOn" or SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		TRP3_UF_DB.Target.relativePoint = location

		local anyChecked = false
		for _, radio in ipairs(TRP3_UFPanel.TRP3_scrollChild.Tf.allRadios) do
			if radio ~= self then
				anyChecked = radio:GetChecked() or anyChecked
				radio:SetChecked(false)
			end
		end
		if not anyChecked then
			self:SetChecked(true)
		end
		trpTarget.SetPos()
	end
	return onRadioClicked
end

TRP3_UFPanel.TRP3_scrollChild.Tf.radioTopLeft:SetScript("OnClick", TRP3_UFPanel.TRP3_scrollChild.Tf.createOnRadioClicked("TOPLEFT"))
TRP3_UFPanel.TRP3_scrollChild.Tf.radioTop:SetScript("OnClick", TRP3_UFPanel.TRP3_scrollChild.Tf.createOnRadioClicked("TOP"))
TRP3_UFPanel.TRP3_scrollChild.Tf.radioTopRight:SetScript("OnClick", TRP3_UFPanel.TRP3_scrollChild.Tf.createOnRadioClicked("TOPRIGHT"))
TRP3_UFPanel.TRP3_scrollChild.Tf.radioLeft:SetScript("OnClick", TRP3_UFPanel.TRP3_scrollChild.Tf.createOnRadioClicked("LEFT"))
TRP3_UFPanel.TRP3_scrollChild.Tf.radioCenter:SetScript("OnClick", TRP3_UFPanel.TRP3_scrollChild.Tf.createOnRadioClicked("CENTER"))
TRP3_UFPanel.TRP3_scrollChild.Tf.radioRight:SetScript("OnClick", TRP3_UFPanel.TRP3_scrollChild.Tf.createOnRadioClicked("RIGHT"))
TRP3_UFPanel.TRP3_scrollChild.Tf.radioBottomLeft:SetScript("OnClick", TRP3_UFPanel.TRP3_scrollChild.Tf.createOnRadioClicked("BOTTOMLEFT"))
TRP3_UFPanel.TRP3_scrollChild.Tf.radioBottom:SetScript("OnClick", TRP3_UFPanel.TRP3_scrollChild.Tf.createOnRadioClicked("BOTTOM"))
TRP3_UFPanel.TRP3_scrollChild.Tf.radioBottomRight:SetScript("OnClick", TRP3_UFPanel.TRP3_scrollChild.Tf.createOnRadioClicked("BOTTOMRIGHT"))

------------------------------------------------------------------------------------------------------------------

TRP3_UFPanel.TRP3_scrollChild.PColor = CreateFrame("Frame", nil, TRP3_UFPanel.TRP3_scrollChild.dummyFramePlayer)
TRP3_UFPanel.TRP3_scrollChild.PColor:SetPoint("TOPLEFT", TRP3_UFPanel.TRP3_scrollChild.dummyFramePlayer, "TOPLEFT", 58, -11)
TRP3_UFPanel.TRP3_scrollChild.PColor:SetWidth(135)
TRP3_UFPanel.TRP3_scrollChild.PColor:SetHeight(18)
TRP3_UFPanel.TRP3_scrollChild.PColor.tex = TRP3_UFPanel.TRP3_scrollChild.PColor:CreateTexture("TRP3_UFSettingsRepDummyPlayer", "ARTWORK", nil, 1)
TRP3_UFPanel.TRP3_scrollChild.PColor.tex:SetAllPoints(TRP3_UFPanel.TRP3_scrollChild.PColor)
TRP3_UFPanel.TRP3_scrollChild.PColor.tex:SetAtlas("UI-HUD-UnitFrame-Target-PortraitOn-Type")
TRP3_UFPanel.TRP3_scrollChild.PColor.tex:SetTexCoord(1, 0, 0, 1)

TRP3_UFPanel.TRP3_scrollChild.PColor.Name = TRP3_UFPanel.TRP3_scrollChild.PColor:CreateFontString("TRP3_UFSettingsRepTextDummyPlayer", "OVERLAY", "GameFontNormal");
TRP3_UFPanel.TRP3_scrollChild.PColor.Name:SetFont(TRP3_UFPanel.TRP3_scrollChild.PColor.Name:GetFont(), 12);
TRP3_UFPanel.TRP3_scrollChild.PColor.Name:SetTextColor(1,1,1,1);
TRP3_UFPanel.TRP3_scrollChild.PColor.Name:ClearAllPoints();
TRP3_UFPanel.TRP3_scrollChild.PColor.Name:SetPoint("TOP", TRP3_UFPanel.TRP3_scrollChild.PColor, "TOP",0,0);
TRP3_UFPanel.TRP3_scrollChild.PColor.Name:SetText(PLAYER);


TRP3_UFPanel.TRP3_scrollChild.TColor = CreateFrame("Frame", nil, TRP3_UFPanel.TRP3_scrollChild.dummyFrameTarget)
TRP3_UFPanel.TRP3_scrollChild.TColor:SetPoint("TOPRIGHT", TRP3_UFPanel.TRP3_scrollChild.dummyFrameTarget, "TOPRIGHT", -60, -10)
TRP3_UFPanel.TRP3_scrollChild.TColor:SetWidth(135)
TRP3_UFPanel.TRP3_scrollChild.TColor:SetHeight(18)
TRP3_UFPanel.TRP3_scrollChild.TColor.tex = TRP3_UFPanel.TRP3_scrollChild.TColor:CreateTexture("TRP3_UFSettingsRepDummyTarget", "ARTWORK", nil, 1)
TRP3_UFPanel.TRP3_scrollChild.TColor.tex:SetAllPoints(TRP3_UFPanel.TRP3_scrollChild.TColor)
TRP3_UFPanel.TRP3_scrollChild.TColor.tex:SetAtlas("UI-HUD-UnitFrame-Target-PortraitOn-Type")

TRP3_UFPanel.TRP3_scrollChild.TColor.Name = TRP3_UFPanel.TRP3_scrollChild.TColor:CreateFontString("TRP3_UFSettingsRepTextDummyTarget", "OVERLAY", "GameFontNormal");
TRP3_UFPanel.TRP3_scrollChild.TColor.Name:SetFont(TRP3_UFPanel.TRP3_scrollChild.TColor.Name:GetFont(), 12);
TRP3_UFPanel.TRP3_scrollChild.TColor.Name:SetTextColor(1,1,1,1);
TRP3_UFPanel.TRP3_scrollChild.TColor.Name:ClearAllPoints();
TRP3_UFPanel.TRP3_scrollChild.TColor.Name:SetPoint("TOP", TRP3_UFPanel.TRP3_scrollChild.TColor, "TOP",0,0);
TRP3_UFPanel.TRP3_scrollChild.TColor.Name:SetText(TARGET);


------------------------------------------------------------------------------------------------------------------

TRP3_UFPanel.TRP3_scrollChild.VisibilityText = TRP3_UFPanel.TRP3_scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal");
TRP3_UFPanel.TRP3_scrollChild.VisibilityText:SetFont(TRP3_UFPanel.TRP3_scrollChild.VisibilityText:GetFont(), 15);
TRP3_UFPanel.TRP3_scrollChild.VisibilityText:SetTextColor(1,1,1,1);
TRP3_UFPanel.TRP3_scrollChild.VisibilityText:ClearAllPoints();
TRP3_UFPanel.TRP3_scrollChild.VisibilityText:SetPoint("TOPLEFT", 5, -53*3.7);
TRP3_UFPanel.TRP3_scrollChild.VisibilityText:SetText(L["Visibility"]);


TRP3_UFPanel.TRP3_scrollChild.PShowCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild, "UICheckButtonTemplate"); -- SettingsCheckBoxTemplate
TRP3_UFPanel.TRP3_scrollChild.PShowCheckbox:ClearAllPoints();
TRP3_UFPanel.TRP3_scrollChild.PShowCheckbox:SetPoint("TOPLEFT", 5, -53*4);
TRP3_UFPanel.TRP3_scrollChild.PShowCheckbox.Text:SetText(L["ShowButtonPlayer"]);

TRP3_UFPanel.TRP3_scrollChild.PShowCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.TRP3_scrollChild.PShowCheckbox:GetChecked() then
		TRP3_UF_DB.Player.show = true;
		trpPlayer.SetVisible();
	else
		TRP3_UF_DB.Player.show = false;
		trpPlayer.SetVisible();
	end
	TRP3_UFPanel.CheckSettings();
end);


TRP3_UFPanel.TRP3_scrollChild.TShowCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild, "UICheckButtonTemplate");
TRP3_UFPanel.TRP3_scrollChild.TShowCheckbox:ClearAllPoints();
TRP3_UFPanel.TRP3_scrollChild.TShowCheckbox:SetPoint("TOPLEFT", 5, -53*4.5);
TRP3_UFPanel.TRP3_scrollChild.TShowCheckbox.Text:SetText(L["ShowButtonTarget"]);

TRP3_UFPanel.TRP3_scrollChild.TShowCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.TRP3_scrollChild.TShowCheckbox:GetChecked() then
		TRP3_UF_DB.Target.show = true;
		trpPlayer.SetVisible();
	else
		TRP3_UF_DB.Target.show = false;
		trpPlayer.SetVisible();
	end
	TRP3_UFPanel.CheckSettings();
end);


TRP3_UFPanel.TRP3_scrollChild.PortShowCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild, "UICheckButtonTemplate");
TRP3_UFPanel.TRP3_scrollChild.PortShowCheckbox:ClearAllPoints();
TRP3_UFPanel.TRP3_scrollChild.PortShowCheckbox:SetPoint("TOPLEFT", 5, -53*5);
TRP3_UFPanel.TRP3_scrollChild.PortShowCheckbox.Text:SetText(L["ShowBorderFrame"]);

TRP3_UFPanel.TRP3_scrollChild.PortShowCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.TRP3_scrollChild.PortShowCheckbox:GetChecked() then
		TRP3_UF_DB.Border.show = true;
		TRP3_UFPanel.TRP3_scrollChild.PortraitButton:SetEnabled(TRP3_UF_DB.Border.show);
		PlayerDragonFrame:Show();
	else
		TRP3_UF_DB.Border.show = false;
		TRP3_UFPanel.TRP3_scrollChild.PortraitButton:SetEnabled(TRP3_UF_DB.Border.show);
		PlayerDragonFrame:Hide();
	end
	TRP3_UFPanel.CheckSettings();
end);


TRP3_UFPanel.TRP3_scrollChild.StatusHideCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild, "UICheckButtonTemplate");
TRP3_UFPanel.TRP3_scrollChild.StatusHideCheckbox:ClearAllPoints();
TRP3_UFPanel.TRP3_scrollChild.StatusHideCheckbox:SetPoint("TOPLEFT", 5, -53*6.0);
TRP3_UFPanel.TRP3_scrollChild.StatusHideCheckbox.Text:SetText(L["HideRestedGlow"]);

TRP3_UFPanel.TRP3_scrollChild.StatusHideCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.TRP3_scrollChild.StatusHideCheckbox:GetChecked() then
		TRP3_UF_DB.Border.status = true;
		PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture:Hide();
	else
		TRP3_UF_DB.Border.status = false;
		PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture:Show();
	end
	TRP3_UFPanel.CheckSettings();
end);

------------------------------------------------------------------------------------------------------------------

TRP3_UFPanel.TRP3_scrollChild.TargetSizeSlider = CreateFrame("Slider", nil, TRP3_UFPanel.TRP3_scrollChild, "OptionsSliderTemplate");
TRP3_UFPanel.TRP3_scrollChild.TargetSizeSlider:SetWidth(250);
TRP3_UFPanel.TRP3_scrollChild.TargetSizeSlider:SetHeight(15);
TRP3_UFPanel.TRP3_scrollChild.TargetSizeSlider:SetMinMaxValues(0.5,15);
TRP3_UFPanel.TRP3_scrollChild.TargetSizeSlider:SetValueStep(.5);
TRP3_UFPanel.TRP3_scrollChild.TargetSizeSlider:SetObeyStepOnDrag(true)
TRP3_UFPanel.TRP3_scrollChild.TargetSizeSlider:ClearAllPoints();
TRP3_UFPanel.TRP3_scrollChild.TargetSizeSlider:SetPoint("TOPLEFT", TRP3_UFPanel.TRP3_scrollChild, "TOPLEFT", 10, -53*6.75);
TRP3_UFPanel.TRP3_scrollChild.TargetSizeSlider.Low:SetText("0.5");
TRP3_UFPanel.TRP3_scrollChild.TargetSizeSlider.High:SetText("15");
TRP3_UFPanel.TRP3_scrollChild.TargetSizeSlider.Text:SetText(L["ButtonSizeTarget"]);
TRP3_UFPanel.TRP3_scrollChild.TargetSizeSlider:SetScript("OnValueChanged", function()
	local scaleValue = TRP3_UFPanel.TRP3_scrollChild.TargetSizeSlider:GetValue();
	TRP3_UF_DB.Target.scale = scaleValue;
	trpTarget.button:SetScale(TRP3_UF_DB.Target.scale);
	TRP3_UFPanel.CheckSettings();
end)


TRP3_UFPanel.TRP3_scrollChild.TargetPosSlider = CreateFrame("Slider", nil, TRP3_UFPanel.TRP3_scrollChild, "OptionsSliderTemplate");
TRP3_UFPanel.TRP3_scrollChild.TargetPosSlider:SetWidth(250);
TRP3_UFPanel.TRP3_scrollChild.TargetPosSlider:SetHeight(15);
TRP3_UFPanel.TRP3_scrollChild.TargetPosSlider:SetMinMaxValues(-15,15);
TRP3_UFPanel.TRP3_scrollChild.TargetPosSlider:SetValueStep(.5);
TRP3_UFPanel.TRP3_scrollChild.TargetPosSlider:SetObeyStepOnDrag(true)
TRP3_UFPanel.TRP3_scrollChild.TargetPosSlider:ClearAllPoints();
TRP3_UFPanel.TRP3_scrollChild.TargetPosSlider:SetPoint("TOPLEFT", TRP3_UFPanel.TRP3_scrollChild, "TOPLEFT", 10, -53*7.5);
TRP3_UFPanel.TRP3_scrollChild.TargetPosSlider.Low:SetText("-15");
TRP3_UFPanel.TRP3_scrollChild.TargetPosSlider.High:SetText("15");
TRP3_UFPanel.TRP3_scrollChild.TargetPosSlider.Text:SetText(L["ButtonPosTarget"]);
TRP3_UFPanel.TRP3_scrollChild.TargetPosSlider:SetScript("OnValueChanged", function()
	local scaleValue = TRP3_UFPanel.TRP3_scrollChild.TargetPosSlider:GetValue();
	TRP3_UF_DB.Target.position = scaleValue;
	trpTarget.SetPos();
	TRP3_UFPanel.CheckSettings();
end)


TRP3_UFPanel.TRP3_scrollChild.PlayerSizeSlider = CreateFrame("Slider", nil, TRP3_UFPanel.TRP3_scrollChild, "OptionsSliderTemplate");
TRP3_UFPanel.TRP3_scrollChild.PlayerSizeSlider:SetWidth(250);
TRP3_UFPanel.TRP3_scrollChild.PlayerSizeSlider:SetHeight(15);
TRP3_UFPanel.TRP3_scrollChild.PlayerSizeSlider:SetMinMaxValues(0.5,15);
TRP3_UFPanel.TRP3_scrollChild.PlayerSizeSlider:SetValueStep(.5);
TRP3_UFPanel.TRP3_scrollChild.PlayerSizeSlider:SetObeyStepOnDrag(true)
TRP3_UFPanel.TRP3_scrollChild.PlayerSizeSlider:ClearAllPoints();
TRP3_UFPanel.TRP3_scrollChild.PlayerSizeSlider:SetPoint("TOPLEFT", TRP3_UFPanel.TRP3_scrollChild, "TOPLEFT", 10, -53*8.25);
TRP3_UFPanel.TRP3_scrollChild.PlayerSizeSlider.Low:SetText("0.5");
TRP3_UFPanel.TRP3_scrollChild.PlayerSizeSlider.High:SetText("15");
TRP3_UFPanel.TRP3_scrollChild.PlayerSizeSlider.Text:SetText(L["ButtonSizePlayer"]);
TRP3_UFPanel.TRP3_scrollChild.PlayerSizeSlider:SetScript("OnValueChanged", function()
	local scaleValue = TRP3_UFPanel.TRP3_scrollChild.PlayerSizeSlider:GetValue();
	TRP3_UF_DB.Player.scale = scaleValue;
	trpPlayer.button:SetScale(TRP3_UF_DB.Player.scale);
	TRP3_UFPanel.CheckSettings();
end)


TRP3_UFPanel.TRP3_scrollChild.PlayerPosSlider = CreateFrame("Slider", nil, TRP3_UFPanel.TRP3_scrollChild, "OptionsSliderTemplate");
TRP3_UFPanel.TRP3_scrollChild.PlayerPosSlider:SetWidth(250);
TRP3_UFPanel.TRP3_scrollChild.PlayerPosSlider:SetHeight(15);
TRP3_UFPanel.TRP3_scrollChild.PlayerPosSlider:SetMinMaxValues(-15,15);
TRP3_UFPanel.TRP3_scrollChild.PlayerPosSlider:SetValueStep(.5);
TRP3_UFPanel.TRP3_scrollChild.PlayerPosSlider:SetObeyStepOnDrag(true)
TRP3_UFPanel.TRP3_scrollChild.PlayerPosSlider:ClearAllPoints();
TRP3_UFPanel.TRP3_scrollChild.PlayerPosSlider:SetPoint("TOPLEFT", TRP3_UFPanel.TRP3_scrollChild, "TOPLEFT", 10, -53*9);
TRP3_UFPanel.TRP3_scrollChild.PlayerPosSlider.Low:SetText("-15");
TRP3_UFPanel.TRP3_scrollChild.PlayerPosSlider.High:SetText("15");
TRP3_UFPanel.TRP3_scrollChild.PlayerPosSlider.Text:SetText(L["ButtonPosPlayer"]);
TRP3_UFPanel.TRP3_scrollChild.PlayerPosSlider:SetScript("OnValueChanged", function()
	local scaleValue = TRP3_UFPanel.TRP3_scrollChild.PlayerPosSlider:GetValue();
	TRP3_UF_DB.Player.position = scaleValue;
	trpPlayer.SetPos();
	TRP3_UFPanel.CheckSettings();
end)

------------------------------------------------------------------------------------------------------------------

TRP3_UFPanel.TRP3_scrollChild.ColorsText = TRP3_UFPanel.TRP3_scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal");
TRP3_UFPanel.TRP3_scrollChild.ColorsText:SetFont(TRP3_UFPanel.TRP3_scrollChild.ColorsText:GetFont(), 15);
TRP3_UFPanel.TRP3_scrollChild.ColorsText:SetTextColor(1,1,1,1);
TRP3_UFPanel.TRP3_scrollChild.ColorsText:ClearAllPoints();
TRP3_UFPanel.TRP3_scrollChild.ColorsText:SetPoint("TOPLEFT", 300, -53*3.7);
TRP3_UFPanel.TRP3_scrollChild.ColorsText:SetText(COLORS);

TRP3_UFPanel.TRP3_scrollChild.ColorsTarText = TRP3_UFPanel.TRP3_scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal");
TRP3_UFPanel.TRP3_scrollChild.ColorsTarText:SetFont(TRP3_UFPanel.TRP3_scrollChild.ColorsTarText:GetFont(), 12);
TRP3_UFPanel.TRP3_scrollChild.ColorsTarText:SetTextColor(1,1,1,1);
TRP3_UFPanel.TRP3_scrollChild.ColorsTarText:ClearAllPoints();
TRP3_UFPanel.TRP3_scrollChild.ColorsTarText:SetPoint("TOPLEFT", 300, -53*4.2);
TRP3_UFPanel.TRP3_scrollChild.ColorsTarText:SetText(HUD_EDIT_MODE_TARGET_FRAME_LABEL);

TRP3_UFPanel.TRP3_scrollChild.ColorsPlayerText = TRP3_UFPanel.TRP3_scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal");
TRP3_UFPanel.TRP3_scrollChild.ColorsPlayerText:SetFont(TRP3_UFPanel.TRP3_scrollChild.ColorsPlayerText:GetFont(), 12);
TRP3_UFPanel.TRP3_scrollChild.ColorsPlayerText:SetTextColor(1,1,1,1);
TRP3_UFPanel.TRP3_scrollChild.ColorsPlayerText:ClearAllPoints();
TRP3_UFPanel.TRP3_scrollChild.ColorsPlayerText:SetPoint("TOPLEFT", 300, -53*7.7);
TRP3_UFPanel.TRP3_scrollChild.ColorsPlayerText:SetText(HUD_EDIT_MODE_PLAYER_FRAME_LABEL);

TRP3_UFPanel.TRP3_scrollChild.NPCOptions = TRP3_UFPanel.TRP3_scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal");
TRP3_UFPanel.TRP3_scrollChild.NPCOptions:SetFont(TRP3_UFPanel.TRP3_scrollChild.NPCOptions:GetFont(), 12);
TRP3_UFPanel.TRP3_scrollChild.NPCOptions:SetTextColor(1,1,1,1);
TRP3_UFPanel.TRP3_scrollChild.NPCOptions:ClearAllPoints();
TRP3_UFPanel.TRP3_scrollChild.NPCOptions:SetPoint("TOPLEFT", 300, -53*11.2);
TRP3_UFPanel.TRP3_scrollChild.NPCOptions:SetText(UNIT_NAME_NPC);


TRP3_UFPanel.TRP3_scrollChild.TargetTextColorCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild, "UICheckButtonTemplate");
TRP3_UFPanel.TRP3_scrollChild.TargetTextColorCheckbox:ClearAllPoints();
TRP3_UFPanel.TRP3_scrollChild.TargetTextColorCheckbox:SetPoint("TOPLEFT", 300, -53*4.5);
TRP3_UFPanel.TRP3_scrollChild.TargetTextColorCheckbox.Text:SetText(L["OverwriteTextCol"])

TRP3_UFPanel.TRP3_scrollChild.TargetTextColorCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.TRP3_scrollChild.TargetTextColorCheckbox:GetChecked() then
		TRP3_UF_DB.Target.colorText.custom = true;
	else
		TRP3_UF_DB.Target.colorText.custom = false;
	end
	TRP3_UFPanel.TRP3_scrollChild.TarCustomTextColButton:SetEnabled(TRP3_UF_DB.Target.colorText.custom);
	trpPlayer.UpdateInfo();
	trpTarget.UpdateInfo();
	TRP3_UFPanel.CheckSettings();
end);


TRP3_UFPanel.TRP3_scrollChild.TargetBackColorCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild, "UICheckButtonTemplate");
TRP3_UFPanel.TRP3_scrollChild.TargetBackColorCheckbox:ClearAllPoints();
TRP3_UFPanel.TRP3_scrollChild.TargetBackColorCheckbox:SetPoint("TOPLEFT", 300, -53*5.5);
TRP3_UFPanel.TRP3_scrollChild.TargetBackColorCheckbox.Text:SetText(L["OverwriteBackCol"])

TRP3_UFPanel.TRP3_scrollChild.TargetBackColorCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.TRP3_scrollChild.TargetBackColorCheckbox:GetChecked() then
		TRP3_UF_DB.Target.colorBack.custom = true;
	else
		TRP3_UF_DB.Target.colorBack.custom = false;
	end
	TRP3_UFPanel.TRP3_scrollChild.TarCustomBackColButton:SetEnabled(TRP3_UF_DB.Target.colorBack.custom);
	trpPlayer.UpdateInfo();
	trpTarget.UpdateInfo();
	TRP3_UFPanel.CheckSettings();
end);


TRP3_UFPanel.TRP3_scrollChild.TargetClassTextColorCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild, "UICheckButtonTemplate");
TRP3_UFPanel.TRP3_scrollChild.TargetClassTextColorCheckbox:ClearAllPoints();
TRP3_UFPanel.TRP3_scrollChild.TargetClassTextColorCheckbox:SetPoint("TOPLEFT", 300, -53*6.5);
TRP3_UFPanel.TRP3_scrollChild.TargetClassTextColorCheckbox.Text:SetText(L["BlizzTextCol"])

TRP3_UFPanel.TRP3_scrollChild.TargetClassTextColorCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.TRP3_scrollChild.TargetClassTextColorCheckbox:GetChecked() then
		TRP3_UF_DB.Target.colorText.class = true;
	else
		TRP3_UF_DB.Target.colorText.class = false;
	end
	trpPlayer.UpdateInfo();
	trpTarget.UpdateInfo();
	TRP3_UFPanel.CheckSettings();
end);


TRP3_UFPanel.TRP3_scrollChild.TargetClassBackColorCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild, "UICheckButtonTemplate");
TRP3_UFPanel.TRP3_scrollChild.TargetClassBackColorCheckbox:ClearAllPoints();
TRP3_UFPanel.TRP3_scrollChild.TargetClassBackColorCheckbox:SetPoint("TOPLEFT", 300, -53*7);
TRP3_UFPanel.TRP3_scrollChild.TargetClassBackColorCheckbox.Text:SetText(L["BlizzBackCol"])

TRP3_UFPanel.TRP3_scrollChild.TargetClassBackColorCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.TRP3_scrollChild.TargetClassBackColorCheckbox:GetChecked() then
		TRP3_UF_DB.Target.colorBack.class = true;
	else
		TRP3_UF_DB.Target.colorBack.class = false;
	end
	trpPlayer.UpdateInfo();
	trpTarget.UpdateInfo();
	TRP3_UFPanel.CheckSettings();
end);


--player
TRP3_UFPanel.TRP3_scrollChild.PlayerTextColorCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild, "UICheckButtonTemplate");
TRP3_UFPanel.TRP3_scrollChild.PlayerTextColorCheckbox:ClearAllPoints();
TRP3_UFPanel.TRP3_scrollChild.PlayerTextColorCheckbox:SetPoint("TOPLEFT", 300, -53*8);
TRP3_UFPanel.TRP3_scrollChild.PlayerTextColorCheckbox.Text:SetText(L["OverwriteTextCol"])

TRP3_UFPanel.TRP3_scrollChild.PlayerTextColorCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.TRP3_scrollChild.PlayerTextColorCheckbox:GetChecked() then
		TRP3_UF_DB.Player.colorText.custom = true;
	else
		TRP3_UF_DB.Player.colorText.custom = false;
	end
	TRP3_UFPanel.TRP3_scrollChild.PlayerCustomTextColButton:SetEnabled(TRP3_UF_DB.Player.colorText.custom);
	trpPlayer.UpdateInfo();
	trpTarget.UpdateInfo();
	TRP3_UFPanel.CheckSettings();
end);


TRP3_UFPanel.TRP3_scrollChild.PlayerBackColorCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild, "UICheckButtonTemplate");
TRP3_UFPanel.TRP3_scrollChild.PlayerBackColorCheckbox:ClearAllPoints();
TRP3_UFPanel.TRP3_scrollChild.PlayerBackColorCheckbox:SetPoint("TOPLEFT", 300, -53*9);
TRP3_UFPanel.TRP3_scrollChild.PlayerBackColorCheckbox.Text:SetText(L["OverwriteBackCol"])

TRP3_UFPanel.TRP3_scrollChild.PlayerBackColorCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.TRP3_scrollChild.PlayerBackColorCheckbox:GetChecked() then
		TRP3_UF_DB.Player.colorBack.custom = true;
	else
		TRP3_UF_DB.Player.colorBack.custom = false;
	end
	TRP3_UFPanel.TRP3_scrollChild.PlayerCustomBackColButton:SetEnabled(TRP3_UF_DB.Player.colorBack.custom);
	trpPlayer.UpdateInfo();
	trpTarget.UpdateInfo();
	TRP3_UFPanel.CheckSettings();
end);


TRP3_UFPanel.TRP3_scrollChild.PlayerClassTextColorCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild, "UICheckButtonTemplate");
TRP3_UFPanel.TRP3_scrollChild.PlayerClassTextColorCheckbox:ClearAllPoints();
TRP3_UFPanel.TRP3_scrollChild.PlayerClassTextColorCheckbox:SetPoint("TOPLEFT", 300, -53*10);
TRP3_UFPanel.TRP3_scrollChild.PlayerClassTextColorCheckbox.Text:SetText(L["BlizzTextCol"])

TRP3_UFPanel.TRP3_scrollChild.PlayerClassTextColorCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.TRP3_scrollChild.PlayerClassTextColorCheckbox:GetChecked() then
		TRP3_UF_DB.Player.colorText.class = true;
	else
		TRP3_UF_DB.Player.colorText.class = false;
	end
	trpPlayer.UpdateInfo();
	trpTarget.UpdateInfo();
	TRP3_UFPanel.CheckSettings();
end);


TRP3_UFPanel.TRP3_scrollChild.PlayerClassBackColorCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild, "UICheckButtonTemplate");
TRP3_UFPanel.TRP3_scrollChild.PlayerClassBackColorCheckbox:ClearAllPoints();
TRP3_UFPanel.TRP3_scrollChild.PlayerClassBackColorCheckbox:SetPoint("TOPLEFT", 300, -53*10.5);
TRP3_UFPanel.TRP3_scrollChild.PlayerClassBackColorCheckbox.Text:SetText(L["BlizzBackCol"])

TRP3_UFPanel.TRP3_scrollChild.PlayerClassBackColorCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.TRP3_scrollChild.PlayerClassBackColorCheckbox:GetChecked() then
		TRP3_UF_DB.Player.colorBack.class = true;
	else
		TRP3_UF_DB.Player.colorBack.class = false;
	end
	trpPlayer.UpdateInfo();
	trpTarget.UpdateInfo();
	TRP3_UFPanel.CheckSettings();
end);


--other
TRP3_UFPanel.TRP3_scrollChild.NPCOptionsCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild, "UICheckButtonTemplate");
TRP3_UFPanel.TRP3_scrollChild.NPCOptionsCheckbox:ClearAllPoints();
TRP3_UFPanel.TRP3_scrollChild.NPCOptionsCheckbox:SetPoint("TOPLEFT", 300, -53*11.5);
TRP3_UFPanel.TRP3_scrollChild.NPCOptionsCheckbox.Text:SetText(L["ApplyToNPCs"])

TRP3_UFPanel.TRP3_scrollChild.NPCOptionsCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.TRP3_scrollChild.NPCOptionsCheckbox:GetChecked() then
		TRP3_UF_DB.Setting.NPCs = true;
	else
		TRP3_UF_DB.Setting.NPCs = false;
	end
	trpTarget.UpdateInfo();
	TRP3_UFPanel.CheckSettings();
end);

--toggle full names

TRP3_UFPanel.TRP3_scrollChild.UseTRP3NameCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild, "UICheckButtonTemplate");
TRP3_UFPanel.TRP3_scrollChild.UseTRP3NameCheckbox:ClearAllPoints();
TRP3_UFPanel.TRP3_scrollChild.UseTRP3NameCheckbox:SetPoint("TOPLEFT", 300, -53*12);
TRP3_UFPanel.TRP3_scrollChild.UseTRP3NameCheckbox.Text:SetText(L["TRP3CustomName"])

TRP3_UFPanel.TRP3_scrollChild.UseTRP3NameCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.TRP3_scrollChild.UseTRP3NameCheckbox:GetChecked() then
		TRP3_UF_DB.Setting.UseTRPName = true;
	else
		TRP3_UF_DB.Setting.UseTRPName = false;
	end
	TRP3_UFPanel.TRP3_scrollChild.FullNamePCheckbox:SetEnabled(TRP3_UF_DB.Setting.UseTRPName);
	TRP3_UFPanel.TRP3_scrollChild.FullNameTCheckbox:SetEnabled(TRP3_UF_DB.Setting.UseTRPName);
	trpPlayer.UpdateInfo();
	trpTarget.UpdateInfo();
	TRP3_UFPanel.CheckSettings();
end);

TRP3_UFPanel.TRP3_scrollChild.FullNamePCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild, "UICheckButtonTemplate");
TRP3_UFPanel.TRP3_scrollChild.FullNamePCheckbox:ClearAllPoints();
TRP3_UFPanel.TRP3_scrollChild.FullNamePCheckbox:SetPoint("TOPLEFT", 300, -53*12.5);
TRP3_UFPanel.TRP3_scrollChild.FullNamePCheckbox.Text:SetText(L["FullNamePlayer"])

TRP3_UFPanel.TRP3_scrollChild.FullNamePCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.TRP3_scrollChild.FullNamePCheckbox:GetChecked() then
		TRP3_UF_DB.Setting.FullNamePlayer = true;
	else
		TRP3_UF_DB.Setting.FullNamePlayer = false;
	end
	trpPlayer.UpdateInfo();
	trpTarget.UpdateInfo();
	TRP3_UFPanel.CheckSettings();
end);

TRP3_UFPanel.TRP3_scrollChild.FullNameTCheckbox = CreateFrame("CheckButton", nil, TRP3_UFPanel.TRP3_scrollChild, "UICheckButtonTemplate");
TRP3_UFPanel.TRP3_scrollChild.FullNameTCheckbox:ClearAllPoints();
TRP3_UFPanel.TRP3_scrollChild.FullNameTCheckbox:SetPoint("TOPLEFT", 300, -53*13);
TRP3_UFPanel.TRP3_scrollChild.FullNameTCheckbox.Text:SetText(L["FullNameTarget"])

TRP3_UFPanel.TRP3_scrollChild.FullNameTCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.TRP3_scrollChild.FullNameTCheckbox:GetChecked() then
		TRP3_UF_DB.Setting.FullNameTarget = true;
	else
		TRP3_UF_DB.Setting.FullNameTarget = false;
	end
	trpPlayer.UpdateInfo();
	trpTarget.UpdateInfo();
	TRP3_UFPanel.CheckSettings();
end);



------------------------------------------------------------------------------------------------------------------


--setting up our "atlas member" list
function PlayerDragonFrame.TextureStuff()
	if TRP3_UF_DB.Border.show ~= true then
		PlayerDragonFrame:Hide()
		return
	end
	if TRP3_UF_DB.Border.style == "rare" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\uiunitframeboss2x")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", 8, -10)
		PlayerDragonFrame:SetSize(80, 79);
		PlayerDragonFrame.tex:SetTexCoord(0.314453125, 0.001953125, 0.322265625, 0.630859375) -- rare
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "rare-elite" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\uiunitframeboss2x")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(0.77734375, 0.390625, 0.001953125, 0.318359375) -- rare-elite
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "elite" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\uiunitframeboss2x")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", 8, -10)
		PlayerDragonFrame:SetSize(80, 79);
		PlayerDragonFrame.tex:SetTexCoord(0.3125, 0.001953125, 0.634765625, 0.947265625) -- elite
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "boss" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\uiunitframeboss2x")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(0.388671875, 0.001953125, 0.001953125, 0.318359375) -- boss
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end

	--LGBTQ+
	if TRP3_UF_DB.Border.style == "agender" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_agender")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(.051, .437, .215, .845) -- lgbtq+ player
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "asexual" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_asexual")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(.051, .437, .215, .845) -- lgbtq+ player
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "aroace" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_aroace")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(.051, .437, .215, .845) -- lgbtq+ player
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "bisexual" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_BiS")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(.051, .437, .215, .845) -- lgbtq+ player
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "enby" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_enby")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(.051, .437, .215, .845) -- lgbtq+ player
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "gaym" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_gayM")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(.051, .437, .215, .845) -- lgbtq+ player
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "genderfluid" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_genderfluid")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(.051, .437, .215, .845) -- lgbtq+ player
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "genderqueer" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_genderqueer")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(.051, .437, .215, .845) -- lgbtq+ player
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "lesbian" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_lesbian")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(.051, .437, .215, .845) -- lgbtq+ player
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "transgender" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_trans")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(.051, .437, .215, .845) -- lgbtq+ player
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "pansexual" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_pansexual")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(.051, .437, .215, .845) -- lgbtq+ player
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "rainbow" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_rainbow")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(.051, .437, .215, .845) -- lgbtq+ player
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "rainbowphilly" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_philly")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(.051, .437, .215, .845) -- lgbtq+ player
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "rainbowgilbaker" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_gilbertbaker")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(.051, .437, .215, .845) -- lgbtq+ player
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "rainbowprogress" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\unitframe_progress")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(.051, .437, .215, .845) -- lgbtq+ player
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end


	--Narcissus
	if TRP3_UF_DB.Border.style == "NarciHexagonBorder" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder.tga")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -8)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(-.26, .93, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonBorder-Artifact" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Artifact.tga")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -8)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(-.26, .93, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonBorder-Azerite" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Azerite.tga")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -8)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(-.26, .93, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonBorder-Black" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Black.tga")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -8)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(-.26, .93, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonBorder-BlackDragon" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-BlackDragon.tga")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -8)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(-.26, .93, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonBorder-Epic" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Epic.tga")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -8)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(-.26, .93, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonBorder-Heart" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Heart.tga")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -8)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(-.26, .93, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonBorder-Heirloom" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Heirloom.tga")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -8)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(-.26, .93, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonBorder-Legendary" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Legendary.tga")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -8)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(-.26, .93, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonBorder-NZoth" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-NZoth.tga")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -8)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(-.26, .93, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonBorder-Rare" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Rare.tga")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -8)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(-.26, .93, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonBorder-Special" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Special.tga")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -8)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(-.26, .93, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonBorder-Uncommon" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Uncommon.tga")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -8)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(-.26, .93, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonBorder-Void" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\Border\\HexagonBorder-Void.tga")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -8)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(-.26, .93, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:RemoveMaskTexture(PlayerDragonFrame.mask)
	end


	if TRP3_UF_DB.Border.style == "NarciHexagonDarkBorder-Artifact" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\JPG\\Artifact.jpg")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -27, 30)
		PlayerDragonFrame:SetSize(160, 160);
		PlayerDragonFrame.tex:SetTexCoord(0, 1, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:AddMaskTexture(PlayerDragonFrame.mask)
		PlayerDragonFrame.mask:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\Mask\\RegularHeavy.tga")
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonDarkBorder-Azerite" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\JPG\\Azerite.jpg")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -27, 30)
		PlayerDragonFrame:SetSize(160, 160);
		PlayerDragonFrame.tex:SetTexCoord(0, 1, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:AddMaskTexture(PlayerDragonFrame.mask)
		PlayerDragonFrame.mask:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\Mask\\RegularHeavy.tga")
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonDarkBorder-Black" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\JPG\\Black.jpg")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -27, 30)
		PlayerDragonFrame:SetSize(160, 160);
		PlayerDragonFrame.tex:SetTexCoord(0, 1, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:AddMaskTexture(PlayerDragonFrame.mask)
		PlayerDragonFrame.mask:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\Mask\\RegularHeavy.tga")
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonDarkBorder-BlackDragon" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\JPG\\BlackDragon.jpg")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -27, 30)
		PlayerDragonFrame:SetSize(160, 160);
		PlayerDragonFrame.tex:SetTexCoord(0, 1, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:AddMaskTexture(PlayerDragonFrame.mask)
		PlayerDragonFrame.mask:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\Mask\\RegularHeavy.tga")
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonDarkBorder-Dragonflight" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\JPG\\Dragonflight.jpg")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -27, 30)
		PlayerDragonFrame:SetSize(160, 160);
		PlayerDragonFrame.tex:SetTexCoord(0, 1, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:AddMaskTexture(PlayerDragonFrame.mask)
		PlayerDragonFrame.mask:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\Mask\\Dragonflight.tga")
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonDarkBorder-Epic" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\JPG\\Epic.jpg")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -27, 30)
		PlayerDragonFrame:SetSize(160, 160);
		PlayerDragonFrame.tex:SetTexCoord(0, 1, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:AddMaskTexture(PlayerDragonFrame.mask)
		PlayerDragonFrame.mask:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\Mask\\RegularHeavy.tga")
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonDarkBorder-Heart" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\JPG\\Heart.jpg")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -27, 30)
		PlayerDragonFrame:SetSize(160, 160);
		PlayerDragonFrame.tex:SetTexCoord(0, 1, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:AddMaskTexture(PlayerDragonFrame.mask)
		PlayerDragonFrame.mask:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\Mask\\Heart.tga")
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonDarkBorder-Heirloom" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\JPG\\Heirloom.jpg")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -27, 30)
		PlayerDragonFrame:SetSize(160, 160);
		PlayerDragonFrame.tex:SetTexCoord(0, 1, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:AddMaskTexture(PlayerDragonFrame.mask)
		PlayerDragonFrame.mask:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\Mask\\RegularHeavy.tga")
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonDarkBorder-Legendary" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\JPG\\Legendary.jpg")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -27, 30)
		PlayerDragonFrame:SetSize(160, 160);
		PlayerDragonFrame.tex:SetTexCoord(0, 1, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:AddMaskTexture(PlayerDragonFrame.mask)
		PlayerDragonFrame.mask:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\Mask\\RegularHeavy.tga")
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonDarkBorder-Progenitor" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\JPG\\Progenitor.jpg")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -27, 30)
		PlayerDragonFrame:SetSize(160, 160);
		PlayerDragonFrame.tex:SetTexCoord(0, 1, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:AddMaskTexture(PlayerDragonFrame.mask)
		PlayerDragonFrame.mask:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\Mask\\Progenitor.tga")
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonDarkBorder-Rare" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\JPG\\Rare.jpg")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -27, 30)
		PlayerDragonFrame:SetSize(160, 160);
		PlayerDragonFrame.tex:SetTexCoord(0, 1, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:AddMaskTexture(PlayerDragonFrame.mask)
		PlayerDragonFrame.mask:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\Mask\\RegularHeavy.tga")
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonDarkBorder-Runeforge" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\JPG\\Runeforge.jpg")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -27, 30)
		PlayerDragonFrame:SetSize(160, 160);
		PlayerDragonFrame.tex:SetTexCoord(0, 1, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:AddMaskTexture(PlayerDragonFrame.mask)
		PlayerDragonFrame.mask:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\Mask\\Runeforge.tga")
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonDarkBorder-Shield" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\JPG\\Shield.jpg")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -27, 30)
		PlayerDragonFrame:SetSize(160, 160);
		PlayerDragonFrame.tex:SetTexCoord(0, 1, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:AddMaskTexture(PlayerDragonFrame.mask)
		PlayerDragonFrame.mask:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\Mask\\RegularHeavy.tga")
	end
	if TRP3_UF_DB.Border.style == "NarciHexagonDarkBorder-Uncommon" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\JPG\\Uncommon.jpg")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -27, 30)
		PlayerDragonFrame:SetSize(160, 160);
		PlayerDragonFrame.tex:SetTexCoord(0, 1, 0, 1) -- Narcissus Pack
		PlayerDragonFrame.tex:AddMaskTexture(PlayerDragonFrame.mask)
		PlayerDragonFrame.mask:SetTexture("Interface\\AddOns\\Narcissus\\Art\\ItemBorder-Dark\\Mask\\RegularHeavy.tga")
	end

end


------------------------------------------------------------------------------------------------------------------



TRP3_UFPanel.TRP3_scrollChild.menuFrame = CreateFrame("Frame", "TRP3PlayerPortraitMenuFrame", TRP3_UFPanel.TRP3_scrollChild, "UIDropDownMenuTemplate")

TRP3_UFPanel.TRP3_scrollChild.PortraitButton = CreateFrame("Button", nil, TRP3_UFPanel.TRP3_scrollChild, "SharedGoldRedButtonSmallTemplate")
TRP3_UFPanel.TRP3_scrollChild.PortraitButton:SetPoint("TOPLEFT", 10, -53*5.5);
TRP3_UFPanel.TRP3_scrollChild.PortraitButton:SetSize(120, 26);
TRP3_UFPanel.TRP3_scrollChild.PortraitButton:SetText(L["PlayerPortrait"])
TRP3_UFPanel.TRP3_scrollChild.PortraitButton:SetScript("OnClick", function() EasyMenu(TRP3_UFPanel.menu, TRP3_UFPanel.TRP3_scrollChild.menuFrame, TRP3_UFPanel.TRP3_scrollChild.PortraitButton, 0 , 0, "MENU", 10) end)

------------------------------------------------------------------------------------------------------------------

TRP3_UFPanel.TRP3_scrollChild.TarCustomTextColButton = CreateFrame("Button", nil, TRP3_UFPanel.TRP3_scrollChild, "SharedGoldRedButtonSmallTemplate")
TRP3_UFPanel.TRP3_scrollChild.TarCustomTextColButton:SetPoint("TOPLEFT", 305, -53*5.1);
TRP3_UFPanel.TRP3_scrollChild.TarCustomTextColButton:SetSize(120, 26);
TRP3_UFPanel.TRP3_scrollChild.TarCustomTextColButton:SetText(COLOR_PICKER)
TRP3_UFPanel.TRP3_scrollChild.TarCustomTextColButton:SetScript("OnClick", function() ShowColorPicker(TRP3_UF_DB.Target.colorText.r, TRP3_UF_DB.Target.colorText.g, TRP3_UF_DB.Target.colorText.b, nil, TargetTextColor); end)


TRP3_UFPanel.TRP3_scrollChild.TarCustomBackColButton = CreateFrame("Button", nil, TRP3_UFPanel.TRP3_scrollChild, "SharedGoldRedButtonSmallTemplate")
TRP3_UFPanel.TRP3_scrollChild.TarCustomBackColButton:SetPoint("TOPLEFT", 305, -53*6.1);
TRP3_UFPanel.TRP3_scrollChild.TarCustomBackColButton:SetSize(120, 26);
TRP3_UFPanel.TRP3_scrollChild.TarCustomBackColButton:SetText(COLOR_PICKER)
TRP3_UFPanel.TRP3_scrollChild.TarCustomBackColButton:SetScript("OnClick", function() ShowColorPicker(TRP3_UF_DB.Target.colorBack.r, TRP3_UF_DB.Target.colorBack.g, TRP3_UF_DB.Target.colorBack.b, TRP3_UF_DB.Target.colorBack.a, TargetBackdropColor); end)

TRP3_UFPanel.TRP3_scrollChild.PlayerCustomTextColButton = CreateFrame("Button", nil, TRP3_UFPanel.TRP3_scrollChild, "SharedGoldRedButtonSmallTemplate")
TRP3_UFPanel.TRP3_scrollChild.PlayerCustomTextColButton:SetPoint("TOPLEFT", 305, -53*8.6);
TRP3_UFPanel.TRP3_scrollChild.PlayerCustomTextColButton:SetSize(120, 26);
TRP3_UFPanel.TRP3_scrollChild.PlayerCustomTextColButton:SetText(COLOR_PICKER)
TRP3_UFPanel.TRP3_scrollChild.PlayerCustomTextColButton:SetScript("OnClick", function() ShowColorPicker(TRP3_UF_DB.Player.colorText.r, TRP3_UF_DB.Player.colorText.g, TRP3_UF_DB.Player.colorText.b, nil, PlayerTextColor); end)

TRP3_UFPanel.TRP3_scrollChild.PlayerCustomBackColButton = CreateFrame("Button", nil, TRP3_UFPanel.TRP3_scrollChild, "SharedGoldRedButtonSmallTemplate")
TRP3_UFPanel.TRP3_scrollChild.PlayerCustomBackColButton:SetPoint("TOPLEFT", 305, -53*9.6);
TRP3_UFPanel.TRP3_scrollChild.PlayerCustomBackColButton:SetSize(120, 26);
TRP3_UFPanel.TRP3_scrollChild.PlayerCustomBackColButton:SetText(COLOR_PICKER)
TRP3_UFPanel.TRP3_scrollChild.PlayerCustomBackColButton:SetScript("OnClick", function() ShowColorPicker(TRP3_UF_DB.Player.colorBack.r, TRP3_UF_DB.Player.colorBack.g, TRP3_UF_DB.Player.colorBack.b, TRP3_UF_DB.Player.colorBack.a, PlayerBackdropColor); end)

------------------------------------------------------------------------------------------------------------------

--DUPLICATE OF THE SETTINGS PANEL, BUT FOR TRP3 WINDOW. WILL BE REMOVING THIS SOME DAY
--]]






------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------

local PlayerRepFrame = CreateFrame("Frame", nil, PlayerFrame)
PlayerRepFrame:SetPoint("TOPRIGHT", PlayerFrame, "TOPRIGHT", -22, -26)
PlayerRepFrame:SetWidth(135)
PlayerRepFrame:SetHeight(18)
PlayerRepFrame.tex = PlayerRepFrame:CreateTexture("PlayerFrameReputationColor", "BACKGROUND", nil, 0)
PlayerRepFrame.tex:SetAllPoints(PlayerRepFrame)
PlayerRepFrame.tex:SetAtlas("UI-HUD-UnitFrame-Target-PortraitOn-Type")
PlayerRepFrame.tex:SetTexCoord(1, 0, 0, 1)
PlayerRepFrame.tex:SetVertexColor(0,0,0,1)




InterfaceOptions_AddCategory(TRP3_UFPanel);

------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------

trpTarget.portraitClick = CreateFrame("Button")
trpTarget.portraitClick:SetParent(TargetFrame)
trpTarget.portraitClick:SetAllPoints(TargetFrame.TargetFrameContainer.Portrait)
trpTarget.portraitClick:SetFrameLevel(trpTarget.portraitClick:GetParent():GetFrameLevel()+5)
trpTarget.portraitClick:Hide()
trpTarget.portraitClick:SetScript("OnEnter", function()
	GameTooltip_SetDefaultAnchor(GameTooltip, trpTarget)
	GameTooltip:ClearAllPoints()
	GameTooltip:AddLine(TRP3_API.loc.BINDING_NAME_TRP3_OPEN_TARGET_PROFILE, 1, 1, 1, 1);
	GameTooltip:SetPoint("BOTTOMLEFT", trpTarget.portraitClick, "TOPRIGHT", 0, 0);
	GameTooltip:Show()
end)
trpTarget.portraitClick:SetScript("OnLeave", function()
	GameTooltip:Hide()
end)
trpTarget.portraitClick:SetScript("OnMouseDown", function()
	TargetFrame.TargetFrameContainer.Portrait:SetTexCoord(-0.02, 1.02, -0.02, 1.02)
end)
trpTarget.portraitClick:SetScript("OnMouseUp", function()
	TRP3_API.slash.openProfile("target")
	TargetFrame.TargetFrameContainer.Portrait:SetTexCoord(0, 1, 0, 1)
end)


function trpTarget.SetAsPortrait()
	if TRP3_UF_DB.Target.relativePoint == "CENTER" and UnitIsPlayer("target") == true and AddOn_TotalRP3.Player.CreateFromUnit("target"):GetProfileID() ~= nil then
		trpTarget.button:Hide()
		--trpTarget.button:SetAllPoints(TargetFrame.TargetFrameContainer.Portrait)
		--trpTarget.button.ring:Hide()
		local player = AddOn_TotalRP3.Player.CreateFromUnit("target")
		local icon = player:GetCustomIcon()
		if icon == nil then
			icon = "inv_inscription_scroll"
		end
		SetPortraitToTexture(TargetFrame.TargetFrameContainer.Portrait, "Interface/icons/" .. icon)
		trpTarget.portraitClick:Show()
		trpPlayer.SetVisible()
	else
		SetPortraitTexture(TargetFrame.TargetFrameContainer.Portrait, "target")
		trpTarget.portraitClick:Hide()
		return
	end
end
--SetPortraitToTexture(TargetFrame.TargetFrameContainer.Portrait, "Interface/icons/inv_inscription_scroll")

function trpTarget.SetPos()
	local xPos = 0
	local yPos = 0
	if TRP3_UF_DB.Target.relativePoint == "CENTER" then
		trpTarget.SetAsPortrait()
		return
	end
	trpPlayer.SetVisible()
	if TRP3_UF_DB.Target.relativePoint == "TOPLEFT" then
		yPos = -5*TRP3_UF_DB.Target.position
		xPos = 5*TRP3_UF_DB.Target.position
	end
	if TRP3_UF_DB.Target.relativePoint == "LEFT" then
		yPos = 0*TRP3_UF_DB.Target.position
		xPos = 0*TRP3_UF_DB.Target.position
	end
	if TRP3_UF_DB.Target.relativePoint == "BOTTOMLEFT" then
		yPos = 5*TRP3_UF_DB.Target.position
		xPos = 5*TRP3_UF_DB.Target.position
	end
	if TRP3_UF_DB.Target.relativePoint == "TOP" then
		yPos = 0*TRP3_UF_DB.Target.position
		xPos = 0*TRP3_UF_DB.Target.position
	end
	if TRP3_UF_DB.Target.relativePoint == "BOTTOM" then
		yPos = 0*TRP3_UF_DB.Target.position
		xPos = 0*TRP3_UF_DB.Target.position
	end
	if TRP3_UF_DB.Target.relativePoint == "TOPRIGHT" then
		yPos = -5*TRP3_UF_DB.Target.position
		xPos = -5*TRP3_UF_DB.Target.position
	end
	if TRP3_UF_DB.Target.relativePoint == "RIGHT" then
		yPos = 0*TRP3_UF_DB.Target.position
		xPos = 0*TRP3_UF_DB.Target.position
	end
	if TRP3_UF_DB.Target.relativePoint == "BOTTOMRIGHT" then
		yPos = 5*TRP3_UF_DB.Target.position
		xPos = -5*TRP3_UF_DB.Target.position
	end
	trpTarget.SetAsPortrait()
	trpTarget.button:ClearAllPoints()
	trpTarget.button:SetPoint("CENTER", TargetFrame.TargetFrameContainer.Portrait, TRP3_UF_DB.Target.relativePoint, xPos, yPos)
end

------------------------------------------------------------------------------------------------------------------

trpPlayer.portraitClick = CreateFrame("Button")
trpPlayer.portraitClick:SetParent(PlayerFrame)
trpPlayer.portraitClick:SetAllPoints(PlayerFrame.PlayerFrameContainer.PlayerPortrait)
trpPlayer.portraitClick:SetFrameLevel(trpPlayer.portraitClick:GetParent():GetFrameLevel()+5)
trpPlayer.portraitClick:Hide()
trpPlayer.portraitClick:SetScript("OnEnter", function()
	GameTooltip_SetDefaultAnchor(GameTooltip, trpPlayer)
	GameTooltip:ClearAllPoints()
	GameTooltip:AddLine(TRP3_API.loc.TF_OPEN_CHARACTER, 1, 1, 1, 1);
	GameTooltip:SetPoint("BOTTOMLEFT", trpPlayer.portraitClick, "TOPRIGHT", 0, 0);
	GameTooltip:Show()
end)
trpPlayer.portraitClick:SetScript("OnLeave", function()
	GameTooltip:Hide()
end)
trpPlayer.portraitClick:SetScript("OnMouseDown", function()
	PlayerFrame.PlayerFrameContainer.PlayerPortrait:SetTexCoord(-0.02, 1.02, -0.02, 1.02)
end)
trpPlayer.portraitClick:SetScript("OnMouseUp", function()
	TRP3_API.slash.openProfile("player")
	PlayerFrame.PlayerFrameContainer.PlayerPortrait:SetTexCoord(0, 1, 0, 1)
end)


function trpPlayer.SetAsPortrait()
	if TRP3_UF_DB.Player.relativePoint == "CENTER" then
		trpPlayer.button:Hide()
		--trpPlayer.button:SetAllPoints(TargetFrame.TargetFrameContainer.Portrait)
		--trpPlayer.button.ring:Hide()
		local player = AddOn_TotalRP3.Player.CreateFromUnit("player")
		local icon = player:GetCustomIcon()
		if icon == nil then
			icon = "inv_inscription_scroll"
		end
		SetPortraitToTexture(PlayerFrame.PlayerFrameContainer.PlayerPortrait, "Interface/icons/" .. icon)
		trpPlayer.portraitClick:Show()
		trpPlayer.SetVisible()
	else
		SetPortraitTexture(PlayerFrame.PlayerFrameContainer.PlayerPortrait, "player")
		trpPlayer.portraitClick:Hide()
		return
	end
	trpPlayer.SetVisible()
end
--SetPortraitToTexture(TargetFrame.TargetFrameContainer.Portrait, "Interface/icons/inv_inscription_scroll")

function trpPlayer.SetPos()
	local xPos = 0
	local yPos = 0
	if TRP3_UF_DB.Player.relativePoint == "CENTER" then
		trpPlayer.SetAsPortrait()
		return
	end
	trpPlayer.SetVisible()
	if TRP3_UF_DB.Player.relativePoint == "TOPLEFT" then
		yPos = -5*TRP3_UF_DB.Player.position
		xPos = 5*TRP3_UF_DB.Player.position
	end
	if TRP3_UF_DB.Player.relativePoint == "LEFT" then
		yPos = 0*TRP3_UF_DB.Player.position
		xPos = 0*TRP3_UF_DB.Player.position
	end
	if TRP3_UF_DB.Player.relativePoint == "BOTTOMLEFT" then
		yPos = 5*TRP3_UF_DB.Player.position
		xPos = 5*TRP3_UF_DB.Player.position
	end
	if TRP3_UF_DB.Player.relativePoint == "TOP" then
		yPos = 0*TRP3_UF_DB.Player.position
		xPos = 0*TRP3_UF_DB.Player.position
	end
	if TRP3_UF_DB.Player.relativePoint == "BOTTOM" then
		yPos = 0*TRP3_UF_DB.Player.position
		xPos = 0*TRP3_UF_DB.Player.position
	end
	if TRP3_UF_DB.Player.relativePoint == "TOPRIGHT" then
		yPos = -5*TRP3_UF_DB.Player.position
		xPos = -5*TRP3_UF_DB.Player.position
	end
	if TRP3_UF_DB.Player.relativePoint == "RIGHT" then
		yPos = 0*TRP3_UF_DB.Player.position
		xPos = 0*TRP3_UF_DB.Player.position
	end
	if TRP3_UF_DB.Player.relativePoint == "BOTTOMRIGHT" then
		yPos = 5*TRP3_UF_DB.Player.position
		xPos = -5*TRP3_UF_DB.Player.position
	end
	trpPlayer.SetAsPortrait()
	trpPlayer.button:ClearAllPoints()
	trpPlayer.button:SetPoint("CENTER", PlayerFrame.PlayerFrameContainer.PlayerPortrait, TRP3_UF_DB.Player.relativePoint, xPos, yPos)
end

------------------------------------------------------------------------------------------------------------------

function trpPlayer.SetVisible()
	if TRP3_UF_DB.Target.show == true and UnitIsPlayer("target") == true and AddOn_TotalRP3.Player.CreateFromUnit("target"):GetProfileID() ~= nil then
		trpTarget.button:Show();
		trpTarget.portraitClick:Show();
	else
		trpTarget.button:Hide();
		trpTarget.portraitClick:Hide();
		SetPortraitTexture(TargetFrame.TargetFrameContainer.Portrait, "target")
	end
	if TRP3_UF_DB.Player.show == true then
		trpPlayer.button:Show();
		trpPlayer.portraitClick:Show();
	else
		trpPlayer.button:Hide();
		trpPlayer.portraitClick:Hide();
		SetPortraitTexture(PlayerFrame.PlayerFrameContainer.PlayerPortrait, "player")
	end
	if TRP3_UF_DB.Player.relativePoint == "CENTER" then
		trpPlayer.button:Hide()
	elseif TRP3_UF_DB.Player.relativePoint ~= "CENTER" then
		trpPlayer.portraitClick:Hide();
	end
	if TRP3_UF_DB.Target.relativePoint == "CENTER" then
		trpTarget.button:Hide()
	elseif TRP3_UF_DB.Target.relativePoint ~= "CENTER" then
		trpTarget.portraitClick:Hide();
	end
end


function trpPlayer.fadeout()
	UIFrameFadeOut(trpPlayer.button, .5, trpPlayer.button:GetAlpha(), 0)
end
function trpPlayer.hide()
	trpPlayer.button:Hide()
end

function trpPlayer.fadein()
	UIFrameFadeIn(trpPlayer.button, .5, trpPlayer.button:GetAlpha(), 1)
end
function trpPlayer.show()
	trpPlayer.SetVisible()
end

function trpTarget.SetColor()
	--local r, g, b, a = TargetFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:GetVertexColor()
	if TRP3_UF_DB.Target.colorBack.custom == true then
		TargetFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:SetVertexColor(TRP3_UF_DB.Target.colorBack.r, TRP3_UF_DB.Target.colorBack.g, TRP3_UF_DB.Target.colorBack.b, TRP3_UF_DB.Target.colorBack.a)
	end
	if TRP3_UF_DB.Target.colorText.custom == true then
		if TRP3_UF_DB.Setting.FullNameTarget == true and TRP3_UF_DB.Setting.UseTRPName == true then
			TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetText(TRP3_API.r.name("target"))
		elseif TRP3_UF_DB.Setting.FullNameTarget == false and TRP3_UF_DB.Setting.UseTRPName == true then
			if AddOn_TotalRP3.Player.CreateFromGUID(UnitGUID("target")):GetFirstName() == nil then
				local nameBingus, realmBingus = UnitName("target")
				TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetText(nameBingus)
			else
				TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetText(AddOn_TotalRP3.Player.CreateFromGUID(UnitGUID("target")):GetFirstName())
			end
		else
			TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetText(UnitName("target"))
		end
		TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetTextColor(TRP3_UF_DB.Target.colorText.r, TRP3_UF_DB.Target.colorText.g, TRP3_UF_DB.Target.colorText.b)
	end
end

function trpTarget.nameChecker()
	trpTarget.UpdateInfo()
	trpPlayer.UpdateInfo()
	if UnitIsPlayer("target") == true and AddOn_TotalRP3.Player.CreateFromUnit("target"):GetProfileID() ~= nil then
		local textColorQ = AddOn_TotalRP3.Player.CreateFromUnit("target"):GetCustomColorForDisplay()
		if textColorQ ~= nil then
			textColorStuff = textColorQ:GenerateHexColor()
		else
			textColorStuff = "FFFFD100"
		end
		--TargetFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:SetVertexColor(TRP3_UF_DB.Target.colorBack.r, TRP3_UF_DB.Target.colorBack.g, TRP3_UF_DB.Target.colorBack.b, TRP3_UF_DB.Target.colorBack.a)
		--TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetText("|c" .. textColorStuff .. TRP3_API.r.name("target") .. "|r")
		--PlayerName:SetText(TRP3_API.r.name("player"))
		trpTarget.SetColor()
		local player = AddOn_TotalRP3.Player.CreateFromUnit("target")
		local icon = player:GetCustomIcon()
		if icon == nil then
			icon = "inv_inscription_scroll"
		end
		--trpTarget.button:SetNormalTexture("Interface/icons/" .. icon)
		SetPortraitToTexture(trpTarget.button.tex, "Interface/icons/" .. icon)
		trpPlayer.SetVisible()
		trpTarget.SetAsPortrait()
	else
		trpTarget.button:Hide()
		trpTarget.portraitClick:Hide()
	end
end


--[[ -- Currently Frame Tester - NYI

trpTarget.Bingus = ""
trpTarget.Bongus = ""
trpTarget.UnitName1 = ""
trpTarget.UnitName2 = ""

--trpTarget.CurrentlyNotifier = CreateFrame("Frame", nil, UIParent)
--trpTarget.CurrentlyNotifier:SetPoint("CENTER")
--trpTarget.CurrentlyNotifier:SetSize(300,100)

trpTarget.CurrentlyNotifier = CreateFrame("Frame", "FizzleTestSomeFrameName", TargetFrame, "BackdropTemplate")
trpTarget.CurrentlyNotifier:SetFrameLevel(trpTarget.CurrentlyNotifier:GetParent():GetFrameLevel()+15)
trpTarget.CurrentlyNotifier:SetClampedToScreen(true)
-- Simple backdrop so you can see it but style the frame how you like
trpTarget.CurrentlyNotifier:SetSize(300,100)
trpTarget.CurrentlyNotifier:SetPoint("BOTTOMLEFT", TargetFrame, "TOPLEFT",0,0) -- or wherever you want the default anchor to be
trpTarget.CurrentlyNotifier:SetBackdrop({
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
 	tile = true,
	tileEdge = true,
	tileSize = 8,
	edgeSize = 8,
	insets = {
		left = 3,
		right = 3,
		top = 3,
		bottom = 3,
	},
})
trpTarget.CurrentlyNotifier:SetAlpha(1)
trpTarget.CurrentlyNotifier:SetBackdropColor(0,0,0,.7)
trpTarget.CurrentlyNotifier:SetBackdropBorderColor(1,1,1,0)

--trpTarget.CurrentlyNotifier.tex = trpTarget.CurrentlyNotifier:CreateTexture(nil, "BACKGROUND")
--trpTarget.CurrentlyNotifier.tex:SetAllPoints(trpTarget.CurrentlyNotifier)
--trpTarget.CurrentlyNotifier.tex:SetColorTexture(0, 0, 0, 0.5)
--trpTarget.CurrentlyNotifier.tex:SetTexture("interface/garrison/adventuremissionbackgroundshadow")

trpTarget.CurrentlyNotifier.title = trpTarget.CurrentlyNotifier:CreateFontString(nil, "OVERLAY", "GameTooltipText")
trpTarget.CurrentlyNotifier.title:SetPoint("TOPLEFT", trpTarget.CurrentlyNotifier, "TOPLEFT", 5, -5)
trpTarget.CurrentlyNotifier.title:SetText(TRP3_API.loc.REG_PLAYER_CURRENT)

trpTarget.CurrentlyNotifier.font = trpTarget.CurrentlyNotifier:CreateFontString("bingusfont", "OVERLAY", "GameTooltipText")
trpTarget.CurrentlyNotifier.font:SetPoint("TOPLEFT", trpTarget.CurrentlyNotifier, "TOPLEFT", 15, -25)
trpTarget.CurrentlyNotifier.font:SetText("Hello, friend.")
trpTarget.CurrentlyNotifier.font:SetWordWrap(true)
trpTarget.CurrentlyNotifier.font:SetSize(285,70)

trpTarget.CurrentlyNotifier:Hide()
trpTarget.CurrentlyNotifier:SetAlpha(0)

function trpTarget.CurrentlyNotifier.FadeOut()
	UIFrameFadeOut(trpTarget.CurrentlyNotifier, 2, trpTarget.CurrentlyNotifier:GetAlpha(), 0)
	C_Timer.After(2, function() trpTarget.CurrentlyNotifier:Hide() end)
end

function trpTarget.CurrentlyNotifier.FadeIn()
	trpTarget.CurrentlyNotifier:Show()
	UIFrameFadeIn(trpTarget.CurrentlyNotifier, .5, trpTarget.CurrentlyNotifier:GetAlpha(), 1)
	C_Timer.After(5, function() trpTarget.CurrentlyNotifier.FadeOut() end)
end




function trpTarget.ChangedCurrently()
	if UnitIsPlayer("target") == true and AddOn_TotalRP3.Player.CreateFromUnit("target"):GetProfileID() ~= nil then
		trpTarget.Bongus = AddOn_TotalRP3.Player.CreateFromUnit("target"):GetCurrentlyText()
		if (trpTarget.Bingus == nil) or (trpTarget.Bongus == nil) then
			trpTarget.Bingus = ""
			trpTarget.Bongus = ""
		end
		trpTarget.UnitName2 = UnitName("target")
		--trpTarget.Bongus = trpTarget.Bongus:gsub("%s+", " ")
		if trpTarget.Bingus ~= trpTarget.Bongus and trpTarget.UnitName1 == trpTarget.UnitName2 then
			if trpTarget.Bingus == ("" or " " or nil) then
				--print("nothing before!")
				trpTarget.CurrentlyNotifier.font:SetText(trpTarget.Bongus)
				trpTarget.CurrentlyNotifier.title:SetText(TRP3_API.loc.REG_PLAYER_CURRENT)
				trpTarget.CurrentlyNotifier.FadeIn()
			elseif trpTarget.Bongus == ("" or " " or nil) then
				--print("nothing after!")
				--return
			else
				--print("Currently change detected! Previously: " .. trpTarget.Bingus .. "\nAfter: " .. trpTarget.Bongus)
				trpTarget.CurrentlyNotifier.font:SetText(trpTarget.Bongus)
				trpTarget.CurrentlyNotifier.FadeIn()
			end

			--trpTarget.CurrentlyChecker()
		end
	end
	trpTarget.CurrentlyChecker()
end

function trpTarget.CurrentlyChecker()
	if UnitIsPlayer("target") == true and AddOn_TotalRP3.Player.CreateFromUnit("target"):GetProfileID() ~= nil then
		trpTarget.Bingus = AddOn_TotalRP3.Player.CreateFromUnit("target"):GetCurrentlyText()
		if (trpTarget.Bingus == nil) or (trpTarget.Bongus == nil) then
			trpTarget.Bingus = ""
			trpTarget.Bongus = ""
		end
		trpTarget.UnitName1 = UnitName("target")
		--trpTarget.Bingus = trpTarget.Bingus:gsub("%s+", " ")
	end
	C_Timer.After(10, trpTarget.ChangedCurrently)
end
]]


local function onStart()
	if TRP3_UF_DB == nil then
		TRP3_UF_DB = defaultsTable
	end
	--[[ --so that old users now have the new settings put in
	if not TRP3_UF_DB.CurrNotifier then
		TRP3_UF_DB.CurrNotifier = defaultsTable.CurrNotifier
	end
	]]

	if TRP3_UF_DB.Setting.FullNamePlayer == nil then
		TRP3_UF_DB.Setting.FullNamePlayer = defaultsTable.Setting.FullNamePlayer
	end
	if TRP3_UF_DB.Setting.FullNameTarget == nil then
		TRP3_UF_DB.Setting.FullNameTarget = defaultsTable.Setting.FullNameTarget
	end
	if TRP3_UF_DB.Setting.UseTRPName == nil then
		TRP3_UF_DB.Setting.UseTRPName = defaultsTable.Setting.UseTRPName
	end


	--trpTarget.CurrentlyChecker() --(don't forget to enable this, future me), Currently Frame Tester - NYI

	--trpTarget:RegisterEvent("CHAT_MSG_ADDON")
	trpTarget:RegisterEvent("PLAYER_TARGET_CHANGED")
	trpTarget:RegisterEvent("UNIT_TARGET")

	local TarWidth = TargetFrame.TargetFrameContainer.Portrait:GetWidth()
	local TarHeight = TargetFrame.TargetFrameContainer.Portrait:GetHeight()
	trpTarget.button = CreateFrame("Button")
	trpTarget.button:SetPoint("CENTER", TargetFrame.TargetFrameContainer.Portrait, "BOTTOMLEFT", TarWidth/12, TarHeight/12)
	trpTarget.button:SetParent(TargetFrame)
	trpTarget.button:SetSize(14.3,14.3)
	trpTarget.button:SetScale(1.5)
	trpTarget.button:SetFrameLevel(trpTarget.button:GetParent():GetFrameLevel()+5)
	trpTarget.button.tex = trpTarget.button:CreateTexture(nil, "ARTWORK", nil, 0)
	trpTarget.button.tex:SetAllPoints(trpTarget.button)
	trpTarget.button.tex:SetTexCoord(.08, .92, .08, .92)
	SetPortraitToTexture(trpTarget.button.tex)

	trpTarget.button:SetScript("OnMouseDown", function()
		trpTarget.button.tex:SetTexCoord(0, 1, 0, 1)
	end)
	trpTarget.button:SetScript("OnMouseUp", function()
		TRP3_API.slash.openProfile("target")
		trpTarget.button.tex:SetTexCoord(.08, .92, .08, .92)
	end)

	trpTarget.button.ring = trpTarget.button:CreateTexture(nil, "ARTWORK", nil, 1)
	trpTarget.button.ring:SetPoint("CENTER", trpTarget.button.tex, "CENTER", .8, -.8)
	trpTarget.button.ring:SetSize(20,20)
	trpTarget.button.ring:SetAtlas("bag-border")
	--trpTarget.button.ring:SetAtlas("communities-ring-gold")
	trpTarget.button:Hide()
	--PlayerName
	--C_ClassColor.GetClassColor(UnitClassBase("target")):GenerateHexColor() -- generates default class color

	--trpPlayer:RegisterEvent("CHAT_MSG_ADDON")
	-- a list of events that change the backdrop frame color and reset values
	trpPlayer:RegisterEvent("PLAYER_TARGET_CHANGED")
	trpPlayer:RegisterEvent("UNIT_TARGET")
	trpPlayer:RegisterEvent("PLAYER_REGEN_DISABLED")
	trpPlayer:RegisterEvent("PLAYER_REGEN_ENABLED")
	trpPlayer:RegisterEvent("PLAYER_LOGOUT")
	trpPlayer:RegisterEvent("PLAYER_ENTERING_WORLD")
	trpPlayer:RegisterEvent("UNIT_FACTION")
	trpPlayer:RegisterEvent("GROUP_ROSTER_UPDATE")
	trpPlayer:RegisterEvent("PLAYER_ROLES_ASSIGNED")
	trpPlayer:RegisterEvent("GUILD_PARTY_STATE_UPDATED")
	trpPlayer:RegisterEvent("UNIT_AREA_CHANGED")
	trpPlayer:RegisterEvent("UNIT_PHASE")
	trpPlayer:RegisterEvent("CLIENT_SCENE_OPENED")
	trpPlayer:RegisterEvent("CLIENT_SCENE_CLOSED")
	trpPlayer:RegisterEvent("ZONE_CHANGED")

	local AddonChecker = CreateFrame("Frame")
	AddonChecker:RegisterEvent("ADDON_LOADED")
	function AddonChecker.Compatibility(event, arg1)
		if event == "ADDON_LOADED" and arg1 == "Narcissus" then
			print("yee haw")
		end
	end
	if IsAddOnLoaded("Narcissus") then
		TRP3_UFPanel.menu[4] = {
			text = L["Narcissus"],
			menuList = {
				{ text = "NarciHexagonBorder", func = function() TRP3_UF_DB.Border.style = "NarciHexagonBorder"; PlayerDragonFrame.TextureStuff(); end },
				{ text = "NarciHexagonBorder-Artifact", func = function() TRP3_UF_DB.Border.style = "NarciHexagonBorder-Artifact"; PlayerDragonFrame.TextureStuff(); end },
				{ text = "NarciHexagonBorder-Azerite", func = function() TRP3_UF_DB.Border.style = "NarciHexagonBorder-Azerite"; PlayerDragonFrame.TextureStuff(); end },
				{ text = "NarciHexagonBorder-Black", func = function() TRP3_UF_DB.Border.style = "NarciHexagonBorder-Black"; PlayerDragonFrame.TextureStuff(); end },
				{ text = "NarciHexagonBorder-BlackDragon", func = function() TRP3_UF_DB.Border.style = "NarciHexagonBorder-BlackDragon"; PlayerDragonFrame.TextureStuff(); end },
				{ text = "NarciHexagonBorder-Epic", func = function() TRP3_UF_DB.Border.style = "NarciHexagonBorder-Epic"; PlayerDragonFrame.TextureStuff(); end },
				{ text = "NarciHexagonBorder-Heart", func = function() TRP3_UF_DB.Border.style = "NarciHexagonBorder-Heart"; PlayerDragonFrame.TextureStuff(); end },
				{ text = "NarciHexagonBorder-Heirloom", func = function() TRP3_UF_DB.Border.style = "NarciHexagonBorder-Heirloom"; PlayerDragonFrame.TextureStuff(); end },
				{ text = "NarciHexagonBorder-Legendary", func = function() TRP3_UF_DB.Border.style = "NarciHexagonBorder-Legendary"; PlayerDragonFrame.TextureStuff(); end },
				{ text = "NarciHexagonBorder-NZoth", func = function() TRP3_UF_DB.Border.style = "NarciHexagonBorder-NZoth"; PlayerDragonFrame.TextureStuff(); end },
				{ text = "NarciHexagonBorder-Rare", func = function() TRP3_UF_DB.Border.style = "NarciHexagonBorder-Rare"; PlayerDragonFrame.TextureStuff(); end },
				{ text = "NarciHexagonBorder-Special", func = function() TRP3_UF_DB.Border.style = "NarciHexagonBorder-Special"; PlayerDragonFrame.TextureStuff(); end },
				{ text = "NarciHexagonBorder-Uncommon", func = function() TRP3_UF_DB.Border.style = "NarciHexagonBorder-Uncommon"; PlayerDragonFrame.TextureStuff(); end },
				{ text = "NarciHexagonBorder-Void", func = function() TRP3_UF_DB.Border.style = "NarciHexagonBorder-Void"; PlayerDragonFrame.TextureStuff(); end },
				{ text = "NarciHexagonDarkBorder-Artifact", func = function() TRP3_UF_DB.Border.style = "NarciHexagonDarkBorder-Artifact"; PlayerDragonFrame.TextureStuff(); end },
				{ text = "NarciHexagonDarkBorder-Azerite", func = function() TRP3_UF_DB.Border.style = "NarciHexagonDarkBorder-Azerite"; PlayerDragonFrame.TextureStuff(); end },
				{ text = "NarciHexagonDarkBorder-Black", func = function() TRP3_UF_DB.Border.style = "NarciHexagonDarkBorder-Black"; PlayerDragonFrame.TextureStuff(); end },
				{ text = "NarciHexagonDarkBorder-BlackDragon", func = function() TRP3_UF_DB.Border.style = "NarciHexagonDarkBorder-BlackDragon"; PlayerDragonFrame.TextureStuff(); end },
				{ text = "NarciHexagonDarkBorder-Dragonflight", func = function() TRP3_UF_DB.Border.style = "NarciHexagonDarkBorder-Dragonflight"; PlayerDragonFrame.TextureStuff(); end },
				{ text = "NarciHexagonDarkBorder-Epic", func = function() TRP3_UF_DB.Border.style = "NarciHexagonDarkBorder-Epic"; PlayerDragonFrame.TextureStuff(); end },
				{ text = "NarciHexagonDarkBorder-Heart", func = function() TRP3_UF_DB.Border.style = "NarciHexagonDarkBorder-Heart"; PlayerDragonFrame.TextureStuff(); end },
				{ text = "NarciHexagonDarkBorder-Heirloom", func = function() TRP3_UF_DB.Border.style = "NarciHexagonDarkBorder-Heirloom"; PlayerDragonFrame.TextureStuff(); end },
				{ text = "NarciHexagonDarkBorder-Legendary", func = function() TRP3_UF_DB.Border.style = "NarciHexagonDarkBorder-Legendary"; PlayerDragonFrame.TextureStuff(); end },
				{ text = "NarciHexagonDarkBorder-Progenitor", func = function() TRP3_UF_DB.Border.style = "NarciHexagonDarkBorder-Progenitor"; PlayerDragonFrame.TextureStuff(); end },
				{ text = "NarciHexagonDarkBorder-Rare", func = function() TRP3_UF_DB.Border.style = "NarciHexagonDarkBorder-Rare"; PlayerDragonFrame.TextureStuff(); end },
				{ text = "NarciHexagonDarkBorder-Runeforge", func = function() TRP3_UF_DB.Border.style = "NarciHexagonDarkBorder-Runeforge"; PlayerDragonFrame.TextureStuff(); end },
				{ text = "NarciHexagonDarkBorder-Shield", func = function() TRP3_UF_DB.Border.style = "NarciHexagonDarkBorder-Shield"; PlayerDragonFrame.TextureStuff(); end },
				{ text = "NarciHexagonDarkBorder-Uncommon", func = function() TRP3_UF_DB.Border.style = "NarciHexagonDarkBorder-Uncommon"; PlayerDragonFrame.TextureStuff(); end },

			},
			hasArrow = true
		}
	else
		TRP3_UFPanel.menu[4] = {
			text = L["Narcissus"],
			menuList = {
				[1] = {
				isTitle = true,
				text = L["NotDetected"]
				}
			},
			hasArrow = true
		}
	end
	AddonChecker:SetScript("OnEvent", AddonChecker.Compatibility)


	local PlayWidth = PlayerFrame.PlayerFrameContainer.PlayerPortrait:GetWidth()
	local PlayHeight = PlayerFrame.PlayerFrameContainer.PlayerPortrait:GetHeight()
	trpPlayer.button = CreateFrame("Button")
	trpPlayer.button:SetPoint("CENTER", PlayerFrame.PlayerFrameContainer.PlayerPortrait, "BOTTOMRIGHT", -PlayWidth/12, PlayHeight/12)
	trpPlayer.button:SetParent(PlayerFrame)
	trpPlayer.button:SetSize(14.3,14.3)
	trpPlayer.button:SetScale(1.5)
	trpPlayer.button:SetFrameLevel(trpPlayer.button:GetParent():GetFrameLevel()+5)
	trpPlayer.button.tex = trpPlayer.button:CreateTexture(nil, "ARTWORK", nil, 0)
	trpPlayer.button.tex:SetAllPoints(trpPlayer.button)
	trpPlayer.button.tex:SetTexCoord(.08, .92, .08, .92)
	SetPortraitToTexture(trpPlayer.button.tex)

	trpPlayer.button:SetScript("OnMouseDown", function()
		trpPlayer.button.tex:SetTexCoord(0, 1, 0, 1)
	end)
	trpPlayer.button:SetScript("OnMouseUp", function()
		TRP3_API.slash.openProfile("player")
		trpPlayer.button.tex:SetTexCoord(.08, .92, .08, .92)
	end)

	trpPlayer.button.ring = trpPlayer.button:CreateTexture(nil, "ARTWORK", nil, 1)
	trpPlayer.button.ring:SetPoint("CENTER", trpPlayer.button.tex, "CENTER", .8, -.8)
	trpPlayer.button.ring:SetSize(20,20)
	trpPlayer.button.ring:SetAtlas("bag-border")
	--trpPlayer.button.ring:SetAtlas("communities-ring-gold")
	
	trpPlayer:SetScript("OnEvent", function(self, event)
		if event == "PLAYER_REGEN_DISABLED" then
			trpPlayer.fadeout()
			C_Timer.After(.5, trpPlayer.hide)
		elseif event == "PLAYER_REGEN_ENABLED" then
			trpPlayer.fadein()
			C_Timer.After(.5, trpPlayer.show)
		end

		if event == "PLAYER_LOGOUT" then
			SetPortraitTexture(TargetFrame.TargetFrameContainer.Portrait, "target")
			SetPortraitTexture(PlayerFrame.PlayerFrameContainer.PlayerPortrait, "player")
		end

		if event == "PLAYER_ENTERING_WORLD" then
			trpPlayer.UpdateInfo()
			trpTarget.DummyColors()
		end

		if event ~= "PLAYER_ENTERING_WORLD" then
			trpTarget.UpdateInfo()
			trpPlayer.UpdateInfo()
		end
	end);

	trpTarget:SetScript("OnEvent", trpTarget.nameChecker)
	trpTarget.button:SetScript("OnEnter", function()
		GameTooltip_SetDefaultAnchor(GameTooltip, trpTarget)
		GameTooltip:ClearAllPoints()
		GameTooltip:AddLine(TRP3_API.loc.BINDING_NAME_TRP3_OPEN_TARGET_PROFILE, 1, 1, 1, 1);
		GameTooltip:SetPoint("BOTTOMLEFT", trpTarget.button, "TOPRIGHT", 0, 0);
		GameTooltip:Show()
	end)
	trpTarget.button:SetScript("OnLeave", function()
		GameTooltip:Hide()
	end)
	
	trpPlayer.button:SetScript("OnEnter", function()
		GameTooltip_SetDefaultAnchor(GameTooltip, trpPlayer)
		GameTooltip:ClearAllPoints()
		GameTooltip:AddLine(TRP3_API.loc.TF_OPEN_CHARACTER, 1, 1, 1, 1);
		GameTooltip:SetPoint("BOTTOMLEFT", trpPlayer.button, "TOPRIGHT", 0, 0);
		GameTooltip:Show()
	end)
	trpPlayer.button:SetScript("OnLeave", function()
		GameTooltip:Hide()
	end)


	--set out stuff here
	trpTarget.SetPos()
	trpPlayer.SetPos()
	TRP3_UFPanel.CheckSettings()

	trpPlayer.SetVisible()

	--player border portrait
	PlayerDragonFrame.TextureStuff()
	

	if TRP3_UF_DB.Border.show == true then
		PlayerDragonFrame:Show();
	else
		PlayerDragonFrame:Hide();
	end

	trpPlayer.button:SetScale(TRP3_UF_DB.Player.scale)
	trpTarget.button:SetScale(TRP3_UF_DB.Target.scale)
	

	--handle dummy frames
	function trpTarget.DummyColors()
		TRP3_UFRepDummyTarget:SetVertexColor(TRP3_UF_DB.Target.colorBack.r,TRP3_UF_DB.Target.colorBack.g,TRP3_UF_DB.Target.colorBack.b,TRP3_UF_DB.Target.colorBack.a)
		TRP3_UFRepTextDummyTarget:SetTextColor(TRP3_UF_DB.Target.colorText.r,TRP3_UF_DB.Target.colorText.g,TRP3_UF_DB.Target.colorText.b)
		TRP3_UFRepDummyPlayer:SetVertexColor(TRP3_UF_DB.Player.colorBack.r,TRP3_UF_DB.Player.colorBack.g,TRP3_UF_DB.Player.colorBack.b,TRP3_UF_DB.Player.colorBack.a)
		TRP3_UFRepTextDummyPlayer:SetTextColor(TRP3_UF_DB.Player.colorText.r,TRP3_UF_DB.Player.colorText.g,TRP3_UF_DB.Player.colorText.b)


		TRP3_UFSettingsRepDummyTarget:SetVertexColor(TRP3_UF_DB.Target.colorBack.r,TRP3_UF_DB.Target.colorBack.g,TRP3_UF_DB.Target.colorBack.b,TRP3_UF_DB.Target.colorBack.a)
		TRP3_UFSettingsRepTextDummyTarget:SetTextColor(TRP3_UF_DB.Target.colorText.r,TRP3_UF_DB.Target.colorText.g,TRP3_UF_DB.Target.colorText.b)
		TRP3_UFSettingsRepDummyPlayer:SetVertexColor(TRP3_UF_DB.Player.colorBack.r,TRP3_UF_DB.Player.colorBack.g,TRP3_UF_DB.Player.colorBack.b,TRP3_UF_DB.Player.colorBack.a)
		TRP3_UFSettingsRepTextDummyPlayer:SetTextColor(TRP3_UF_DB.Player.colorText.r,TRP3_UF_DB.Player.colorText.g,TRP3_UF_DB.Player.colorText.b)

		--AAAAAAAAAAAAAAAAAAAAAAAA
		--recolor the dummy frames in TRP3 frame
	end




	if TRP3_UF_DB.Border.status == false then
		PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture:Show()
	else
		PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture:Hide()
	end
	function trpTarget.OnShow()
		if TRP3_UF_DB.Border.status == false then
			return
		else
			PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture:Hide()
		end
	end

	PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture:SetScript("OnShow",trpTarget.OnShow);

	--set info on frames

	function trpPlayer.UpdateInfo()
		local classR, classG, classB = C_ClassColor.GetClassColor(UnitClassBase("player")).r, C_ClassColor.GetClassColor(UnitClassBase("player")).g, C_ClassColor.GetClassColor(UnitClassBase("player")).b
		if TRP3_UF_DB.Setting.FullNamePlayer == true and TRP3_UF_DB.Setting.UseTRPName == true then
			PlayerName:SetText(TRP3_API.r.name("player"))
		elseif TRP3_UF_DB.Setting.FullNamePlayer == false and TRP3_UF_DB.Setting.UseTRPName == true then
			PlayerName:SetText(AddOn_TotalRP3.Player.CreateFromGUID(UnitGUID("player")):GetFirstName())
		else
			PlayerName:SetText(UnitName("player"))
		end
		PlayerName:SetTextColor(1,0.8960791349411,0,1)
		PlayerFrameReputationColor:SetVertexColor(0, 0, 0, 0)
		if TRP3_UF_DB.Player.colorText.class == true then
			PlayerName:SetTextColor(classR, classG, classB)
		end
		if AddOn_TotalRP3.Player.CreateFromUnit("player"):GetCustomColorForDisplay() ~= nil then
			PlayerName:SetTextColor(AddOn_TotalRP3.Player.CreateFromUnit("player"):GetCustomColorForDisplay():GetRGB())
		end

		if TRP3_UF_DB.Player.colorText.custom == true then
			PlayerName:SetTextColor(TRP3_UF_DB.Player.colorText.r, TRP3_UF_DB.Player.colorText.g, TRP3_UF_DB.Player.colorText.b)
		end


		if TRP3_UF_DB.Player.colorBack.class == true then
			PlayerFrameReputationColor:SetVertexColor(classR, classG, classB, 1)
		end
		if TRP3_UF_DB.Player.colorBack.custom == true then
			PlayerFrameReputationColor:SetVertexColor(TRP3_UF_DB.Player.colorBack.r, TRP3_UF_DB.Player.colorBack.g, TRP3_UF_DB.Player.colorBack.b, TRP3_UF_DB.Player.colorBack.a)
		end
		if TRP3_UF_DB.Player.colorBack.class == false and TRP3_UF_DB.Player.colorBack.custom == false then
			PlayerFrameReputationColor:SetVertexColor(0, 0, 0, 0)
		end

		if AddOn_TotalRP3.Player.CreateFromUnit("player"):GetProfileID() ~= nil then
			local player1 = AddOn_TotalRP3.Player.CreateFromUnit("player")
			local icon = player1:GetCustomIcon()
			--trpTarget.button:SetNormalTexture("Interface/icons/" .. icon)
			SetPortraitToTexture(trpPlayer.button.tex, "Interface/icons/" .. icon)
			trpPlayer.SetVisible()
			trpPlayer.SetAsPortrait()
		else
			trpPlayer.button:Hide()
		end
	end

	function trpTarget.UpdateInfo()
		TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetTextColor(1,0.8960791349411,0,1)
		if UnitIsPlayer("target") == true then
			TargetFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:SetVertexColor(0, 0, 1, 1)
			if TRP3_UF_DB.Target.colorText.class == true then
				local classR, classG, classB = C_ClassColor.GetClassColor(UnitClassBase("target")).r, C_ClassColor.GetClassColor(UnitClassBase("target")).g, C_ClassColor.GetClassColor(UnitClassBase("target")).b
				if classR == nil or classG == nil or classB == nil then
					classR, classG, classB = 1, 1, 1
				end
				if TRP3_UF_DB.Setting.FullNameTarget == true and TRP3_UF_DB.Setting.UseTRPName == true then
					TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetText(TRP3_API.r.name("target"))
				elseif TRP3_UF_DB.Setting.FullNameTarget == false and TRP3_UF_DB.Setting.UseTRPName == true then
					if AddOn_TotalRP3.Player.CreateFromGUID(UnitGUID("target")):GetFirstName() == nil then
						local nameBingus, realmBingus = UnitName("target")
						TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetText(nameBingus)
					else
						TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetText(AddOn_TotalRP3.Player.CreateFromGUID(UnitGUID("target")):GetFirstName())
					end
				else
					TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetText(UnitName("target"))
				end

				TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetTextColor(classR, classG, classB)
			end


			local textColorQ = AddOn_TotalRP3.Player.CreateFromUnit("target"):GetCustomColorForDisplay()
			local profileR, profileG, profileB = 1, 1, 1
			if textColorQ ~= nil then
				textColorStuff = textColorQ:GenerateHexColor()
				profileR, profileG, profileB = AddOn_TotalRP3.Player.CreateFromUnit("target"):GetCustomColorForDisplay():GetRGBTable().r, AddOn_TotalRP3.Player.CreateFromUnit("target"):GetCustomColorForDisplay():GetRGBTable().g, AddOn_TotalRP3.Player.CreateFromUnit("target"):GetCustomColorForDisplay():GetRGBTable().b
				TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetTextColor(profileR, profileG, profileB)
			end
			
			if TRP3_UF_DB.Target.colorText.custom == true then
				TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetTextColor(TRP3_UF_DB.Target.colorText.r, TRP3_UF_DB.Target.colorText.g, TRP3_UF_DB.Target.colorText.b)
			end


			if TRP3_UF_DB.Target.colorBack.class == true then
				local classR, classG, classB = C_ClassColor.GetClassColor(UnitClassBase("target")).r, C_ClassColor.GetClassColor(UnitClassBase("target")).g, C_ClassColor.GetClassColor(UnitClassBase("target")).b
				if classR == nil or classG == nil or classB == nil then
					classR, classG, classB = 0, 0, 0
				end
				TargetFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:SetVertexColor(classR, classG, classB, 1)
			end
			if TRP3_UF_DB.Target.colorBack.custom == true then
				TargetFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:SetVertexColor(TRP3_UF_DB.Target.colorBack.r, TRP3_UF_DB.Target.colorBack.g, TRP3_UF_DB.Target.colorBack.b, TRP3_UF_DB.Target.colorBack.a)
			end
			if TRP3_UF_DB.Target.colorBack.class == false and TRP3_UF_DB.Target.colorBack.custom == false then
				TargetFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:SetVertexColor(0, 0, 1, 1)
			end

		end
		if UnitIsPlayer("target") == false and TRP3_UF_DB.Setting.NPCs == true then
			TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetTextColor(TRP3_UF_DB.Target.colorText.r, TRP3_UF_DB.Target.colorText.g, TRP3_UF_DB.Target.colorText.b)
			TargetFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:SetVertexColor(TRP3_UF_DB.Target.colorBack.r, TRP3_UF_DB.Target.colorBack.g, TRP3_UF_DB.Target.colorBack.b, TRP3_UF_DB.Target.colorBack.a)
		end
	end

	TRP3_API.RegisterCallback(TRP3_Addon, "REGISTER_DATA_UPDATED", trpPlayer.UpdateInfo)
	TRP3_API.RegisterCallback(TRP3_Addon, "REGISTER_DATA_UPDATED", trpTarget.UpdateInfo)

	local SETTINGS_PAGE_ID = "main_unitframesplugin";
	local SETTINGS_MENU_ID = "main_91_config_main_config_unitframesplugin";

	local bingusPluginThing = TRP3_UFSettingsFrame

	TRP3_API.navigation.page.registerPage({
		id = SETTINGS_PAGE_ID,
		frame = bingusPluginThing,
	});

	TRP3_API.navigation.menu.registerMenu({
		id = SETTINGS_MENU_ID,
		text = TRP3_API.utils.Oldgodify(L["PluginColored"]),
		isChildOf = "main_90_config",
		onSelected = function() TRP3_API.navigation.page.setPage(SETTINGS_PAGE_ID); end,
	});

end


local totalRP3_UnitFrames = {
    ["name"] = "Total RP 3: Unit Frames",
    ["description"] = "Modifies the target and player frames to have some additional profile info.",
    ["version"] = 1.3, -- Your version number
    ["id"] = "trp3_unitframes", -- Your module ID
    ["onStart"] = onStart, -- Your starting function
    ["minVersion"] = 108, -- Whatever TRP3 minimum build you require, 108 was the current one
};

TRP3_API.module.registerModule(totalRP3_UnitFrames);