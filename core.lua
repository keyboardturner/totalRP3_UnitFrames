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
--TRP3_TargetDB

local defaultsTable = {
	Target = {show = true, x = 5, y = 5, point = "CENTER", relativePoint = "BOTTOMLEFT", scale = 1.5,
		colorText = {r = 1, g = 1, b = 1, custom = false, class = false,},
		colorBack = {r = 1, g = 1, b = 1, a = 1, custom = false, class = false,},
	},
	Player = {show = true, x = 5, y = 5, point = "CENTER", relativePoint = "BOTTOMRIGHT", scale = 1.5,
		colorText = {r = 1, g = 1, b = 1, custom = false, class = false,},
		colorBack = {r = 1, g = 1, b = 1, a = 1, custom = false, class = false,},
	},

	Border = {show = false, style = "rare-elite",
		color = {r = 1, g = 1, b = 1, a = 1, custom = false, class = false,},
	},

	Setting = {locked = true, charSpecific = false,},
};

--if TRP3_TargetDB.Setting.charSpecific == true then
--	TRP3_CharDB stuff
--

------------------------------------------------------------------------------------------------------------------

local function ShowColorPicker(r, g, b, a, changedCallback)
	ColorPickerFrame:SetColorRGB(r,g,b);
	ColorPickerFrame.hasOpacity, ColorPickerFrame.opacity = (a ~= nil), a;
	ColorPickerFrame.previousValues = {r,g,b,a};
	ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = changedCallback, changedCallback, changedCallback;
	ColorPickerFrame:Hide(); -- Need to run the OnShow handler.
	ColorPickerFrame:Show();
end

local function round(number, decimals)
	return (("%%.%df"):format(decimals)):format(number)
end

local function myColorCallback(restore)
	local newR, newG, newB, newA; -- I forgot what to do with the alpha value but it's needed to not swap RGB values
	if restore then
	 -- The user bailed, we extract the old color from the table created by ShowColorPicker.
	newR, newG, newB, newA = unpack(restore);
	else
	 -- Something changed
		newA, newR, newG, newB = OpacitySliderFrame:GetValue(), ColorPickerFrame:GetColorRGB();
	end
	 -- Update our internal storage.
	TRP3_TargetDB.Target.colorBack.r, TRP3_TargetDB.Target.colorBack.g, TRP3_TargetDB.Target.colorBack.b, TRP3_TargetDB.Target.colorBack.a = newR, newG, newB, newA;
	 -- And update any UI elements that use this color...
	print("New values: " .. "\nRGB(0-1) - |cffff7f7f" .. round(TRP3_TargetDB.Target.colorBack.r,2) .. "|r, |cff7fff7f" .. round(TRP3_TargetDB.Target.colorBack.g,2) .. "|r, |cff7f7fff" .. round(TRP3_TargetDB.Target.colorBack.b,2) .. "|r\nRGB(0-255) - |cffff7f7f" .. round(TRP3_TargetDB.Target.colorBack.r*255) .. "|r, |cff7fff7f" .. round(TRP3_TargetDB.Target.colorBack.g*255) .. "|r, |cff7f7fff" .. round(TRP3_TargetDB.Target.colorBack.b*255) .. "|r")
	TargetFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:SetVertexColor(TRP3_TargetDB.Target.colorBack.r, TRP3_TargetDB.Target.colorBack.g, TRP3_TargetDB.Target.colorBack.b, TRP3_TargetDB.Target.colorBack.a)
end

SLASH_BINGUS1 = "/bingus"
SlashCmdList["BINGUS"] = function(msg)
	ShowColorPicker(TRP3_TargetDB.Target.colorBack.r, TRP3_TargetDB.Target.colorBack.g, TRP3_TargetDB.Target.colorBack.b, TRP3_TargetDB.Target.colorBack.a, myColorCallback);
	print("Current values: " .. "\nRGB(0-1) - |cffff7f7f" .. round(TRP3_TargetDB.Target.colorBack.r,2) .. "|r, |cff7fff7f" .. round(TRP3_TargetDB.Target.colorBack.g,2) .. "|r, |cff7f7fff" .. round(TRP3_TargetDB.Target.colorBack.b,2) .. "|r\nRGB(0-255) - |cffff7f7f" .. round(TRP3_TargetDB.Target.colorBack.r*255) .. "|r, |cff7fff7f" .. round(TRP3_TargetDB.Target.colorBack.g*255) .. "|r, |cff7f7fff" .. round(TRP3_TargetDB.Target.colorBack.b*255) .. "|r")
end

local trpTarget, trpPlayer
trpTarget = CreateFrame("Frame")
trpPlayer = CreateFrame("Frame")

local VERSION_TEXT = string.format(TRP3_API.loc.CREDITS_VERSION_TEXT, GetAddOnMetadata("TotalRP3_Target", "Version"));
local TRP3_TargetPanel = CreateFrame("Frame");
TRP3_TargetPanel.name = "Total RP 3: Target";

TRP3_TargetPanel.Headline = TRP3_TargetPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal");
TRP3_TargetPanel.Headline:SetFont(TRP3_TargetPanel.Headline:GetFont(), 23);
TRP3_TargetPanel.Headline:SetTextColor(1,.73,0,1);
TRP3_TargetPanel.Headline:ClearAllPoints();
TRP3_TargetPanel.Headline:SetPoint("TOPLEFT", TRP3_TargetPanel, "TOPLEFT",12,-12);
TRP3_TargetPanel.Headline:SetText("|cffF5038BTotal RP 3|r|cffffffff: Target|r");

TRP3_TargetPanel.Version = TRP3_TargetPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal");
TRP3_TargetPanel.Version:SetFont(TRP3_TargetPanel.Version:GetFont(), 12);
TRP3_TargetPanel.Version:SetTextColor(1,1,1,1);
TRP3_TargetPanel.Version:ClearAllPoints();
TRP3_TargetPanel.Version:SetPoint("TOPLEFT", TRP3_TargetPanel, "TOPLEFT",400,-21);
TRP3_TargetPanel.Version:SetText(VERSION_TEXT);


------------------------------------------------------------------------------------------------------------------
--position presets
TRP3_TargetPanel.Pf = CreateFrame("Frame", nil, TRP3_TargetPanel)
TRP3_TargetPanel.Pf:ClearAllPoints();
TRP3_TargetPanel.Pf:SetPoint("TOPLEFT", TRP3_TargetPanel, "TOPLEFT", 12, -53*2);
TRP3_TargetPanel.Pf:SetSize(64, 64)

TRP3_TargetPanel.Pf.tex = TRP3_TargetPanel.Pf:CreateTexture()
TRP3_TargetPanel.Pf.tex:SetAllPoints(TRP3_TargetPanel.Pf)
SetPortraitTexture(TRP3_TargetPanel.Pf.tex, "player")

TRP3_TargetPanel.Pf.radioTopLeft = CreateFrame("CheckButton", nil, TRP3_TargetPanel.Pf, "UIRadioButtonTemplate")
TRP3_TargetPanel.Pf.radioTop = CreateFrame("CheckButton", nil, TRP3_TargetPanel.Pf, "UIRadioButtonTemplate")
TRP3_TargetPanel.Pf.radioTopRight = CreateFrame("CheckButton", nil, TRP3_TargetPanel.Pf, "UIRadioButtonTemplate")
TRP3_TargetPanel.Pf.radioLeft = CreateFrame("CheckButton", nil, TRP3_TargetPanel.Pf, "UIRadioButtonTemplate")
TRP3_TargetPanel.Pf.radioCenter = CreateFrame("CheckButton", nil, TRP3_TargetPanel.Pf, "UIRadioButtonTemplate")
TRP3_TargetPanel.Pf.radioRight = CreateFrame("CheckButton", nil, TRP3_TargetPanel.Pf, "UIRadioButtonTemplate")
TRP3_TargetPanel.Pf.radioBottomLeft = CreateFrame("CheckButton", nil, TRP3_TargetPanel.Pf, "UIRadioButtonTemplate")
TRP3_TargetPanel.Pf.radioBottom = CreateFrame("CheckButton", nil, TRP3_TargetPanel.Pf, "UIRadioButtonTemplate")
TRP3_TargetPanel.Pf.radioBottomRight = CreateFrame("CheckButton", nil, TRP3_TargetPanel.Pf, "UIRadioButtonTemplate")

TRP3_TargetPanel.Pf.radioTopLeft:SetChecked(false)
TRP3_TargetPanel.Pf.radioTop:SetChecked(false)
TRP3_TargetPanel.Pf.radioTopRight:SetChecked(false)
TRP3_TargetPanel.Pf.radioLeft:SetChecked(false)
TRP3_TargetPanel.Pf.radioCenter:SetChecked(false)
TRP3_TargetPanel.Pf.radioRight:SetChecked(false)
TRP3_TargetPanel.Pf.radioBottomLeft:SetChecked(false)
TRP3_TargetPanel.Pf.radioBottom:SetChecked(false)
TRP3_TargetPanel.Pf.radioBottomRight:SetChecked(true)

TRP3_TargetPanel.Pf.radioTopLeft:SetPoint("CENTER", TRP3_TargetPanel.Pf, "TOPLEFT", 0, 0)
TRP3_TargetPanel.Pf.radioTop:SetPoint("CENTER", TRP3_TargetPanel.Pf, "TOP", 0, 0)
TRP3_TargetPanel.Pf.radioTopRight:SetPoint("CENTER", TRP3_TargetPanel.Pf, "TOPRIGHT", 0, 0)
TRP3_TargetPanel.Pf.radioLeft:SetPoint("CENTER", TRP3_TargetPanel.Pf, "LEFT", 0, 0)
TRP3_TargetPanel.Pf.radioCenter:SetPoint("CENTER", TRP3_TargetPanel.Pf, "CENTER", 0, 0)
TRP3_TargetPanel.Pf.radioRight:SetPoint("CENTER", TRP3_TargetPanel.Pf, "RIGHT", 0, 0)
TRP3_TargetPanel.Pf.radioBottomLeft:SetPoint("CENTER", TRP3_TargetPanel.Pf, "BOTTOMLEFT", 0, 0)
TRP3_TargetPanel.Pf.radioBottom:SetPoint("CENTER", TRP3_TargetPanel.Pf, "BOTTOM", 0, 0)
TRP3_TargetPanel.Pf.radioBottomRight:SetPoint("CENTER", TRP3_TargetPanel.Pf, "BOTTOMRIGHT", 0, 0)

TRP3_TargetPanel.Pf.TitleText = TRP3_TargetPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal");
TRP3_TargetPanel.Pf.TitleText:SetFont(TRP3_TargetPanel.Pf.TitleText:GetFont(), 12);
TRP3_TargetPanel.Pf.TitleText:SetTextColor(1,1,1,1);
TRP3_TargetPanel.Pf.TitleText:ClearAllPoints();
TRP3_TargetPanel.Pf.TitleText:SetPoint("BOTTOM", TRP3_TargetPanel.Pf, "TOP",0,10);
TRP3_TargetPanel.Pf.TitleText:SetText(PLAYER);

TRP3_TargetPanel.Pf.allRadios = {
	TRP3_TargetPanel.Pf.radioTopLeft,
	TRP3_TargetPanel.Pf.radioTop,
	TRP3_TargetPanel.Pf.radioTopRight,
	TRP3_TargetPanel.Pf.radioLeft,
	TRP3_TargetPanel.Pf.radioCenter,
	TRP3_TargetPanel.Pf.radioRight,
	TRP3_TargetPanel.Pf.radioBottomLeft,
	TRP3_TargetPanel.Pf.radioBottom,
	TRP3_TargetPanel.Pf.radioBottomRight
}

function TRP3_TargetPanel.Pf.createOnRadioClicked (location)
	local function onRadioClicked (self, a, b, c)
		local checked = self:GetChecked()
		PlaySound(PlaySoundKitID and "igMainMenuOptionCheckBoxOn" or SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		TRP3_TargetDB.Player.relativePoint = location

		local anyChecked = false
		for _, radio in ipairs(TRP3_TargetPanel.Pf.allRadios) do
			if radio ~= self then
				anyChecked = radio:GetChecked() or anyChecked
				radio:SetChecked(false)
			end
		end
		if not anyChecked then
			self:SetChecked(true)
		end
	end
	return onRadioClicked
end

TRP3_TargetPanel.Pf.radioTopLeft:SetScript("OnClick", TRP3_TargetPanel.Pf.createOnRadioClicked("TOPLEFT"))
TRP3_TargetPanel.Pf.radioTop:SetScript("OnClick", TRP3_TargetPanel.Pf.createOnRadioClicked("TOP"))
TRP3_TargetPanel.Pf.radioTopRight:SetScript("OnClick", TRP3_TargetPanel.Pf.createOnRadioClicked("TOPRIGHT"))
TRP3_TargetPanel.Pf.radioLeft:SetScript("OnClick", TRP3_TargetPanel.Pf.createOnRadioClicked("LEFT"))
TRP3_TargetPanel.Pf.radioCenter:SetScript("OnClick", TRP3_TargetPanel.Pf.createOnRadioClicked("CENTER"))
TRP3_TargetPanel.Pf.radioRight:SetScript("OnClick", TRP3_TargetPanel.Pf.createOnRadioClicked("RIGHT"))
TRP3_TargetPanel.Pf.radioBottomLeft:SetScript("OnClick", TRP3_TargetPanel.Pf.createOnRadioClicked("BOTTOMLEFT"))
TRP3_TargetPanel.Pf.radioBottom:SetScript("OnClick", TRP3_TargetPanel.Pf.createOnRadioClicked("BOTTOM"))
TRP3_TargetPanel.Pf.radioBottomRight:SetScript("OnClick", TRP3_TargetPanel.Pf.createOnRadioClicked("BOTTOMRIGHT"))



TRP3_TargetPanel.Tf = CreateFrame("Frame", nil, TRP3_TargetPanel)
TRP3_TargetPanel.Tf:ClearAllPoints();
TRP3_TargetPanel.Tf:SetPoint("TOPLEFT", TRP3_TargetPanel, "TOPLEFT", 170*3, -53*2);
TRP3_TargetPanel.Tf:SetSize(64, 64)

TRP3_TargetPanel.Tf.tex = TRP3_TargetPanel.Tf:CreateTexture()
TRP3_TargetPanel.Tf.tex:SetAllPoints(TRP3_TargetPanel.Tf)
SetPortraitTexture(TRP3_TargetPanel.Tf.tex, "player")

TRP3_TargetPanel.Tf.radioTopLeft = CreateFrame("CheckButton", nil, TRP3_TargetPanel.Tf, "UIRadioButtonTemplate")
TRP3_TargetPanel.Tf.radioTop = CreateFrame("CheckButton", nil, TRP3_TargetPanel.Tf, "UIRadioButtonTemplate")
TRP3_TargetPanel.Tf.radioTopRight = CreateFrame("CheckButton", nil, TRP3_TargetPanel.Tf, "UIRadioButtonTemplate")
TRP3_TargetPanel.Tf.radioLeft = CreateFrame("CheckButton", nil, TRP3_TargetPanel.Tf, "UIRadioButtonTemplate")
TRP3_TargetPanel.Tf.radioCenter = CreateFrame("CheckButton", nil, TRP3_TargetPanel.Tf, "UIRadioButtonTemplate")
TRP3_TargetPanel.Tf.radioRight = CreateFrame("CheckButton", nil, TRP3_TargetPanel.Tf, "UIRadioButtonTemplate")
TRP3_TargetPanel.Tf.radioBottomLeft = CreateFrame("CheckButton", nil, TRP3_TargetPanel.Tf, "UIRadioButtonTemplate")
TRP3_TargetPanel.Tf.radioBottom = CreateFrame("CheckButton", nil, TRP3_TargetPanel.Tf, "UIRadioButtonTemplate")
TRP3_TargetPanel.Tf.radioBottomRight = CreateFrame("CheckButton", nil, TRP3_TargetPanel.Tf, "UIRadioButtonTemplate")

TRP3_TargetPanel.Tf.radioTopLeft:SetChecked(false)
TRP3_TargetPanel.Tf.radioTop:SetChecked(false)
TRP3_TargetPanel.Tf.radioTopRight:SetChecked(false)
TRP3_TargetPanel.Tf.radioLeft:SetChecked(false)
TRP3_TargetPanel.Tf.radioCenter:SetChecked(false)
TRP3_TargetPanel.Tf.radioRight:SetChecked(false)
TRP3_TargetPanel.Tf.radioBottomLeft:SetChecked(true)
TRP3_TargetPanel.Tf.radioBottom:SetChecked(false)
TRP3_TargetPanel.Tf.radioBottomRight:SetChecked(false)

TRP3_TargetPanel.Tf.radioTopLeft:SetPoint("CENTER", TRP3_TargetPanel.Tf, "TOPLEFT", 0, 0)
TRP3_TargetPanel.Tf.radioTop:SetPoint("CENTER", TRP3_TargetPanel.Tf, "TOP", 0, 0)
TRP3_TargetPanel.Tf.radioTopRight:SetPoint("CENTER", TRP3_TargetPanel.Tf, "TOPRIGHT", 0, 0)
TRP3_TargetPanel.Tf.radioLeft:SetPoint("CENTER", TRP3_TargetPanel.Tf, "LEFT", 0, 0)
TRP3_TargetPanel.Tf.radioCenter:SetPoint("CENTER", TRP3_TargetPanel.Tf, "CENTER", 0, 0)
TRP3_TargetPanel.Tf.radioRight:SetPoint("CENTER", TRP3_TargetPanel.Tf, "RIGHT", 0, 0)
TRP3_TargetPanel.Tf.radioBottomLeft:SetPoint("CENTER", TRP3_TargetPanel.Tf, "BOTTOMLEFT", 0, 0)
TRP3_TargetPanel.Tf.radioBottom:SetPoint("CENTER", TRP3_TargetPanel.Tf, "BOTTOM", 0, 0)
TRP3_TargetPanel.Tf.radioBottomRight:SetPoint("CENTER", TRP3_TargetPanel.Tf, "BOTTOMRIGHT", 0, 0)

TRP3_TargetPanel.Tf.TitleText = TRP3_TargetPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal");
TRP3_TargetPanel.Tf.TitleText:SetFont(TRP3_TargetPanel.Tf.TitleText:GetFont(), 12);
TRP3_TargetPanel.Tf.TitleText:SetTextColor(1,1,1,1);
TRP3_TargetPanel.Tf.TitleText:ClearAllPoints();
TRP3_TargetPanel.Tf.TitleText:SetPoint("BOTTOM", TRP3_TargetPanel.Tf, "TOP",0,10);
TRP3_TargetPanel.Tf.TitleText:SetText(TARGET);

TRP3_TargetPanel.Tf.allRadios = {
	TRP3_TargetPanel.Tf.radioTopLeft,
	TRP3_TargetPanel.Tf.radioTop,
	TRP3_TargetPanel.Tf.radioTopRight,
	TRP3_TargetPanel.Tf.radioLeft,
	TRP3_TargetPanel.Tf.radioCenter,
	TRP3_TargetPanel.Tf.radioRight,
	TRP3_TargetPanel.Tf.radioBottomLeft,
	TRP3_TargetPanel.Tf.radioBottom,
	TRP3_TargetPanel.Tf.radioBottomRight
}

function TRP3_TargetPanel.Tf.createOnRadioClicked (location)
	local function onRadioClicked (self, a, b, c)
		local checked = self:GetChecked()
		PlaySound(PlaySoundKitID and "igMainMenuOptionCheckBoxOn" or SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		TRP3_TargetDB.Target.relativePoint = location

		local anyChecked = false
		for _, radio in ipairs(TRP3_TargetPanel.Tf.allRadios) do
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

TRP3_TargetPanel.Tf.radioTopLeft:SetScript("OnClick", TRP3_TargetPanel.Tf.createOnRadioClicked("TOPLEFT"))
TRP3_TargetPanel.Tf.radioTop:SetScript("OnClick", TRP3_TargetPanel.Tf.createOnRadioClicked("TOP"))
TRP3_TargetPanel.Tf.radioTopRight:SetScript("OnClick", TRP3_TargetPanel.Tf.createOnRadioClicked("TOPRIGHT"))
TRP3_TargetPanel.Tf.radioLeft:SetScript("OnClick", TRP3_TargetPanel.Tf.createOnRadioClicked("LEFT"))
TRP3_TargetPanel.Tf.radioCenter:SetScript("OnClick", TRP3_TargetPanel.Tf.createOnRadioClicked("CENTER"))
TRP3_TargetPanel.Tf.radioRight:SetScript("OnClick", TRP3_TargetPanel.Tf.createOnRadioClicked("RIGHT"))
TRP3_TargetPanel.Tf.radioBottomLeft:SetScript("OnClick", TRP3_TargetPanel.Tf.createOnRadioClicked("BOTTOMLEFT"))
TRP3_TargetPanel.Tf.radioBottom:SetScript("OnClick", TRP3_TargetPanel.Tf.createOnRadioClicked("BOTTOM"))
TRP3_TargetPanel.Tf.radioBottomRight:SetScript("OnClick", TRP3_TargetPanel.Tf.createOnRadioClicked("BOTTOMRIGHT"))

------------------------------------------------------------------------------------------------------------------

--UI-HUD-UnitFrame-Target-PortraitOn-Type
TRP3_TargetPanel.PColor = CreateFrame("Button", nil, TRP3_TargetPanel)
TRP3_TargetPanel.PColor:SetPoint("TOPLEFT", TRP3_TargetPanel, "TOPLEFT", 100, -53*2)
TRP3_TargetPanel.PColor:SetWidth(135)
TRP3_TargetPanel.PColor:SetHeight(18)
TRP3_TargetPanel.PColor.tex = TRP3_TargetPanel.PColor:CreateTexture(nil, "ARTWORK", nil, 1)
TRP3_TargetPanel.PColor.tex:SetAllPoints(TRP3_TargetPanel.PColor)
TRP3_TargetPanel.PColor.tex:SetAtlas("UI-HUD-UnitFrame-Target-PortraitOn-Type")
TRP3_TargetPanel.PColor.tex:SetTexCoord(1, 0, 0, 1)

TRP3_TargetPanel.PColor.Name = TRP3_TargetPanel.PColor:CreateFontString(nil, "OVERLAY", "GameFontNormal");
TRP3_TargetPanel.PColor.Name:SetFont(TRP3_TargetPanel.PColor.Name:GetFont(), 12);
TRP3_TargetPanel.PColor.Name:SetTextColor(1,1,1,1);
TRP3_TargetPanel.PColor.Name:ClearAllPoints();
TRP3_TargetPanel.PColor.Name:SetPoint("TOP", TRP3_TargetPanel.PColor, "TOP",0,0);
TRP3_TargetPanel.PColor.Name:SetText(PLAYER);

TRP3_TargetPanel.PColor:SetScript("OnMouseDown", function()
	TRP3_TargetPanel.PColor.tex:SetTexCoord(.99, .01, .1, .99)
end)
TRP3_TargetPanel.PColor:SetScript("OnMouseUp", function()
	print("debug you clicked me!")
	TRP3_TargetPanel.PColor.tex:SetTexCoord(1, 0, 0, 1)
end)



TRP3_TargetPanel.TColor = CreateFrame("Button", nil, TRP3_TargetPanel)
TRP3_TargetPanel.TColor:SetPoint("TOPLEFT", TRP3_TargetPanel, "TOPLEFT", 170*2, -53*2)
TRP3_TargetPanel.TColor:SetWidth(135)
TRP3_TargetPanel.TColor:SetHeight(18)
TRP3_TargetPanel.TColor.tex = TRP3_TargetPanel.TColor:CreateTexture(nil, "ARTWORK", nil, 1)
TRP3_TargetPanel.TColor.tex:SetAllPoints(TRP3_TargetPanel.TColor)
TRP3_TargetPanel.TColor.tex:SetAtlas("UI-HUD-UnitFrame-Target-PortraitOn-Type")

TRP3_TargetPanel.TColor.Name = TRP3_TargetPanel.TColor:CreateFontString(nil, "OVERLAY", "GameFontNormal");
TRP3_TargetPanel.TColor.Name:SetFont(TRP3_TargetPanel.TColor.Name:GetFont(), 12);
TRP3_TargetPanel.TColor.Name:SetTextColor(1,1,1,1);
TRP3_TargetPanel.TColor.Name:ClearAllPoints();
TRP3_TargetPanel.TColor.Name:SetPoint("TOP", TRP3_TargetPanel.TColor, "TOP",0,0);
TRP3_TargetPanel.TColor.Name:SetText(TARGET);


TRP3_TargetPanel.TColor:SetScript("OnMouseDown", function()
	TRP3_TargetPanel.TColor.tex:SetTexCoord(.01, .99, .1, .99)
end)
TRP3_TargetPanel.TColor:SetScript("OnMouseUp", function()
	print("debug you clicked me!")
	TRP3_TargetPanel.TColor.tex:SetTexCoord(0, 1, 0, 1)
end)

--PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture:SetVertexColor(0,1,1) -- the glowy highlight texture when rested
--PlayerFrame.PlayerFrameContainer.FrameTexture:SetVertexColor(0,1,1) -- player border colors
--TRP3_TargetPanel.TColor.tex:SetTexCoord(-.08, 1.08, -.08, 1.08)
--TRP3_TargetPanel.TColor:SetNormalAtlas("chatframe-button-up")
--TRP3_TargetPanel.TColor:SetPushedAtlas("chatframe-button-down")
--TRP3_TargetPanel.TColor:SetHighlightAtlas("chatframe-button-highlight")


------------------------------------------------------------------------------------------------------------------

local PlayerRepFrame = CreateFrame("Frame", nil, PlayerFrame)
PlayerRepFrame:SetPoint("TOPRIGHT", PlayerFrame, "TOPRIGHT", -22, -26)
PlayerRepFrame:SetWidth(135)
PlayerRepFrame:SetHeight(18)
PlayerRepFrame.tex = PlayerRepFrame:CreateTexture(nil, "BACKGROUND", nil, 0)
PlayerRepFrame.tex:SetAllPoints(PlayerRepFrame)
PlayerRepFrame.tex:SetAtlas("UI-HUD-UnitFrame-Target-PortraitOn-Type")
PlayerRepFrame.tex:SetTexCoord(1, 0, 0, 1)
PlayerRepFrame.tex:SetVertexColor(0,1,1)


local PlayerDragonFrame = CreateFrame("Frame", nil, PlayerFrame)
PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
PlayerDragonFrame:SetSize(99, 81);
PlayerDragonFrame.tex = PlayerDragonFrame:CreateTexture(nil, "ARTWORK", nil, 0)
PlayerDragonFrame.tex:SetAllPoints(PlayerDragonFrame)
PlayerDragonFrame.tex:SetTexture("Interface\\AddOns\\totalRP3_Target\\tex\\uiunitframeboss2x")
PlayerDragonFrame.tex:SetTexCoord(1, 0, 0, 1)
PlayerDragonFrame.tex:SetVertexColor(1,1,1)

PlayerDragonFrame.texlist = {
"rare",
"rare-elite",
"elite",
"boss",
};

function PlayerDragonFrame.TextureStuff()
	if TRP3_TargetDB.Border.style == "rare" then
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", 8, -10)
		PlayerDragonFrame:SetSize(80, 79);
		PlayerDragonFrame.tex:SetTexCoord(0.314453125, 0.001953125, 0.322265625, 0.630859375) -- rare
	end
	if TRP3_TargetDB.Border.style == "rare-elite" then
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -10, -10)
		PlayerDragonFrame:SetSize(99, 81);
		PlayerDragonFrame.tex:SetTexCoord(0.77734375, 0.390625, 0.001953125, 0.318359375) -- rare-elite
	end
	if TRP3_TargetDB.Border.style == "elite" then
		PlayerDragonFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", 8, -10)
		PlayerDragonFrame:SetSize(80, 79);
		PlayerDragonFrame.tex:SetTexCoord(0.3125, 0.001953125, 0.634765625, 0.947265625) -- elite
	end
	if TRP3_TargetDB.Border.style == "boss" then
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

InterfaceOptions_AddCategory(TRP3_TargetPanel);

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
	if TRP3_TargetDB.Target.relativePoint == "CENTER" and UnitIsPlayer("target") == true and AddOn_TotalRP3.Player.CreateFromUnit("target"):GetProfileID() ~= nil then
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
	if TRP3_TargetDB.Target.relativePoint == "CENTER" then
		trpTarget.SetAsPortrait()
		return
	end
	trpTarget.button:Show()
	if TRP3_TargetDB.Target.relativePoint == "TOPLEFT" then
		yPos = -5
		xPos = 5
	end
	if TRP3_TargetDB.Target.relativePoint == "LEFT" then
		yPos = 0
		xPos = 0
	end
	if TRP3_TargetDB.Target.relativePoint == "BOTTOMLEFT" then
		yPos = 5
		xPos = 5
	end
	if TRP3_TargetDB.Target.relativePoint == "TOP" then
		yPos = 0
		xPos = 0
	end
	if TRP3_TargetDB.Target.relativePoint == "BOTTOM" then
		yPos = 0
		xPos = 0
	end
	if TRP3_TargetDB.Target.relativePoint == "TOPRIGHT" then
		yPos = -5
		xPos = -5
	end
	if TRP3_TargetDB.Target.relativePoint == "RIGHT" then
		yPos = 0
		xPos = 0
	end
	if TRP3_TargetDB.Target.relativePoint == "BOTTOMRIGHT" then
		yPos = 5
		xPos = -5
	end
	trpTarget.button:ClearAllPoints()
	trpTarget.button:SetPoint("CENTER", TargetFrame.TargetFrameContainer.Portrait, TRP3_TargetDB.Target.relativePoint, xPos, yPos)
end

function trpPlayer.fadeout()
	UIFrameFadeOut(trpPlayer.button, .5, trpPlayer.button:GetAlpha(), 0)
	print(trpPlayer.button:GetAlpha())
end
function trpPlayer.hide()
	trpPlayer.button:Hide()
end

function trpPlayer.fadein()
	UIFrameFadeIn(trpPlayer.button, .5, trpPlayer.button:GetAlpha(), 1)
end
function trpPlayer.show()
	trpPlayer.button:Show()
end

function trpTarget.nameChecker()
	if AddOn_TotalRP3.Player.CreateFromUnit("player"):GetProfileID() ~= nil then
		local player1 = AddOn_TotalRP3.Player.CreateFromUnit("player")
		local icon = player1:GetCustomIcon()
		--trpTarget.button:SetNormalTexture("Interface/icons/" .. icon)
		SetPortraitToTexture(trpPlayer.button.tex, "Interface/icons/" .. icon)
		trpPlayer.button:Show()
	else
		trpPlayer.button:Hide()
	end

	if UnitIsPlayer("target") == true and AddOn_TotalRP3.Player.CreateFromUnit("target"):GetProfileID() ~= nil then
		local textColorQ = AddOn_TotalRP3.Player.CreateFromUnit("target"):GetCustomColorForDisplay()
		if textColorQ ~= nil then
			textColorStuff = textColorQ:GenerateHexColor()
		else
			textColorStuff = "FFFFD100"
		end
		TargetFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:SetVertexColor(TRP3_TargetDB.Target.colorBack.r, TRP3_TargetDB.Target.colorBack.g, TRP3_TargetDB.Target.colorBack.b, TRP3_TargetDB.Target.colorBack.a)
		TargetFrame.TargetFrameContent.TargetFrameContentMain.Name:SetText("|c" .. textColorStuff .. TRP3_API.r.name("target") .. "|r")
		PlayerName:SetText(TRP3_API.r.name("player"))
		local player = AddOn_TotalRP3.Player.CreateFromUnit("target")
		local icon = player:GetCustomIcon()
		if icon == nil then
			icon = "inv_inscription_scroll"
		end
		--trpTarget.button:SetNormalTexture("Interface/icons/" .. icon)
		SetPortraitToTexture(trpTarget.button.tex, "Interface/icons/" .. icon)
		trpTarget.button:Show()
		trpTarget.SetAsPortrait()
	else
		trpTarget.button:Hide()
		trpTarget.portraitClick:Hide()
	end
end

local function onStart()
	if not TRP3_TargetDB then
		TRP3_TargetDB = defaultsTable
	end

	trpTarget:RegisterEvent("CHAT_MSG_ADDON")
	trpTarget:RegisterEvent("PLAYER_TARGET_CHANGED")
	trpTarget:RegisterEvent("UNIT_TARGET")

	local TarWidth = TargetFrame.TargetFrameContainer.Portrait:GetWidth()
	local TarHeight = TargetFrame.TargetFrameContainer.Portrait:GetHeight()
	trpTarget.button = CreateFrame("Button", "Bingus")
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
	--C_ClassColor.GetClassColor(UnitClass("target")):GenerateHexColor() -- generates default class color

	trpPlayer:RegisterEvent("CHAT_MSG_ADDON")
	trpPlayer:RegisterEvent("PLAYER_TARGET_CHANGED")
	trpPlayer:RegisterEvent("UNIT_TARGET")
	trpPlayer:RegisterEvent("PLAYER_REGEN_DISABLED")
	trpPlayer:RegisterEvent("PLAYER_REGEN_ENABLED")

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
		--print("firing function")
		if event == "PLAYER_REGEN_DISABLED" then
			print("entering combat")
			trpPlayer.fadeout()
			C_Timer.After(.5, trpPlayer.hide)
		elseif event == "PLAYER_REGEN_ENABLED" then
			print("exiting combat")
			trpPlayer.fadein()
			C_Timer.After(.5, trpPlayer.show)
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

	trpTarget.SetPos()
end


local totalRP3_Target = {
    ["name"] = "Total RP 3: Target",
    ["description"] = "Modifies the target frame to have some additional profile info.",
    ["version"] = 0.1, -- Your version number
    ["id"] = "trp3_target", -- Your module ID
    ["onStart"] = onStart, -- Your starting function
    ["minVersion"] = 108, -- Whatever TRP3 minimum build you require, 108 is the current one
};

TRP3_API.module.registerModule(totalRP3_Target);