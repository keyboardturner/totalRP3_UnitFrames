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

	Setting = {locked = true, charSpecific = false, NPCs = false},
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

------------------------------------------------------------------------------------------------------------------

local trpTarget, trpPlayer
trpTarget = CreateFrame("Frame")
trpPlayer = CreateFrame("Frame")

local VERSION_TEXT = string.format(TRP3_API.loc.CREDITS_VERSION_TEXT, GetAddOnMetadata("totalRP3_UnitFrames", "Version"));
local TRP3_UFPanel = CreateFrame("Frame");
TRP3_UFPanel.name = "Total RP 3: Unit Frames";

TRP3_UFPanel.Headline = TRP3_UFPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal");
TRP3_UFPanel.Headline:SetFont(TRP3_UFPanel.Headline:GetFont(), 23);
TRP3_UFPanel.Headline:SetTextColor(1,.73,0,1);
TRP3_UFPanel.Headline:ClearAllPoints();
TRP3_UFPanel.Headline:SetPoint("TOPLEFT", TRP3_UFPanel, "TOPLEFT",12,-12);
TRP3_UFPanel.Headline:SetText("|cffF5038BTotal RP 3|r|cffffffff: Unit Frames|r");

TRP3_UFPanel.Version = TRP3_UFPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal");
TRP3_UFPanel.Version:SetFont(TRP3_UFPanel.Version:GetFont(), 12);
TRP3_UFPanel.Version:SetTextColor(1,1,1,1);
TRP3_UFPanel.Version:ClearAllPoints();
TRP3_UFPanel.Version:SetPoint("TOPLEFT", TRP3_UFPanel, "TOPLEFT",400,-21);
TRP3_UFPanel.Version:SetText(VERSION_TEXT);


------------------------------------------------------------------------------------------------------------------
--position presets
TRP3_UFPanel.Pf = CreateFrame("Frame", nil, TRP3_UFPanel)
TRP3_UFPanel.Pf:ClearAllPoints();
TRP3_UFPanel.Pf:SetPoint("TOPLEFT", TRP3_UFPanel, "TOPLEFT", 12, -53*2);
TRP3_UFPanel.Pf:SetSize(64, 64)

TRP3_UFPanel.Pf.tex = TRP3_UFPanel.Pf:CreateTexture()
TRP3_UFPanel.Pf.tex:SetAllPoints(TRP3_UFPanel.Pf)
SetPortraitTexture(TRP3_UFPanel.Pf.tex, "player")

TRP3_UFPanel.Pf.radioTopLeft = CreateFrame("CheckButton", nil, TRP3_UFPanel.Pf, "UIRadioButtonTemplate")
TRP3_UFPanel.Pf.radioTop = CreateFrame("CheckButton", nil, TRP3_UFPanel.Pf, "UIRadioButtonTemplate")
TRP3_UFPanel.Pf.radioTopRight = CreateFrame("CheckButton", nil, TRP3_UFPanel.Pf, "UIRadioButtonTemplate")
TRP3_UFPanel.Pf.radioLeft = CreateFrame("CheckButton", nil, TRP3_UFPanel.Pf, "UIRadioButtonTemplate")
TRP3_UFPanel.Pf.radioCenter = CreateFrame("CheckButton", nil, TRP3_UFPanel.Pf, "UIRadioButtonTemplate")
TRP3_UFPanel.Pf.radioRight = CreateFrame("CheckButton", nil, TRP3_UFPanel.Pf, "UIRadioButtonTemplate")
TRP3_UFPanel.Pf.radioBottomLeft = CreateFrame("CheckButton", nil, TRP3_UFPanel.Pf, "UIRadioButtonTemplate")
TRP3_UFPanel.Pf.radioBottom = CreateFrame("CheckButton", nil, TRP3_UFPanel.Pf, "UIRadioButtonTemplate")
TRP3_UFPanel.Pf.radioBottomRight = CreateFrame("CheckButton", nil, TRP3_UFPanel.Pf, "UIRadioButtonTemplate")

TRP3_UFPanel.Pf.radioTopLeft:SetChecked(false)
TRP3_UFPanel.Pf.radioTop:SetChecked(false)
TRP3_UFPanel.Pf.radioTopRight:SetChecked(false)
TRP3_UFPanel.Pf.radioLeft:SetChecked(false)
TRP3_UFPanel.Pf.radioCenter:SetChecked(false)
TRP3_UFPanel.Pf.radioRight:SetChecked(false)
TRP3_UFPanel.Pf.radioBottomLeft:SetChecked(false)
TRP3_UFPanel.Pf.radioBottom:SetChecked(false)
TRP3_UFPanel.Pf.radioBottomRight:SetChecked(true)

TRP3_UFPanel.Pf.radioTopLeft:SetPoint("CENTER", TRP3_UFPanel.Pf, "TOPLEFT", 0, 0)
TRP3_UFPanel.Pf.radioTop:SetPoint("CENTER", TRP3_UFPanel.Pf, "TOP", 0, 0)
TRP3_UFPanel.Pf.radioTopRight:SetPoint("CENTER", TRP3_UFPanel.Pf, "TOPRIGHT", 0, 0)
TRP3_UFPanel.Pf.radioLeft:SetPoint("CENTER", TRP3_UFPanel.Pf, "LEFT", 0, 0)
TRP3_UFPanel.Pf.radioCenter:SetPoint("CENTER", TRP3_UFPanel.Pf, "CENTER", 0, 0)
TRP3_UFPanel.Pf.radioRight:SetPoint("CENTER", TRP3_UFPanel.Pf, "RIGHT", 0, 0)
TRP3_UFPanel.Pf.radioBottomLeft:SetPoint("CENTER", TRP3_UFPanel.Pf, "BOTTOMLEFT", 0, 0)
TRP3_UFPanel.Pf.radioBottom:SetPoint("CENTER", TRP3_UFPanel.Pf, "BOTTOM", 0, 0)
TRP3_UFPanel.Pf.radioBottomRight:SetPoint("CENTER", TRP3_UFPanel.Pf, "BOTTOMRIGHT", 0, 0)

TRP3_UFPanel.Pf.TitleText = TRP3_UFPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal");
TRP3_UFPanel.Pf.TitleText:SetFont(TRP3_UFPanel.Pf.TitleText:GetFont(), 12);
TRP3_UFPanel.Pf.TitleText:SetTextColor(1,1,1,1);
TRP3_UFPanel.Pf.TitleText:ClearAllPoints();
TRP3_UFPanel.Pf.TitleText:SetPoint("BOTTOM", TRP3_UFPanel.Pf, "TOP",0,10);
TRP3_UFPanel.Pf.TitleText:SetText(PLAYER);

TRP3_UFPanel.Pf.allRadios = {
	TRP3_UFPanel.Pf.radioTopLeft,
	TRP3_UFPanel.Pf.radioTop,
	TRP3_UFPanel.Pf.radioTopRight,
	TRP3_UFPanel.Pf.radioLeft,
	TRP3_UFPanel.Pf.radioCenter,
	TRP3_UFPanel.Pf.radioRight,
	TRP3_UFPanel.Pf.radioBottomLeft,
	TRP3_UFPanel.Pf.radioBottom,
	TRP3_UFPanel.Pf.radioBottomRight
};

function TRP3_UFPanel.Pf.createOnRadioClicked (location)
	local function onRadioClicked (self, a, b, c)
		local checked = self:GetChecked()
		PlaySound(PlaySoundKitID and "igMainMenuOptionCheckBoxOn" or SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		TRP3_UF_DB.Player.relativePoint = location

		local anyChecked = false
		for _, radio in ipairs(TRP3_UFPanel.Pf.allRadios) do
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

TRP3_UFPanel.Pf.radioTopLeft:SetScript("OnClick", TRP3_UFPanel.Pf.createOnRadioClicked("TOPLEFT"))
TRP3_UFPanel.Pf.radioTop:SetScript("OnClick", TRP3_UFPanel.Pf.createOnRadioClicked("TOP"))
TRP3_UFPanel.Pf.radioTopRight:SetScript("OnClick", TRP3_UFPanel.Pf.createOnRadioClicked("TOPRIGHT"))
TRP3_UFPanel.Pf.radioLeft:SetScript("OnClick", TRP3_UFPanel.Pf.createOnRadioClicked("LEFT"))
TRP3_UFPanel.Pf.radioCenter:SetScript("OnClick", TRP3_UFPanel.Pf.createOnRadioClicked("CENTER"))
TRP3_UFPanel.Pf.radioRight:SetScript("OnClick", TRP3_UFPanel.Pf.createOnRadioClicked("RIGHT"))
TRP3_UFPanel.Pf.radioBottomLeft:SetScript("OnClick", TRP3_UFPanel.Pf.createOnRadioClicked("BOTTOMLEFT"))
TRP3_UFPanel.Pf.radioBottom:SetScript("OnClick", TRP3_UFPanel.Pf.createOnRadioClicked("BOTTOM"))
TRP3_UFPanel.Pf.radioBottomRight:SetScript("OnClick", TRP3_UFPanel.Pf.createOnRadioClicked("BOTTOMRIGHT"))



TRP3_UFPanel.Tf = CreateFrame("Frame", nil, TRP3_UFPanel)
TRP3_UFPanel.Tf:ClearAllPoints();
TRP3_UFPanel.Tf:SetPoint("TOPLEFT", TRP3_UFPanel, "TOPLEFT", 170*3, -53*2);
TRP3_UFPanel.Tf:SetSize(64, 64)

TRP3_UFPanel.Tf.tex = TRP3_UFPanel.Tf:CreateTexture()
TRP3_UFPanel.Tf.tex:SetAllPoints(TRP3_UFPanel.Tf)
SetPortraitTexture(TRP3_UFPanel.Tf.tex, "player")

function TRP3_UFPanel.OnShow()
	SetPortraitTexture(TRP3_UFPanel.Pf.tex, "player")
	SetPortraitTexture(TRP3_UFPanel.Tf.tex, "player")
end

TRP3_UFPanel:SetScript("OnShow",TRP3_UFPanel.OnShow);

TRP3_UFPanel.Tf.radioTopLeft = CreateFrame("CheckButton", nil, TRP3_UFPanel.Tf, "UIRadioButtonTemplate")
TRP3_UFPanel.Tf.radioTop = CreateFrame("CheckButton", nil, TRP3_UFPanel.Tf, "UIRadioButtonTemplate")
TRP3_UFPanel.Tf.radioTopRight = CreateFrame("CheckButton", nil, TRP3_UFPanel.Tf, "UIRadioButtonTemplate")
TRP3_UFPanel.Tf.radioLeft = CreateFrame("CheckButton", nil, TRP3_UFPanel.Tf, "UIRadioButtonTemplate")
TRP3_UFPanel.Tf.radioCenter = CreateFrame("CheckButton", nil, TRP3_UFPanel.Tf, "UIRadioButtonTemplate")
TRP3_UFPanel.Tf.radioRight = CreateFrame("CheckButton", nil, TRP3_UFPanel.Tf, "UIRadioButtonTemplate")
TRP3_UFPanel.Tf.radioBottomLeft = CreateFrame("CheckButton", nil, TRP3_UFPanel.Tf, "UIRadioButtonTemplate")
TRP3_UFPanel.Tf.radioBottom = CreateFrame("CheckButton", nil, TRP3_UFPanel.Tf, "UIRadioButtonTemplate")
TRP3_UFPanel.Tf.radioBottomRight = CreateFrame("CheckButton", nil, TRP3_UFPanel.Tf, "UIRadioButtonTemplate")

TRP3_UFPanel.Tf.radioTopLeft:SetChecked(false)
TRP3_UFPanel.Tf.radioTop:SetChecked(false)
TRP3_UFPanel.Tf.radioTopRight:SetChecked(false)
TRP3_UFPanel.Tf.radioLeft:SetChecked(false)
TRP3_UFPanel.Tf.radioCenter:SetChecked(false)
TRP3_UFPanel.Tf.radioRight:SetChecked(false)
TRP3_UFPanel.Tf.radioBottomLeft:SetChecked(true)
TRP3_UFPanel.Tf.radioBottom:SetChecked(false)
TRP3_UFPanel.Tf.radioBottomRight:SetChecked(false)

TRP3_UFPanel.Tf.radioTopLeft:SetPoint("CENTER", TRP3_UFPanel.Tf, "TOPLEFT", 0, 0)
TRP3_UFPanel.Tf.radioTop:SetPoint("CENTER", TRP3_UFPanel.Tf, "TOP", 0, 0)
TRP3_UFPanel.Tf.radioTopRight:SetPoint("CENTER", TRP3_UFPanel.Tf, "TOPRIGHT", 0, 0)
TRP3_UFPanel.Tf.radioLeft:SetPoint("CENTER", TRP3_UFPanel.Tf, "LEFT", 0, 0)
TRP3_UFPanel.Tf.radioCenter:SetPoint("CENTER", TRP3_UFPanel.Tf, "CENTER", 0, 0)
TRP3_UFPanel.Tf.radioRight:SetPoint("CENTER", TRP3_UFPanel.Tf, "RIGHT", 0, 0)
TRP3_UFPanel.Tf.radioBottomLeft:SetPoint("CENTER", TRP3_UFPanel.Tf, "BOTTOMLEFT", 0, 0)
TRP3_UFPanel.Tf.radioBottom:SetPoint("CENTER", TRP3_UFPanel.Tf, "BOTTOM", 0, 0)
TRP3_UFPanel.Tf.radioBottomRight:SetPoint("CENTER", TRP3_UFPanel.Tf, "BOTTOMRIGHT", 0, 0)

TRP3_UFPanel.Tf.TitleText = TRP3_UFPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal");
TRP3_UFPanel.Tf.TitleText:SetFont(TRP3_UFPanel.Tf.TitleText:GetFont(), 12);
TRP3_UFPanel.Tf.TitleText:SetTextColor(1,1,1,1);
TRP3_UFPanel.Tf.TitleText:ClearAllPoints();
TRP3_UFPanel.Tf.TitleText:SetPoint("BOTTOM", TRP3_UFPanel.Tf, "TOP",0,10);
TRP3_UFPanel.Tf.TitleText:SetText(TARGET);

TRP3_UFPanel.Tf.allRadios = {
	TRP3_UFPanel.Tf.radioTopLeft,
	TRP3_UFPanel.Tf.radioTop,
	TRP3_UFPanel.Tf.radioTopRight,
	TRP3_UFPanel.Tf.radioLeft,
	TRP3_UFPanel.Tf.radioCenter,
	TRP3_UFPanel.Tf.radioRight,
	TRP3_UFPanel.Tf.radioBottomLeft,
	TRP3_UFPanel.Tf.radioBottom,
	TRP3_UFPanel.Tf.radioBottomRight
}

function TRP3_UFPanel.Tf.createOnRadioClicked (location)
	local function onRadioClicked (self, a, b, c)
		local checked = self:GetChecked()
		PlaySound(PlaySoundKitID and "igMainMenuOptionCheckBoxOn" or SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		TRP3_UF_DB.Target.relativePoint = location

		local anyChecked = false
		for _, radio in ipairs(TRP3_UFPanel.Tf.allRadios) do
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

TRP3_UFPanel.Tf.radioTopLeft:SetScript("OnClick", TRP3_UFPanel.Tf.createOnRadioClicked("TOPLEFT"))
TRP3_UFPanel.Tf.radioTop:SetScript("OnClick", TRP3_UFPanel.Tf.createOnRadioClicked("TOP"))
TRP3_UFPanel.Tf.radioTopRight:SetScript("OnClick", TRP3_UFPanel.Tf.createOnRadioClicked("TOPRIGHT"))
TRP3_UFPanel.Tf.radioLeft:SetScript("OnClick", TRP3_UFPanel.Tf.createOnRadioClicked("LEFT"))
TRP3_UFPanel.Tf.radioCenter:SetScript("OnClick", TRP3_UFPanel.Tf.createOnRadioClicked("CENTER"))
TRP3_UFPanel.Tf.radioRight:SetScript("OnClick", TRP3_UFPanel.Tf.createOnRadioClicked("RIGHT"))
TRP3_UFPanel.Tf.radioBottomLeft:SetScript("OnClick", TRP3_UFPanel.Tf.createOnRadioClicked("BOTTOMLEFT"))
TRP3_UFPanel.Tf.radioBottom:SetScript("OnClick", TRP3_UFPanel.Tf.createOnRadioClicked("BOTTOM"))
TRP3_UFPanel.Tf.radioBottomRight:SetScript("OnClick", TRP3_UFPanel.Tf.createOnRadioClicked("BOTTOMRIGHT"))

------------------------------------------------------------------------------------------------------------------

--UI-HUD-UnitFrame-Target-PortraitOn-Type
TRP3_UFPanel.PColor = CreateFrame("Button", nil, TRP3_UFPanel)
TRP3_UFPanel.PColor:SetPoint("TOPLEFT", TRP3_UFPanel, "TOPLEFT", 100, -53*2)
TRP3_UFPanel.PColor:SetWidth(135)
TRP3_UFPanel.PColor:SetHeight(18)
TRP3_UFPanel.PColor.tex = TRP3_UFPanel.PColor:CreateTexture("TRP3_UFRepDummyPlayer", "ARTWORK", nil, 1)
TRP3_UFPanel.PColor.tex:SetAllPoints(TRP3_UFPanel.PColor)
TRP3_UFPanel.PColor.tex:SetAtlas("UI-HUD-UnitFrame-Target-PortraitOn-Type")
TRP3_UFPanel.PColor.tex:SetTexCoord(1, 0, 0, 1)

TRP3_UFPanel.PColor.Name = TRP3_UFPanel.PColor:CreateFontString("TRP3_UFRepTextDummyPlayer", "OVERLAY", "GameFontNormal");
TRP3_UFPanel.PColor.Name:SetFont(TRP3_UFPanel.PColor.Name:GetFont(), 12);
TRP3_UFPanel.PColor.Name:SetTextColor(1,1,1,1);
TRP3_UFPanel.PColor.Name:ClearAllPoints();
TRP3_UFPanel.PColor.Name:SetPoint("TOP", TRP3_UFPanel.PColor, "TOP",0,0);
TRP3_UFPanel.PColor.Name:SetText(PLAYER);


TRP3_UFPanel.TColor = CreateFrame("Button", nil, TRP3_UFPanel)
TRP3_UFPanel.TColor:SetPoint("TOPLEFT", TRP3_UFPanel, "TOPLEFT", 170*2, -53*2)
TRP3_UFPanel.TColor:SetWidth(135)
TRP3_UFPanel.TColor:SetHeight(18)
TRP3_UFPanel.TColor.tex = TRP3_UFPanel.TColor:CreateTexture("TRP3_UFRepDummyTarget", "ARTWORK", nil, 1)
TRP3_UFPanel.TColor.tex:SetAllPoints(TRP3_UFPanel.TColor)
TRP3_UFPanel.TColor.tex:SetAtlas("UI-HUD-UnitFrame-Target-PortraitOn-Type")

TRP3_UFPanel.TColor.Name = TRP3_UFPanel.TColor:CreateFontString("TRP3_UFRepTextDummyTarget", "OVERLAY", "GameFontNormal");
TRP3_UFPanel.TColor.Name:SetFont(TRP3_UFPanel.TColor.Name:GetFont(), 12);
TRP3_UFPanel.TColor.Name:SetTextColor(1,1,1,1);
TRP3_UFPanel.TColor.Name:ClearAllPoints();
TRP3_UFPanel.TColor.Name:SetPoint("TOP", TRP3_UFPanel.TColor, "TOP",0,0);
TRP3_UFPanel.TColor.Name:SetText(TARGET);


--PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture:SetVertexColor(0,1,1) -- the glowy highlight texture when rested
--PlayerFrame.PlayerFrameContainer.FrameTexture:SetVertexColor(0,1,1) -- player border colors
--TRP3_UFPanel.TColor.tex:SetTexCoord(-.08, 1.08, -.08, 1.08)
--TRP3_UFPanel.TColor:SetNormalAtlas("chatframe-button-up")
--TRP3_UFPanel.TColor:SetPushedAtlas("chatframe-button-down")
--TRP3_UFPanel.TColor:SetHighlightAtlas("chatframe-button-highlight")


------------------------------------------------------------------------------------------------------------------

TRP3_UFPanel.VisibilityText = TRP3_UFPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal");
TRP3_UFPanel.VisibilityText:SetFont(TRP3_UFPanel.VisibilityText:GetFont(), 15);
TRP3_UFPanel.VisibilityText:SetTextColor(1,1,1,1);
TRP3_UFPanel.VisibilityText:ClearAllPoints();
TRP3_UFPanel.VisibilityText:SetPoint("TOPLEFT", 5, -53*3.7);
TRP3_UFPanel.VisibilityText:SetText("Visibility");


TRP3_UFPanel.PShowCheckbox = CreateFrame("CheckButton", "TRP3_UFPShowCheckbox", TRP3_UFPanel, "UICheckButtonTemplate");
TRP3_UFPanel.PShowCheckbox:ClearAllPoints();
TRP3_UFPanel.PShowCheckbox:SetPoint("TOPLEFT", 5, -53*4);
getglobal(TRP3_UFPanel.PShowCheckbox:GetName().."Text"):SetText("Show Player Button");

TRP3_UFPanel.PShowCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.PShowCheckbox:GetChecked() then
		TRP3_UF_DB.Player.show = true;
		trpPlayer.SetVisible()
	else
		TRP3_UF_DB.Player.show = false;
		trpPlayer.SetVisible()
	end
end);


TRP3_UFPanel.TShowCheckbox = CreateFrame("CheckButton", "TRP3_UFTShowCheckbox", TRP3_UFPanel, "UICheckButtonTemplate");
TRP3_UFPanel.TShowCheckbox:ClearAllPoints();
TRP3_UFPanel.TShowCheckbox:SetPoint("TOPLEFT", 5, -53*4.5);
getglobal(TRP3_UFPanel.TShowCheckbox:GetName().."Text"):SetText("Show Target Button");

TRP3_UFPanel.TShowCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.TShowCheckbox:GetChecked() then
		TRP3_UF_DB.Target.show = true;
		trpPlayer.SetVisible()
	else
		TRP3_UF_DB.Target.show = false;
		trpPlayer.SetVisible()
	end
end);


TRP3_UFPanel.PortShowCheckbox = CreateFrame("CheckButton", "TRP3_UFPortShowCheckbox", TRP3_UFPanel, "UICheckButtonTemplate");
TRP3_UFPanel.PortShowCheckbox:ClearAllPoints();
TRP3_UFPanel.PortShowCheckbox:SetPoint("TOPLEFT", 5, -53*5);
getglobal(TRP3_UFPanel.PortShowCheckbox:GetName().."Text"):SetText("Show Border Frame");

TRP3_UFPanel.PortShowCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.PortShowCheckbox:GetChecked() then
		TRP3_UF_DB.Border.show = true;
		TRP3_UFPanel.PortraitButton:SetEnabled(TRP3_UF_DB.Border.show);
		PlayerDragonFrame:Show();
	else
		TRP3_UF_DB.Border.show = false;
		TRP3_UFPanel.PortraitButton:SetEnabled(TRP3_UF_DB.Border.show);
		PlayerDragonFrame:Hide();
	end
end);


TRP3_UFPanel.StatusHideCheckbox = CreateFrame("CheckButton", "TRP3_UFStatusHideCheckbox", TRP3_UFPanel, "UICheckButtonTemplate");
TRP3_UFPanel.StatusHideCheckbox:ClearAllPoints();
TRP3_UFPanel.StatusHideCheckbox:SetPoint("TOPLEFT", 5, -53*5.5);
getglobal(TRP3_UFPanel.StatusHideCheckbox:GetName().."Text"):SetText("Hide Rested Glow - incomplete");

TRP3_UFPanel.StatusHideCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.StatusHideCheckbox:GetChecked() then
		TRP3_UF_DB.Border.status = true;
		PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture:Hide()
	else
		TRP3_UF_DB.Border.status = false;
		PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture:Show()
	end
end);

------------------------------------------------------------------------------------------------------------------

TRP3_UFPanel.TargetSizeSlider = CreateFrame("Slider", "TRP3_UFTargetSizeSlider", TRP3_UFPanel, "OptionsSliderTemplate");
TRP3_UFPanel.TargetSizeSlider:SetWidth(250);
TRP3_UFPanel.TargetSizeSlider:SetHeight(15);
TRP3_UFPanel.TargetSizeSlider:SetMinMaxValues(0.1,15);
TRP3_UFPanel.TargetSizeSlider:SetValueStep(.5);
TRP3_UFPanel.TargetSizeSlider:SetObeyStepOnDrag(true)
TRP3_UFPanel.TargetSizeSlider:ClearAllPoints();
TRP3_UFPanel.TargetSizeSlider:SetPoint("TOPLEFT", TRP3_UFPanel, "TOPLEFT", 5, -53*6.75);
getglobal(TRP3_UFPanel.TargetSizeSlider:GetName() .. 'Low'):SetText('0.1');
getglobal(TRP3_UFPanel.TargetSizeSlider:GetName() .. 'High'):SetText('15');
getglobal(TRP3_UFPanel.TargetSizeSlider:GetName() .. 'Text'):SetText('Target Button Size');
TRP3_UFPanel.TargetSizeSlider:SetScript("OnValueChanged", function()
	local scaleValue = getglobal(TRP3_UFPanel.TargetSizeSlider:GetName()):GetValue();
	TRP3_UF_DB.Target.scale = scaleValue;
	trpTarget.button:SetScale(TRP3_UF_DB.Target.scale)
end)


TRP3_UFPanel.TargetPosSlider = CreateFrame("Slider", "TRP3_UFTargetPosSlider", TRP3_UFPanel, "OptionsSliderTemplate");
TRP3_UFPanel.TargetPosSlider:SetWidth(250);
TRP3_UFPanel.TargetPosSlider:SetHeight(15);
TRP3_UFPanel.TargetPosSlider:SetMinMaxValues(0,15);
TRP3_UFPanel.TargetPosSlider:SetValueStep(.5);
TRP3_UFPanel.TargetPosSlider:SetObeyStepOnDrag(true)
TRP3_UFPanel.TargetPosSlider:ClearAllPoints();
TRP3_UFPanel.TargetPosSlider:SetPoint("TOPLEFT", TRP3_UFPanel, "TOPLEFT", 5, -53*7.5);
getglobal(TRP3_UFPanel.TargetPosSlider:GetName() .. 'Low'):SetText('0');
getglobal(TRP3_UFPanel.TargetPosSlider:GetName() .. 'High'):SetText('15');
getglobal(TRP3_UFPanel.TargetPosSlider:GetName() .. 'Text'):SetText('Target Button Position');
TRP3_UFPanel.TargetPosSlider:SetScript("OnValueChanged", function()
	local scaleValue = getglobal(TRP3_UFPanel.TargetPosSlider:GetName()):GetValue();
	TRP3_UF_DB.Target.position = scaleValue;
	trpTarget.SetPos()
end)


TRP3_UFPanel.PlayerSizeSlider = CreateFrame("Slider", "TRP3_UFPlayerSizeSlider", TRP3_UFPanel, "OptionsSliderTemplate");
TRP3_UFPanel.PlayerSizeSlider:SetWidth(250);
TRP3_UFPanel.PlayerSizeSlider:SetHeight(15);
TRP3_UFPanel.PlayerSizeSlider:SetMinMaxValues(0.1,15);
TRP3_UFPanel.PlayerSizeSlider:SetValueStep(.5);
TRP3_UFPanel.PlayerSizeSlider:SetObeyStepOnDrag(true)
TRP3_UFPanel.PlayerSizeSlider:ClearAllPoints();
TRP3_UFPanel.PlayerSizeSlider:SetPoint("TOPLEFT", TRP3_UFPanel, "TOPLEFT", 5, -53*8.25);
getglobal(TRP3_UFPanel.PlayerSizeSlider:GetName() .. 'Low'):SetText('0.1');
getglobal(TRP3_UFPanel.PlayerSizeSlider:GetName() .. 'High'):SetText('15');
getglobal(TRP3_UFPanel.PlayerSizeSlider:GetName() .. 'Text'):SetText('Player Button Size');
TRP3_UFPanel.PlayerSizeSlider:SetScript("OnValueChanged", function()
	local scaleValue = getglobal(TRP3_UFPanel.PlayerSizeSlider:GetName()):GetValue();
	TRP3_UF_DB.Player.scale = scaleValue;
	trpPlayer.button:SetScale(TRP3_UF_DB.Player.scale)
end)


TRP3_UFPanel.PlayerPosSlider = CreateFrame("Slider", "TRP3_UFPlayerPosSlider", TRP3_UFPanel, "OptionsSliderTemplate");
TRP3_UFPanel.PlayerPosSlider:SetWidth(250);
TRP3_UFPanel.PlayerPosSlider:SetHeight(15);
TRP3_UFPanel.PlayerPosSlider:SetMinMaxValues(0,15);
TRP3_UFPanel.PlayerPosSlider:SetValueStep(.5);
TRP3_UFPanel.PlayerPosSlider:SetObeyStepOnDrag(true)
TRP3_UFPanel.PlayerPosSlider:ClearAllPoints();
TRP3_UFPanel.PlayerPosSlider:SetPoint("TOPLEFT", TRP3_UFPanel, "TOPLEFT", 5, -53*9);
getglobal(TRP3_UFPanel.PlayerPosSlider:GetName() .. 'Low'):SetText('0');
getglobal(TRP3_UFPanel.PlayerPosSlider:GetName() .. 'High'):SetText('15');
getglobal(TRP3_UFPanel.PlayerPosSlider:GetName() .. 'Text'):SetText('Player Button Position');
TRP3_UFPanel.PlayerPosSlider:SetScript("OnValueChanged", function()
	local scaleValue = getglobal(TRP3_UFPanel.PlayerPosSlider:GetName()):GetValue();
	TRP3_UF_DB.Player.position = scaleValue;
	trpPlayer.SetPos()
end)

------------------------------------------------------------------------------------------------------------------

TRP3_UFPanel.ColorsText = TRP3_UFPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal");
TRP3_UFPanel.ColorsText:SetFont(TRP3_UFPanel.ColorsText:GetFont(), 15);
TRP3_UFPanel.ColorsText:SetTextColor(1,1,1,1);
TRP3_UFPanel.ColorsText:ClearAllPoints();
TRP3_UFPanel.ColorsText:SetPoint("TOPLEFT", 300, -53*3.7);
TRP3_UFPanel.ColorsText:SetText("Colors");

TRP3_UFPanel.ColorsTarText = TRP3_UFPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal");
TRP3_UFPanel.ColorsTarText:SetFont(TRP3_UFPanel.ColorsTarText:GetFont(), 12);
TRP3_UFPanel.ColorsTarText:SetTextColor(1,1,1,1);
TRP3_UFPanel.ColorsTarText:ClearAllPoints();
TRP3_UFPanel.ColorsTarText:SetPoint("TOPLEFT", 300, -53*4.2);
TRP3_UFPanel.ColorsTarText:SetText("Target Frame");

TRP3_UFPanel.ColorsPlayerText = TRP3_UFPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal");
TRP3_UFPanel.ColorsPlayerText:SetFont(TRP3_UFPanel.ColorsPlayerText:GetFont(), 12);
TRP3_UFPanel.ColorsPlayerText:SetTextColor(1,1,1,1);
TRP3_UFPanel.ColorsPlayerText:ClearAllPoints();
TRP3_UFPanel.ColorsPlayerText:SetPoint("TOPLEFT", 300, -53*6.7);
TRP3_UFPanel.ColorsPlayerText:SetText("Player Frame");

TRP3_UFPanel.NPCOptions = TRP3_UFPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal");
TRP3_UFPanel.NPCOptions:SetFont(TRP3_UFPanel.NPCOptions:GetFont(), 12);
TRP3_UFPanel.NPCOptions:SetTextColor(1,1,1,1);
TRP3_UFPanel.NPCOptions:ClearAllPoints();
TRP3_UFPanel.NPCOptions:SetPoint("TOPLEFT", 300, -53*9.2);
TRP3_UFPanel.NPCOptions:SetText("Non-RP / NPCs");


TRP3_UFPanel.TargetTextColorCheckbox = CreateFrame("CheckButton", "TRP3_UFTargetTextColorCheckbox", TRP3_UFPanel, "UICheckButtonTemplate");
TRP3_UFPanel.TargetTextColorCheckbox:ClearAllPoints();
TRP3_UFPanel.TargetTextColorCheckbox:SetPoint("TOPLEFT", 300, -53*4.5);
getglobal(TRP3_UFPanel.TargetTextColorCheckbox:GetName().."Text"):SetText("Overwrite Text Color");

TRP3_UFPanel.TargetTextColorCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.TargetTextColorCheckbox:GetChecked() then
		TRP3_UF_DB.Target.colorText.custom = true;
	else
		TRP3_UF_DB.Target.colorText.custom = false;
	end
	TRP3_UFPanel.TarCustomTextColButton:SetEnabled(TRP3_UF_DB.Target.colorText.custom);
	trpPlayer.UpdateInfo()
	trpTarget.UpdateInfo()
end);


TRP3_UFPanel.TargetBackColorCheckbox = CreateFrame("CheckButton", "TRP3_UFTargetBackColorCheckbox", TRP3_UFPanel, "UICheckButtonTemplate");
TRP3_UFPanel.TargetBackColorCheckbox:ClearAllPoints();
TRP3_UFPanel.TargetBackColorCheckbox:SetPoint("TOPLEFT", 300, -53*5);
getglobal(TRP3_UFPanel.TargetBackColorCheckbox:GetName().."Text"):SetText("Overwrite Backdrop Color");

TRP3_UFPanel.TargetBackColorCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.TargetBackColorCheckbox:GetChecked() then
		TRP3_UF_DB.Target.colorBack.custom = true;
	else
		TRP3_UF_DB.Target.colorBack.custom = false;
	end
	TRP3_UFPanel.TarCustomBackColButton:SetEnabled(TRP3_UF_DB.Target.colorBack.custom);
	trpPlayer.UpdateInfo()
	trpTarget.UpdateInfo()
end);


TRP3_UFPanel.TargetClassTextColorCheckbox = CreateFrame("CheckButton", "TRP3_UFTargetClassTextColorCheckbox", TRP3_UFPanel, "UICheckButtonTemplate");
TRP3_UFPanel.TargetClassTextColorCheckbox:ClearAllPoints();
TRP3_UFPanel.TargetClassTextColorCheckbox:SetPoint("TOPLEFT", 300, -53*5.5);
getglobal(TRP3_UFPanel.TargetClassTextColorCheckbox:GetName().."Text"):SetText("Use Blizzard Class Color - Text");

TRP3_UFPanel.TargetClassTextColorCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.TargetClassTextColorCheckbox:GetChecked() then
		TRP3_UF_DB.Target.colorText.class = true;
	else
		TRP3_UF_DB.Target.colorText.class = false;
	end
	trpPlayer.UpdateInfo()
	trpTarget.UpdateInfo()
end);


TRP3_UFPanel.TargetClassBackColorCheckbox = CreateFrame("CheckButton", "TRP3_UFTargetClassBackColorCheckbox", TRP3_UFPanel, "UICheckButtonTemplate");
TRP3_UFPanel.TargetClassBackColorCheckbox:ClearAllPoints();
TRP3_UFPanel.TargetClassBackColorCheckbox:SetPoint("TOPLEFT", 300, -53*6);
getglobal(TRP3_UFPanel.TargetClassBackColorCheckbox:GetName().."Text"):SetText("Use Blizzard Class Color - Backdrop");

TRP3_UFPanel.TargetClassBackColorCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.TargetClassBackColorCheckbox:GetChecked() then
		TRP3_UF_DB.Target.colorBack.class = true;
	else
		TRP3_UF_DB.Target.colorBack.class = false;
	end
	trpPlayer.UpdateInfo()
	trpTarget.UpdateInfo()
end);


--player
TRP3_UFPanel.PlayerTextColorCheckbox = CreateFrame("CheckButton", "TRP3_UFPlayerTextColorCheckbox", TRP3_UFPanel, "UICheckButtonTemplate");
TRP3_UFPanel.PlayerTextColorCheckbox:ClearAllPoints();
TRP3_UFPanel.PlayerTextColorCheckbox:SetPoint("TOPLEFT", 300, -53*7);
getglobal(TRP3_UFPanel.PlayerTextColorCheckbox:GetName().."Text"):SetText("Overwrite Text Color");

TRP3_UFPanel.PlayerTextColorCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.PlayerTextColorCheckbox:GetChecked() then
		TRP3_UF_DB.Player.colorText.custom = true;
	else
		TRP3_UF_DB.Player.colorText.custom = false;
	end
	TRP3_UFPanel.PlayerCustomTextColButton:SetEnabled(TRP3_UF_DB.Player.colorText.custom);
	trpPlayer.UpdateInfo()
	trpTarget.UpdateInfo()
end);


TRP3_UFPanel.PlayerBackColorCheckbox = CreateFrame("CheckButton", "TRP3_UFPlayerBackColorCheckbox", TRP3_UFPanel, "UICheckButtonTemplate");
TRP3_UFPanel.PlayerBackColorCheckbox:ClearAllPoints();
TRP3_UFPanel.PlayerBackColorCheckbox:SetPoint("TOPLEFT", 300, -53*7.5);
getglobal(TRP3_UFPanel.PlayerBackColorCheckbox:GetName().."Text"):SetText("Overwrite Backdrop Color");

TRP3_UFPanel.PlayerBackColorCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.PlayerBackColorCheckbox:GetChecked() then
		TRP3_UF_DB.Player.colorBack.custom = true;
	else
		TRP3_UF_DB.Player.colorBack.custom = false;
	end
	TRP3_UFPanel.PlayerCustomBackColButton:SetEnabled(TRP3_UF_DB.Player.colorBack.custom);
	trpPlayer.UpdateInfo()
	trpTarget.UpdateInfo()
end);


TRP3_UFPanel.PlayerClassTextColorCheckbox = CreateFrame("CheckButton", "TRP3_UFPlayerClassTextColorCheckbox", TRP3_UFPanel, "UICheckButtonTemplate");
TRP3_UFPanel.PlayerClassTextColorCheckbox:ClearAllPoints();
TRP3_UFPanel.PlayerClassTextColorCheckbox:SetPoint("TOPLEFT", 300, -53*8);
getglobal(TRP3_UFPanel.PlayerClassTextColorCheckbox:GetName().."Text"):SetText("Use Blizzard Class Color - Text");

TRP3_UFPanel.PlayerClassTextColorCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.PlayerClassTextColorCheckbox:GetChecked() then
		TRP3_UF_DB.Player.colorText.class = true;
	else
		TRP3_UF_DB.Player.colorText.class = false;
	end
	trpPlayer.UpdateInfo()
	trpTarget.UpdateInfo()
end);


TRP3_UFPanel.PlayerClassBackColorCheckbox = CreateFrame("CheckButton", "TRP3_UFPlayerClassBackColorCheckbox", TRP3_UFPanel, "UICheckButtonTemplate");
TRP3_UFPanel.PlayerClassBackColorCheckbox:ClearAllPoints();
TRP3_UFPanel.PlayerClassBackColorCheckbox:SetPoint("TOPLEFT", 300, -53*8.5);
getglobal(TRP3_UFPanel.PlayerClassBackColorCheckbox:GetName().."Text"):SetText("Use Blizzard Class Color - Backdrop");

TRP3_UFPanel.PlayerClassBackColorCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.PlayerClassBackColorCheckbox:GetChecked() then
		TRP3_UF_DB.Player.colorBack.class = true;
	else
		TRP3_UF_DB.Player.colorBack.class = false;
	end
	trpPlayer.UpdateInfo()
	trpTarget.UpdateInfo()
end);


--other
TRP3_UFPanel.NPCOptionsCheckbox = CreateFrame("CheckButton", "TRP3_UFNPCOptionsCheckbox", TRP3_UFPanel, "UICheckButtonTemplate");
TRP3_UFPanel.NPCOptionsCheckbox:ClearAllPoints();
TRP3_UFPanel.NPCOptionsCheckbox:SetPoint("TOPLEFT", 300, -53*9.5);
getglobal(TRP3_UFPanel.NPCOptionsCheckbox:GetName().."Text"):SetText("Apply to NPCs & Non-RPers");

TRP3_UFPanel.NPCOptionsCheckbox:SetScript("OnClick", function(self)
	if TRP3_UFPanel.NPCOptionsCheckbox:GetChecked() then
		TRP3_UF_DB.Setting.NPCs = true;
	else
		TRP3_UF_DB.Setting.NPCs = false;
	end
	trpTarget.UpdateInfo()
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
	end
	if TRP3_UF_DB.Border.style == "rare-elite" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\uiunitframeboss2x")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(0.77734375, 0.390625, 0.001953125, 0.318359375) -- rare-elite
	end
	if TRP3_UF_DB.Border.style == "elite" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\uiunitframeboss2x")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", 8, -10)
		PlayerDragonFrame:SetSize(80, 79);
		PlayerDragonFrame.tex:SetTexCoord(0.3125, 0.001953125, 0.634765625, 0.947265625) -- elite
	end
	if TRP3_UF_DB.Border.style == "boss" then
		PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_UnitFrames\\tex\\uiunitframeboss2x")
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(0.388671875, 0.001953125, 0.001953125, 0.318359375) -- boss
	end
end

--PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", 8, -10)
--PlayerDragonFrame:SetSize(80, 79);
--PlayerDragonFrame.tex:SetTexCoord(0.314453125, 0.001953125, 0.322265625, 0.630859375) -- rare

PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
PlayerDragonFrame:SetSize(99, 81);
PlayerDragonFrame.tex:SetTexCoord(0.77734375, 0.390625, 0.001953125, 0.318359375) -- rare elite

--PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", 8, -10)
--PlayerDragonFrame:SetSize(80, 79);
--PlayerDragonFrame.tex:SetTexCoord(0.3125, 0.001953125, 0.634765625, 0.947265625) -- elite

--PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
--PlayerDragonFrame:SetSize(99, 81);
--PlayerDragonFrame.tex:SetTexCoord(0.388671875, 0.001953125, 0.001953125, 0.318359375) -- boss



--UI-HUD-UnitFrame-Target-PortraitOn-Type -- texture


------------------------------------------------------------------------------------------------------------------



TRP3_UFPanel.menu = {
	{ text = "Select an Option", isTitle = true},
	{ text = "Dragons", hasArrow = true,
		menuList = {
			{ text = ITEM_QUALITY3_DESC, func = function() TRP3_UF_DB.Border.style = "rare"; PlayerDragonFrame.TextureStuff(); end },
			{ text = ELITE, func = function() TRP3_UF_DB.Border.style = "elite"; PlayerDragonFrame.TextureStuff(); end },
			{ text = ITEM_QUALITY3_DESC .. " " .. ELITE, func = function() TRP3_UF_DB.Border.style = "rare-elite"; PlayerDragonFrame.TextureStuff(); end },
			{ text = BOSS, func = function() TRP3_UF_DB.Border.style = "boss"; PlayerDragonFrame.TextureStuff(); end },
		},
	},
	{ text = "Hearthstone", hasArrow = true,
		menuList = {
			{ text = "Coming Soon!", isTitle = true},
			--{ text = "Option 3", func = function() print("You've chosen option 3"); end },
		},
	},
	{ text = "Narcissus", hasArrow = true,
		menuList = {
			{ text = "Coming Soon!", isTitle = true},
			--{ text = "Option 3", func = function() print("You've chosen option 3"); end },
		},
	},
	--{ text = "PH Option 4", func = function() print("You've chosen option 4"); end },
	--{ text = "PH Option 5", func = function() print("You've chosen option 5"); end },
};
TRP3_UFPanel.menuFrame = CreateFrame("Frame", "TRP3PlayerPortraitMenuFrame", TRP3_UFPanel, "UIDropDownMenuTemplate")

TRP3_UFPanel.PortraitButton = CreateFrame("Button", nil, TRP3_UFPanel, "GameMenuButtonTemplate")
TRP3_UFPanel.PortraitButton:SetPoint("TOPLEFT", 150, -53*5.1);
--TRP3_UFPanel.PortraitButton:SetSize(99, 81);
TRP3_UFPanel.PortraitButton:SetText("Player Portrait")
TRP3_UFPanel.PortraitButton:SetScript("OnClick", function() EasyMenu(TRP3_UFPanel.menu, TRP3_UFPanel.menuFrame, "cursor", 0 , 0, "MENU", 10) end)

------------------------------------------------------------------------------------------------------------------

TRP3_UFPanel.TarCustomTextColButton = CreateFrame("Button", nil, TRP3_UFPanel, "GameMenuButtonTemplate")
TRP3_UFPanel.TarCustomTextColButton:SetPoint("TOPLEFT", 150*3.3, -53*4.6);
--TRP3_UFPanel.TarCustomTextColButton:SetSize(99, 81);
TRP3_UFPanel.TarCustomTextColButton:SetText("Color Picker")
TRP3_UFPanel.TarCustomTextColButton:SetScript("OnClick", function() ShowColorPicker(TRP3_UF_DB.Target.colorText.r, TRP3_UF_DB.Target.colorText.g, TRP3_UF_DB.Target.colorText.b, nil, TargetTextColor); end)

TRP3_UFPanel.TarCustomBackColButton = CreateFrame("Button", nil, TRP3_UFPanel, "GameMenuButtonTemplate")
TRP3_UFPanel.TarCustomBackColButton:SetPoint("TOPLEFT", 150*3.3, -53*5.1);
--TRP3_UFPanel.TarCustomBackColButton:SetSize(99, 81);
TRP3_UFPanel.TarCustomBackColButton:SetText("Color Picker")
TRP3_UFPanel.TarCustomBackColButton:SetScript("OnClick", function() ShowColorPicker(TRP3_UF_DB.Target.colorBack.r, TRP3_UF_DB.Target.colorBack.g, TRP3_UF_DB.Target.colorBack.b, TRP3_UF_DB.Target.colorBack.a, TargetBackdropColor); end)

TRP3_UFPanel.PlayerCustomTextColButton = CreateFrame("Button", nil, TRP3_UFPanel, "GameMenuButtonTemplate")
TRP3_UFPanel.PlayerCustomTextColButton:SetPoint("TOPLEFT", 150*3.3, -53*7.1);
--TRP3_UFPanel.PlayerCustomTextColButton:SetSize(99, 81);
TRP3_UFPanel.PlayerCustomTextColButton:SetText("Color Picker")
TRP3_UFPanel.PlayerCustomTextColButton:SetScript("OnClick", function() ShowColorPicker(TRP3_UF_DB.Player.colorText.r, TRP3_UF_DB.Player.colorText.g, TRP3_UF_DB.Player.colorText.b, nil, PlayerTextColor); end)

TRP3_UFPanel.PlayerCustomBackColButton = CreateFrame("Button", nil, TRP3_UFPanel, "GameMenuButtonTemplate")
TRP3_UFPanel.PlayerCustomBackColButton:SetPoint("TOPLEFT", 150*3.3, -53*7.6);
--TRP3_UFPanel.PlayerCustomBackColButton:SetSize(99, 81);
TRP3_UFPanel.PlayerCustomBackColButton:SetText("Color Picker")
TRP3_UFPanel.PlayerCustomBackColButton:SetScript("OnClick", function() ShowColorPicker(TRP3_UF_DB.Player.colorBack.r, TRP3_UF_DB.Player.colorBack.g, TRP3_UF_DB.Player.colorBack.b, TRP3_UF_DB.Player.colorBack.a, PlayerBackdropColor); end)

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
	if TRP3_UF_DB.Target.show == true then
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
		TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetText(TRP3_API.r.name("target"))
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

local function onStart()
	if not TRP3_UF_DB then
		TRP3_UF_DB = defaultsTable
	end

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
	trpPlayer:RegisterEvent("PLAYER_TARGET_CHANGED")
	trpPlayer:RegisterEvent("UNIT_TARGET")
	trpPlayer:RegisterEvent("PLAYER_REGEN_DISABLED")
	trpPlayer:RegisterEvent("PLAYER_REGEN_ENABLED")
	trpPlayer:RegisterEvent("PLAYER_LOGOUT")
	trpPlayer:RegisterEvent("PLAYER_ENTERING_WORLD")

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

	--show buttons
	TRP3_UFPanel.PShowCheckbox:SetChecked(TRP3_UF_DB.Player.show);
	TRP3_UFPanel.TShowCheckbox:SetChecked(TRP3_UF_DB.Target.show);
	trpPlayer.SetVisible()

	--player border portrait
	PlayerDragonFrame.TextureStuff()
	TRP3_UFPanel.PortShowCheckbox:SetChecked(TRP3_UF_DB.Border.show);
	TRP3_UFPanel.PortraitButton:SetEnabled(TRP3_UF_DB.Border.show);
	if TRP3_UF_DB.Border.show == true then
		PlayerDragonFrame:Show();
	else
		PlayerDragonFrame:Hide();
	end

	--color checkboxes
	TRP3_UFPanel.TargetTextColorCheckbox:SetChecked(TRP3_UF_DB.Target.colorText.custom);
	TRP3_UFPanel.TargetBackColorCheckbox:SetChecked(TRP3_UF_DB.Target.colorBack.custom);
	TRP3_UFPanel.TargetClassTextColorCheckbox:SetChecked(TRP3_UF_DB.Target.colorText.class);
	TRP3_UFPanel.TargetClassBackColorCheckbox:SetChecked(TRP3_UF_DB.Target.colorBack.class);

	TRP3_UFPanel.TarCustomTextColButton:SetEnabled(TRP3_UF_DB.Target.colorText.custom);
	TRP3_UFPanel.TarCustomBackColButton:SetEnabled(TRP3_UF_DB.Target.colorBack.custom);


	TRP3_UFPanel.PlayerTextColorCheckbox:SetChecked(TRP3_UF_DB.Player.colorText.custom);
	TRP3_UFPanel.PlayerBackColorCheckbox:SetChecked(TRP3_UF_DB.Player.colorBack.custom);
	TRP3_UFPanel.PlayerClassTextColorCheckbox:SetChecked(TRP3_UF_DB.Player.colorText.class);
	TRP3_UFPanel.PlayerClassBackColorCheckbox:SetChecked(TRP3_UF_DB.Player.colorBack.class);

	TRP3_UFPanel.PlayerCustomTextColButton:SetEnabled(TRP3_UF_DB.Player.colorText.custom);
	TRP3_UFPanel.PlayerCustomBackColButton:SetEnabled(TRP3_UF_DB.Player.colorBack.custom);

	TRP3_UFPanel.NPCOptionsCheckbox:SetChecked(TRP3_UF_DB.Setting.NPCs);

	--color names


	--sliders
	--TRP3_UF_DB.Player.position
	TRP3_UFPanel.PlayerPosSlider:SetValue(TRP3_UF_DB.Player.position)
	TRP3_UFPanel.TargetPosSlider:SetValue(TRP3_UF_DB.Target.position)

	TRP3_UFPanel.PlayerSizeSlider:SetValue(TRP3_UF_DB.Player.scale)
	TRP3_UFPanel.TargetSizeSlider:SetValue(TRP3_UF_DB.Target.scale)

	trpPlayer.button:SetScale(TRP3_UF_DB.Player.scale)
	trpTarget.button:SetScale(TRP3_UF_DB.Target.scale)
	

	--handle dummy frames
	function trpTarget.DummyColors()
		TRP3_UFRepDummyTarget:SetVertexColor(TRP3_UF_DB.Target.colorBack.r,TRP3_UF_DB.Target.colorBack.g,TRP3_UF_DB.Target.colorBack.b,TRP3_UF_DB.Target.colorBack.a)
		TRP3_UFRepTextDummyTarget:SetTextColor(TRP3_UF_DB.Target.colorText.r,TRP3_UF_DB.Target.colorText.g,TRP3_UF_DB.Target.colorText.b)
		TRP3_UFRepDummyPlayer:SetVertexColor(TRP3_UF_DB.Player.colorBack.r,TRP3_UF_DB.Player.colorBack.g,TRP3_UF_DB.Player.colorBack.b,TRP3_UF_DB.Player.colorBack.a)
		TRP3_UFRepTextDummyPlayer:SetTextColor(TRP3_UF_DB.Player.colorText.r,TRP3_UF_DB.Player.colorText.g,TRP3_UF_DB.Player.colorText.b)
	end

	--status / rested texture visibility

	TRP3_UFPanel.StatusHideCheckbox:SetChecked(TRP3_UF_DB.Border.status)
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
		local classR, classG, classB = C_ClassColor.GetClassColor(UnitClass("player")).r, C_ClassColor.GetClassColor(UnitClass("player")).g, C_ClassColor.GetClassColor(UnitClass("player")).b
		PlayerName:SetText(TRP3_API.r.name("player"))
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
				TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetText(TRP3_API.r.name("target"))
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

	TRP3_API.events.registerCallback("REGISTER_DATA_UPDATED", trpPlayer.UpdateInfo)
	TRP3_API.events.registerCallback("REGISTER_DATA_UPDATED", trpTarget.UpdateInfo)
end


local totalRP3_UnitFrames = {
    ["name"] = "Total RP 3: Unit Frames",
    ["description"] = "Modifies the target and player frames to have some additional profile info.",
    ["version"] = 0.1, -- Your version number
    ["id"] = "trp3_unitframes", -- Your module ID
    ["onStart"] = onStart, -- Your starting function
    ["minVersion"] = 108, -- Whatever TRP3 minimum build you require, 108 is the current one
};

TRP3_API.module.registerModule(totalRP3_UnitFrames);